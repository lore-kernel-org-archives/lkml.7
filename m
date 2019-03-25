Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC6A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sgwcOwOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfCYJkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:40:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbfCYJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:40:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so1851870wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dNQId/lIoLaeASu9LURTpjplB7RM/acz/QEseA3Bzw0=;
        b=sgwcOwOmr9No77IC1pIYv8P5wleLR2mDcE7C99/mjd0M/HOyt+Iv/zKGkGLJ2CMlbq
         171y2XLENDRTgr/9O+iV3lqb9O/h1heIIbaxMGPeQJoKVrEIevjbEACzQQfNs1gXqZJM
         5jddc454VWggc3eAT7LgFkdfiig9UyCPW1QL/kDYXHnD0D0E6Sk2x0Jd5VI6P5XyMq7r
         sJIAc6LUOmHloKLK51aprRlQdBdV1PzRqIegE0fCwohOkIYHOBfQHngFjxOWmoPwLkdP
         1xSN2aR/L5ATwNZvHPgivCayJhuG9A1WI1MN9F/f9a93XSCB/JCUMD+JeqFTWZGnXpqM
         1mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNQId/lIoLaeASu9LURTpjplB7RM/acz/QEseA3Bzw0=;
        b=HspXT04x/a2G4tlZFrRMUtGGQ3f6asYirBJfqzPZv8SugA/MIjMKiK/XHW/kFq4365
         s2ROysvuzO369OGSvQb97Id9n541PWhnACSPoCvQYpnYJ0rm0EL3MduDniWijbhNV6Y8
         319LjQtEjTdyTQiK+xtdxjRSahZ30EZR6xhPcEX48WdrYp6oiNILsNuxzB6Js/Cqlf4T
         SGkziqtr6rPO/A3MPS9K9mr8f/AcSc6UxhIzqeHxTtMG8OofIfu07z9egiFgb+54hGT5
         GjBT64LENynt4mseyTLDIWSiAmRGH3bkfEFFjoNEXjJtD8w76P3MelAlFuO7bklZTqqo
         suHg==
X-Gm-Message-State: APjAAAUgGRffQSIRdbNzm/yzs9E9ztYeZMMC3pABFOY3pvhJW3UjZpuV
        B1hpUh5k0sQxp2Er+CdW8QiYRA==
X-Google-Smtp-Source: APXvYqy5WbGoFBqjlrSmp5NmdZouxQeqdIToZcLG0C+PVAFhVzlX6M0oxEhN5yTq9neGJzNr5V5xfQ==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr1643795wrq.119.1553506800127;
        Mon, 25 Mar 2019 02:40:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k14sm13044652wmj.26.2019.03.25.02.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 02:39:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
Date:   Mon, 25 Mar 2019 10:39:43 +0100
Message-Id: <20190325093943.29138-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325093943.29138-1-narmstrong@baylibre.com>
References: <20190325093943.29138-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Amlogic G12A USB Control Glue HW.

The Amlogic G12A SoC Family embeds 2 USB Controllers :
- a DWC3 IP configured as Host for USB2 and USB3
- a DWC2 IP configured as Peripheral USB2 Only

A glue connects these both controllers to 2 USB2 PHYs, and optionnally
to an USB3+PCIE Combo PHY shared with the PCIE controller.

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

This drivers supports the on-probe setup of the OTG mode, and manually
via a debugfs interface. The IRQ mode change detect is yet to be added
in a future patchset, mainly due to lack of hardware to validate on.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/dwc3/Kconfig           |  10 +
 drivers/usb/dwc3/Makefile          |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c | 604 +++++++++++++++++++++++++++++
 3 files changed, 615 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 2b1494460d0c..d2ea9670563c 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -95,6 +95,16 @@ config USB_DWC3_KEYSTONE
 	  Support of USB2/3 functionality in TI Keystone2 and AM654 platforms.
 	  Say 'Y' or 'M' here if you have one such device
 
+config USB_DWC3_MESON_G12A
+       tristate "Amlogic Meson G12A Platforms"
+       depends on OF && COMMON_CLK
+       depends on ARCH_MESON || COMPILE_TEST
+       default USB_DWC3
+       select USB_ROLE_SWITCH
+       help
+         Support USB2/3 functionality in Amlogic G12A platforms.
+	 Say 'Y' or 'M' if you have one such device.
+
 config USB_DWC3_OF_SIMPLE
        tristate "Generic OF Simple Glue Layer"
        depends on OF && COMMON_CLK
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 6e3ef6144e5d..ae86da0dc5bd 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
 obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
 obj-$(CONFIG_USB_DWC3_HAPS)		+= dwc3-haps.o
 obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
+obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
new file mode 100644
index 000000000000..2aec31a2eacb
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -0,0 +1,604 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Glue for Amlogic G12A SoCs
+ *
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/*
+ * The USB is organized with a glue around the DWC3 Controller IP as :
+ * - Control registers for each USB2 Ports
+ * - Control registers for the USB PHY layer
+ * - SuperSpeed PHY can be enabled only if port is used
+ *
+ * TOFIX:
+ * - Add dynamic OTG switching with ID change interrupt
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/reset.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/role.h>
+#include <linux/regulator/consumer.h>
+
+/* USB2 Ports Control Registers */
+
+#define U2P_REG_SIZE						0x20
+
+#define U2P_R0							0x0
+	#define U2P_R0_HOST_DEVICE				BIT(0)
+	#define U2P_R0_POWER_OK					BIT(1)
+	#define U2P_R0_HAST_MODE				BIT(2)
+	#define U2P_R0_POWER_ON_RESET				BIT(3)
+	#define U2P_R0_ID_PULLUP				BIT(4)
+	#define U2P_R0_DRV_VBUS					BIT(5)
+
+#define U2P_R1							0x4
+	#define U2P_R1_PHY_READY				BIT(0)
+	#define U2P_R1_ID_DIG					BIT(1)
+	#define U2P_R1_OTG_SESSION_VALID			BIT(2)
+	#define U2P_R1_VBUS_VALID				BIT(3)
+
+/* USB Glue Control Registers */
+
+#define USB_R0							0x80
+	#define USB_R0_P30_LANE0_TX2RX_LOOPBACK			BIT(17)
+	#define USB_R0_P30_LANE0_EXT_PCLK_REQ			BIT(18)
+	#define USB_R0_P30_PCS_RX_LOS_MASK_VAL_MASK		GENMASK(28, 19)
+	#define USB_R0_U2D_SS_SCALEDOWN_MODE_MASK		GENMASK(30, 29)
+	#define USB_R0_U2D_ACT					BIT(31)
+
+#define USB_R1							0x84
+	#define USB_R1_U3H_BIGENDIAN_GS				BIT(0)
+	#define USB_R1_U3H_PME_ENABLE				BIT(1)
+	#define USB_R1_U3H_HUB_PORT_OVERCURRENT_MASK		GENMASK(4, 2)
+	#define USB_R1_U3H_HUB_PORT_PERM_ATTACH_MASK		GENMASK(9, 7)
+	#define USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK		GENMASK(13, 12)
+	#define USB_R1_U3H_HOST_U3_PORT_DISABLE			BIT(16)
+	#define USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT	BIT(17)
+	#define USB_R1_U3H_HOST_MSI_ENABLE			BIT(18)
+	#define USB_R1_U3H_FLADJ_30MHZ_REG_MASK			GENMASK(24, 19)
+	#define USB_R1_P30_PCS_TX_SWING_FULL_MASK		GENMASK(31, 25)
+
+#define USB_R2							0x88
+	#define USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK		GENMASK(25, 20)
+	#define USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK		GENMASK(31, 26)
+
+#define USB_R3							0x8c
+	#define USB_R3_P30_SSC_ENABLE				BIT(0)
+	#define USB_R3_P30_SSC_RANGE_MASK			GENMASK(3, 1)
+	#define USB_R3_P30_SSC_REF_CLK_SEL_MASK			GENMASK(12, 4)
+	#define USB_R3_P30_REF_SSP_EN				BIT(13)
+
+#define USB_R4							0x90
+	#define USB_R4_P21_PORT_RESET_0				BIT(0)
+	#define USB_R4_P21_SLEEP_M0				BIT(1)
+	#define USB_R4_MEM_PD_MASK				GENMASK(3, 2)
+	#define USB_R4_P21_ONLY					BIT(4)
+
+#define USB_R5							0x94
+	#define USB_R5_ID_DIG_SYNC				BIT(0)
+	#define USB_R5_ID_DIG_REG				BIT(1)
+	#define USB_R5_ID_DIG_CFG_MASK				GENMASK(3, 2)
+	#define USB_R5_ID_DIG_EN_0				BIT(4)
+	#define USB_R5_ID_DIG_EN_1				BIT(5)
+	#define USB_R5_ID_DIG_CURR				BIT(6)
+	#define USB_R5_ID_DIG_IRQ				BIT(7)
+	#define USB_R5_ID_DIG_TH_MASK				GENMASK(15, 8)
+	#define USB_R5_ID_DIG_CNT_MASK				GENMASK(23, 16)
+
+enum {
+	USB2_HOST_PHY = 0,
+	USB2_OTG_PHY,
+	USB3_HOST_PHY,
+	PHY_COUNT,
+};
+
+static const char *phy_names[PHY_COUNT] = {
+	"usb2-phy0", "usb2-phy1", "usb3-phy0",
+};
+
+struct dwc3_meson_g12a {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct clk		*clk;
+	struct reset_control	*reset;
+	struct phy		*phys[PHY_COUNT];
+	enum usb_dr_mode	otg_mode;
+	enum phy_mode		otg_phy_mode;
+	unsigned int		usb2_ports;
+	unsigned int		usb3_ports;
+	struct regulator	*vbus;
+	struct usb_role_switch_desc switch_desc;
+	struct usb_role_switch	*role_switch;
+};
+
+static void dwc3_meson_g12a_usb2_set_mode(struct dwc3_meson_g12a *priv,
+					  int i, enum phy_mode mode)
+{
+	if (mode == PHY_MODE_USB_HOST)
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				U2P_R0_HOST_DEVICE,
+				U2P_R0_HOST_DEVICE);
+	else
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				U2P_R0_HOST_DEVICE, 0);
+}
+
+static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
+{
+	int i;
+
+	if (priv->otg_mode == USB_DR_MODE_PERIPHERAL)
+		priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
+	else
+		priv->otg_phy_mode = PHY_MODE_USB_HOST;
+
+	for (i = 0 ; i < USB3_HOST_PHY ; ++i) {
+		if (!priv->phys[i])
+			continue;
+
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				   U2P_R0_POWER_ON_RESET,
+				   U2P_R0_POWER_ON_RESET);
+
+		if (i == USB2_OTG_PHY) {
+			regmap_update_bits(priv->regmap,
+				U2P_R0 + (U2P_REG_SIZE * i),
+				U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS,
+				U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS);
+
+			dwc3_meson_g12a_usb2_set_mode(priv, i,
+						      priv->otg_phy_mode);
+		} else
+			dwc3_meson_g12a_usb2_set_mode(priv, i,
+						      PHY_MODE_USB_HOST);
+
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				   U2P_R0_POWER_ON_RESET, 0);
+	}
+
+	return 0;
+}
+
+static void dwc3_meson_g12a_usb3_init(struct dwc3_meson_g12a *priv)
+{
+	regmap_update_bits(priv->regmap, USB_R3,
+			USB_R3_P30_SSC_RANGE_MASK |
+			USB_R3_P30_REF_SSP_EN,
+			USB_R3_P30_SSC_ENABLE |
+			FIELD_PREP(USB_R3_P30_SSC_RANGE_MASK, 2) |
+			USB_R3_P30_REF_SSP_EN);
+	udelay(2);
+
+	regmap_update_bits(priv->regmap, USB_R2,
+			USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK,
+			FIELD_PREP(USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK, 0x15));
+
+	regmap_update_bits(priv->regmap, USB_R2,
+			USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK,
+			FIELD_PREP(USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK, 0x20));
+
+	udelay(2);
+
+	regmap_update_bits(priv->regmap, USB_R1,
+			USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT,
+			USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT);
+
+	regmap_update_bits(priv->regmap, USB_R1,
+			USB_R1_P30_PCS_TX_SWING_FULL_MASK,
+			FIELD_PREP(USB_R1_P30_PCS_TX_SWING_FULL_MASK, 127));
+}
+
+static void dwc3_meson_g12a_usb_otg_apply_mode(struct dwc3_meson_g12a *priv)
+{
+	if (priv->otg_phy_mode == PHY_MODE_USB_DEVICE) {
+		regmap_update_bits(priv->regmap, USB_R0,
+				USB_R0_U2D_ACT, USB_R0_U2D_ACT);
+		regmap_update_bits(priv->regmap, USB_R0,
+				USB_R0_U2D_SS_SCALEDOWN_MODE_MASK, 0);
+		regmap_update_bits(priv->regmap, USB_R4,
+				USB_R4_P21_SLEEP_M0, USB_R4_P21_SLEEP_M0);
+	} else {
+		regmap_update_bits(priv->regmap, USB_R0,
+				USB_R0_U2D_ACT, 0);
+		regmap_update_bits(priv->regmap, USB_R4,
+				USB_R4_P21_SLEEP_M0, 0);
+	}
+}
+
+static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
+{
+	int ret;
+
+	ret = dwc3_meson_g12a_usb2_init(priv);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(priv->regmap, USB_R1,
+			USB_R1_U3H_FLADJ_30MHZ_REG_MASK,
+			FIELD_PREP(USB_R1_U3H_FLADJ_30MHZ_REG_MASK, 0x20));
+
+	regmap_update_bits(priv->regmap, USB_R5,
+			USB_R5_ID_DIG_EN_0,
+			USB_R5_ID_DIG_EN_0);
+	regmap_update_bits(priv->regmap, USB_R5,
+			USB_R5_ID_DIG_EN_1,
+			USB_R5_ID_DIG_EN_1);
+	regmap_update_bits(priv->regmap, USB_R5,
+			USB_R5_ID_DIG_TH_MASK,
+			FIELD_PREP(USB_R5_ID_DIG_TH_MASK, 0xff));
+
+	/* If we have an actual SuperSpeed port, initialize it */
+	if (priv->usb3_ports)
+		dwc3_meson_g12a_usb3_init(priv);
+
+	dwc3_meson_g12a_usb_otg_apply_mode(priv);
+
+	return 0;
+}
+
+static const struct regmap_config phy_meson_g12a_usb3_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = USB_R5,
+};
+
+static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
+{
+	int i;
+
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		priv->phys[i] = devm_phy_optional_get(priv->dev, phy_names[i]);
+		if (!priv->phys[i])
+			continue;
+
+		if (IS_ERR(priv->phys[i]))
+			return PTR_ERR(priv->phys[i]);
+
+		if (i == USB3_HOST_PHY)
+			priv->usb3_ports++;
+		else
+			priv->usb2_ports++;
+	}
+
+	dev_info(priv->dev, "USB2 ports: %d\n", priv->usb2_ports);
+	dev_info(priv->dev, "USB3 ports: %d\n", priv->usb3_ports);
+
+	return 0;
+}
+
+static enum phy_mode dwc3_meson_g12a_get_id(struct dwc3_meson_g12a *priv)
+{
+	u32 reg;
+
+	regmap_read(priv->regmap, USB_R5, &reg);
+
+	if (reg & (USB_R5_ID_DIG_SYNC | USB_R5_ID_DIG_REG))
+		return PHY_MODE_USB_DEVICE;
+
+	return PHY_MODE_USB_HOST;
+}
+
+static int dwc3_meson_g12a_otg_mode_set(struct dwc3_meson_g12a *priv,
+					enum phy_mode mode)
+{
+	int ret;
+
+	if (!priv->phys[USB2_OTG_PHY])
+		return -EINVAL;
+
+	if (mode == PHY_MODE_USB_HOST)
+		dev_info(priv->dev, "switching to Host Mode\n");
+	else
+		dev_info(priv->dev, "switching to Device Mode\n");
+
+	if (priv->vbus) {
+		if (mode == PHY_MODE_USB_DEVICE)
+			ret = regulator_disable(priv->vbus);
+		else
+			ret = regulator_enable(priv->vbus);
+		if (ret)
+			return ret;
+	}
+
+	priv->otg_phy_mode = mode;
+
+	dwc3_meson_g12a_usb2_set_mode(priv, USB2_OTG_PHY, mode);
+
+	dwc3_meson_g12a_usb_otg_apply_mode(priv);
+
+	return 0;
+}
+
+static int dwc3_meson_g12a_role_set(struct device *dev, enum usb_role role)
+{
+	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+	enum phy_mode mode;
+
+	if (role == USB_ROLE_NONE)
+		return 0;
+
+	mode = (role == USB_ROLE_HOST) ? PHY_MODE_USB_HOST
+				       : PHY_MODE_USB_DEVICE;
+
+	if (mode == priv->otg_phy_mode)
+		return 0;
+
+	return dwc3_meson_g12a_otg_mode_set(priv, mode);
+}
+
+static enum usb_role dwc3_meson_g12a_role_get(struct device *dev)
+{
+	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+
+	return priv->otg_phy_mode == PHY_MODE_USB_HOST ?
+		USB_ROLE_HOST : USB_ROLE_DEVICE;
+}
+
+static struct device *dwc3_meson_g12_find_child(struct device *dev,
+						const char *compatible)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_get_compatible_child(dev->of_node, compatible);
+	if (!np)
+		return NULL;
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return NULL;
+
+	return &pdev->dev;
+}
+
+static int dwc3_meson_g12a_probe(struct platform_device *pdev)
+{
+	struct dwc3_meson_g12a	*priv;
+	struct device		*dev = &pdev->dev;
+	struct device_node	*np = dev->of_node;
+	void __iomem *base;
+	struct resource *res;
+	enum phy_mode otg_id;
+	int ret, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &phy_meson_g12a_usb3_regmap_conf);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->vbus = devm_regulator_get_optional(dev, "vbus");
+	if (IS_ERR(priv->vbus)) {
+		if (PTR_ERR(priv->vbus) == -EPROBE_DEFER)
+			return PTR_ERR(priv->vbus);
+		priv->vbus = NULL;
+	}
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	devm_add_action_or_reset(dev,
+				 (void(*)(void *))clk_disable_unprepare,
+				 priv->clk);
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+
+	priv->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
+		dev_err(dev, "failed to get device reset, err=%d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
+	ret = dwc3_meson_g12a_get_phys(priv);
+	if (ret)
+		return ret;
+
+	if (priv->vbus) {
+		ret = regulator_enable(priv->vbus);
+		if (ret)
+			return ret;
+	}
+
+	/* Get dr_mode */
+	priv->otg_mode = usb_get_dr_mode(dev);
+
+	dwc3_meson_g12a_usb_init(priv);
+
+	/* Init PHYs */
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		ret = phy_init(priv->phys[i]);
+		if (ret)
+			return ret;
+	}
+
+	/* Set PHY Power */
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		ret = phy_power_on(priv->phys[i]);
+		if (ret)
+			goto err_phys_exit;
+	}
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
+		goto err_phys_power;
+	}
+
+	/* Setup OTG mode corresponding to the ID pin */
+	if (priv->otg_mode == USB_DR_MODE_OTG) {
+		/* TOFIX Handle ID mode toggling via IRQ */
+		otg_id = dwc3_meson_g12a_get_id(priv);
+		if (otg_id != priv->otg_phy_mode) {
+			if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
+				dev_warn(dev, "Failed to switch OTG mode\n");
+		}
+	}
+
+	/* Setup role switcher */
+	priv->switch_desc.usb2_port = dwc3_meson_g12_find_child(dev,
+								"snps,dwc3");
+	priv->switch_desc.udc = dwc3_meson_g12_find_child(dev, "snps,dwc2");
+	priv->switch_desc.allow_userspace_control = true;
+	priv->switch_desc.set = dwc3_meson_g12a_role_set;
+	priv->switch_desc.get = dwc3_meson_g12a_role_get;
+
+	priv->role_switch = usb_role_switch_register(dev, &priv->switch_desc);
+	if (IS_ERR(priv->role_switch))
+		dev_warn(dev, "Unable to register Role Switch\n");
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	return 0;
+
+err_phys_power:
+	for (i = 0 ; i < PHY_COUNT ; ++i)
+		phy_power_off(priv->phys[i]);
+
+err_phys_exit:
+	for (i = 0 ; i < PHY_COUNT ; ++i)
+		phy_exit(priv->phys[i]);
+
+	return ret;
+}
+
+static int dwc3_meson_g12a_remove(struct platform_device *pdev)
+{
+	struct dwc3_meson_g12a *priv = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int i;
+
+	usb_role_switch_unregister(priv->role_switch);
+
+	of_platform_depopulate(dev);
+
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		phy_power_off(priv->phys[i]);
+		phy_exit(priv->phys[i]);
+	}
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_meson_g12a_runtime_suspend(struct device *dev)
+{
+	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
+
+	clk_disable(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_meson_g12a_runtime_resume(struct device *dev)
+{
+	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
+
+	return clk_enable(priv->clk);
+}
+
+static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
+{
+	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		phy_power_off(priv->phys[i]);
+		phy_exit(priv->phys[i]);
+	}
+
+	reset_control_assert(priv->reset);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
+{
+	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+	int i, ret;
+
+	reset_control_deassert(priv->reset);
+
+	dwc3_meson_g12a_usb_init(priv);
+
+	/* Init PHYs */
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		ret = phy_init(priv->phys[i]);
+		if (ret)
+			return ret;
+	}
+
+	/* Set PHY Power */
+	for (i = 0 ; i < PHY_COUNT ; ++i) {
+		ret = phy_power_on(priv->phys[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_meson_g12a_suspend, dwc3_meson_g12a_resume)
+	SET_RUNTIME_PM_OPS(dwc3_meson_g12a_runtime_suspend,
+			   dwc3_meson_g12a_runtime_resume, NULL)
+};
+
+static const struct of_device_id dwc3_meson_g12a_match[] = {
+	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dwc3_meson_g12a_match);
+
+static struct platform_driver dwc3_meson_g12a_driver = {
+	.probe		= dwc3_meson_g12a_probe,
+	.remove		= dwc3_meson_g12a_remove,
+	.driver		= {
+		.name	= "dwc3-meson-g12a",
+		.of_match_table = dwc3_meson_g12a_match,
+		.pm	= &dwc3_meson_g12a_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_meson_g12a_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Amlogic Meson G12A USB Glue Layer");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-- 
2.21.0

