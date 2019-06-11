Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42EC4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318E4206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EzeY2hPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391587AbfFKN6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:58:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38229 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbfFKN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:58:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so3059243wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKGIIEZ1EWhF8d9VHamuiFuthqcJ8PCoZC+PlSBmz6w=;
        b=EzeY2hPjuYcKKephwbA2K1k8wINtGW9iU2baby+Xliqe1XCNSRPc1BDCV0c7P2Cfyq
         fiswGap6+7EHJyYD4nFTEmjDAndmmuLpxkj0z6N8Si5dC3jZyenH1cLi8DdmoDNfj4ba
         ARQ8YUjx20+dGQtgThBUX9sUMXH4R3nlFlzRiYIEV3Zey05eBOYBfJFFwmCPkmO9Gn1a
         uOoUwOPFvWqAhOOAmKWhhM2wZ98IENtfIHlORA/cK+Qf8dR8LC/pGpZmW1ELLdhHk+Pq
         ydAqAkXyQU1W/SahLXNTTwrpSDtKRdWPjj0lKnHPvnDVgef+NAYipXlO8rplYVr932Yj
         fiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKGIIEZ1EWhF8d9VHamuiFuthqcJ8PCoZC+PlSBmz6w=;
        b=G0jt2wcbb6Wu98LhU8hE1JrWTtII3425gngA5hWBCQM4JCtyWaLD5kxWK1LsxX1aA0
         ddCoUygMCJWdPIhI/qcj2vd+8nYjGYWAE0EBTvxcjjBPtbke2aviTgjvZCp7trcDU9gS
         FOaKp/2CWg5jS7sWQZS1iArllIgXoH1D0tUA9Z19jzRImQ4x+F62yYtqNxzmAS8GiGYC
         FWWV09HISXBn1BOvUtEWtYJETI2Fhp9l6pmPJIXnDFw0Gb1Fyx4hQDRqo4C9ytFFR1Dd
         35DlI+b1xAzn/MY5W/xYwtmLHLa7iuB4hQFylHweRJRwL/2wwNB2M5IRv3dLWeG17XYy
         dBVA==
X-Gm-Message-State: APjAAAXuI+llcnCImSFuenUMf/OUQOe9EG64gM8lGjpZcqgjLQlOB2fZ
        CBmSqSL1cI+kSraTlcBPzeIEOA==
X-Google-Smtp-Source: APXvYqzt0u8aL8eNXkVgF2OmeqrddaS2cdZwbIEkydNhWGlivtGsTJEGph122kdnU4rK2V5IkAeWDw==
X-Received: by 2002:a05:600c:389:: with SMTP id w9mr17129874wmd.139.1560261523914;
        Tue, 11 Jun 2019 06:58:43 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c16sm12317446wrr.53.2019.06.11.06.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 06:58:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: meson-g12a: Add support for IRQ based OTG switching
Date:   Tue, 11 Jun 2019 15:58:42 +0200
Message-Id: <20190611135842.8396-1-narmstrong@baylibre.com>
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
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 32 ++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 2aec31a2eacb..e5c5ad0d529e 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -348,6 +348,22 @@ static enum usb_role dwc3_meson_g12a_role_get(struct device *dev)
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
@@ -374,7 +390,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct resource *res;
 	enum phy_mode otg_id;
-	int ret, i;
+	int ret, i, irq;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -436,6 +452,19 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
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
@@ -460,7 +489,6 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	/* Setup OTG mode corresponding to the ID pin */
 	if (priv->otg_mode == USB_DR_MODE_OTG) {
-		/* TOFIX Handle ID mode toggling via IRQ */
 		otg_id = dwc3_meson_g12a_get_id(priv);
 		if (otg_id != priv->otg_phy_mode) {
 			if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
-- 
2.21.0

