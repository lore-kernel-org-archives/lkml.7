Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F37C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36C42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfH1OEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:04:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:39678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfH1ODc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:03:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 129F1B64B;
        Wed, 28 Aug 2019 14:03:31 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next 06/15] net: sgi: ioc3-eth: get rid of ioc3_clean_rx_ring()
Date:   Wed, 28 Aug 2019 16:03:05 +0200
Message-Id: <20190828140315.17048-7-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190828140315.17048-1-tbogendoerfer@suse.de>
References: <20190828140315.17048-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean rx ring is just called once after a new ring is allocated, which
is per definition clean. So there is not need for this function.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 6ca560d4ab79..39631e067b71 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -761,26 +761,6 @@ static void ioc3_mii_start(struct ioc3_private *ip)
 	add_timer(&ip->ioc3_timer);
 }
 
-static inline void ioc3_clean_rx_ring(struct ioc3_private *ip)
-{
-	struct ioc3_erxbuf *rxb;
-	struct sk_buff *skb;
-	int i;
-
-	for (i = ip->rx_ci; i & 15; i++) {
-		ip->rx_skbs[ip->rx_pi] = ip->rx_skbs[ip->rx_ci];
-		ip->rxr[ip->rx_pi++] = ip->rxr[ip->rx_ci++];
-	}
-	ip->rx_pi &= RX_RING_MASK;
-	ip->rx_ci &= RX_RING_MASK;
-
-	for (i = ip->rx_ci; i != ip->rx_pi; i = (i + 1) & RX_RING_MASK) {
-		skb = ip->rx_skbs[i];
-		rxb = (struct ioc3_erxbuf *)(skb->data - RX_OFFSET);
-		rxb->w0 = 0;
-	}
-}
-
 static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
 {
 	struct sk_buff *skb;
@@ -860,7 +840,6 @@ static void ioc3_init_rings(struct net_device *dev)
 	ioc3_free_rings(ip);
 	ioc3_alloc_rings(dev);
 
-	ioc3_clean_rx_ring(ip);
 	ioc3_clean_tx_ring(ip);
 
 	/* Now the rx ring base, consume & produce registers.  */
-- 
2.13.7

