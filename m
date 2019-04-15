Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBB02075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356532;
	bh=NzRIEg0zWlu0bSbsWOXJMbU/oZlGSPP0WEqAlQh6CcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9TGL89YiyVcaGXcc+RxCVGjVoPhFoi79fHA4LY5Kv/HBMBTfg5pm33GMCnvtF2DP
	 sbp5gL1hv4LDCtLPIKDCdBpVqgU/+KL5XuAfeO8kS7UX5l5lPT/kF6KkWjeBQ/BVc8
	 2s+G5oJDB2UBTTQ9Xw3FJ9LTjaOq96n1V5N17Ls0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfDOT2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfDOTDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544AD218A1;
        Mon, 15 Apr 2019 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354979;
        bh=NzRIEg0zWlu0bSbsWOXJMbU/oZlGSPP0WEqAlQh6CcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKCzN4e1Yl7n+4K+/TG5vhkq5CEuHySVSjjuiTkm/aiRkrzjW+3KCOgqwHs5Ccbos
         HBKgHWsbuNKkPSgMJPseXAzBPkHF51+/S0ovrlXmXbjM8/h+vhs36RYYQpHIcJW6sr
         FZlN6SMxpYdelaSm64ixtaae5Zxwo9LEl06b72kc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 37/69] ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type
Date:   Mon, 15 Apr 2019 20:58:55 +0200
Message-Id: <20190415183732.246176653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>

[ Upstream commit b2e54b09a3d29c4db883b920274ca8dca4d9f04d ]

The device type for ip6 tunnels is set to
ARPHRD_TUNNEL6. However, the ip4ip6_err function
is expecting the device type of the tunnel to be
ARPHRD_TUNNEL.  Since the device types do not
match, the function exits and the ICMP error
packet is not sent to the originating host. Note
that the device type for IPv4 tunnels is set to
ARPHRD_TUNNEL.

Fix is to expect a tunnel device type of
ARPHRD_TUNNEL6 instead.  Now the tunnel device
type matches and the ICMP error packet is sent
to the originating host.

Signed-off-by: Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -633,7 +633,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 					   IPPROTO_IPIP,
 					   RT_TOS(eiph->tos), 0);
 		if (IS_ERR(rt) ||
-		    rt->dst.dev->type != ARPHRD_TUNNEL) {
+		    rt->dst.dev->type != ARPHRD_TUNNEL6) {
 			if (!IS_ERR(rt))
 				ip_rt_put(rt);
 			goto out;
@@ -643,7 +643,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 		ip_rt_put(rt);
 		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
 				   skb2->dev) ||
-		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL)
+		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
 


