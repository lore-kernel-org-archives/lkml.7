Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B985C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D06D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413258;
	bh=TP9vxTRQCvKYd1TJWs+1gVM38nsxIQNmjHkB99AyrMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SjjRCVF+Bjk31Cj4hGuSZS0n68E3VJQ54JyMzowha9mZ3+stzblUdQ9YFp/wfVjF6
	 FAeCZLbEteOaosa99SGepUMsx87CigKLN1PoLvpXHCb9caiOCmiq4r72iFaC2mO/LW
	 5Bz56faKmqJybquhzuq40MPRNpaSP3voK0HGy6Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfCLRyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfCLROM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:12 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EBE921850;
        Tue, 12 Mar 2019 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410851;
        bh=TP9vxTRQCvKYd1TJWs+1gVM38nsxIQNmjHkB99AyrMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fu2Lenq5fofdZ7eyOx8HO48P48EclwaoYaPA8FUN4LfVmuhDToY327Y8OfFjA1RLx
         dyyYriir3/A66YtqZam8/fdkDw0stTkiSt6SZLj2moCw+dm/gpPdPnKPdmh0PpDx4p
         rEbL8pxtmkkON2mgO4IzJ5wMSBBxUU5acGBlJX5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/149] net: macb: Apply RXUBR workaround only to versions with errata
Date:   Tue, 12 Mar 2019 10:07:44 -0700
Message-Id: <20190312170353.650427272@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e501070e4db0b67a4c17a5557d1e9d098f3db310 ]

The interrupt handler contains a workaround for RX hang applicable
to Zynq and AT91RM9200 only. Subsequent versions do not need this
workaround. This workaround unnecessarily resets RX whenever RX used
bit read is observed, which can be often under heavy traffic. There
is no other action performed on RX UBR interrupt. Hence introduce a
CAPS mask; enable this interrupt and workaround only on affected
versions.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 3d45f4c92cf6..9bbaad9f3d63 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -643,6 +643,7 @@
 #define MACB_CAPS_JUMBO				0x00000020
 #define MACB_CAPS_GEM_HAS_PTP			0x00000040
 #define MACB_CAPS_BD_RD_PREFETCH		0x00000080
+#define MACB_CAPS_NEEDS_RSTONUBR		0x00000100
 #define MACB_CAPS_FIFO_MODE			0x10000000
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
@@ -1214,6 +1215,8 @@ struct macb {
 
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
+
+	u32	rx_intr_mask;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8f4b2f9a8e07..8abea1c3844f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -56,8 +56,7 @@
 /* level of occupied TX descriptors under which we wake up TX process */
 #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
 
-#define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(RXUBR)	\
-				 | MACB_BIT(ISR_ROVR))
+#define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(ISR_ROVR))
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
 					| MACB_BIT(ISR_RLE)		\
 					| MACB_BIT(TXERR))
@@ -1271,7 +1270,7 @@ static int macb_poll(struct napi_struct *napi, int budget)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 			napi_reschedule(napi);
 		} else {
-			queue_writel(queue, IER, MACB_RX_INT_FLAGS);
+			queue_writel(queue, IER, bp->rx_intr_mask);
 		}
 	}
 
@@ -1289,7 +1288,7 @@ static void macb_hresp_error_task(unsigned long data)
 	u32 ctrl;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, IDR, MACB_RX_INT_FLAGS |
+		queue_writel(queue, IDR, bp->rx_intr_mask |
 					 MACB_TX_INT_FLAGS |
 					 MACB_BIT(HRESP));
 	}
@@ -1319,7 +1318,7 @@ static void macb_hresp_error_task(unsigned long data)
 
 		/* Enable interrupts */
 		queue_writel(queue, IER,
-			     MACB_RX_INT_FLAGS |
+			     bp->rx_intr_mask |
 			     MACB_TX_INT_FLAGS |
 			     MACB_BIT(HRESP));
 	}
@@ -1373,14 +1372,14 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
 
-		if (status & MACB_RX_INT_FLAGS) {
+		if (status & bp->rx_intr_mask) {
 			/* There's no point taking any more interrupts
 			 * until we have processed the buffers. The
 			 * scheduling call may fail if the poll routine
 			 * is already scheduled, so disable interrupts
 			 * now.
 			 */
-			queue_writel(queue, IDR, MACB_RX_INT_FLAGS);
+			queue_writel(queue, IDR, bp->rx_intr_mask);
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
@@ -1413,8 +1412,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		/* There is a hardware issue under heavy load where DMA can
 		 * stop, this causes endless "used buffer descriptor read"
 		 * interrupts but it can be cleared by re-enabling RX. See
-		 * the at91 manual, section 41.3.1 or the Zynq manual
-		 * section 16.7.4 for details.
+		 * the at91rm9200 manual, section 41.3.1 or the Zynq manual
+		 * section 16.7.4 for details. RXUBR is only enabled for
+		 * these two versions.
 		 */
 		if (status & MACB_BIT(RXUBR)) {
 			ctrl = macb_readl(bp, NCR);
@@ -2264,7 +2264,7 @@ static void macb_init_hw(struct macb *bp)
 
 		/* Enable interrupts */
 		queue_writel(queue, IER,
-			     MACB_RX_INT_FLAGS |
+			     bp->rx_intr_mask |
 			     MACB_TX_INT_FLAGS |
 			     MACB_BIT(HRESP));
 	}
@@ -3912,6 +3912,7 @@ static const struct macb_config sama5d4_config = {
 };
 
 static const struct macb_config emac_config = {
+	.caps = MACB_CAPS_NEEDS_RSTONUBR,
 	.clk_init = at91ether_clk_init,
 	.init = at91ether_init,
 };
@@ -3933,7 +3934,8 @@ static const struct macb_config zynqmp_config = {
 };
 
 static const struct macb_config zynq_config = {
-	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF,
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
+		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -4088,6 +4090,10 @@ static int macb_probe(struct platform_device *pdev)
 						macb_dma_desc_get_size(bp);
 	}
 
+	bp->rx_intr_mask = MACB_RX_INT_FLAGS;
+	if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
+		bp->rx_intr_mask |= MACB_BIT(RXUBR);
+
 	mac = of_get_mac_address(np);
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
-- 
2.19.1



