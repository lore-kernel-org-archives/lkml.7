Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28449C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1412073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354123;
	bh=fqqghuoew1fAiTkUKaRTLpkDR40Vu5aPq0rH1RLLJgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MyL8Mugn/2zx/JWAHY/MKpB0PLpRXskCNSmqbxbNI509GWA8M8BNKaMOb7on4an3T
	 Bw1X+9OQxR4EUn92NuBJfmA7uA0NqhqH2YoqrrEvbvLsM04/EGGUbhZEWb5kdINBwW
	 HMBZ8+nMxYX79mRyXyDn6DHIz0NrJ7SLI3KyXHO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfDOSsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfDOSrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4682087C;
        Mon, 15 Apr 2019 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354071;
        bh=fqqghuoew1fAiTkUKaRTLpkDR40Vu5aPq0rH1RLLJgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5F6sIsBRdMX5055Y8men1/KhnXHkynYM92jp3z7muK2i3ZA4kaZIWUsx4CM4OfOD
         HV1dZkF93rGOj3f5GvehH59C/021GurgsA+43oV/H/XHPWlZZyihYaOfEfPRBMhYgr
         YpF004pxz8uIHJtXOyTcb0xplGT1ct5MdaZfcm4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 62/76] ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type
Date:   Mon, 15 Apr 2019 20:44:26 +0200
Message-Id: <20190415183725.492172798@linuxfoundation.org>
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
@@ -634,7 +634,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 					   IPPROTO_IPIP,
 					   RT_TOS(eiph->tos), 0);
 		if (IS_ERR(rt) ||
-		    rt->dst.dev->type != ARPHRD_TUNNEL) {
+		    rt->dst.dev->type != ARPHRD_TUNNEL6) {
 			if (!IS_ERR(rt))
 				ip_rt_put(rt);
 			goto out;
@@ -644,7 +644,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 		ip_rt_put(rt);
 		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
 				   skb2->dev) ||
-		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL)
+		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
 


