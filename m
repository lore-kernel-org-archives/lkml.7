Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956CBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEA922BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033268;
	bh=bU8JmnIf0S2UTSfiMcOwDN2VXep2/+pVvG31xsfqtKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hh4WnuPomEggz9QSRHkForoRiJ/T0Mb5tEqV8M5XnTD+mKEhUKls0wyQFO28nZOSo
	 IeiAUVOBfuKM7Iedf6efFVHe1MQwX1053tsUDJQfQmsuB7DCHbIGEhVq6xo4DQRVD+
	 Sj8hj3ktZcDvBJKQQ6U6D2xjxUQJWYwJ3NJyiO3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404539AbfGYFlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404520AbfGYFlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:41:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A072222BF3;
        Thu, 25 Jul 2019 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033264;
        bh=bU8JmnIf0S2UTSfiMcOwDN2VXep2/+pVvG31xsfqtKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stRgVfx0UBRqlmymwbSzxrXMO60ECwEiCKTYH3j88cpbPtC62ugDA/joQjbsyFE2x
         D8sfmIix4pJG1IbYAxBcUseYnrVmCMgOdJMXKDH9ij6Pndq/NGm8uYkGHur4gCGHQ9
         v5rGMeRnvdcH1bdvSJAlMKSMiUfxMG2haqKCgEkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Michael Scott <mike@foundries.io>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 149/271] Bluetooth: 6lowpan: search for destination address in all peers
Date:   Wed, 24 Jul 2019 21:20:18 +0200
Message-Id: <20190724191707.953222987@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b188b03270b7f8568fc714101ce82fbf5e811c5a ]

Handle overlooked case where the target address is assigned to a peer
and neither route nor gateway exist.

For one peer, no checks are performed to see if it is meant to receive
packets for a given address.

As soon as there is a second peer however, checks are performed
to deal with routes and gateways for handling complex setups with
multiple hops to a target address.
This logic assumed that no route and no gateway imply that the
destination address can not be reached, which is false in case of a
direct peer.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Tested-by: Michael Scott <mike@foundries.io>
Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/6lowpan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4e2576fc0c59..357475cceec6 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -187,10 +187,16 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 	}
 
 	if (!rt) {
-		nexthop = &lowpan_cb(skb)->gw;
-
-		if (ipv6_addr_any(nexthop))
-			return NULL;
+		if (ipv6_addr_any(&lowpan_cb(skb)->gw)) {
+			/* There is neither route nor gateway,
+			 * probably the destination is a direct peer.
+			 */
+			nexthop = daddr;
+		} else {
+			/* There is a known gateway
+			 */
+			nexthop = &lowpan_cb(skb)->gw;
+		}
 	} else {
 		nexthop = rt6_nexthop(rt, daddr);
 
-- 
2.20.1



