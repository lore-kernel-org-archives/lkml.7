Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7FAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACB22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356355;
	bh=rQphpVjouBAQr1c3g7nBTLSvw6Ia9Nq0X1ElDqoDqio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVm4wID0O4XsvI9wV8qNeti1KAMxeqJPSYV7sl3qRJMDwgew0iOnoC0EDQw9FdYn6
	 pY+eNngXwz7xCFCzY+arpxRv8vrJ7ib/FVYPx4kIP0xN30YqlmCso8KRNwjJee/euu
	 vL3KQ8s1qsXXMMkvjpBz7wRJ37CnUoHjs8SZfR5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfDOTZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbfDOTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F402087C;
        Mon, 15 Apr 2019 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355108;
        bh=rQphpVjouBAQr1c3g7nBTLSvw6Ia9Nq0X1ElDqoDqio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2dUB4qb3wU44l8XzlYl2woDcXP6tv9UiYJFfEwkuGkTxyx7sciw1NSPpDXA94FjU
         1feXg643WfYE95KcKenb/kc/zDSxL0j4C8cbfJ/66PMAIaaJ1DTFhm6do5T3Xmj9d4
         6a174YnrIYy/0sKEWCCnLvGaIqb/NVXNIj1WC/FI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/101] ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type
Date:   Mon, 15 Apr 2019 20:58:04 +0200
Message-Id: <20190415183740.688095494@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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



