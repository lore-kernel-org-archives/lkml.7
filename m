Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEDEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146C20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402395;
	bh=OUxMEqaedTerczHBI7WUPaEO4Ds7NoVMV/fIilPn1tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VBZAFtDnSEH75DSFHsp9rTCjbAIhn8DKGGpX3mgd9BRV4Cv9CDtNKx4ZoZ2GNMokf
	 CxOEh+PR/K7TejY0zqxqgrp9d6InMtJK+OjOUnESmIY9Yw4iUIZDtGx6rJh1Ae4wmw
	 WIKEpOeI6sHJxnu/vQu60/hY9b+IhZl/j5ZE9wbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfKVF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbfKVF5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5972070A;
        Fri, 22 Nov 2019 05:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402265;
        bh=OUxMEqaedTerczHBI7WUPaEO4Ds7NoVMV/fIilPn1tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrwlhPWDKxUkK4fMnELIT8wlVhj9Jd6oGP9tPiTEMjZrdnDypCg7hgqgQ3pityuGV
         ZFz1NdTX2BViq0VfIb4YU19eaA82DxsJ1QINnC29kXv+/K+nkfMR8ipHqfX0ox77C/
         7FRmEwtGUrZr5CJZeC4XdCBdEolHVbKOPK6kd7rU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wenxu <wenxu@ucloud.cn>, "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 106/127] ip_tunnel: Make none-tunnel-dst tunnel port work with lwtunnel
Date:   Fri, 22 Nov 2019 00:55:24 -0500
Message-Id: <20191122055544.3299-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index fabc299cb875f..7a31287ff1232 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -661,13 +661,19 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
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

