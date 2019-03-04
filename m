Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7DA20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZRWhal5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCDKjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:39:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51403 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCDKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:38:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so4072703wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KE/Ag92eZkmaEXb+bw28OqTZIKfiGkWvL6G21tsdm6c=;
        b=ZRWhal5UAPAGwSkEL4nmJcK/qy/nH+ppl2DwjZCviYVTyL9P6LJMOFWLVDDVJ4vooe
         iyOfixarHY7hMPqtrmNv+YOOgj8GBSwx4PDRlN9XOVAuGv4354TMBMlgCH9TY+wDRfiM
         vKTPSnbJClDfIgSvj2WoycdDjWYj4lceZJGp4VS8OM7PFavoxyptVwi/kUIXjDmHrAJr
         rdPuBq8L9+YSS1cqSmwttVJvzzkLLdd5M6qeRLMkwaQsy7qmTi86SzynXDjs3so0Gk+h
         8RqFpD+CSWeEypeKm0nkDOB/I06bMr60DF+nOqN/4Xe+EcnPhU2utQO5J365Ff7W87eZ
         1Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KE/Ag92eZkmaEXb+bw28OqTZIKfiGkWvL6G21tsdm6c=;
        b=niVuLLCJkKNpb5rvVYSKpUvkR8VL2VPJ/qdiwHDFz2oJFcNJz5BBcXEVDKa+wBZnWy
         YxFmzb0sz8V2Q6//Vyb+PY1XPRXNliUulHXnj/LC+OgXSGOafaBDqtpyg7/c+ro54ogz
         /iAecXtMwwiOSrIjBNo/bvR1JlZlnvviRMkrJvSxe6PHMryJ4+QBIoEWicFy7HphGXVo
         nF9v8xTzfvrWXFnwGB26G9q/Mi6GBMJ/JhQ4EaQ5GIouuL0fGxZU8+Fokc/7chkKqH9x
         RyZnUizDRhPdEE5ZiufWAQYPCSsPpVyBiNRnLx6K/ksHkjmxjKkxet/HzslYhrIe75rB
         Rs8w==
X-Gm-Message-State: AHQUAuZzpVyK9JD20wc/6zM9vSSbBMLaBmTEHJGxD37gg+z5UMW3Y1Z3
        26QgUUnmNFK1zvqjkokWqyGm+g==
X-Google-Smtp-Source: AHgI3IZAp6oS3PKDahHjHYYIr51x+a6YNfE/B/IUusZbGB8tr+dcZVlzTC+vMAXufYznDLAlzdWniA==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr11433660wme.22.1551695934796;
        Mon, 04 Mar 2019 02:38:54 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g24sm5505676wmh.45.2019.03.04.02.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:38:54 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
Date:   Mon,  4 Mar 2019 11:38:43 +0100
Message-Id: <20190304103846.2060-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304103846.2060-1-narmstrong@baylibre.com>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the USB2 PHY found in the Amlogic G12A SoC Family.

It supports Host and/or Peripheral mode, depending on it's position.
The first PHY is only used as Host, but the second supports Dual modes
defined by the USB Control Glue HW in front of the USB Controllers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/Kconfig               |  11 ++
 drivers/phy/amlogic/Makefile              |   1 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c | 190 ++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 23fe1cda2f70..560ff0f1ed4c 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -36,3 +36,14 @@ config PHY_MESON_GXL_USB3
 	  Enable this to support the Meson USB3 PHY and OTG detection
 	  IP block found in Meson GXL and GXM SoCs.
 	  If unsure, say N.
+
+config PHY_MESON_G12A_USB2
+	tristate "Meson G12A USB2 PHY driver"
+	default ARCH_MESON
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	help
+	  Enable this to support the Meson USB2 PHYs found in Meson
+	  G12A SoCs.
+	  If unsure, say N.
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 4fd8848c194d..7d4d10f5a6b3 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
+obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
new file mode 100644
index 000000000000..4712a9464ac9
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Meson G12A USB2 PHY driver
+ *
+ * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ * Copyright (C) 2017 Amlogic, Inc. All rights reserved
+ * Copyright (C) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/reset.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define PHY_CTRL_R0						0x0
+#define PHY_CTRL_R1						0x4
+#define PHY_CTRL_R2						0x8
+#define PHY_CTRL_R3						0xc
+#define PHY_CTRL_R4						0x10
+#define PHY_CTRL_R5						0x14
+#define PHY_CTRL_R6						0x18
+#define PHY_CTRL_R7						0x1c
+#define PHY_CTRL_R8						0x20
+#define PHY_CTRL_R9						0x24
+#define PHY_CTRL_R10						0x28
+#define PHY_CTRL_R11						0x2c
+#define PHY_CTRL_R12						0x30
+#define PHY_CTRL_R13						0x34
+#define PHY_CTRL_R14						0x38
+#define PHY_CTRL_R15						0x3c
+#define PHY_CTRL_R16						0x40
+#define PHY_CTRL_R17						0x44
+#define PHY_CTRL_R18						0x48
+#define PHY_CTRL_R19						0x4c
+#define PHY_CTRL_R20						0x50
+#define PHY_CTRL_R21						0x54
+#define PHY_CTRL_R22						0x58
+#define PHY_CTRL_R23						0x5c
+
+#define RESET_COMPLETE_TIME					1000
+#define PLL_RESET_COMPLETE_TIME					100
+
+struct phy_meson_g12a_usb2_priv {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct clk		*clk;
+	struct reset_control	*reset;
+};
+
+static const struct regmap_config phy_meson_g12a_usb2_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = PHY_CTRL_R23,
+};
+
+static int phy_meson_g12a_usb2_init(struct phy *phy)
+{
+	struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
+	udelay(RESET_COMPLETE_TIME);
+
+	/* usb2_otg_aca_en == 0 */
+	regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
+
+	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
+	regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
+	regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
+	regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
+
+	udelay(PLL_RESET_COMPLETE_TIME);
+
+	/* UnReset PLL */
+	regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
+
+	/* PHY Tuning */
+	regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
+	regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
+
+	/* Tuning Disconnect Threshold */
+	regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
+
+	/* Analog Settings */
+	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
+	regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
+
+	return 0;
+}
+
+static int phy_meson_g12a_usb2_exit(struct phy *phy)
+{
+	struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
+
+	return reset_control_reset(priv->reset);
+}
+
+/* set_mode is not needed, mode setting is handled via the UTMI bus */
+static const struct phy_ops phy_meson_g12a_usb2_ops = {
+	.init		= phy_meson_g12a_usb2_init,
+	.exit		= phy_meson_g12a_usb2_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	struct phy_meson_g12a_usb2_priv *priv;
+	struct phy *phy;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &phy_meson_g12a_usb2_regmap_conf);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->clk = devm_clk_get(dev, "xtal");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->reset = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return ret;
+
+	phy = devm_phy_create(dev, NULL, &phy_meson_g12a_usb2_ops);
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to create PHY\n");
+
+		return ret;
+	}
+
+	phy_set_bus_width(phy, 8);
+	phy_set_drvdata(phy, priv);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id phy_meson_g12a_usb2_of_match[] = {
+	{ .compatible = "amlogic,g12a-usb2-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, phy_meson_g12a_usb2_of_match);
+
+static struct platform_driver phy_meson_g12a_usb2_driver = {
+	.probe	= phy_meson_g12a_usb2_probe,
+	.driver	= {
+		.name		= "phy-meson-g12a-usb2",
+		.of_match_table	= phy_meson_g12a_usb2_of_match,
+	},
+};
+module_platform_driver(phy_meson_g12a_usb2_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Meson G12A USB2 PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

