FROM debian:bullseye

RUN apt update && apt install -y curl build-essential gawk gcc g++ gfortran git texinfo bison libncurses-dev
RUN mkdir -p /opt
RUN curl -L 'https://sourceforge.net/projects/raspberry-pi-cross-compilers/files/Raspberry%20Pi%20GCC%20Cross-Compiler%20Toolchains/Bullseye/GCC%2010.3.0/Raspberry%20Pi%201%2C%20Zero/cross-gcc-10.3.0-pi_0-1.tar.gz/download' | tar xzv -C /opt
ENV HOME="/root"
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain="stable"
ENV PATH="$HOME/.cargo/bin:${PATH}"
RUN rustup target add arm-unknown-linux-gnueabihf
COPY ./cargo_config $HOME/.cargo/config

CMD cargo build --release --target=arm-unknown-linux-gnueabihf