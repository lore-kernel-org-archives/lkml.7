Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301EFC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6C32082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oyzu7bG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfIHNnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:43:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51632 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfIHNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:43:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so1273645wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q+gXveabjDvHhpC6qc1CpmFJ+TUvrJis+m/C9VqLzqg=;
        b=oyzu7bG1+xZEGvR7Q39Urdd69S90lU+u85NJ3+bouVhgvWfcTkeZKIML4knyo+zEGY
         qIiNlXKSIlPDz4FKoEZ0tY2S795jdYq+42rvpKTnuDlbQfcI0DBNRDbHp1WUSyvhx74S
         iOI8IBPQeSOoEnHq9kk+PXvSKq+d0dH9n6eqKZq7Z0uNO0TbtswNp1LvOnBiKSDcleD9
         Q3OooNLwF9aNi6EZpwYQLyvRs2BrXyke692fgLx+GtcYuJ8aRiI5tCYq0R2QfC43aXpy
         zzdopT+xtX9s9zbKzFiPmYkysxZ2jlcnYn4ZIJYyN1qgwOFe7tYhOe+bAIhYsE1d3Opl
         DmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q+gXveabjDvHhpC6qc1CpmFJ+TUvrJis+m/C9VqLzqg=;
        b=ordmfBmNtUFEhpBJv0QMJHPxzfCSbtFp4itA7J/J8/Zp2j7G07lwFOX8thYiY4LVWy
         bYjK34Ci4gkWTQt+DlMTCzURTYTh03GDvjoyYuSwtSpWaQMCCkjK8ti9pxhvoGDfWpgi
         MFGXyNTsPNQ/OpTnG+fpLWS5AWgKi6Gvt/GQ6FItBoe1EtNxmsCyXGNV4JIFw8PLJeY4
         clQdW8kksDALszeFYWeg4wScYHOm+NoqEcQZY+R+qPcr8Lmh0qsJojYXxHM4igafZMxC
         to5o7D9OtitiZQQVGZtJyMr9KN2lcZjeOucPd+8p8cXq0Avq0w/LNBim+kfbviY4VVCG
         wSsw==
X-Gm-Message-State: APjAAAXoJDzvyDf4/1cs46XrI1lOgCvTcOyWEldeE/+4hdi8ZUwoFPCv
        CRTXrcSUrxb1nY7Qdz3Sr2sTlw==
X-Google-Smtp-Source: APXvYqxg5Y6Z+b5UiFBPJdp9at+q+phrtN1UeWj0gzoHG8ymBgjCeT8PdTC/1TlSmNMAondOSSD/8A==
X-Received: by 2002:a1c:ef18:: with SMTP id n24mr14961141wmh.29.1567950188879;
        Sun, 08 Sep 2019 06:43:08 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id t203sm14313902wmf.42.2019.09.08.06.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 06:43:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] phy: meson-g12a-usb3-pcie: Add support for PCIe mode
Date:   Sun,  8 Sep 2019 13:42:56 +0000
Message-Id: <1567950178-4466-5-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds extended PCIe PHY functions for the Amlogic G12A
USB3+PCIE Combo PHY to support reset, power_on and power_off for
PCIe exclusively.

With these callbacks, we can handle all the needed operations of the
Amlogic PCIe controller driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 70 ++++++++++++++++---
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
index ac322d643c7a..08e322789e59 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -50,6 +50,8 @@
 	#define PHY_R5_PHY_CR_ACK				BIT(16)
 	#define PHY_R5_PHY_BS_OUT				BIT(17)
 
+#define PCIE_RESET_DELAY					500
+
 struct phy_g12a_usb3_pcie_priv {
 	struct regmap		*regmap;
 	struct regmap		*regmap_cr;
@@ -196,6 +198,10 @@ static int phy_g12a_usb3_init(struct phy *phy)
 	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
 	int data, ret;
 
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
 	/* Switch PHY to USB3 */
 	/* TODO figure out how to handle when PCIe was set in the bootloader */
 	regmap_update_bits(priv->regmap, PHY_R0,
@@ -272,24 +278,64 @@ static int phy_g12a_usb3_init(struct phy *phy)
 	return 0;
 }
 
-static int phy_g12a_usb3_pcie_init(struct phy *phy)
+static int phy_g12a_usb3_pcie_power_on(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+
+	if (priv->mode == PHY_TYPE_USB3)
+		return 0;
+
+	regmap_update_bits(priv->regmap, PHY_R0,
+			   PHY_R0_PCIE_POWER_STATE,
+			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_power_off(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+
+	if (priv->mode == PHY_TYPE_USB3)
+		return 0;
+
+	regmap_update_bits(priv->regmap, PHY_R0,
+			   PHY_R0_PCIE_POWER_STATE,
+			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1d));
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_reset(struct phy *phy)
 {
 	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
 	int ret;
 
-	ret = reset_control_reset(priv->reset);
+	if (priv->mode == PHY_TYPE_USB3)
+		return 0;
+
+	ret = reset_control_assert(priv->reset);
 	if (ret)
 		return ret;
 
+	udelay(PCIE_RESET_DELAY);
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return ret;
+
+	udelay(PCIE_RESET_DELAY);
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_init(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+
 	if (priv->mode == PHY_TYPE_USB3)
 		return phy_g12a_usb3_init(phy);
 
-	/* Power UP PCIE */
-	/* TODO figure out when the bootloader has set USB3 mode before */
-	regmap_update_bits(priv->regmap, PHY_R0,
-			   PHY_R0_PCIE_POWER_STATE,
-			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
-
 	return 0;
 }
 
@@ -297,7 +343,10 @@ static int phy_g12a_usb3_pcie_exit(struct phy *phy)
 {
 	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
 
-	return reset_control_reset(priv->reset);
+	if (priv->mode == PHY_TYPE_USB3)
+		return reset_control_reset(priv->reset);
+
+	return 0;
 }
 
 static struct phy *phy_g12a_usb3_pcie_xlate(struct device *dev,
@@ -326,6 +375,9 @@ static struct phy *phy_g12a_usb3_pcie_xlate(struct device *dev,
 static const struct phy_ops phy_g12a_usb3_pcie_ops = {
 	.init		= phy_g12a_usb3_pcie_init,
 	.exit		= phy_g12a_usb3_pcie_exit,
+	.power_on	= phy_g12a_usb3_pcie_power_on,
+	.power_off	= phy_g12a_usb3_pcie_power_off,
+	.reset		= phy_g12a_usb3_pcie_reset,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.17.1

