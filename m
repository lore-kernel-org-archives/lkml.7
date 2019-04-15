Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03049C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC0B20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355391;
	bh=rQphpVjouBAQr1c3g7nBTLSvw6Ia9Nq0X1ElDqoDqio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UQs28kc5so3uy7hUjroSUgfd7RUKUazS8FtuzmC70qp3Ydn7zgbTph0eGuZZWKteP
	 jrvIY3dwJ5xhtiwftruSMBPXKMIF5bqHLzPoomDEPwxYp5h3FzW6no4oeBOSoJncFf
	 JQvk+VJoIOBeyDKeK15EhRCGeHyk1XWGwHWiS4gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfDOTJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbfDOTJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A2820880;
        Mon, 15 Apr 2019 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355387;
        bh=rQphpVjouBAQr1c3g7nBTLSvw6Ia9Nq0X1ElDqoDqio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOgYlQTO9rS6R0xWFYyYjgyux960C4EGY79GmWkkt5iesY5WOmdy3b8kq4ytVsfAN
         +/KjU6e17y1U74HMJLsM4AjLA7QAl9DN9/rMUmOGpTL7xtuo9BglSGSo2PamAoyRxL
         GSZfgPkjuSDSmALl9rEuINx3lqyvqZXAI7jOt8PA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 008/117] ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type
Date:   Mon, 15 Apr 2019 20:59:38 +0200
Message-Id: <20190415183745.312422842@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 0c6403cf8b52..ade1390c6348 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -627,7 +627,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
 					   eiph->daddr, eiph->saddr, 0, 0,
 					   IPPROTO_IPIP, RT_TOS(eiph->tos), 0);
-		if (IS_ERR(rt) || rt->dst.dev->type != ARPHRD_TUNNEL) {
+		if (IS_ERR(rt) || rt->dst.dev->type != ARPHRD_TUNNEL6) {
 			if (!IS_ERR(rt))
 				ip_rt_put(rt);
 			goto out;
@@ -636,7 +636,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	} else {
 		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
 				   skb2->dev) ||
-		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL)
+		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
 
-- 
2.19.1



