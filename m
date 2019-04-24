Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78D1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D0421903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125984;
	bh=C2CU/o7t4Hm8HZii7SPRwgDUbgo+tL/Dm5lywnxL8jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EdYHQk3906tAs+Ok9JYYFzKoYC4HXZPvq0u7eObqyYowgFMRxvsEq9m7u4Hnd/uBb
	 7zUZsQK4rtFXokmIB2kccZDgT9qtn2XkqawYHZ32n07TESaS/2WMUAiTZq++i37ClZ
	 oZW115qRjb4SSXbbBkK62QoWP8KD4DHClxUQDMsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbfDXRND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387766AbfDXRNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:01 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB5821900;
        Wed, 24 Apr 2019 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125981;
        bh=C2CU/o7t4Hm8HZii7SPRwgDUbgo+tL/Dm5lywnxL8jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDSBIHSFQU1XgvOBmfFZv0OykfL1Y/OjEcQYaITZbmOZvjsLnvgA9swP4ig8x3T4L
         NHKt4NayxxRFr47s4Lc9avjk14obIuscSYikhS1RstqPGls+QH5JRo8QQSJ5xQmhp4
         oU70sPGCVkTL8qKARM6CuFo/pUG6FpqLyGf1eB64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 051/104] ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type
Date:   Wed, 24 Apr 2019 19:09:08 +0200
Message-Id: <20190424170901.640176755@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
@@ -638,7 +638,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 					   IPPROTO_IPIP,
 					   RT_TOS(eiph->tos), 0);
 		if (IS_ERR(rt) ||
-		    rt->dst.dev->type != ARPHRD_TUNNEL) {
+		    rt->dst.dev->type != ARPHRD_TUNNEL6) {
 			if (!IS_ERR(rt))
 				ip_rt_put(rt);
 			goto out;
@@ -648,7 +648,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 		ip_rt_put(rt);
 		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
 				   skb2->dev) ||
-		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL)
+		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
 


