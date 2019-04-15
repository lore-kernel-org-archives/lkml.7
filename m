Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132AAC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1F6218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354025;
	bh=vzlzmWxzTtKvmH/ZOwAKKyMqhwy3x8/6Q1taPPIiVP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dav1No2VtVMd7kOrfyqt01d3ZLcliiQlwLCTyVmG6qhxuGz6fJ97peFMPJij97ab4
	 G5jpnpfpTOTXEFILl4PYqwzrdruEMtm9Eu09i72/3AmYg+OFAUn/NRGnGc6WcE4g9D
	 pE/YDX0imK+aqTrVzmHX0w5sOPGfCBmxZDM2QTq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfDOSrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbfDOSrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8296218FC;
        Mon, 15 Apr 2019 18:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354019;
        bh=vzlzmWxzTtKvmH/ZOwAKKyMqhwy3x8/6Q1taPPIiVP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGbgA4qUNs1X2deIUxSPjWwL+y/wIB+/QToX7KcOXqlyd8lOUFkGwedpV7JGYUPi6
         1LzlTICn8jU/pouSd8L2F9NzZ+SntmwLsD4UJseheOj9VHPXIatPfyIq5KyxfGDqr/
         2iujeK5c3TVRG3TojeuBw2XslZXV2TSAVst3JcW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 56/76] vrf: check accept_source_route on the original netdevice
Date:   Mon, 15 Apr 2019 20:44:20 +0200
Message-Id: <20190415183724.048353439@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Suryaputra <ssuryaextr@gmail.com>

[ Upstream commit 8c83f2df9c6578ea4c5b940d8238ad8a41b87e9e ]

Configuration check to accept source route IP options should be made on
the incoming netdevice when the skb->dev is an l3mdev master. The route
lookup for the source route next hop also needs the incoming netdev.

v2->v3:
- Simplify by passing the original netdevice down the stack (per David
  Ahern).

Signed-off-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip.h      |    2 +-
 net/ipv4/ip_input.c   |    7 +++----
 net/ipv4/ip_options.c |    4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -580,7 +580,7 @@ int ip_options_get_from_user(struct net
 			     unsigned char __user *data, int optlen);
 void ip_options_undo(struct ip_options *opt);
 void ip_forward_options(struct sk_buff *skb);
-int ip_options_rcv_srr(struct sk_buff *skb);
+int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
 
 /*
  *	Functions provided by ip_sockglue.c
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -259,11 +259,10 @@ int ip_local_deliver(struct sk_buff *skb
 		       ip_local_deliver_finish);
 }
 
-static inline bool ip_rcv_options(struct sk_buff *skb)
+static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip_options *opt;
 	const struct iphdr *iph;
-	struct net_device *dev = skb->dev;
 
 	/* It looks as overkill, because not all
 	   IP options require packet mangling.
@@ -299,7 +298,7 @@ static inline bool ip_rcv_options(struct
 			}
 		}
 
-		if (ip_options_rcv_srr(skb))
+		if (ip_options_rcv_srr(skb, dev))
 			goto drop;
 	}
 
@@ -361,7 +360,7 @@ static int ip_rcv_finish(struct net *net
 	}
 #endif
 
-	if (iph->ihl > 5 && ip_rcv_options(skb))
+	if (iph->ihl > 5 && ip_rcv_options(skb, dev))
 		goto drop;
 
 	rt = skb_rtable(skb);
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -614,7 +614,7 @@ void ip_forward_options(struct sk_buff *
 	}
 }
 
-int ip_options_rcv_srr(struct sk_buff *skb)
+int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip_options *opt = &(IPCB(skb)->opt);
 	int srrspace, srrptr;
@@ -649,7 +649,7 @@ int ip_options_rcv_srr(struct sk_buff *s
 
 		orefdst = skb->_skb_refdst;
 		skb_dst_set(skb, NULL);
-		err = ip_route_input(skb, nexthop, iph->saddr, iph->tos, skb->dev);
+		err = ip_route_input(skb, nexthop, iph->saddr, iph->tos, dev);
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);


