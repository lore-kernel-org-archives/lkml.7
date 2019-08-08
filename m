Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DFAC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93B12173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291443;
	bh=d2X5vi0u/zBX98fB5Q1TwQW6QPlzwvIK4dSsR5HCzds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YglsvCZcSTScVB5GUv1SV7a4GAbTu0P0VEuwvLqSLOkYeVjOs14sHMJdqx7oRqf08
	 F+eRCsb8fysyw/fR5bX7vtSvdpZisbwVmNKqnG5i9kcu1+hg22lqX4gDWaPQHANAUV
	 NsTqz+gyeA87lTFhCVx+v52ksjcveWRUI8rxyIhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405341AbfHHTKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405334AbfHHTKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:10:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F762214C6;
        Thu,  8 Aug 2019 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291436;
        bh=d2X5vi0u/zBX98fB5Q1TwQW6QPlzwvIK4dSsR5HCzds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H73m8YE5clqLyKObtLHKM8cLzuf9DRYdwCOho58FI+NOMV7iImaZkOmq4CktWhEkZ
         SDr4PKABnEbbMWUfYQ673QuF/T1On8NZ3dG5KlH0Py2nFGymqHcISc1QX1c8NIFk2+
         Ql5e5vc8UlhlbN5YxYkRnXgHi6MJU+/ezGLec3SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 14/33] ip6_tunnel: fix possible use-after-free on xmit
Date:   Thu,  8 Aug 2019 21:05:21 +0200
Message-Id: <20190808190454.273335824@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.582417307@linuxfoundation.org>
References: <20190808190453.582417307@linuxfoundation.org>
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
 net/ipv6/ip6_tunnel.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1280,12 +1280,11 @@ ip4ip6_tnl_xmit(struct sk_buff *skb, str
 	}
 
 	fl6.flowi6_uid = sock_net_uid(dev_net(dev), NULL);
+	dsfield = INET_ECN_encapsulate(dsfield, ipv4_get_dsfield(iph));
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
 		return -1;
 
-	dsfield = INET_ECN_encapsulate(dsfield, ipv4_get_dsfield(iph));
-
 	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
@@ -1371,12 +1370,11 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, str
 	}
 
 	fl6.flowi6_uid = sock_net_uid(dev_net(dev), NULL);
+	dsfield = INET_ECN_encapsulate(dsfield, ipv6_get_dsfield(ipv6h));
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
 		return -1;
 
-	dsfield = INET_ECN_encapsulate(dsfield, ipv6_get_dsfield(ipv6h));
-
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,


