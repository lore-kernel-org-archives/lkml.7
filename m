Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9CC2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wzNkBxfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfLJRLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:11:32 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44604 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLJRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575997877; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMGcZ/SUwcopwbokeiH9BmWGrI35YwfGN6RItRHcNq0=;
        b=wzNkBxfbrlpAzZC68tsbGLtfbu39m7m3uNXJVBdVKv4LUgN8kADaaVtzsJBhPK9QdzB+sR
        mlEndyrMFrCMOwXW0w+JQo4PQGhVLf/7cZfPpD/7TO2bIqYIwlPcBs6vLXstTZi3LBHmfR
        /lQqw5TfFbxoQVrnac1g+RZ8vqWzf4k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 3/7] usb: musb: jz4740: Add support for DMA
Date:   Tue, 10 Dec 2019 18:11:06 +0100
Message-Id: <20191210171110.62141-3-paul@crapouillou.net>
In-Reply-To: <20191210171110.62141-1-paul@crapouillou.net>
References: <20191210171110.62141-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using the DMA channels built into the Inventra IP.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: Rebase on 5.4-rc4
    v3: Rebase on 5.5-rc1

 drivers/usb/musb/Kconfig  |  2 +-
 drivers/usb/musb/jz4740.c | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 52f8e2b57ad5..210e4844c92a 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -142,7 +142,7 @@ config USB_UX500_DMA
 
 config USB_INVENTRA_DMA
 	bool 'Inventra'
-	depends on USB_MUSB_OMAP2PLUS
+	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_JZ4740
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 5261f8dfedec..bbecfdee6ea1 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -25,11 +25,14 @@ struct jz4740_glue {
 static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 {
 	unsigned long   flags;
-	irqreturn_t     retval = IRQ_NONE;
+	irqreturn_t     retval = IRQ_NONE, retval_dma = IRQ_NONE;
 	struct musb     *musb = __hci;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
+	if (IS_ENABLED(CONFIG_USB_INVENTRA_DMA) && musb->dma_controller)
+		retval_dma = musbhs_dma_controller_irq(musb->dma_controller);
+
 	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
 	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
 	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
@@ -47,7 +50,10 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	return retval;
+	if (retval == IRQ_HANDLED || retval_dma == IRQ_HANDLED)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
 }
 
 static struct musb_fifo_cfg jz4740_musb_fifo_cfg[] = {
@@ -91,18 +97,19 @@ static int jz4740_musb_init(struct musb *musb)
 	musb->dyn_fifo = true;
 
 	musb->isr = jz4740_musb_interrupt;
+	musb->dma_share_usb_irq = true;
 
 	return 0;
 }
 
-/*
- * DMA has not been confirmed to work with CONFIG_USB_INVENTRA_DMA,
- * so let's not set up the dma function pointers yet.
- */
 static const struct musb_platform_ops jz4740_musb_ops = {
 	.quirks		= MUSB_DMA_INVENTRA | MUSB_INDEXED_EP,
 	.fifo_mode	= 2,
 	.init		= jz4740_musb_init,
+#ifdef CONFIG_USB_INVENTRA_DMA
+	.dma_init	= musbhs_dma_controller_create,
+	.dma_exit	= musbhs_dma_controller_destroy,
+#endif
 };
 
 static int jz4740_probe(struct platform_device *pdev)
@@ -137,6 +144,8 @@ static int jz4740_probe(struct platform_device *pdev)
 	}
 
 	musb->dev.parent		= &pdev->dev;
+	musb->dev.dma_mask		= &musb->dev.coherent_dma_mask;
+	musb->dev.coherent_dma_mask	= DMA_BIT_MASK(32);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
-- 
2.24.0

