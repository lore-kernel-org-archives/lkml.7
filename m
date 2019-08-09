Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE65C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7679021773
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565358446;
	bh=xD6mmyx4qmu7XUgr3j1ZkhH9i2aaST81fAJxUf7glKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hh8OCakD3MfBuKBvz+hnpAQRahtA3Wl49FKwH5XNTP8ZTS+suq70p5D5YSS7/K6o7
	 t0H2dn8omgn2xhMVBeZLIT+apvftPB1WVvAlN7TjdUuxxryhJUuc+iM3hfS66XEUvU
	 g0vNc2rj2W5Gmy+sP0uLjm0hnLiDfQaETmzFxi3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436601AbfHINrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407218AbfHINrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391372171F;
        Fri,  9 Aug 2019 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565358435;
        bh=xD6mmyx4qmu7XUgr3j1ZkhH9i2aaST81fAJxUf7glKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnrnkX4hQQXWvmHMfTw3XfLBQy1xo9a8OXr5+B6er7k312CwJe6Fl+IpaqLhJ7x42
         2tAOrqma4DPNqmu7+x/vR5wAcfE32iOq+q2SPc8GNeaptpXaAGthamuVJqk52GXdy5
         S9b+EgA4I+vks7QP+0RcgpNHX4+jdMA3ip4bihBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 23/32] ip6_tunnel: fix possible use-after-free on xmit
Date:   Fri,  9 Aug 2019 15:45:26 +0200
Message-Id: <20190809133923.685751310@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809133922.945349906@linuxfoundation.org>
References: <20190809133922.945349906@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 01f5bffad555f8e22a61f4b1261fe09cf1b96994 ]

ip4ip6/ip6ip6 tunnels run iptunnel_handle_offloads on xmit which
can cause a possible use-after-free accessing iph/ipv6h pointer
since the packet will be 'uncloned' running pskb_expand_head if
it is a cloned gso skb.

Fixes: 0e9a709560db ("ip6_tunnel, ip6_gre: fix setting of DSCP on encapsulated packets")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1275,11 +1275,11 @@ ip4ip6_tnl_xmit(struct sk_buff *skb, str
 			fl6.flowi6_mark = skb->mark;
 	}
 
+	dsfield = INET_ECN_encapsulate(dsfield, ipv4_get_dsfield(iph));
+
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
 		return -1;
 
-	dsfield = INET_ECN_encapsulate(dsfield, ipv4_get_dsfield(iph));
-
 	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
@@ -1362,11 +1362,11 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, str
 			fl6.flowi6_mark = skb->mark;
 	}
 
+	dsfield = INET_ECN_encapsulate(dsfield, ipv6_get_dsfield(ipv6h));
+
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
 		return -1;
 
-	dsfield = INET_ECN_encapsulate(dsfield, ipv6_get_dsfield(ipv6h));
-
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,


