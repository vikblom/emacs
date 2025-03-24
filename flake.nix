{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in with pkgs; {
        devShells.default = mkShell {
          nativeBuildInputs = [
             makeWrapper pkg-config autoreconfHook texinfo gnutls
          ];
          # ++ lib.optional (withPgtk || withX && (withGTK3 || withXwidgets))
          buildInputs = [
            gcc
            libgccjit
            autoconf
            automake
            gettext
            gnutls
            harfbuzz.dev
            jansson
            libxml2
            ncurses
            mailutils

            # darwin.apple_sdk.frameworks.AppKit
          ];
        };
      });
}
