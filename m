Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262FBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1AD2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VwVccZcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfLJRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:11:54 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44652 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLJRLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575997880; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHVSQkc27MO6T15+ZxEyDagf9cw9uMLD8WZYKdeHNB0=;
        b=VwVccZcRZ+P9+iKt7oTJrx4J+p6J9gWZ405ThrRQ33GROGx4uVJ6nLgRDkLDSuPWASnnUk
        r4ctrEaXY6/iqpG0lpdBm2VCrCDQ3vb8322kL44WZKJsrigFLzKYWGFmQ8FSlvWd0PWdPk
        v6LIYkXoKphNRPdu1uYYDbMtWrDKODw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 6/7] usb: musb: jz4740: Code cleanup
Date:   Tue, 10 Dec 2019 18:11:09 +0100
Message-Id: <20191210171110.62141-6-paul@crapouillou.net>
In-Reply-To: <20191210171110.62141-1-paul@crapouillou.net>
References: <20191210171110.62141-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some code maintenance; no functional change.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch
    v3: Rebase on 5.5-rc1

 drivers/usb/musb/jz4740.c | 75 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 5e885fa26829..f948eca654f3 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -17,16 +17,15 @@
 #include "musb_core.h"
 
 struct jz4740_glue {
-	struct device           *dev;
-	struct platform_device  *musb;
+	struct platform_device	*pdev;
 	struct clk		*clk;
 };
 
 static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 {
-	unsigned long   flags;
-	irqreturn_t     retval = IRQ_NONE, retval_dma = IRQ_NONE;
-	struct musb     *musb = __hci;
+	unsigned long	flags;
+	irqreturn_t	retval = IRQ_NONE, retval_dma = IRQ_NONE;
+	struct musb	*musb = __hci;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
@@ -43,7 +42,7 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 	 * never see them set
 	 */
 	musb->int_usb &= MUSB_INTR_SUSPEND | MUSB_INTR_RESUME |
-	    MUSB_INTR_RESET | MUSB_INTR_SOF;
+			 MUSB_INTR_RESET | MUSB_INTR_SOF;
 
 	if (musb->int_usb || musb->int_tx || musb->int_rx)
 		retval = musb_interrupt(musb);
@@ -57,25 +56,20 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 }
 
 static struct musb_fifo_cfg jz4740_musb_fifo_cfg[] = {
-{ .hw_ep_num = 1, .style = FIFO_TX, .maxpacket = 512, },
-{ .hw_ep_num = 1, .style = FIFO_RX, .maxpacket = 512, },
-{ .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 64, },
+	{ .hw_ep_num = 1, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 1, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 64, },
 };
 
 static const struct musb_hdrc_config jz4740_musb_config = {
 	/* Silicon does not implement USB OTG. */
-	.multipoint = 0,
+	.multipoint	= 0,
 	/* Max EPs scanned, driver will decide which EP can be used. */
-	.num_eps    = 4,
+	.num_eps	= 4,
 	/* RAMbits needed to configure EPs from table */
-	.ram_bits   = 9,
-	.fifo_cfg = jz4740_musb_fifo_cfg,
-	.fifo_cfg_size = ARRAY_SIZE(jz4740_musb_fifo_cfg),
-};
-
-static struct musb_hdrc_platform_data jz4740_musb_platform_data = {
-	.mode   = MUSB_PERIPHERAL,
-	.config = &jz4740_musb_config,
+	.ram_bits	= 9,
+	.fifo_cfg	= jz4740_musb_fifo_cfg,
+	.fifo_cfg_size	= ARRAY_SIZE(jz4740_musb_fifo_cfg),
 };
 
 static int jz4740_musb_init(struct musb *musb)
@@ -94,7 +88,8 @@ static int jz4740_musb_init(struct musb *musb)
 		return err;
 	}
 
-	/* Silicon does not implement ConfigData register.
+	/*
+	 * Silicon does not implement ConfigData register.
 	 * Set dyn_fifo to avoid reading EP config from hardware.
 	 */
 	musb->dyn_fifo = true;
@@ -115,65 +110,69 @@ static const struct musb_platform_ops jz4740_musb_ops = {
 #endif
 };
 
+static const struct musb_hdrc_platform_data jz4740_musb_pdata = {
+	.mode		= MUSB_PERIPHERAL,
+	.config		= &jz4740_musb_config,
+	.platform_ops	= &jz4740_musb_ops,
+};
+
 static int jz4740_probe(struct platform_device *pdev)
 {
-	struct musb_hdrc_platform_data	*pdata = &jz4740_musb_platform_data;
+	struct device			*dev = &pdev->dev;
+	const struct musb_hdrc_platform_data *pdata = &jz4740_musb_pdata;
 	struct platform_device		*musb;
 	struct jz4740_glue		*glue;
-	struct clk                      *clk;
+	struct clk			*clk;
 	int				ret;
 
-	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
+	glue = devm_kzalloc(dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue)
 		return -ENOMEM;
 
 	musb = platform_device_alloc("musb-hdrc", PLATFORM_DEVID_AUTO);
 	if (!musb) {
-		dev_err(&pdev->dev, "failed to allocate musb device\n");
+		dev_err(dev, "failed to allocate musb device");
 		return -ENOMEM;
 	}
 
-	clk = devm_clk_get(&pdev->dev, "udc");
+	clk = devm_clk_get(dev, "udc");
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "failed to get clock\n");
+		dev_err(dev, "failed to get clock");
 		ret = PTR_ERR(clk);
 		goto err_platform_device_put;
 	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
+		dev_err(dev, "failed to enable clock");
 		goto err_platform_device_put;
 	}
 
-	musb->dev.parent		= &pdev->dev;
+	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
 
-	glue->dev			= &pdev->dev;
-	glue->musb			= musb;
+	glue->pdev			= musb;
 	glue->clk			= clk;
 
-	pdata->platform_ops		= &jz4740_musb_ops;
-
 	platform_set_drvdata(pdev, glue);
 
 	ret = platform_device_add_resources(musb, pdev->resource,
 					    pdev->num_resources);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to add resources\n");
+		dev_err(dev, "failed to add resources");
 		goto err_clk_disable;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to add platform_data\n");
+		dev_err(dev, "failed to add platform_data");
 		goto err_clk_disable;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register musb device\n");
+		dev_err(dev, "failed to register musb device");
 		goto err_clk_disable;
 	}
 
@@ -188,9 +187,9 @@ static int jz4740_probe(struct platform_device *pdev)
 
 static int jz4740_remove(struct platform_device *pdev)
 {
-	struct jz4740_glue	*glue = platform_get_drvdata(pdev);
+	struct jz4740_glue *glue = platform_get_drvdata(pdev);
 
-	platform_device_unregister(glue->musb);
+	platform_device_unregister(glue->pdev);
 	clk_disable_unprepare(glue->clk);
 
 	return 0;
@@ -199,7 +198,7 @@ static int jz4740_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_musb_of_match[] = {
 	{ .compatible = "ingenic,jz4740-musb" },
-	{},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, jz4740_musb_of_match);
 #endif
-- 
2.24.0

