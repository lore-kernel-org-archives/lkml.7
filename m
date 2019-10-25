Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFAD21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QPWCgX3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503349AbfJYLra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:47:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55926 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439621AbfJYLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572004039; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rkw9Sfx5EpcVJuLuKvY75aB7yGbnoPHOHTcgANtJznE=;
        b=QPWCgX3iw4UewQVozHd34uLTlbo/tFebZRvZTF+CW0nSLHHIDu8SYrM4GgJE5lRMw9eGP1
        YKm7/w4Eg2Lz4T2VzWS8ZUP9WSYtEI28BRACu3SlcHPXby1AnC9nD4C2zzNb4KcIClD8CO
        v70FjsLxKvx05aeI/3qm285bRZdh2Lk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/6] usb: musb: dma: Add support for shared IRQ
Date:   Fri, 25 Oct 2019 13:47:06 +0200
Message-Id: <20191025114710.13222-2-paul@crapouillou.net>
In-Reply-To: <20191025114710.13222-1-paul@crapouillou.net>
References: <20191025114710.13222-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of the Inventra IP in some of the Ingenic JZ47xx SoCs
does not use a separate IRQ line for DMA transfers.

Allow these SoCs to be supported by adding a flag 'dma_share_usb_irq'
in the struct musb. If set, no extra IRQ line is required, and the musb
glue will need to call the API function musbhs_dma_controller_irq()
within its interrupt handler.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: Rebase on 4.5-rc4

 drivers/usb/musb/musb_core.h |  2 ++
 drivers/usb/musb/musb_dma.h  |  1 +
 drivers/usb/musb/musbhsdma.c | 27 ++++++++++++++++++++++-----
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 04203b7126d5..b7c31c717800 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -392,6 +392,8 @@ struct musb {
 
 	unsigned		flush_irq_work:1;
 
+	unsigned		dma_share_usb_irq:1;
+
 	u8			address;
 	u8			test_mode_nr;
 	u16			ackpend;		/* ep0 */
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 8f60271c0a9d..b3f65016a972 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -191,6 +191,7 @@ extern void (*musb_dma_controller_destroy)(struct dma_controller *);
 extern struct dma_controller *
 musbhs_dma_controller_create(struct musb *musb, void __iomem *base);
 extern void musbhs_dma_controller_destroy(struct dma_controller *c);
+extern irqreturn_t musbhs_dma_controller_irq(struct dma_controller *c);
 
 extern struct dma_controller *
 tusb_dma_controller_create(struct musb *musb, void __iomem *base);
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 2d3751d885b4..898856e9974e 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -268,7 +268,7 @@ static int dma_channel_abort(struct dma_channel *channel)
 	return 0;
 }
 
-static irqreturn_t dma_controller_irq(int irq, void *private_data)
+static irqreturn_t dma_controller_irq_cb(int irq, void *private_data)
 {
 	struct musb_dma_controller *controller = private_data;
 	struct musb *musb = controller->private_data;
@@ -292,6 +292,9 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
 
 	if (!int_hsdma) {
+		if (musb->dma_share_usb_irq)
+			goto done;
+
 		musb_dbg(musb, "spurious DMA irq");
 
 		for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
@@ -384,6 +387,15 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	return retval;
 }
 
+irqreturn_t musbhs_dma_controller_irq(struct dma_controller *c)
+{
+	struct musb_dma_controller *controller = container_of(c,
+			struct musb_dma_controller, controller);
+
+	return dma_controller_irq_cb(controller->irq, controller);
+}
+EXPORT_SYMBOL_GPL(musbhs_dma_controller_irq);
+
 void musbhs_dma_controller_destroy(struct dma_controller *c)
 {
 	struct musb_dma_controller *controller = container_of(c,
@@ -404,9 +416,14 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
 	struct musb_dma_controller *controller;
 	struct device *dev = musb->controller;
 	struct platform_device *pdev = to_platform_device(dev);
-	int irq = platform_get_irq_byname(pdev, "dma");
+	int irq;
+
+	if (musb->dma_share_usb_irq)
+		irq = 0;
+	else
+		irq = platform_get_irq_byname(pdev, "dma");
 
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(dev, "No DMA interrupt line!\n");
 		return NULL;
 	}
@@ -424,8 +441,8 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
 	controller->controller.channel_program = dma_channel_program;
 	controller->controller.channel_abort = dma_channel_abort;
 
-	if (request_irq(irq, dma_controller_irq, 0,
-			dev_name(musb->controller), controller)) {
+	if (irq > 0 && request_irq(irq, dma_controller_irq_cb, 0,
+				   dev_name(musb->controller), controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
 		musb_dma_controller_destroy(&controller->controller);
 
-- 
2.23.0

