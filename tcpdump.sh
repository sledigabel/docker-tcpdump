#!/bin/sh

# build image if needed
build(){
docker images | grep -q tcpdump > /dev/null || docker build -t tcpdump - << EOF
FROM alpine:latest

RUN apk update && apk add tcpdump
RUN mkdir /workdir
WORKDIR /workdir
ENTRYPOINT [ "/usr/sbin/tcpdump" ]
CMD [ "-i", "any" ]
EOF
}

# load the alias
alias tcpdump="build; docker run -ti --network host --rm -v $(pwd):/workdir tcpdump"
