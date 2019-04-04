Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88561C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DB72147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UMbV94QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfDDJrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:47:52 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38534 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731037AbfDDJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554371267; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c5gIV1WBt4NfCQy/Dtw/ozvFkXgXPwJC2jGPWx6xhkQ=;
        b=UMbV94QYqXtWVZ0DWSXLgNyN8EuShmTCzF99N9GFku8a5dKofDc4ti/vSQ2kIHDzd6pp9N
        eOgQbgIaPETPZAhmZQd36eaNSESpkuNVVAjrdGCTW/jtbJJCJlFLSQrb/swRvfp5fwp1mc
        n/HEg48dBJgl6ok8Q3PpiIsCcv6hiqg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/3] usb: musb: jz4740: obtain USB PHY from devicetree
Date:   Thu,  4 Apr 2019 11:47:39 +0200
Message-Id: <20190404094739.23503-3-paul@crapouillou.net>
In-Reply-To: <20190404094739.23503-1-paul@crapouillou.net>
References: <20190404094739.23503-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fall back to devm_usb_get_phy() if devicetree is not available.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Change "usb-phy" DT property to "phys"

 drivers/usb/musb/jz4740.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index ad35e09f90bd..5261f8dfedec 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -74,9 +74,14 @@ static struct musb_hdrc_platform_data jz4740_musb_platform_data = {
 
 static int jz4740_musb_init(struct musb *musb)
 {
-	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
+	struct device *dev = musb->controller->parent;
+
+	if (dev->of_node)
+		musb->xceiv = devm_usb_get_phy_by_phandle(dev, "phys", 0);
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

