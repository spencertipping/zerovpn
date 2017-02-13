FROM zerovpn-base:latest

ADD authorized_keys new-client openvpn-server.conf openvpn-client.conf \
      docker-entrypoint \
    /home/vpn/

RUN sed -ri 's/IP_BASE_PREFIX/'$ip_base'/g' /home/vpn/* \
 && mv /home/vpn/openvpn-server.conf /etc/openvpn/server.conf \
 && mv /home/vpn/authorized_keys /home/vpn/.ssh/ \
 && mv /home/vpn/docker-entrypoint / \
 && chown vpn:vpn /home/vpn/.ssh/authorized_keys \
 && chmod 0700 /home/vpn/.ssh/authorized_keys

EXPOSE 22
EXPOSE 1194

CMD /docker-entrypoint
