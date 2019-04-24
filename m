Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D571C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E7C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129062;
	bh=hlONfSzjJg5fgtnLZI6dd6qUWiP3++aLO/I8xtegk8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGYia6hPYSPzJO8/VxZCHYEM+bskz6Vs16Mn1YqobbMpInPGdwcpXyv9+PzEGKCQU
	 VrNd3KmLjuAYCsobcYT8+M9BsmkBNGiAjwfEUNXejodXpGmsgOlADN74HIsyB225Aa
	 qID9StrDSC9qH10IMEUJHLhYgraiVYSW4BHO5IuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbfDXSEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388165AbfDXRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3485821915;
        Wed, 24 Apr 2019 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126366;
        bh=hlONfSzjJg5fgtnLZI6dd6qUWiP3++aLO/I8xtegk8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGRlx+8rJuFSCX7P2ak5Ofj6C4OnmWLk/oSeYh8O4iyBYqZOkrXs+KN1ZLa6cTyUJ
         YToUXUbWarfoqvJRJPWPUJhUjrAFsvFudT2FDT9pfasDD1BRpvWs+6DZZVSJJWvdvn
         PEeJCdV1x8twCOfWyyakmGBDeZQa6Gs2cJXw/z24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 086/168] ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type
Date:   Wed, 24 Apr 2019 19:08:50 +0200
Message-Id: <20190424170928.880304574@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -622,7 +622,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 					   IPPROTO_IPIP,
 					   RT_TOS(eiph->tos), 0);
 		if (IS_ERR(rt) ||
-		    rt->dst.dev->type != ARPHRD_TUNNEL) {
+		    rt->dst.dev->type != ARPHRD_TUNNEL6) {
 			if (!IS_ERR(rt))
 				ip_rt_put(rt);
 			goto out;
@@ -632,7 +632,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 		ip_rt_put(rt);
 		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
 				   skb2->dev) ||
-		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL)
+		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
 


