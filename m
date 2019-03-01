Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B192083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HXlNQtBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCAXbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:31:05 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:49554 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbfCAXbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:31:04 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id D31351156;
        Fri,  1 Mar 2019 15:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1551483063;
        bh=XHvXLKBKWIKqOp2z4uYjcPWmjT/SnB6fQAPdVVA/rEQ=;
        h=Date:To:Subject:From;
        b=HXlNQtBaR6G43jol1YkZFipNflzzcjzH5gMdrnVlGr6hox2y2wFLkzwz1uZF294W/
         1ioNhI/DjPgYiaK+2Z01x6XiUGAylsB+1XVh3IR3QzqpwaHky2m6JDKGp2xcOaOTQx
         6d2/HIQPscwfe3FrSBjQ/v1Fh55ueQjHZYIxy8W9d6VobM1W2cIN1PKu1CimizWym+
         DpvilcDzl1gUG4RWFaFuijenY2YKON5e+6P20yWayf8AMwiqmbsBWYvRpsFXtXiPDa
         WHyRaASauCuXUo/HuwIEwSN60B8l4oVR1yub9l6ot3io6ZZMj5vTOW0nhxLbSHvHpS
         UNcZVpbvHqI5w==
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id D0D941151;
        Fri,  1 Mar 2019 15:31:03 -0800 (PST)
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id B4EE095C2D16; Fri,  1 Mar 2019 15:31:03 -0800 (PST)
Date:   Fri, 01 Mar 2019 15:31:03 -0800
To:     yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, davem@davemloft.net,
        maxim@arista.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, fruggeri@arista.com
Subject: [PATCH] net: ipv6: add socket option IPV6_ROUTER_ALERT_ISOLATE
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20190301233103.B4EE095C2D16@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default IPv6 socket with IPV6_ROUTER_ALERT socket option set will
receive all IPv6 RA packets from all namespaces.
IPV6_ROUTER_ALERT_ISOLATE socket option restricts packets received by
the socket to be only from the socket's namespace.

Signed-off-by: Maxim Martynov <maxim@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
---
 include/linux/ipv6.h     |  3 ++-
 include/uapi/linux/in6.h |  1 +
 net/ipv6/ip6_output.c    |  6 ++++++
 net/ipv6/ipv6_sockglue.c | 10 ++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 495e834c1367..26b8f45ffba3 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -275,7 +275,8 @@ struct ipv6_pinfo {
 				dontfrag:1,
 				autoflowlabel:1,
 				autoflowlabel_set:1,
-				mc_all:1;
+				mc_all:1,
+				rtalert_isolate:1;
 	__u8			min_hopcount;
 	__u8			tclass;
 	__be32			rcv_flowinfo;
diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index 71d82fe15b03..9f2273a08356 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -178,6 +178,7 @@ struct in6_flowlabel_req {
 #define IPV6_JOIN_ANYCAST	27
 #define IPV6_LEAVE_ANYCAST	28
 #define IPV6_MULTICAST_ALL	29
+#define IPV6_ROUTER_ALERT_ISOLATE	30
 
 /* IPV6_MTU_DISCOVER values */
 #define IPV6_PMTUDISC_DONT		0
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 5f9fa0302b5a..edbd12067170 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -300,6 +300,12 @@ static int ip6_call_ra_chain(struct sk_buff *skb, int sel)
 		if (sk && ra->sel == sel &&
 		    (!sk->sk_bound_dev_if ||
 		     sk->sk_bound_dev_if == skb->dev->ifindex)) {
+			struct ipv6_pinfo *np = inet6_sk(sk);
+
+			if (np && np->rtalert_isolate &&
+			    !net_eq(sock_net(sk), dev_net(skb->dev))) {
+				continue;
+			}
 			if (last) {
 				struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
 				if (skb2)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 973e215c3114..40f21fef25ff 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -787,6 +787,12 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		retv = ip6_ra_control(sk, val);
 		break;
+	case IPV6_ROUTER_ALERT_ISOLATE:
+		if (optlen < sizeof(int))
+			goto e_inval;
+		np->rtalert_isolate = valbool;
+		retv = 0;
+		break;
 	case IPV6_MTU_DISCOVER:
 		if (optlen < sizeof(int))
 			goto e_inval;
@@ -1358,6 +1364,10 @@ static int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		val = np->rxopt.bits.recvfragsize;
 		break;
 
+	case IPV6_ROUTER_ALERT_ISOLATE:
+		val = np->rtalert_isolate;
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.19.1

