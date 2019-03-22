Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC30C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F27E218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="kxADz2eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCVGjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:39:21 -0400
Received: from mail.synology.com ([211.23.38.101]:35119 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbfCVGjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:39:20 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2019 02:39:18 EDT
From:   lifonghsu <lifonghsu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1553236213; bh=+TyQ2ld6b+WpeAV4MOSaXkFmKltzNZOAeaD2+CWwWbE=;
        h=From:To:Cc:Subject:Date;
        b=kxADz2eR0jh6XS9sJjGgprGnR8ZvVUPFcOmVBDSlfGAQ2f7w7mN5Er4EYnJEvP0TS
         PMN1MoFEHR1k+y2t5RoFlGRnRXnzeshQkcM5xzorqrjYXbLTT1ezirjUs9jPH4zcjh
         zmmHkNGQoczwDtSHo9ojj4YchoREDgXBt/EMw5j0=
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        LiFong Hsu <lifonghsu@synology.com>
Subject: net: fix routing encapsulated packets when binding a socket to a tunnel interface
Date:   Fri, 22 Mar 2019 14:29:58 +0800
Message-Id: <1553236198-5955-1-git-send-email-lifonghsu@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: LiFong Hsu <lifonghsu@synology.com>

When binding a socket to a 4in6/6in4 tunnel interface, the kernel sends
the packet to the tunnel interface without any problem, e.g.,
ping 8.8.8.8 -I 4in6. However, after the 4in6/6in4 tunnel encapsulation,
the encapsulated packet could be sent to the tunnel interface again when
some fields of the skb were changed in mangle table's output chain,
such as skb->mark and src/dest IP address. Sending to the tunnel interface
twice is unexpected, since there are no corresponding routing rules on
the tunnel interface for the encapsulated packet. Eventually, the encapsulated
packet will be dropped by the tunnel interface.

This commit stops referring to sk_bound_dev_if while re-routing a packet
with skb_iif!=0 which indicates that the packet has already been sent to
the interface specified by sk_bound_dev_if. Instead, this commit sends
the packet to the underlying network device.

Signed-off-by: LiFong Hsu <lifonghsu@synology.com>
Reviewed-by: JianJhen Chen <kchen@synology.com>
---
 net/ipv4/netfilter.c  | 2 +-
 net/ipv6/ip6_tunnel.c | 3 +++
 net/ipv6/netfilter.c  | 2 +-
 net/ipv6/sit.c        | 4 ++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index 8d2e5dc9..426c56b 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -41,7 +41,7 @@ int ip_route_me_harder(struct net *net, struct sk_buff *skb, unsigned int addr_t
 	fl4.daddr = iph->daddr;
 	fl4.saddr = saddr;
 	fl4.flowi4_tos = RT_TOS(iph->tos);
-	fl4.flowi4_oif = sk ? sk->sk_bound_dev_if : 0;
+	fl4.flowi4_oif = (sk && !skb->skb_iif) ? sk->sk_bound_dev_if : 0;
 	if (!fl4.flowi4_oif)
 		fl4.flowi4_oif = l3mdev_master_ifindex(dev);
 	fl4.flowi4_mark = skb->mark;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 0c6403c..6997599 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1220,6 +1220,9 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	ipv6h->nexthdr = proto;
 	ipv6h->saddr = fl6->saddr;
 	ipv6h->daddr = fl6->daddr;
+
+	/* Reset the skb_iif to Tunnels interface index */
+	skb->skb_iif = dev->ifindex;
 	ip6tunnel_xmit(NULL, skb, dev);
 	return 0;
 tx_err_link_failure:
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 6d0b1f3..55cc431 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -26,7 +26,7 @@ int ip6_route_me_harder(struct net *net, struct sk_buff *skb)
 	int strict = (ipv6_addr_type(&iph->daddr) &
 		      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
 	struct flowi6 fl6 = {
-		.flowi6_oif = sk && sk->sk_bound_dev_if ? sk->sk_bound_dev_if :
+		.flowi6_oif = (sk && sk->sk_bound_dev_if && !skb->skb_iif) ? sk->sk_bound_dev_if :
 			strict ? skb_dst(skb)->dev->ifindex : 0,
 		.flowi6_mark = skb->mark,
 		.flowi6_uid = sock_net_uid(net, sk),
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index e8a1dab..1112ef2 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -988,6 +988,8 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
+	/* Reset the skb_iif to Tunnels interface index */
+	skb->skb_iif = dev->ifindex;
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return NETDEV_TX_OK;
@@ -1011,6 +1013,8 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_buff *skb,
 
 	skb_set_inner_ipproto(skb, ipproto);
 
+	/* Reset the skb_iif to Tunnels interface index */
+	skb->skb_iif = dev->ifindex;
 	ip_tunnel_xmit(skb, dev, tiph, ipproto);
 	return NETDEV_TX_OK;
 tx_error:
-- 
1.9.1

