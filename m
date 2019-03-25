Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D90E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qIRfgrQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfCYJkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:40:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40396 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbfCYJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:39:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so9216800wri.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8Fe7QISSuU5FG689zdAEk35T07vsehiVzQIhifpmw8=;
        b=qIRfgrQOdjykf9NpukNyOkby4IItMB17o50iAgoULPSQe44j3Gw+pTwU6yVjbYFJj0
         6eXOCbDlPkXY38UAGFmC8Aq7qcDXoIVps3i8wex/OKWpHrBmotrFcsbZXL8SiOjFy+wT
         6YtWhdym7ep4sJ8l9GT7LfXfRreCUCIkoG6FQP/al/VKkquBt60iMkViV/S2y/sQAyEu
         O8nFAW/8sx4FmC8ETacw4W0WJQiHPYKBfl9/usSIWyuJdTPH86AtYNvqXcbq/vdGgusJ
         HO15IXVOLrX0o8Y4tnjiKsz0oLt8j6SV7I2RMM1b4SLMkoYqGkn9jjF1eN0SuQWTOHuX
         WiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8Fe7QISSuU5FG689zdAEk35T07vsehiVzQIhifpmw8=;
        b=Ibxc2Tp7XGxwRJqYPiz/XNTl8vYfFz+JIOitJZ/93n5556l+jeO23NgEntCP1oC56n
         yrXvf1aNYMdKwPSRtRllUKZ60VkGfz8mdyLH7P1z9SVDnRaGjXrvlhCYEX26JeWf+oVs
         +adUfbStrQMJcpQQDrHSGrXQMN757AjqRGeEuemfi4byK1i8mSt6gRsa1l+hwyTkPYKi
         8NoudeNzeW3TaIcLLma1d8PYBtKf5MEjOgHmEtqG0Wd4TLYckdtdrZ+po3cfJ5FGDnF0
         VX2q0CXc+rRDS4GhxBN1Nqzy1yZnvM+7g3GfnJ6sSvgU3HXUQV2/ZN2cICKm6iVfXl+N
         4ViA==
X-Gm-Message-State: APjAAAWqJIInpJP4Q7UiHTXoCHqUlg5ynIfPZly/VLLag4x89e99qsNP
        eCUrAdbBEnjme9JvovLVOOI/gA==
X-Google-Smtp-Source: APXvYqy9TpF4Q59YZQYTH3Ij7NURr7qiBcy5rE79Pi+5pxZaliGIWogDe/W/Q+Cqg4W/aFshhy0FsQ==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr14400711wrj.134.1553506796528;
        Mon, 25 Mar 2019 02:39:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k14sm13044652wmj.26.2019.03.25.02.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 02:39:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
Date:   Mon, 25 Mar 2019 10:39:40 +0100
Message-Id: <20190325093943.29138-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325093943.29138-1-narmstrong@baylibre.com>
References: <20190325093943.29138-1-narmstrong@baylibre.com>
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
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/Kconfig               |  11 +
 drivers/phy/amlogic/Makefile              |   1 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c | 341 ++++++++++++++++++++++
 3 files changed, 353 insertions(+)
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
index 000000000000..9065ffc85eb4
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
@@ -0,0 +1,341 @@
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
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define PHY_CTRL_R0						0x0
+#define PHY_CTRL_R1						0x4
+#define PHY_CTRL_R2						0x8
+#define PHY_CTRL_R3						0xc
+	#define PHY_CTRL_R3_SQUELCH_REF				GENMASK(1, 0)
+	#define PHY_CTRL_R3_HSDIC_REF				GENMASK(3, 2)
+	#define PHY_CTRL_R3_DISC_THRESH				GENMASK(7, 4)
+
+#define PHY_CTRL_R4						0x10
+	#define PHY_CTRL_R4_CALIB_CODE_7_0			GENMASK(7, 0)
+	#define PHY_CTRL_R4_CALIB_CODE_15_8			GENMASK(15, 8)
+	#define PHY_CTRL_R4_CALIB_CODE_23_16			GENMASK(23, 16)
+	#define PHY_CTRL_R4_I_C2L_CAL_EN			BIT(24)
+	#define PHY_CTRL_R4_I_C2L_CAL_RESET_N			BIT(25)
+	#define PHY_CTRL_R4_I_C2L_CAL_DONE			BIT(26)
+	#define PHY_CTRL_R4_TEST_BYPASS_MODE_EN			BIT(27)
+	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0			GENMASK(29, 28)
+	#define PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2			GENMASK(31, 30)
+
+#define PHY_CTRL_R5						0x14
+#define PHY_CTRL_R6						0x18
+#define PHY_CTRL_R7						0x1c
+#define PHY_CTRL_R8						0x20
+#define PHY_CTRL_R9						0x24
+#define PHY_CTRL_R10						0x28
+#define PHY_CTRL_R11						0x2c
+#define PHY_CTRL_R12						0x30
+#define PHY_CTRL_R13						0x34
+	#define PHY_CTRL_R13_CUSTOM_PATTERN_19			GENMASK(7, 0)
+	#define PHY_CTRL_R13_LOAD_STAT				BIT(14)
+	#define PHY_CTRL_R13_UPDATE_PMA_SIGNALS			BIT(15)
+	#define PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET		GENMASK(20, 16)
+	#define PHY_CTRL_R13_CLEAR_HOLD_HS_DISCONNECT		BIT(21)
+	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_VAL		BIT(22)
+	#define PHY_CTRL_R13_BYPASS_HOST_DISCONNECT_EN		BIT(23)
+	#define PHY_CTRL_R13_I_C2L_HS_EN			BIT(24)
+	#define PHY_CTRL_R13_I_C2L_FS_EN			BIT(25)
+	#define PHY_CTRL_R13_I_C2L_LS_EN			BIT(26)
+	#define PHY_CTRL_R13_I_C2L_HS_OE			BIT(27)
+	#define PHY_CTRL_R13_I_C2L_FS_OE			BIT(28)
+	#define PHY_CTRL_R13_I_C2L_HS_RX_EN			BIT(29)
+	#define PHY_CTRL_R13_I_C2L_FSLS_RX_EN			BIT(30)
+
+#define PHY_CTRL_R14						0x38
+	#define PHY_CTRL_R14_I_RDP_EN				BIT(0)
+	#define PHY_CTRL_R14_I_RPU_SW1_EN			BIT(1)
+	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(2, 3)
+	#define PHY_CTRL_R14_PG_RSTN				BIT(4)
+	#define PHY_CTRL_R14_I_C2L_DATA_16_8			BIT(5)
+	#define PHY_CTRL_R14_I_C2L_ASSERT_SINGLE_EN_ZERO	BIT(6)
+	#define PHY_CTRL_R14_BYPASS_CTRL_7_0			GENMASK(15, 8)
+	#define PHY_CTRL_R14_BYPASS_CTRL_15_8			GENMASK(23, 16)
+
+#define PHY_CTRL_R15						0x3c
+#define PHY_CTRL_R16						0x40
+	#define PHY_CTRL_R16_MPLL_M				GENMASK(8, 0)
+	#define PHY_CTRL_R16_MPLL_N				GENMASK(14, 10)
+	#define PHY_CTRL_R16_MPLL_TDC_MODE			BIT(20)
+	#define PHY_CTRL_R16_MPLL_SDM_EN			BIT(21)
+	#define PHY_CTRL_R16_MPLL_LOAD				BIT(22)
+	#define PHY_CTRL_R16_MPLL_DCO_SDM_EN			BIT(23)
+	#define PHY_CTRL_R16_MPLL_LOCK_LONG			GENMASK(25, 24)
+	#define PHY_CTRL_R16_MPLL_LOCK_F			BIT(26)
+	#define PHY_CTRL_R16_MPLL_FAST_LOCK			BIT(27)
+	#define PHY_CTRL_R16_MPLL_EN				BIT(28)
+	#define PHY_CTRL_R16_MPLL_RESET				BIT(29)
+	#define PHY_CTRL_R16_MPLL_LOCK				BIT(30)
+	#define PHY_CTRL_R16_MPLL_LOCK_DIG			BIT(31)
+
+#define PHY_CTRL_R17						0x44
+	#define PHY_CTRL_R17_MPLL_FRAC_IN			GENMASK(13, 0)
+	#define PHY_CTRL_R17_MPLL_FIX_EN			BIT(16)
+	#define PHY_CTRL_R17_MPLL_LAMBDA1			GENMASK(19, 17)
+	#define PHY_CTRL_R17_MPLL_LAMBDA0			GENMASK(22, 20)
+	#define PHY_CTRL_R17_MPLL_FILTER_MODE			BIT(23)
+	#define PHY_CTRL_R17_MPLL_FILTER_PVT2			GENMASK(27, 24)
+	#define PHY_CTRL_R17_MPLL_FILTER_PVT1			GENMASK(31, 28)
+
+#define PHY_CTRL_R18						0x48
+	#define PHY_CTRL_R18_MPLL_LKW_SEL			GENMASK(1, 0)
+	#define PHY_CTRL_R18_MPLL_LK_W				GENMASK(5, 2)
+	#define PHY_CTRL_R18_MPLL_LK_S				GENMASK(11, 6)
+	#define PHY_CTRL_R18_MPLL_DCO_M_EN			BIT(12)
+	#define PHY_CTRL_R18_MPLL_DCO_CLK_SEL			BIT(13)
+	#define PHY_CTRL_R18_MPLL_PFD_GAIN			GENMASK(15, 14)
+	#define PHY_CTRL_R18_MPLL_ROU				GENMASK(18, 16)
+	#define PHY_CTRL_R18_MPLL_DATA_SEL			GENMASK(21, 19)
+	#define PHY_CTRL_R18_MPLL_BIAS_ADJ			GENMASK(23, 22)
+	#define PHY_CTRL_R18_MPLL_BB_MODE			GENMASK(25, 24)
+	#define PHY_CTRL_R18_MPLL_ALPHA				GENMASK(28, 26)
+	#define PHY_CTRL_R18_MPLL_ADJ_LDO			GENMASK(30, 29)
+	#define PHY_CTRL_R18_MPLL_ACG_RANGE			BIT(31)
+
+#define PHY_CTRL_R19						0x4c
+#define PHY_CTRL_R20						0x50
+	#define PHY_CTRL_R20_USB2_IDDET_EN			BIT(0)
+	#define PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0		GENMASK(3, 1)
+	#define PHY_CTRL_R20_USB2_OTG_VBUSDET_EN		BIT(4)
+	#define PHY_CTRL_R20_USB2_AMON_EN			BIT(5)
+	#define PHY_CTRL_R20_USB2_CAL_CODE_R5			BIT(6)
+	#define PHY_CTRL_R20_BYPASS_OTG_DET			BIT(7)
+	#define PHY_CTRL_R20_USB2_DMON_EN			BIT(8)
+	#define PHY_CTRL_R20_USB2_DMON_SEL_3_0			GENMASK(12, 9)
+	#define PHY_CTRL_R20_USB2_EDGE_DRV_EN			BIT(13)
+	#define PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0		GENMASK(15, 14)
+	#define PHY_CTRL_R20_USB2_BGR_ADJ_4_0			GENMASK(20, 16)
+	#define PHY_CTRL_R20_USB2_BGR_START			BIT(21)
+	#define PHY_CTRL_R20_USB2_BGR_VREF_4_0			GENMASK(28, 24)
+	#define PHY_CTRL_R20_USB2_BGR_DBG_1_0			GENMASK(30, 29)
+	#define PHY_CTRL_R20_BYPASS_CAL_DONE_R5			BIT(31)
+
+#define PHY_CTRL_R21						0x54
+	#define PHY_CTRL_R21_USB2_BGR_FORCE			BIT(0)
+	#define PHY_CTRL_R21_USB2_CAL_ACK_EN			BIT(1)
+	#define PHY_CTRL_R21_USB2_OTG_ACA_EN			BIT(2)
+	#define PHY_CTRL_R21_USB2_TX_STRG_PD			BIT(3)
+	#define PHY_CTRL_R21_USB2_OTG_ACA_TRIM_1_0		GENMASK(5, 4)
+	#define PHY_CTRL_R21_BYPASS_UTMI_CNTR			GENMASK(15, 6)
+	#define PHY_CTRL_R21_BYPASS_UTMI_REG			GENMASK(25, 20)
+
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
+	regmap_update_bits(priv->regmap, PHY_CTRL_R21,
+			   PHY_CTRL_R21_USB2_OTG_ACA_EN, 0);
+
+	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
+	regmap_write(priv->regmap, PHY_CTRL_R16,
+		     FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
+		     FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
+		     PHY_CTRL_R16_MPLL_LOAD |
+		     FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
+		     PHY_CTRL_R16_MPLL_FAST_LOCK |
+		     PHY_CTRL_R16_MPLL_EN |
+		     PHY_CTRL_R16_MPLL_RESET);
+
+	regmap_write(priv->regmap, PHY_CTRL_R17,
+		     FIELD_PREP(PHY_CTRL_R17_MPLL_FRAC_IN, 0) |
+		     FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA1, 7) |
+		     FIELD_PREP(PHY_CTRL_R17_MPLL_LAMBDA0, 7) |
+		     FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT2, 2) |
+		     FIELD_PREP(PHY_CTRL_R17_MPLL_FILTER_PVT1, 9));
+
+	regmap_write(priv->regmap, PHY_CTRL_R18,
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_LKW_SEL, 1) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_LK_W, 9) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_LK_S, 0x27) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_PFD_GAIN, 1) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_ROU, 7) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_DATA_SEL, 3) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_BIAS_ADJ, 1) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_BB_MODE, 0) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_ALPHA, 3) |
+		     FIELD_PREP(PHY_CTRL_R18_MPLL_ADJ_LDO, 1) |
+		     PHY_CTRL_R18_MPLL_ACG_RANGE);
+
+	udelay(PLL_RESET_COMPLETE_TIME);
+
+	/* UnReset PLL */
+	regmap_write(priv->regmap, PHY_CTRL_R16,
+		     FIELD_PREP(PHY_CTRL_R16_MPLL_M, 20) |
+		     FIELD_PREP(PHY_CTRL_R16_MPLL_N, 1) |
+		     PHY_CTRL_R16_MPLL_LOAD |
+		     FIELD_PREP(PHY_CTRL_R16_MPLL_LOCK_LONG, 1) |
+		     PHY_CTRL_R16_MPLL_FAST_LOCK |
+		     PHY_CTRL_R16_MPLL_EN);
+
+	/* PHY Tuning */
+	regmap_write(priv->regmap, PHY_CTRL_R20,
+		     FIELD_PREP(PHY_CTRL_R20_USB2_OTG_VBUS_TRIM_2_0, 4) |
+		     PHY_CTRL_R20_USB2_OTG_VBUSDET_EN |
+		     FIELD_PREP(PHY_CTRL_R20_USB2_DMON_SEL_3_0, 15) |
+		     PHY_CTRL_R20_USB2_EDGE_DRV_EN |
+		     FIELD_PREP(PHY_CTRL_R20_USB2_EDGE_DRV_TRIM_1_0, 3) |
+		     FIELD_PREP(PHY_CTRL_R20_USB2_BGR_ADJ_4_0, 0) |
+		     FIELD_PREP(PHY_CTRL_R20_USB2_BGR_VREF_4_0, 0) |
+		     FIELD_PREP(PHY_CTRL_R20_USB2_BGR_DBG_1_0, 0));
+
+	regmap_write(priv->regmap, PHY_CTRL_R4,
+		     FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_7_0, 0xf) |
+		     FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_15_8, 0xf) |
+		     FIELD_PREP(PHY_CTRL_R4_CALIB_CODE_23_16, 0xf) |
+		     PHY_CTRL_R4_TEST_BYPASS_MODE_EN |
+		     FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_1_0, 0) |
+		     FIELD_PREP(PHY_CTRL_R4_I_C2L_BIAS_TRIM_3_2, 0));
+
+	/* Tuning Disconnect Threshold */
+	regmap_write(priv->regmap, PHY_CTRL_R3,
+		     FIELD_PREP(PHY_CTRL_R3_SQUELCH_REF, 0) |
+		     FIELD_PREP(PHY_CTRL_R3_HSDIC_REF, 1) |
+		     FIELD_PREP(PHY_CTRL_R3_DISC_THRESH, 3));
+
+	/* Analog Settings */
+	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
+	regmap_write(priv->regmap, PHY_CTRL_R13,
+		     PHY_CTRL_R13_UPDATE_PMA_SIGNALS |
+		     FIELD_PREP(PHY_CTRL_R13_MIN_COUNT_FOR_SYNC_DET, 7));
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
2.21.0

