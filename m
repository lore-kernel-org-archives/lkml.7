Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54627C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DC221473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDIFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:48:14 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41542 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfDIFsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:48:14 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2D51645D417A2F6FA42D;
        Tue,  9 Apr 2019 13:48:11 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x395m5Fc046077;
        Tue, 9 Apr 2019 13:48:05 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040913482107-7975996 ;
          Tue, 9 Apr 2019 13:48:21 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] net: xilinx: add a helper function for axienet_probe
Date:   Tue, 9 Apr 2019 13:48:00 +0800
Message-Id: <1554788881-22647-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-09 13:48:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-09 13:48:03,
        Serialize complete at 2019-04-09 13:48:03
X-MAIL: mse01.zte.com.cn x395m5Fc046077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Find DMA Node, Map DMA Register, and Decode DMA IRQ" code snippets
in Axienet_Probe are independent. Tidy up axienet_probe a little by
factoring these out into a helper function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Cc: Anirudha Sarangi <anirudh@xilinx.com>
Cc: John Linn <John.Linn@xilinx.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 69 +++++++++++++++--------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 4041c75..2d15897 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1434,6 +1434,48 @@ static void axienet_dma_err_handler(unsigned long data)
 }
 
 /**
+ * axienet_dma_res_init - Initialize the DMA related resources of
+ *                        the axienet local structure.
+ * @lp: Pointer to axienet local structure
+ *
+ * Return: 0, on success
+ *	    Non-zero error value on failure.
+ *
+ * This function find the DMA node via pdev, map the DMA registers,
+ * and decode the DMA IRQs.
+ */
+static int axienet_dma_res_init(struct axienet_local *lp)
+{
+	struct resource dmares;
+	struct device_node *np;
+	int ret;
+
+	np = of_parse_phandle(lp->dev->of_node, "axistream-connected", 0);
+	if (!np) {
+		dev_err(lp->dev, "could not find DMA node\n");
+		ret = -ENODEV;
+		return ret;
+	}
+	ret = of_address_to_resource(np, 0, &dmares);
+	if (ret) {
+		dev_err(lp->dev, "unable to get DMA resource\n");
+		goto put_node;
+	}
+	lp->dma_regs = devm_ioremap_resource(lp->dev, &dmares);
+	if (IS_ERR(lp->dma_regs)) {
+		dev_err(lp->dev, "could not map DMA regs\n");
+		ret = PTR_ERR(lp->dma_regs);
+		goto put_node;
+	}
+	lp->rx_irq = irq_of_parse_and_map(np, 1);
+	lp->tx_irq = irq_of_parse_and_map(np, 0);
+
+put_node:
+	of_node_put(np);
+	return ret;
+}
+
+/**
  * axienet_probe - Axi Ethernet probe function.
  * @pdev:	Pointer to platform device structure.
  *
@@ -1448,11 +1490,10 @@ static void axienet_dma_err_handler(unsigned long data)
 static int axienet_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct device_node *np;
 	struct axienet_local *lp;
 	struct net_device *ndev;
 	const void *mac_addr;
-	struct resource *ethres, dmares;
+	struct resource *ethres;
 	u32 value;
 
 	ndev = alloc_etherdev(sizeof(*lp));
@@ -1565,29 +1606,9 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
-	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
-	if (!np) {
-		dev_err(&pdev->dev, "could not find DMA node\n");
-		ret = -ENODEV;
-		goto free_netdev;
-	}
-	ret = of_address_to_resource(np, 0, &dmares);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to get DMA resource\n");
-		of_node_put(np);
-		goto free_netdev;
-	}
-	lp->dma_regs = devm_ioremap_resource(&pdev->dev, &dmares);
-	if (IS_ERR(lp->dma_regs)) {
-		dev_err(&pdev->dev, "could not map DMA regs\n");
-		ret = PTR_ERR(lp->dma_regs);
-		of_node_put(np);
+	ret = axienet_dma_res_init(lp);
+	if (ret)
 		goto free_netdev;
-	}
-	lp->rx_irq = irq_of_parse_and_map(np, 1);
-	lp->tx_irq = irq_of_parse_and_map(np, 0);
-	of_node_put(np);
 	if ((lp->rx_irq <= 0) || (lp->tx_irq <= 0)) {
 		dev_err(&pdev->dev, "could not determine irqs\n");
 		ret = -ENOMEM;
-- 
2.9.5

