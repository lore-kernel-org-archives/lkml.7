Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4123A21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="yZ+b4kZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfCUPKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:10:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47414 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfCUPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553181003; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=85tuU9E/K2KHBS7SEf/SrKNaXEXPxafH1Mpt0gibGVQ=;
        b=yZ+b4kZx8SAz1VLYaBW4lGJFs3MxoDcRLwQO0dOPDE2ewj4Q8ol/8okUMREKnKhW+NBuyC
        ndovKQz2HcS/bkcnrvSi+Lr1aeFNr381z+SlEgy1BpLFcuIYVtjonwgrJhnniiWctrOAiM
        IkFESqJW2S+b0mqYMP74SYaYBuFzvqk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] usb: musb: jz4740: obtain USB PHY from devicetree
Date:   Thu, 21 Mar 2019 16:09:56 +0100
Message-Id: <20190321150956.6629-3-paul@crapouillou.net>
In-Reply-To: <20190321150956.6629-1-paul@crapouillou.net>
References: <20190321150956.6629-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fall back to devm_usb_get_phy() if devicetree is not available.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index ad35e09f90bd..e4dbf76548c0 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -74,9 +74,14 @@ static struct musb_hdrc_platform_data jz4740_musb_platform_data = {
 
 static int jz4740_musb_init(struct musb *musb)
 {
-	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
+	struct device *dev = musb->controller->parent;
+
+	if (dev->of_node)
+		musb->xceiv = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
+	else
+		musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
 	if (IS_ERR(musb->xceiv)) {
-		pr_err("HS UDC: no transceiver configured\n");
+		dev_err(dev, "No transceiver configured\n");
 		return PTR_ERR(musb->xceiv);
 	}
 
@@ -90,13 +95,6 @@ static int jz4740_musb_init(struct musb *musb)
 	return 0;
 }
 
-static int jz4740_musb_exit(struct musb *musb)
-{
-	usb_put_phy(musb->xceiv);
-
-	return 0;
-}
-
 /*
  * DMA has not been confirmed to work with CONFIG_USB_INVENTRA_DMA,
  * so let's not set up the dma function pointers yet.
@@ -105,7 +103,6 @@ static const struct musb_platform_ops jz4740_musb_ops = {
 	.quirks		= MUSB_DMA_INVENTRA | MUSB_INDEXED_EP,
 	.fifo_mode	= 2,
 	.init		= jz4740_musb_init,
-	.exit		= jz4740_musb_exit,
 };
 
 static int jz4740_probe(struct platform_device *pdev)
-- 
2.11.0

