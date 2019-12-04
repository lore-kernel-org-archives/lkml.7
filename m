Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBA1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8EE20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483204;
	bh=DgcQXiIgyHSxGbSxUc51xg1P7nmKC/rS5icNxdhZ+EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RVlS1ReLMYVdjPfAITTx3vVkNGraH6/omJv36QasLF2N/5MuRnKsAB1Oj1CNIUDjm
	 cDv/823UbDIpRDuMduj97kcntBg3t1g6Uhd9bAgImp4ib4WYWdnSDsq/gZ9kwGfrFF
	 NzlmzeGrHunT4S25+pg8NAFSTc7e16tt9hkMoK28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfLDSNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731727AbfLDSNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:13:16 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1533206DF;
        Wed,  4 Dec 2019 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483195;
        bh=DgcQXiIgyHSxGbSxUc51xg1P7nmKC/rS5icNxdhZ+EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbWN/u5fbQ+QidC1SUk89vWwsCcqgkZWOsVYt6G3i7c7pnP4DdpNaNtb3NLebr9PH
         0e+KYARz5Ma8KSDrWiYPJXnWEp85RhEvSJqFHuytN4nizbhMKuBiwBcUz5O7J394CD
         MwMOHe2d0fL0Gjur468bcv2ZxcmXwkyTJSorFJZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, wenxu <wenxu@ucloud.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 092/125] ip_tunnel: Make none-tunnel-dst tunnel port work with lwtunnel
Date:   Wed,  4 Dec 2019 18:56:37 +0100
Message-Id: <20191204175324.656279180@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

[ Upstream commit d71b57532d70c03f4671dd04e84157ac6bf021b0 ]

ip l add dev tun type gretap key 1000
ip a a dev tun 10.0.0.1/24

Packets with tun-id 1000 can be recived by tun dev. But packet can't
be sent through dev tun for non-tunnel-dst

With this patch: tunnel-dst can be get through lwtunnel like beflow:
ip r a 10.0.0.7 encap ip dst 172.168.0.11 dev tun

Signed-off-by: wenxu <wenxu@ucloud.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6ee6acac80c4..a4db2d79b9134 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -653,13 +653,19 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	dst = tnl_params->daddr;
 	if (dst == 0) {
 		/* NBMA tunnel */
+		struct ip_tunnel_info *tun_info;
 
 		if (!skb_dst(skb)) {
 			dev->stats.tx_fifo_errors++;
 			goto tx_error;
 		}
 
-		if (skb->protocol == htons(ETH_P_IP)) {
+		tun_info = skb_tunnel_info(skb);
+		if (tun_info && (tun_info->mode & IP_TUNNEL_INFO_TX) &&
+		    ip_tunnel_info_af(tun_info) == AF_INET &&
+		    tun_info->key.u.ipv4.dst)
+			dst = tun_info->key.u.ipv4.dst;
+		else if (skb->protocol == htons(ETH_P_IP)) {
 			rt = skb_rtable(skb);
 			dst = rt_nexthop(rt, inner_iph->daddr);
 		}
-- 
2.20.1



