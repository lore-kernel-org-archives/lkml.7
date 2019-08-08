Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6D0C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A6C214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291427;
	bh=qiYgcK43HU4xTj+4cIhgLdJuxtg4uUYn0P0UTlRbTlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPFxd7egkADCDLCQDActNYRZIYNyOgVqOMEGDlyzTs383fGqVDTz00HFL/22pwjUq
	 Y2J2EcIYJlpOY8h5RSqzZMfme2j26YTbUS/SaCx+MtRUJe98/6DTs2qypLagM8BLlK
	 aMKhTqrw1VHXiAhy7hRtbvhGTLtaNOOx3INKfJvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404902AbfHHTK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405280AbfHHTKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:10:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC6E214C6;
        Thu,  8 Aug 2019 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291421;
        bh=qiYgcK43HU4xTj+4cIhgLdJuxtg4uUYn0P0UTlRbTlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7g4tugPse4vxzWkQIzCI9/MPSI6oAA4Ra6SoLcbMwy6YSncFCR4Mjoz4JgudQ9mP
         nTNlhKMGL6nGu0rIwLB6e3uB8Hv41WTRo1HwVVHhLHrcM/uV6ooNA6DbllfOttGTQc
         vT/52JR7rwOmhem4M4ICtHM54FWUwabrV7hqmhJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 16/45] ip6_tunnel: fix possible use-after-free on xmit
Date:   Thu,  8 Aug 2019 21:05:02 +0200
Message-Id: <20190808190454.652366942@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
References: <20190808190453.827571908@linuxfoundation.org>
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
@@ -1283,12 +1283,11 @@ ip4ip6_tnl_xmit(struct sk_buff *skb, str
 	}
 
 	fl6.flowi6_uid = sock_net_uid(dev_net(dev), NULL);
+	dsfield = INET_ECN_encapsulate(dsfield, ipv4_get_dsfield(iph));
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
 		return -1;
 
-	dsfield = INET_ECN_encapsulate(dsfield, ipv4_get_dsfield(iph));
-
 	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
@@ -1372,12 +1371,11 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, str
 	}
 
 	fl6.flowi6_uid = sock_net_uid(dev_net(dev), NULL);
+	dsfield = INET_ECN_encapsulate(dsfield, ipv6_get_dsfield(ipv6h));
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
 		return -1;
 
-	dsfield = INET_ECN_encapsulate(dsfield, ipv6_get_dsfield(ipv6h));
-
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,


