Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C9C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED182089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfFUPew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:34:52 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49943 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:34:52 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3D8651C000E;
        Fri, 21 Jun 2019 15:34:46 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, nicolas.ferre@microchip.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
Subject: [PATCH net-next] net: macb: use GRO
Date:   Fri, 21 Jun 2019 17:30:02 +0200
Message-Id: <20190621153002.30587-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the macb driver to use NAPI GRO helpers when
receiving SKBs. This improves performances.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 00ee5e8e0ff0..a8ed28b597c0 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1063,7 +1063,8 @@ struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
 	void	(*mog_init_rings)(struct macb *bp);
-	int	(*mog_rx)(struct macb_queue *queue, int budget);
+	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
+			  int budget);
 };
 
 /* MACB-PTP interface: adapt to platform needs. */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1cd1f2c36d6f..f1cf50b8ad11 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -994,7 +994,8 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
-static int gem_rx(struct macb_queue *queue, int budget)
+static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
+		  int budget)
 {
 	struct macb *bp = queue->bp;
 	unsigned int		len;
@@ -1076,7 +1077,7 @@ static int gem_rx(struct macb_queue *queue, int budget)
 			       skb->data, 32, true);
 #endif
 
-		netif_receive_skb(skb);
+		napi_gro_receive(napi, skb);
 	}
 
 	gem_rx_refill(queue);
@@ -1084,8 +1085,8 @@ static int gem_rx(struct macb_queue *queue, int budget)
 	return count;
 }
 
-static int macb_rx_frame(struct macb_queue *queue, unsigned int first_frag,
-			 unsigned int last_frag)
+static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
+			 unsigned int first_frag, unsigned int last_frag)
 {
 	unsigned int len;
 	unsigned int frag;
@@ -1161,7 +1162,7 @@ static int macb_rx_frame(struct macb_queue *queue, unsigned int first_frag,
 	bp->dev->stats.rx_bytes += skb->len;
 	netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
 		    skb->len, skb->csum);
-	netif_receive_skb(skb);
+	napi_gro_receive(napi, skb);
 
 	return 0;
 }
@@ -1184,7 +1185,8 @@ static inline void macb_init_rx_ring(struct macb_queue *queue)
 	queue->rx_tail = 0;
 }
 
-static int macb_rx(struct macb_queue *queue, int budget)
+static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
+		   int budget)
 {
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
@@ -1221,7 +1223,7 @@ static int macb_rx(struct macb_queue *queue, int budget)
 				continue;
 			}
 
-			dropped = macb_rx_frame(queue, first_frag, tail);
+			dropped = macb_rx_frame(queue, napi, first_frag, tail);
 			first_frag = -1;
 			if (unlikely(dropped < 0)) {
 				reset_rx_queue = true;
@@ -1275,7 +1277,7 @@ static int macb_poll(struct napi_struct *napi, int budget)
 	netdev_vdbg(bp->dev, "poll: status = %08lx, budget = %d\n",
 		    (unsigned long)status, budget);
 
-	work_done = bp->macbgem_ops.mog_rx(queue, budget);
+	work_done = bp->macbgem_ops.mog_rx(queue, napi, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 
-- 
2.21.0

