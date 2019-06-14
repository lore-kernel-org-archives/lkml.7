Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7275AC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4433020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ygwDU90/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFNI63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:58:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45071 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFNI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:58:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so1611731wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQzfi5pCNjbWy0L+GM97E8S0hKWGfnv4Ct4OLdEoTWQ=;
        b=ygwDU90/bi1g10z7gM0VCKByS/vE0RY0Mqms4KLT+5oQ8yni0T9alBS4/LbqjjUU8O
         CMduCLq82OBf0/FCW23pRrjy6MPK3NlzWhoH2X2Kx0CLV8aegxIuYVPevaekx8eHrss1
         2SsMq88cy1p8HtUW4cQ2/e6dTbgSu/GBTp5TI5V2dUrTXe+7OJOUBrkdFyYnltCRimqR
         grgDVsfyIznazMBGeb/RtN+LCMdoksG65JataHHx8nXm9CigDVyvIA5ne0TRENQz3BVl
         fgX4hegRPe7emSbCUv+wQJZP8+VsTYA+Eaf1zHePeoAuTmsOtbHKRWfi2ktbxcpBxAcs
         9chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQzfi5pCNjbWy0L+GM97E8S0hKWGfnv4Ct4OLdEoTWQ=;
        b=bxI7ggUnhXOB6/yOlbau6ZlnqccuSyyzXouhhfZ4fPv5M9c4/AKxvL7ulI1By7Ek18
         w+YwobNnvCW9K/wxzIBMexYmPyBtMROP1WjgexuyKUudiwIvceQH2vF+lyIPE4GDiLiX
         uLfiNWLrY7GU46KuwLb8Zf0hBU8Sm9nMHUvj3bXz63ypIjvQF2SWvTCIR1AB67pG3G5B
         Lhgec9iEelQoKqZTIyMVhyFPcd9Cvv7qrwgDu4A7p6pMglwZKr/HJoE+DQzNY0qDZkle
         M6K7pjHVdnQvTU04a3/zJzVwM9zm4K5e1QhT5KhCcMntjtWIoAcxfgOw3rtLjsyfNGP4
         Y77w==
X-Gm-Message-State: APjAAAV1UZvTEBTFWchJ3vrjeVyqZzUK8RRt0OFYcraKUFwq6N43rtCV
        rhSKYpTRJW1PBLYxCnrJIbIEkA==
X-Google-Smtp-Source: APXvYqw485uYVt+kqDbpQ0wxUDiPbGSM8KdkwxJABu2kHY2ceJEAOlsM1vw93IQ0cwpPB9fhmy66qw==
X-Received: by 2002:adf:a749:: with SMTP id e9mr64394856wrd.64.1560502706508;
        Fri, 14 Jun 2019 01:58:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c2sm2178672wrf.75.2019.06.14.01.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 01:58:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] usb: dwc3: meson-g12a: Add support for IRQ based OTG switching
Date:   Fri, 14 Jun 2019 10:58:24 +0200
Message-Id: <20190614085824.23307-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the OTG ID change interrupt to switch between Host
and Device mode.

Tested on the Hardkernel Odroid-N2 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 36 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 2aec31a2eacb..bca7e92a10e9 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -11,9 +11,7 @@
  * - Control registers for each USB2 Ports
  * - Control registers for the USB PHY layer
  * - SuperSpeed PHY can be enabled only if port is used
- *
- * TOFIX:
- * - Add dynamic OTG switching with ID change interrupt
+ * - Dynamic OTG switching with ID change interrupt
  */
 
 #include <linux/module.h>
@@ -348,6 +346,22 @@ static enum usb_role dwc3_meson_g12a_role_get(struct device *dev)
 		USB_ROLE_HOST : USB_ROLE_DEVICE;
 }
 
+static irqreturn_t dwc3_meson_g12a_irq_thread(int irq, void *data)
+{
+	struct dwc3_meson_g12a *priv = data;
+	enum phy_mode otg_id;
+
+	otg_id = dwc3_meson_g12a_get_id(priv);
+	if (otg_id != priv->otg_phy_mode) {
+		if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
+			dev_warn(priv->dev, "Failed to switch OTG mode\n");
+	}
+
+	regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_IRQ, 0);
+
+	return IRQ_HANDLED;
+}
+
 static struct device *dwc3_meson_g12_find_child(struct device *dev,
 						const char *compatible)
 {
@@ -374,7 +388,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct resource *res;
 	enum phy_mode otg_id;
-	int ret, i;
+	int ret, i, irq;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -436,6 +450,19 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	/* Get dr_mode */
 	priv->otg_mode = usb_get_dr_mode(dev);
 
+	if (priv->otg_mode == USB_DR_MODE_OTG) {
+		/* Ack irq before registering */
+		regmap_update_bits(priv->regmap, USB_R5,
+				   USB_R5_ID_DIG_IRQ, 0);
+
+		irq = platform_get_irq(pdev, 0);
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						dwc3_meson_g12a_irq_thread,
+						IRQF_ONESHOT, pdev->name, priv);
+		if (ret)
+			return ret;
+	}
+
 	dwc3_meson_g12a_usb_init(priv);
 
 	/* Init PHYs */
@@ -460,7 +487,6 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	/* Setup OTG mode corresponding to the ID pin */
 	if (priv->otg_mode == USB_DR_MODE_OTG) {
-		/* TOFIX Handle ID mode toggling via IRQ */
 		otg_id = dwc3_meson_g12a_get_id(priv);
 		if (otg_id != priv->otg_phy_mode) {
 			if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
-- 
2.21.0

