Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D71C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE3D2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfH2PwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:52:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:32846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728250AbfH2Pug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:50:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4CC4B69F;
        Thu, 29 Aug 2019 15:50:34 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 net-next 06/15] net: sgi: ioc3-eth: get rid of ioc3_clean_rx_ring()
Date:   Thu, 29 Aug 2019 17:50:04 +0200
Message-Id: <20190829155014.9229-7-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190829155014.9229-1-tbogendoerfer@suse.de>
References: <20190829155014.9229-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move clearing of the descriptor valid bit into ioc3_alloc_rings. This
makes ioc3_clean_rx_ring obsolete.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index d9d94a55ac34..e3867ea9abb7 100644
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
@@ -841,6 +821,7 @@ static void ioc3_alloc_rings(struct net_device *dev)
 		/* Because we reserve afterwards. */
 		skb_put(skb, (1664 + RX_OFFSET));
 		rxb = (struct ioc3_erxbuf *)skb->data;
+		rxb->w0 = 0;	/* Clear valid flag */
 		ip->rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
 		skb_reserve(skb, RX_OFFSET);
 	}
@@ -860,7 +841,6 @@ static void ioc3_init_rings(struct net_device *dev)
 	ioc3_free_rings(ip);
 	ioc3_alloc_rings(dev);
 
-	ioc3_clean_rx_ring(ip);
 	ioc3_clean_tx_ring(ip);
 
 	/* Now the rx ring base, consume & produce registers.  */
-- 
2.13.7

