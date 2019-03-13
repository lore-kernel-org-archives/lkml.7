Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C808C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AE020643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY10vYHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfCMSgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:36:17 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43042 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCMSgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:36:17 -0400
Received: by mail-yw1-f67.google.com with SMTP id j66so2284181ywc.10;
        Wed, 13 Mar 2019 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6L65lk7kIG3GRor8FqCt/SYbuxDOgk7bcgitamrpqw8=;
        b=eY10vYHQ6Q3HM0YHC9WTEwn6iRbqPRyCtb9neQyENyCNXrOjuP+GtTMzYYWwWVSKUi
         yCwRJWJUXswcPrcqFbOcpJySg4dgUf5kIYIjxWD0WWyWpgTB2DjhaGybLFyg4c3cEq0g
         pbjAuHSN0tFySTmQzlksASTyQMvwctLZljf6WxU264vr4nY1BDYkjZr4ifc6y+R8RTvu
         1C8jWmRV7MHGeLinMUDP+ZxVVNArkDh/ARHhfTQ5QUOB+HTkDT8ZC//hV/xBljp6CULi
         wH7ZdNkj/G26AdDRd6s5F9eUV8N4nrYvd4hyGGXZXdVj7KKfI9PD3K0S3EI2qCAfLEAm
         141g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6L65lk7kIG3GRor8FqCt/SYbuxDOgk7bcgitamrpqw8=;
        b=KbUj5gqp9NHNpYpOHvMbmIVL88rV5YFMx2kQcwLODkg0hTkCppFu+wbm28h14+HEG6
         LXS+3vPyNnzeVUHXosI1arQJAoro1I3gbPaBKTEF9i0fTe0oPbvLorq/PwGuxaisSP3S
         tCK1Im9OG0ohRdVMPfH3lV66f2Tc3XnbSMn7wPHabLQDDPYsTlq3GoTZnpSiKbktO3GL
         rylpZlzvfbFK7l9O08pL3DZSBBPI4xTzHXNXshCwJMbfsNQ2Z0xXD+MXSxiKi5LU1FPf
         up4qu4NAmS3cLVW1yfjnm8x3cxLtGNOdGZKDEzfD1BYsYYqPfVCroX0H6Wz01xUGG/VV
         DQWg==
X-Gm-Message-State: APjAAAU7eO3wz4pqID3F8y4JYFmzaMOpVh7rM/5WY0XJJkEzky6MiE34
        7XoVqwtC06iWRa/yis4sIRo=
X-Google-Smtp-Source: APXvYqyGlpz9i+EtRsC2MNQpaXDelJryRJtFbMJg7A4mkE84u4Vu+nAd3J+jqUjoFfaQMjd3CNuKJA==
X-Received: by 2002:a25:4e0b:: with SMTP id c11mr23611902ybb.480.1552502174507;
        Wed, 13 Mar 2019 11:36:14 -0700 (PDT)
Received: from vince-laptop.corp.lucid.lcl ([12.151.33.163])
        by smtp.googlemail.com with ESMTPSA id a194sm5571200ywh.103.2019.03.13.11.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:36:13 -0700 (PDT)
From:   Vince Kim <vince.k.kim@gmail.com>
Cc:     Vince Kim <vince.k.kim@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/bridge: add initial support for TI FPDLINK bridge drivers
Date:   Wed, 13 Mar 2019 11:34:57 -0700
Message-Id: <20190313183527.22883-1-vince.k.kim@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti-fpdlink/ti-fpdlink.c:

  - A wrapper bridge driver for TI FPD LINK serializer and deserializer.

  - This driver takes care of initilizing FPD link connection between
  serializer and deserializer.

  - of_drm_find_bridge() looks up matching serializer/deserializer bridges
  from given serializer/deserializer device node.

ti-fpdlink/ti-ub927.c:

  - drm bridge driver for TI DS90UB927 FPD-Link III Serializer

ti-fpdlink/ti-ub949.c:

  - drm bridge driver for TI DS90UB949 FPD-Link III Serializer

ti-fpdlink/ti-ub948.c:

  - drm bridge driver for TI DS90UB948 FPD-Link III Deserializer

Signed-off-by: Vince Kim <vince.k.kim@gmail.com>
---
 drivers/gpu/drm/bridge/Kconfig                |  52 +--
 drivers/gpu/drm/bridge/Makefile               |   6 +-
 drivers/gpu/drm/bridge/ti-fpdlink/Kconfig     |  32 ++
 drivers/gpu/drm/bridge/ti-fpdlink/Makefile    |   5 +
 .../gpu/drm/bridge/ti-fpdlink/ti-ds90ub927.c  | 421 +++++++++++++++++
 .../gpu/drm/bridge/ti-fpdlink/ti-ds90ub948.c  | 333 ++++++++++++++
 .../gpu/drm/bridge/ti-fpdlink/ti-ds90ub949.c  | 435 ++++++++++++++++++
 .../gpu/drm/bridge/ti-fpdlink/ti-fpdlink.c    | 396 ++++++++++++++++
 .../gpu/drm/bridge/ti-fpdlink/ti-fpdlink.h    |  70 +++
 9 files changed, 1696 insertions(+), 54 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/ti-fpdlink/Kconfig
 create mode 100644 drivers/gpu/drm/bridge/ti-fpdlink/Makefile
 create mode 100644 drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub927.c
 create mode 100644 drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub948.c
 create mode 100644 drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub949.c
 create mode 100644 drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.c
 create mode 100644 drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.h

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 8840f396a7b6..4441f860f04b 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -25,24 +25,12 @@ config DRM_ANALOGIX_ANX78XX
 	  the HDMI output of an application processor to MyDP
 	  or DisplayPort.
 
-config DRM_CDNS_DSI
-	tristate "Cadence DPI/DSI bridge"
-	select DRM_KMS_HELPER
-	select DRM_MIPI_DSI
-	select DRM_PANEL_BRIDGE
-	select GENERIC_PHY_MIPI_DPHY
-	depends on OF
-	help
-	  Support Cadence DPI to DSI bridge. This is an internal
-	  bridge and is meant to be directly embedded in a SoC.
-
 config DRM_DUMB_VGA_DAC
 	tristate "Dumb VGA DAC Bridge support"
 	depends on OF
 	select DRM_KMS_HELPER
 	help
-	  Support for non-programmable RGB to VGA DAC bridges, such as ADI
-	  ADV7123, TI THS8134 and THS8135 or passive resistor ladder DACs.
+	  Support for RGB to VGA DAC based bridges
 
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
@@ -85,9 +73,6 @@ config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
 	select DRM_KMS_HELPER
-	imply EXTCON
-	select INPUT
-	select RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
 
@@ -96,32 +81,9 @@ config DRM_SII902X
 	depends on OF
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
-	select I2C_MUX
 	---help---
 	  Silicon Image sii902x bridge chip driver.
 
-config DRM_SII9234
-	tristate "Silicon Image SII9234 HDMI/MHL bridge"
-	depends on OF
-	---help---
-	  Say Y here if you want support for the MHL interface.
-	  It is an I2C driver, that detects connection of MHL bridge
-	  and starts encapsulation of HDMI signal.
-
-config DRM_THINE_THC63LVD1024
-	tristate "Thine THC63LVD1024 LVDS decoder bridge"
-	depends on OF
-	---help---
-	  Thine THC63LVD1024 LVDS/parallel converter driver.
-
-config DRM_TOSHIBA_TC358764
-	tristate "TC358764 DSI/LVDS bridge"
-	depends on DRM && DRM_PANEL
-	depends on OF
-	select DRM_MIPI_DSI
-	help
-	  Toshiba TC358764 DSI/LVDS bridge driver.
-
 config DRM_TOSHIBA_TC358767
 	tristate "Toshiba TC358767 eDP bridge"
 	depends on OF
@@ -138,20 +100,12 @@ config DRM_TI_TFP410
 	---help---
 	  Texas Instruments TFP410 DVI/HDMI Transmitter driver
 
-config DRM_TI_SN65DSI86
-	tristate "TI SN65DSI86 DSI to eDP bridge"
-	depends on OF
-	select DRM_KMS_HELPER
-	select REGMAP_I2C
-	select DRM_PANEL
-	select DRM_MIPI_DSI
-	help
-	  Texas Instruments SN65DSI86 DSI to eDP Bridge driver
-
 source "drivers/gpu/drm/bridge/analogix/Kconfig"
 
 source "drivers/gpu/drm/bridge/adv7511/Kconfig"
 
 source "drivers/gpu/drm/bridge/synopsys/Kconfig"
 
+source "drivers/gpu/drm/bridge/ti-fpdlink/Kconfig"
+
 endmenu
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 4934fcf5a6f8..9edd4c89f152 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
-obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
 obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
 obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
@@ -8,12 +7,9 @@ obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
 obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
 obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
 obj-$(CONFIG_DRM_SII902X) += sii902x.o
-obj-$(CONFIG_DRM_SII9234) += sii9234.o
-obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
-obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
 obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
-obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
 obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
+obj-$(CONFIG_DRM_TI_FPDLINK) += ti-fpdlink/
 obj-y += synopsys/
diff --git a/drivers/gpu/drm/bridge/ti-fpdlink/Kconfig b/drivers/gpu/drm/bridge/ti-fpdlink/Kconfig
new file mode 100644
index 000000000000..4e81e6454cfe
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti-fpdlink/Kconfig
@@ -0,0 +1,32 @@
+
+config DRM_TI_FPDLINK
+	tristate "TI FPD-Link III bridge"
+	depends on OF
+	select DRM_KMS_HELPER
+	help
+          Support wrapper bridge driver for Texas Instruments FPD-Link
+          Serializer and Deserializer chip.
+
+config DRM_TI_UB949
+	tristate "TI FPD-Link III UB949 Serializer"
+	depends on DRM_TI_FPDLINK
+	select DRM_KMS_HELPER
+	help
+          Support Texas Instruments FPD-Link III DS90UB949
+          Serializer which converts HDMI input to FPD-link output.
+
+config DRM_TI_UB948
+	tristate "TI FPD-Link III UB948 Deserializer"
+	depends on DRM_TI_FPDLINK
+	select DRM_KMS_HELPER
+	help
+          Supports Texas Instruments FPD-Link III DS90UB948
+          Deserializer which converts FPD-link input to LVDS output.
+
+config DRM_TI_UB927
+	tristate "TI FPD-Link III UB927 Serializer"
+	depends on DRM_TI_FPDLINK
+	select DRM_KMS_HELPER
+	help
+          Support Texas Instruments FPD-Link III DS90UB927
+          Serializer which converts LVDS input to FPD-link output.
diff --git a/drivers/gpu/drm/bridge/ti-fpdlink/Makefile b/drivers/gpu/drm/bridge/ti-fpdlink/Makefile
new file mode 100644
index 000000000000..a176a388f872
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti-fpdlink/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DRM_TI_FPDLINK) += ti-fpdlink.o
+obj-$(CONFIG_DRM_TI_UB949) += ti-ds90ub949.o
+obj-$(CONFIG_DRM_TI_UB948) += ti-ds90ub948.o
+obj-$(CONFIG_DRM_TI_UB927) += ti-ds90ub927.o
diff --git a/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub927.c b/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub927.c
new file mode 100644
index 000000000000..88173f8b18ae
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub927.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI FPD-LinkIII DS90UB927 driver
+ *
+ * Copyright (C) 2019 Lucid Motors Inc.
+ *
+ * Contact: Vince Kim <vince.k.kim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of_gpio.h>
+#include <drm/drmP.h>
+#include "ti-fpdlink.h"
+
+#define UB927_RESET_REG				0x01
+#define UB927_RESET_DGTL_RST1			(1<<1)
+
+#define UB927_GS_REG				0x0c
+#define UB927_GS_BIST_CRC_ERROR			(1<<3)
+#define UB927_GS_PCLK_DETECT			(1<<2)
+#define UB927_GS_DES_CRC_ERROR			(1<<1)
+#define UB927_GS_LINK_DETECT			(1<<0)
+
+#define UB927_I2C_CTRL_REG			0x17
+#define UB927_I2C_CTRL_PASS_ALL			(1<<7)
+
+#define MAX_I2C_RETRY 10
+
+
+static inline struct fpdlink_dev *
+drm_bridge_to_ub927(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct fpdlink_dev, bridge);
+}
+
+static inline int
+regmap_write_fpdlink(struct regmap *map, unsigned int reg, unsigned int val)
+{
+	int count = MAX_I2C_RETRY;
+	int ret = -1;
+
+	while (count-- && (ret = regmap_write(map, reg, val)))
+		usleep_range(1000, 1100);
+
+	return ret;
+}
+
+static const struct regmap_config ub927_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.max_register = 0xff,
+};
+
+static int ub927_enable(struct fpdlink_dev *ub927)
+{
+	if (gpio_is_valid(ub927->gpio_power_en)) {
+		gpio_set_value(ub927->gpio_power_en, 1);
+	} else {
+		if (ub927->gpio_power_en > 0) {
+			dev_err(ub927->dev, "invalid gpio for gpio_disp_en %s\n",
+				ub927->gpio_name);
+			return -ENXIO;
+		}
+	}
+	msleep(200);
+	return 0;
+}
+
+static void ub927_disable(struct fpdlink_dev *ub927)
+{
+	regmap_write_fpdlink(ub927->regmap, UB927_RESET_REG,
+			UB927_RESET_DGTL_RST1);
+}
+
+static int ub927_reset(struct fpdlink_dev *ub927)
+{
+	int ret;
+
+	ret = regmap_write_fpdlink(ub927->regmap, UB927_RESET_REG,
+				   UB927_RESET_DGTL_RST1);
+	usleep_range(1000, 1500);
+	return ret;
+}
+
+static int ub927_enable_i2c_passthrough(struct fpdlink_dev *ub927)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(ub927->regmap, UB927_I2C_CTRL_REG, &val);
+	if (ret < 0) {
+		dev_err(ub927->dev, "failed on regmap_read at %s()\n",
+				__func__);
+		return ret;
+	}
+
+	ret = regmap_write_fpdlink(ub927->regmap, UB927_I2C_CTRL_REG,
+				   (val | UB927_I2C_CTRL_PASS_ALL));
+	if (ret < 0) {
+		dev_err(ub927->dev, "failed onregmap_write_fpdlink at %s()\n",
+			__func__);
+		return ret;
+	}
+
+	msleep(100);
+	return ret;
+}
+
+static int ub927_reg_write(struct fpdlink_dev *ub927, u8 reg, u8 val)
+{
+	return regmap_write_fpdlink(ub927->regmap, reg, val);
+}
+
+static int ub927_update_config(struct fpdlink_dev *ub927)
+{
+	int i = 0;
+	int size;
+	u8 *config_array;
+	int ret = 0;
+
+	size = ub927->config_array_size;
+	config_array = ub927->config_array;
+
+	if (!config_array)
+		return 0;
+
+	while (i < size) {
+		ret = regmap_write_fpdlink(ub927->regmap, config_array[i],
+					   config_array[i+1]);
+		if (ret) {
+			dev_err(ub927->dev,
+				"%s: failed to update register\n", __func__);
+			return -EINVAL;
+		}
+		i += 2;
+	}
+	return 0;
+}
+
+static bool ub927_link_detect(struct fpdlink_dev *ub927)
+{
+	unsigned int val;
+	int count, ret;
+
+	mutex_lock(&ub927->lock);
+	ub927->link_status = not_detected;
+
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		usleep_range(10000, 15000);
+		ret = regmap_read(ub927->regmap, UB927_GS_REG, &val);
+		if (!ret && (val & UB927_GS_LINK_DETECT)) {
+			dev_info(ub927->dev,
+				 "LVDS: %d Serializer FPD link ready!\n",
+				 ub927->index);
+			ub927->link_status = detected;
+			ret = true;
+			goto done;
+		}
+	}
+
+	dev_info(ub927->dev, "LVDS: %d Serializer FPD link failed!!\n",
+			ub927->index);
+
+done:
+	mutex_unlock(&ub927->lock);
+
+	if (ret < 0) {
+		dev_info(ub927->dev,
+				"failed on regmap_read at %s()\n", __func__);
+	}
+	return (ub927->link_status ? true : false);
+}
+
+static bool ub927_pixel_clk_detect(struct fpdlink_dev *ub927)
+{
+	unsigned int val;
+	int count, ret;
+
+	mutex_lock(&ub927->lock);
+
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		ret = regmap_read(ub927->regmap, UB927_GS_REG, &val);
+		if (!ret && (val & UB927_GS_PCLK_DETECT)) {
+			dev_info(ub927->dev,
+					"LVDS: %d, Serializer LVDS CLK OK!!\n",
+					ub927->index);
+			ub927->pixel_clk_status = detected;
+			ret = true;
+			goto done;
+		}
+	}
+	dev_info(ub927->dev,
+			"LVDS:%d LVDS CLK is not detected at Serializer !!\n",
+			ub927->index);
+	ub927->pixel_clk_status = not_detected;
+
+done:
+	mutex_unlock(&ub927->lock);
+	if (ret < 0) {
+		dev_info(ub927->dev,
+				"failed on regmap_read at %s()\n", __func__);
+	}
+	return (ub927->pixel_clk_status ? true : false);
+
+}
+
+static int parse_config_val(struct fpdlink_dev *ub927, struct device_node *np)
+{
+	const u32 *config_property;
+	int len;
+	u8 *config_array;
+	int config_array_size;
+	int i = 0;
+
+	config_property = of_get_property(np, "reg_config", &len);
+	config_array_size = len/sizeof(u32);
+
+	/*config value must be pair of register offset and value */
+	if (!config_property || config_array_size <= 1 || config_array_size%2)
+		return -EINVAL;
+
+	config_array = kcalloc(config_array_size, sizeof(u8), GFP_KERNEL);
+	if (!config_array_size)
+		return -ENOMEM;
+
+	for (i = 0; i < config_array_size; i++)
+		config_array[i] = (u8)be32_to_cpu(config_property[i]);
+
+	ub927->config_array_size = config_array_size;
+	ub927->config_array = config_array;
+	return 0;
+}
+
+static const struct fpdlink_dev_funcs ub927_fpdlink_dev_funcs = {
+	.enable				= ub927_enable,
+	.reset				= ub927_reset,
+	.enable_i2c_passthrough		= ub927_enable_i2c_passthrough,
+	.reg_write			= ub927_reg_write,
+	.link_detect			= ub927_link_detect,
+	.pixel_clk_detect		= ub927_pixel_clk_detect,
+	.config				= ub927_update_config,
+};
+
+static void ub927_shutdown(struct i2c_client *client)
+{
+	struct fpdlink_dev *ub927 = i2c_get_clientdata(client);
+
+	ub927_disable(ub927);
+}
+
+static ssize_t link_status_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct fpdlink_dev *ub927 = dev_get_drvdata(dev);
+	int ret = 0;
+	int count, status;
+	unsigned int val;
+
+	ret = mutex_lock_interruptible(&ub927->lock);
+	if (ret)
+		return ret;
+
+	ub927->link_status = not_detected;
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		usleep_range(10000, 15000);
+		ret = regmap_read(ub927->regmap, UB927_GS_REG, &val);
+		if (!ret && (val & UB927_GS_LINK_DETECT)) {
+			ub927->link_status = detected;
+			break;
+		}
+		usleep_range(10000, 15000);
+	}
+	status = ub927->link_status;
+	mutex_unlock(&ub927->lock);
+
+	if (ret < 0) {
+		dev_info(ub927->dev, "failed on regmap_read at %s()\n",
+				__func__);
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			status ? "connected":"disconnected");
+}
+
+static ssize_t pixel_clk_status_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct fpdlink_dev *ub927 = dev_get_drvdata(dev);
+	int count, status;
+	int ret = 0;
+	unsigned int val;
+
+	ret = mutex_lock_interruptible(&ub927->lock);
+	if (ret)
+		return ret;
+
+	ub927->pixel_clk_status = not_detected;
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		ret = regmap_read(ub927->regmap, UB927_GS_REG, &val);
+		if (!ret && (val & UB927_GS_PCLK_DETECT)) {
+			ub927->pixel_clk_status = detected;
+			break;
+		}
+		usleep_range(10000, 15000);
+	}
+
+	status = ub927->pixel_clk_status;
+	mutex_unlock(&ub927->lock);
+
+	if (ret < 0) {
+		dev_info(ub927->dev, "failed on regmap_read at %s()\n",
+				__func__);
+	}
+	return snprintf(buf, PAGE_SIZE, "%s\n", status ? "on":"off");
+}
+
+static DEVICE_ATTR_RO(link_status);
+static DEVICE_ATTR_RO(pixel_clk_status);
+
+
+static int ub927_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct fpdlink_dev *ub927;
+	struct device_node *node_ptr;
+
+	int ret = 0;
+
+	ub927 = devm_kzalloc(dev, sizeof(*ub927), GFP_KERNEL);
+	if (!ub927)
+		return -ENOMEM;
+
+	ub927->dev = dev;
+	node_ptr = dev->of_node;
+
+	ub927->gpio_power_en = of_get_named_gpio(node_ptr, "power-en-pin", 0);
+	if (ub927->gpio_power_en > 0) {
+		sprintf(ub927->gpio_name, "ub927 %d", ub927->index);
+		if (!gpio_is_valid(ub927->gpio_power_en)) {
+			dev_err(dev, "invalid gpio for gpio_power_en %s\n",
+					ub927->gpio_name);
+			ret = -ENXIO;
+			goto done;
+		}
+	}
+
+	ub927->client = client;
+	ub927->regmap = devm_regmap_init_i2c(client, &ub927_regmap_config);
+	if (IS_ERR(ub927->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		ret = PTR_ERR(ub927->regmap);
+		goto done;
+	}
+
+	ub927->bridge.of_node = node_ptr;
+	ub927_disable(ub927);
+
+	mutex_init(&ub927->lock);
+	ub927->funcs = &ub927_fpdlink_dev_funcs;
+	parse_config_val(ub927, node_ptr);
+	i2c_set_clientdata(client, ub927);
+
+	drm_bridge_add(&ub927->bridge);
+
+	device_create_file(dev, &dev_attr_link_status);
+	device_create_file(dev, &dev_attr_pixel_clk_status);
+
+done:
+	if (ret < 0)
+		devm_kfree(&client->dev, ub927);
+	return ret;
+}
+
+static int ub927_remove(struct i2c_client *client)
+{
+	struct fpdlink_dev *ub927 =  i2c_get_clientdata(client);
+
+	drm_bridge_remove(&ub927->bridge);
+	return 0;
+}
+
+static const struct i2c_device_id ub927_id[] = {
+	{ "ds90ub927", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ub927_id);
+
+static const struct of_device_id ub927_match[] = {
+	{ .compatible = "ti,ds90ub927" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ub927_match);
+
+static struct i2c_driver ti_ub927_driver = {
+	.id_table	= ub927_id,
+	.probe		= ub927_probe,
+	.remove		= ub927_remove,
+	.shutdown	= ub927_shutdown,
+	.driver		= {
+	.name		= "ti-ub927",
+	.of_match_table	= ub927_match,
+	},
+};
+module_i2c_driver(ti_ub927_driver);
+
+MODULE_AUTHOR("Vince Kim <vince.k.kim@gmail.com>");
+MODULE_DESCRIPTION("TI UB927 Serializer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub948.c b/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub948.c
new file mode 100644
index 000000000000..f42130a19533
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub948.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI FPD-LinkIII DS90UB948 driver
+ *
+ * Copyright (C) 2019 Lucid Motors Inc.
+ *
+ * Contact: Vince Kim <vince.k.kim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of_gpio.h>
+#include <drm/drmP.h>
+#include "ti-fpdlink.h"
+
+#define UB948_RESET_REG				0x01
+#define UB948_RESET_DGTL_RST0			(1<<2)
+
+#define UB948_GS_REG				0x1c
+#define UB948_GS_LOCK_DETECT			(1<<0)
+
+#define UB948_DUAL_CTL1_REG			0x5b
+
+#define UB948_DUAL_STS_REG			0x5a
+#define UB948_DUAL_STS_FPD3_LINK_READY		(1<<7)
+
+#define MAX_I2C_RETRY 10
+
+static inline struct fpdlink_dev *
+drm_bridge_to_ub948(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct fpdlink_dev, bridge);
+}
+
+static inline int regmap_write_fpdlink(struct regmap *map, unsigned int reg,
+					unsigned int val)
+{
+	int count = MAX_I2C_RETRY;
+	int ret = -1;
+
+	while (count-- && (ret = regmap_write(map, reg, val)))
+		usleep_range(1000, 1100);
+
+	return ret;
+}
+
+static const struct regmap_config ub948_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.max_register = 0xff,
+};
+
+static int ub948_enable(struct fpdlink_dev *ub948)
+{
+	if (gpio_is_valid(ub948->gpio_power_en)) {
+		gpio_set_value(ub948->gpio_power_en, 1);
+	} else {
+		if (ub948->gpio_power_en > 0) {
+			dev_err(ub948->dev,
+				"invalid gpio for gpio_disp_en %s\n",
+				ub948->gpio_name);
+			return -ENXIO;
+		}
+	}
+	msleep(200);
+	return 0;
+}
+
+static void ub948_disable(struct fpdlink_dev *ub948)
+{
+	if (gpio_is_valid(ub948->gpio_power_en))
+		gpio_set_value(ub948->gpio_power_en, 0);
+}
+
+static int ub948_reset(struct fpdlink_dev *ub948)
+{
+	int ret;
+
+	ret = regmap_write_fpdlink(ub948->regmap,
+			UB948_RESET_REG, UB948_RESET_DGTL_RST0);
+	msleep(100);
+	if (ret == 0)
+		ub948->detected = true;
+	return ret;
+}
+
+static int ub948_reg_write(struct fpdlink_dev *ub948, u8 reg, u8 val)
+{
+	return regmap_write_fpdlink(ub948->regmap, reg, val);
+}
+
+static int ub948_update_config(struct fpdlink_dev *ub948)
+{
+	int i = 0;
+	int size;
+	u8 *config_array;
+	int ret = 0;
+
+	size = ub948->config_array_size;
+	config_array = ub948->config_array;
+
+	if (!config_array)
+		return 0;
+
+	while (i < size) {
+		ret = regmap_write_fpdlink(ub948->regmap, config_array[i],
+				config_array[i+1]);
+		if (ret) {
+			dev_err(ub948->dev,
+				"%s: failed to update register\n", __func__);
+			return -EINVAL;
+		}
+		i += 2;
+	}
+	return 0;
+}
+
+static bool ub948_link_detect(struct fpdlink_dev *ub948)
+{
+	unsigned int val;
+	int count, ret;
+
+	if (ub948->detected == false)
+		return false;
+
+	mutex_lock(&ub948->lock);
+	ub948->link_status = not_detected;
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		ret = regmap_read(ub948->regmap, UB948_GS_REG, &val);
+
+		if (!ret && (val & UB948_GS_LOCK_DETECT)) {
+			dev_info(ub948->dev,
+				"HDMI: %d DeSerializer FPD link ready!\n",
+				ub948->index);
+			ub948->link_status = detected;
+			ret = true;
+			goto done;
+		}
+		usleep_range(10000, 11000);
+	}
+	dev_info(ub948->dev, "HDMI: %d DeSerializer FPD link failed!!\n",
+			ub948->index);
+
+done:
+	mutex_unlock(&ub948->lock);
+
+	if (ret < 0)
+		dev_info(ub948->dev, "failed on regmap_read at %s()\n",
+				__func__);
+
+	return ub948->link_status ? true : false;
+}
+
+static int parse_config_val(struct fpdlink_dev *ub948,
+		struct device_node *node_ptr)
+{
+	const u32 *config_property;
+	int len;
+	u8 *config_array;
+	int config_array_size;
+	int i = 0;
+
+	config_property = of_get_property(node_ptr, "reg_config", &len);
+	config_array_size = len/sizeof(u32);
+
+	/*config value must be pair of register offset and value */
+	if (!config_property || config_array_size <= 1 || config_array_size%2)
+		return -EINVAL;
+
+	config_array = kcalloc(config_array_size, sizeof(u8), GFP_KERNEL);
+	if (!config_array_size)
+		return -ENOMEM;
+
+	for (i = 0; i < config_array_size; i++)
+		config_array[i] = (u8)be32_to_cpu(config_property[i]);
+
+	ub948->config_array_size = config_array_size;
+	ub948->config_array = config_array;
+	return 0;
+}
+
+static const struct fpdlink_dev_funcs ub948_fpdlink_dev_funcs = {
+	.enable				= ub948_enable,
+	.reset				= ub948_reset,
+	.reg_write			= ub948_reg_write,
+	.link_detect			= ub948_link_detect,
+	.config				= ub948_update_config,
+};
+
+static void ub948_shutdown(struct i2c_client *client)
+{
+	struct fpdlink_dev *ub948 = i2c_get_clientdata(client);
+
+	ub948_disable(ub948);
+}
+
+static ssize_t lock_status_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct fpdlink_dev *ub948 = dev_get_drvdata(dev);
+	int ret = 0;
+	int status;
+	unsigned int val;
+	int count;
+
+	if (ub948->detected == false)
+		return snprintf(buf, PAGE_SIZE, "%s\n", "off");
+
+	ret = mutex_lock_interruptible(&ub948->lock);
+	if (ret)
+		return ret;
+
+	ub948->link_status = not_detected;
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		ret = regmap_read(ub948->regmap, UB948_GS_REG, &val);
+		if (!ret && (val & UB948_GS_LOCK_DETECT)) {
+			ub948->link_status = detected;
+			break;
+		}
+		usleep_range(10000, 11000);
+	}
+	status = ub948->link_status;
+	mutex_unlock(&ub948->lock);
+
+	if (ret < 0) {
+		dev_info(ub948->dev, "failed on regmap_read at %s()\n",
+				__func__);
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", status ? "on":"off");
+}
+static DEVICE_ATTR_RO(lock_status);
+
+static int ub948_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct fpdlink_dev *ub948;
+	struct device_node *node_ptr;
+
+	int ret = 0;
+
+	ub948 = devm_kzalloc(dev, sizeof(*ub948), GFP_KERNEL);
+	if (!ub948)
+		return -ENOMEM;
+
+	ub948->dev = dev;
+	node_ptr = dev->of_node;
+
+	ub948->gpio_power_en = of_get_named_gpio(node_ptr, "power-en-pin", 0);
+	if (ub948->gpio_power_en > 0) {
+		sprintf(ub948->gpio_name, "ub948 %d", ub948->index);
+		if (!gpio_is_valid(ub948->gpio_power_en)) {
+			dev_err(dev, "invalid gpio for gpio_power_en %s\n",
+					ub948->gpio_name);
+			ret = -ENXIO;
+			goto done;
+		}
+	}
+
+	ub948->client = client;
+	ub948->regmap = devm_regmap_init_i2c(client, &ub948_regmap_config);
+	if (IS_ERR(ub948->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		ret = PTR_ERR(ub948->regmap);
+		goto done;
+	}
+
+	mutex_init(&ub948->lock);
+	ub948->bridge.of_node = node_ptr;
+	ub948_disable(ub948);
+
+	ub948->funcs = &ub948_fpdlink_dev_funcs;
+	parse_config_val(ub948, node_ptr);
+	i2c_set_clientdata(client, ub948);
+
+	drm_bridge_add(&ub948->bridge);
+	device_create_file(dev, &dev_attr_lock_status);
+	/*
+	 * we don't know if deserializer is attached until serializer is ready.
+	 */
+	ub948->detected = false;
+
+done:
+	return ret;
+}
+
+static int ub948_remove(struct i2c_client *client)
+{
+	struct fpdlink_dev *ub948 =  i2c_get_clientdata(client);
+
+	drm_bridge_remove(&ub948->bridge);
+	return 0;
+}
+
+static const struct i2c_device_id ub948_id[] = {
+	{ "ds90ub948", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ub948_id);
+
+static const struct of_device_id ub948_match[] = {
+	{ .compatible = "ti,ds90ub948" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ub948_match);
+
+static struct i2c_driver ti_ub948_driver = {
+	.id_table	= ub948_id,
+	.probe		= ub948_probe,
+	.remove		= ub948_remove,
+	.shutdown	= ub948_shutdown,
+	.driver		= {
+	.name		= "ti-ub948",
+	.of_match_table	= ub948_match,
+	},
+};
+module_i2c_driver(ti_ub948_driver);
+
+MODULE_AUTHOR("Vince Kim <vince.k.kim@gmail.com>");
+MODULE_DESCRIPTION("TI UB948 Serializer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub949.c b/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub949.c
new file mode 100644
index 000000000000..bb99d296fbb8
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti-fpdlink/ti-ds90ub949.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI FPD-LinkIII DS90UB949 driver
+ *
+ * Copyright (C) 2019 Lucid Motors Inc.
+ *
+ * Contact: Vince Kim <vince.k.kim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of_gpio.h>
+#include <drm/drmP.h>
+#include "ti-fpdlink.h"
+
+#define UB949_RESET_REG				0x01
+#define UB949_RESET_HDMI_RST			(1<<4)
+#define UB949_RESET_DGTL_RST1			(1<<1)
+
+#define UB949_GS_REG				0x0c
+#define UB949_GS_BIST_CRC_ERROR			(1<<3)
+#define UB949_GS_TMDS_CLK_DETECT		(1<<2)
+#define UB949_GS_DES_CRC_ERROR			(1<<1)
+#define UB949_GS_LINK_DETECT			(1<<0)
+
+#define UB949_I2C_CTRL_REG			0x17
+#define UB949_I2C_CTRL_PASS_ALL			(1<<7)
+
+#define UB949_DUAL_STS_REG			0x5a
+#define UB949_DUAL_STS_FPD3_LINK_READY		(1<<7)
+#define UB949_DUAL_STS_FPD3_TX_STS		(1<<6)
+
+#define UB949_DUAL_CTL1_REG			0x5b
+#define UB949_DUAL_CTL2_REG			0x5c
+#define UB949_HDMI_FREQ				0x5f
+
+#define MAX_I2C_RETRY 10
+
+
+static inline struct fpdlink_dev *
+drm_bridge_to_ub949(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct fpdlink_dev, bridge);
+}
+
+static inline int regmap_write_fpdlink(struct regmap *map, unsigned int reg,
+					unsigned int val)
+{
+	int count = MAX_I2C_RETRY;
+	int ret = -1;
+
+	while (count-- && (ret = regmap_write(map, reg, val)))
+		usleep_range(1000, 1100);
+
+	return ret;
+}
+
+static const struct regmap_config ub949_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.max_register = 0xff,
+};
+
+static int ub949_enable(struct fpdlink_dev *ub949)
+{
+	if (gpio_is_valid(ub949->gpio_power_en)) {
+		gpio_set_value(ub949->gpio_power_en, 1);
+	} else {
+		if (ub949->gpio_power_en > 0) {
+			dev_err(ub949->dev,
+				"invalid gpio for gpio_disp_en %s\n",
+				ub949->gpio_name);
+			return -ENXIO;
+		}
+	}
+
+	msleep(200);
+	return 0;
+}
+
+static void ub949_disable(struct fpdlink_dev *ub949)
+{
+	regmap_write_fpdlink(ub949->regmap, UB949_RESET_REG,
+			(UB949_RESET_HDMI_RST|UB949_RESET_DGTL_RST1));
+}
+
+static int ub949_reset(struct fpdlink_dev *ub949)
+{
+	int ret;
+
+	ret = regmap_write_fpdlink(ub949->regmap, UB949_RESET_REG,
+			(UB949_RESET_HDMI_RST|UB949_RESET_DGTL_RST1));
+	usleep_range(10000, 11000);
+
+	return ret;
+}
+
+static int ub949_enable_i2c_passthrough(struct fpdlink_dev *ub949)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(ub949->regmap, UB949_I2C_CTRL_REG, &val);
+	if (ret < 0) {
+		dev_err(ub949->dev, "failed on regmap_read at %s()\n",
+				__func__);
+		return ret;
+	}
+
+	ret = regmap_write_fpdlink(ub949->regmap, UB949_I2C_CTRL_REG,
+			(val | UB949_I2C_CTRL_PASS_ALL));
+	msleep(100);
+
+	return ret;
+}
+
+static int ub949_reg_write(struct fpdlink_dev *ub949, u8 reg, u8 val)
+{
+	return regmap_write_fpdlink(ub949->regmap, reg, val);
+}
+
+static int ub949_update_config(struct fpdlink_dev *ub949)
+{
+	int i = 0;
+	int size;
+	u8 *config_array;
+	int ret = 0;
+
+	size = ub949->config_array_size;
+	config_array = ub949->config_array;
+
+	if (!config_array)
+		return 0;
+
+	while (i < size) {
+		ret = regmap_write_fpdlink(ub949->regmap, config_array[i],
+				config_array[i+1]);
+		if (ret) {
+			dev_err(ub949->dev,
+				"%s: failed to update register\n", __func__);
+			return -EINVAL;
+		}
+		i += 2;
+	}
+
+	return 0;
+}
+
+static bool ub949_link_detect(struct fpdlink_dev *ub949)
+{
+	unsigned int val, val2;
+	int count, ret;
+
+	mutex_lock(&ub949->lock);
+	ub949->link_status = not_detected;
+
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		usleep_range(10000, 11000);
+		ret = regmap_read(ub949->regmap, UB949_GS_REG, &val);
+		ret += regmap_read(ub949->regmap, UB949_DUAL_STS_REG, &val2);
+		if (!ret && (val & UB949_GS_LINK_DETECT) &&
+				(val2 & UB949_DUAL_STS_FPD3_LINK_READY)) {
+			dev_info(ub949->dev,
+					"HDMI: %d Serializer FPD link ready!\n",
+					ub949->index);
+			ub949->link_status = detected;
+			ret = true;
+			goto done;
+		}
+	}
+	dev_info(ub949->dev,
+			"HDMI:%d Serializer FPD link failed!!\n", ub949->index);
+
+done:
+	mutex_unlock(&ub949->lock);
+
+	if (ret < 0) {
+		dev_info(ub949->dev,
+				"failed on regmap_read at %s()\n", __func__);
+	}
+
+	return (ub949->link_status ? true : false);
+}
+
+static bool ub949_pixel_clk_detect(struct fpdlink_dev *ub949)
+{
+	unsigned int val;
+	int count, ret;
+
+	mutex_lock(&ub949->lock);
+
+	for (count = 0; count < 1; count++) {
+		ret = regmap_read(ub949->regmap, UB949_HDMI_FREQ, &val);
+		if (!ret && val) {
+			dev_info(ub949->dev,
+					"HDMI: %d,  Serializer HDMI CLK OK!!\n",
+					ub949->index);
+			ub949->pixel_clk_status = detected;
+			ret = true;
+			goto done;
+		}
+	}
+	dev_info(ub949->dev,
+			"HDMI:%d HDMI CLK is not detected at Serializer !!\n",
+			ub949->index);
+	ub949->pixel_clk_status = not_detected;
+
+done:
+	mutex_unlock(&ub949->lock);
+
+	if (ret < 0)
+		dev_info(ub949->dev,
+				"failed on regmap_read at %s()\n", __func__);
+
+	return ub949->pixel_clk_status ? true : false;
+
+}
+
+static int parse_config_val(struct fpdlink_dev *ub949,
+		struct device_node *node_ptr)
+{
+	const u32 *config_property;
+	int len;
+	u8 *config_array;
+	int config_array_size;
+	int i = 0;
+
+	config_property = of_get_property(node_ptr, "reg_config", &len);
+	config_array_size = len/sizeof(u32);
+
+	/*config value must be a pair of register offset and value */
+	if (!config_property || config_array_size <= 1 || config_array_size%2)
+		return -EINVAL;
+
+	config_array = kcalloc(config_array_size, sizeof(u8), GFP_KERNEL);
+	if (!config_array_size)
+		return -ENOMEM;
+
+	for (i = 0; i < config_array_size; i++)
+		config_array[i] = (u8)be32_to_cpu(config_property[i]);
+
+	ub949->config_array_size = config_array_size;
+	ub949->config_array = config_array;
+	return 0;
+}
+
+static const struct fpdlink_dev_funcs ub949_fpdlink_dev_funcs = {
+	.enable				= ub949_enable,
+	.reset				= ub949_reset,
+	.enable_i2c_passthrough		= ub949_enable_i2c_passthrough,
+	.reg_write			= ub949_reg_write,
+	.link_detect			= ub949_link_detect,
+	.pixel_clk_detect		= ub949_pixel_clk_detect,
+	.config				= ub949_update_config,
+};
+
+static void ub949_shutdown(struct i2c_client *client)
+{
+	struct fpdlink_dev *ub949 = i2c_get_clientdata(client);
+
+	ub949_disable(ub949);
+}
+
+static ssize_t link_status_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct fpdlink_dev *ub949 = dev_get_drvdata(dev);
+	int status, ret;
+	unsigned int val, val2;
+	int count;
+
+	ret = mutex_lock_interruptible(&ub949->lock);
+	if (ret)
+		return ret;
+
+	ub949->link_status = not_detected;
+
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		ret = regmap_read(ub949->regmap, UB949_GS_REG, &val);
+		ret += regmap_read(ub949->regmap, UB949_DUAL_STS_REG, &val2);
+		if (!ret && (val & UB949_GS_LINK_DETECT)
+			 && (val2 & UB949_DUAL_STS_FPD3_LINK_READY)) {
+			ub949->link_status = detected;
+			break;
+		}
+		usleep_range(10000, 11000);
+	}
+	status = ub949->link_status;
+	mutex_unlock(&ub949->lock);
+
+	if (ret < 0)
+		dev_err(ub949->dev,
+				"failed on regmap_read at %s()\n", __func__);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			status ? "connected":"disconnected");
+}
+
+static ssize_t pixel_clk_status_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct fpdlink_dev *ub949 = dev_get_drvdata(dev);
+	int status, ret;
+	unsigned int val, val2;
+	int count;
+
+	ret = mutex_lock_interruptible(&ub949->lock);
+	if (ret)
+		return ret;
+
+	ub949->pixel_clk_status = not_detected;
+	for (count = 0; count < MAX_I2C_RETRY; count++) {
+		ret = regmap_read(ub949->regmap, UB949_HDMI_FREQ, &val);
+		ret += regmap_read(ub949->regmap, UB949_GS_REG, &val2);
+		if (!ret && val && (val2 & UB949_GS_TMDS_CLK_DETECT)) {
+			ub949->pixel_clk_status = detected;
+			break;
+		}
+		usleep_range(10000, 11000);
+	}
+	status = ub949->pixel_clk_status;
+	mutex_unlock(&ub949->lock);
+
+	if (ret < 0)
+		dev_err(ub949->dev,
+				"failed on regmap_read at %s()\n", __func__);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", status ? "on":"off");
+}
+
+static DEVICE_ATTR_RO(link_status);
+static DEVICE_ATTR_RO(pixel_clk_status);
+
+static int ub949_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct fpdlink_dev *ub949;
+	struct device_node *node_ptr;
+
+	int ret = 0;
+
+	ub949 = devm_kzalloc(dev, sizeof(*ub949), GFP_KERNEL);
+	if (!ub949)
+		return -ENOMEM;
+
+	ub949->dev = dev;
+	node_ptr = dev->of_node;
+
+	ub949->gpio_power_en = of_get_named_gpio(node_ptr, "power-en-pin", 0);
+	if (ub949->gpio_power_en > 0) {
+		sprintf(ub949->gpio_name, "ub949 %d", ub949->index);
+		if (!gpio_is_valid(ub949->gpio_power_en)) {
+			dev_err(dev, "invalid gpio for gpio_power_en %s\n",
+					ub949->gpio_name);
+			ret = -ENXIO;
+			goto done;
+		}
+	}
+
+	ub949->client = client;
+	ub949->regmap = devm_regmap_init_i2c(client, &ub949_regmap_config);
+	if (IS_ERR(ub949->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		ret = PTR_ERR(ub949->regmap);
+		goto done;
+	}
+
+	mutex_init(&ub949->lock);
+
+	ub949->bridge.of_node = node_ptr;
+	ub949_disable(ub949);
+
+	ub949->funcs = &ub949_fpdlink_dev_funcs;
+	parse_config_val(ub949, node_ptr);
+	i2c_set_clientdata(client, ub949);
+
+	drm_bridge_add(&ub949->bridge);
+
+	device_create_file(dev, &dev_attr_link_status);
+	device_create_file(dev, &dev_attr_pixel_clk_status);
+
+done:
+	if (ret < 0)
+		devm_kfree(&client->dev, ub949);
+
+	return ret;
+}
+
+static int ub949_remove(struct i2c_client *client)
+{
+	struct fpdlink_dev *ub949 =  i2c_get_clientdata(client);
+
+	drm_bridge_remove(&ub949->bridge);
+	return 0;
+}
+
+static const struct i2c_device_id ub949_id[] = {
+	{ "ds90ub949", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ub949_id);
+
+static const struct of_device_id ub949_match[] = {
+	{ .compatible = "ti,ds90ub949" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ub949_match);
+
+static struct i2c_driver ti_ub949_driver = {
+	.id_table	= ub949_id,
+	.probe		= ub949_probe,
+	.remove		= ub949_remove,
+	.shutdown	= ub949_shutdown,
+	.driver		= {
+		.name		= "ti-ub949",
+		.of_match_table	= ub949_match,
+	},
+};
+module_i2c_driver(ti_ub949_driver);
+
+MODULE_AUTHOR("Vince Kim <vince.k.kim@gmail.com>");
+MODULE_DESCRIPTION("TI UB949 Serializer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.c b/drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.c
new file mode 100644
index 000000000000..fa4cd5806f19
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI FPD-LinkIII interface bridge driver
+ *
+ * Copyright (C) 2019 Lucid Motors Inc.
+ *
+ * Contact: Vince Kim <vince.k.kim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <linux/of_gpio.h>
+#include "ti-fpdlink.h"
+
+struct fpdlink {
+	struct drm_bridge	bridge;
+	struct drm_connector	connector;
+
+	struct fpdlink_dev	*serializer;
+	struct fpdlink_dev	*deserializer;
+	struct device_node	*fpdlink_node;
+	struct mutex lock;
+
+	unsigned int index;
+	enum clk_status pixel_clk_status;
+	enum clk_status link_status;
+	bool enabled;
+};
+
+
+static inline struct fpdlink *
+drm_bridge_to_fpdlink(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct fpdlink, bridge);
+}
+
+static inline struct fpdlink *
+drm_connector_to_fpdlink(struct drm_connector *connector)
+{
+	return container_of(connector, struct fpdlink, connector);
+}
+
+static int fpdlink_dev_enable(struct fpdlink_dev *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+	if (!dev->funcs)
+		return -EINVAL;
+	if (!dev->funcs->enable)
+		return -EINVAL;
+
+	ret = dev->funcs->enable(dev);
+
+	return ret;
+}
+
+static int fpdlink_dev_reset(struct fpdlink_dev *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+	if (!dev->funcs)
+		return -EINVAL;
+	if (!dev->funcs->reset)
+		return -EINVAL;
+
+	ret = dev->funcs->reset(dev);
+	return ret;
+}
+
+static int fpdlink_dev_enable_i2c_passthrough(struct fpdlink_dev *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+	if (!dev->funcs)
+		return -EINVAL;
+	if (!dev->funcs->enable_i2c_passthrough)
+		return -EINVAL;
+
+	ret = dev->funcs->enable_i2c_passthrough(dev);
+	return ret;
+}
+
+static bool fpdlink_dev_link_detect(struct fpdlink_dev *dev)
+{
+	bool ret;
+
+	if (!dev)
+		return -EINVAL;
+	if (!dev->funcs)
+		return -EINVAL;
+	if (!dev->funcs->link_detect)
+		return -EINVAL;
+
+	ret = dev->funcs->link_detect(dev);
+	return ret;
+}
+
+static bool fpdlink_dev_pixel_clk_detect(struct fpdlink_dev *dev)
+{
+	bool ret;
+
+	if (!dev)
+		return -EINVAL;
+	if (!dev->funcs)
+		return -EINVAL;
+	if (!dev->funcs->pixel_clk_detect)
+		return -EINVAL;
+
+	ret = dev->funcs->pixel_clk_detect(dev);
+	return ret;
+}
+
+static int fpdlink_dev_config(struct fpdlink_dev *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+	if (!dev->funcs)
+		return -EINVAL;
+	if (!dev->funcs->config)
+		return -EINVAL;
+
+	ret = dev->funcs->config(dev);
+	return ret;
+}
+
+static enum drm_connector_status
+fpdlink_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct fpdlink *fpdlink_bridge = drm_connector_to_fpdlink(connector);
+
+	if (fpdlink_bridge->link_status == detected)
+		return connector_status_connected;
+
+	return connector_status_disconnected;
+}
+
+static const struct drm_connector_funcs fpdlink_con_funcs = {
+	.detect			= fpdlink_connector_detect,
+	.fill_modes		= drm_helper_probe_single_connector_modes,
+	.destroy		= drm_connector_cleanup,
+	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+};
+
+static void fpdlink_pre_enable(struct drm_bridge *bridge)
+{
+	struct fpdlink *fpdlink_bridge = drm_bridge_to_fpdlink(bridge);
+
+	struct fpdlink_dev *serializer = fpdlink_bridge->serializer;
+	struct fpdlink_dev *deserializer = fpdlink_bridge->deserializer;
+	int ret = 0;
+
+	mutex_lock(&fpdlink_bridge->lock);
+
+	if (fpdlink_bridge->link_status == detected)
+		goto done;
+
+	fpdlink_dev_enable(deserializer);
+	fpdlink_dev_enable(serializer);
+	fpdlink_dev_reset(serializer);
+	fpdlink_dev_enable_i2c_passthrough(serializer);
+	ret = fpdlink_dev_reset(deserializer);
+	if (ret != 0) {
+		fpdlink_bridge->connector.status =
+				connector_status_disconnected;
+		DRM_INFO("Not able to detect Deserializer at %pOF\n",
+				fpdlink_bridge->fpdlink_node);
+		goto done;
+	}
+
+	ret = fpdlink_dev_link_detect(serializer);
+	if (ret != true) {
+		fpdlink_bridge->connector.status =
+				connector_status_disconnected;
+		goto done;
+	}
+
+	fpdlink_bridge->link_status = detected;
+	fpdlink_bridge->pixel_clk_status = not_detected;
+	fpdlink_bridge->connector.status = connector_status_connected;
+done:
+	mutex_unlock(&fpdlink_bridge->lock);
+}
+
+static void fpdlink_enable(struct drm_bridge *bridge)
+{
+	struct fpdlink *fpdlink_bridge = drm_bridge_to_fpdlink(bridge);
+	int ret = 0;
+	struct fpdlink_dev *serializer = fpdlink_bridge->serializer;
+	struct fpdlink_dev *deserializer = fpdlink_bridge->deserializer;
+
+	mutex_lock(&fpdlink_bridge->lock);
+
+	if (fpdlink_bridge->link_status == not_detected) {
+		fpdlink_bridge->connector.status =
+				connector_status_disconnected;
+		fpdlink_bridge->pixel_clk_status = not_detected;
+		goto done;
+	}
+
+	if (fpdlink_bridge->enabled)
+		goto done;
+
+	ret = fpdlink_dev_pixel_clk_detect(serializer);
+
+	if (ret != true) {
+		fpdlink_bridge->connector.status =
+				connector_status_disconnected;
+		fpdlink_bridge->pixel_clk_status = not_detected;
+		pr_err("pixel_clk_status not detected\n");
+		goto done;
+	}
+
+	fpdlink_bridge->pixel_clk_status = detected;
+	fpdlink_bridge->connector.status = connector_status_connected;
+	fpdlink_dev_config(serializer);
+	fpdlink_dev_config(deserializer);
+	fpdlink_bridge->enabled = 1;
+
+done:
+	mutex_unlock(&fpdlink_bridge->lock);
+}
+
+static int fpdlink_get_modes(struct drm_connector *connector)
+{
+	struct fpdlink *fpdlink_bridge = drm_connector_to_fpdlink(connector);
+
+	if (fpdlink_bridge->enabled == 0)
+		fpdlink_enable(&fpdlink_bridge->bridge);
+
+	return 0;
+}
+static const struct drm_connector_helper_funcs fpdlink_con_helper_funcs = {
+	.get_modes	= fpdlink_get_modes,
+};
+
+
+static int fpdlink_attach(struct drm_bridge *bridge)
+{
+	struct fpdlink *fpdlink_bridge = drm_bridge_to_fpdlink(bridge);
+	struct device_node *fpdlink_node = bridge->of_node;
+	struct device_node *serializer_node;
+	struct device_node *deserializer_node;
+	struct drm_bridge *serializer_bridge = NULL;
+	struct drm_bridge *deserializer_bridge = NULL;
+	struct drm_connector *connector;
+	int ret;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Missing encoder\n");
+		return -ENODEV;
+	}
+	connector = dev_get_drvdata(bridge->dev->dev);
+	fpdlink_node = fpdlink_bridge->fpdlink_node;
+
+	drm_connector_helper_add(&fpdlink_bridge->connector,
+				 &fpdlink_con_helper_funcs);
+
+	ret = drm_connector_init(bridge->dev, &fpdlink_bridge->connector,
+				 &fpdlink_con_funcs, DRM_MODE_CONNECTOR_VGA);
+	if (ret) {
+		DRM_ERROR("Failed to initialize connector\n");
+		return ret;
+	}
+
+	drm_connector_attach_encoder(&fpdlink_bridge->connector,
+					  bridge->encoder);
+
+	serializer_node = of_parse_phandle(fpdlink_node,
+					   "fpdlink-serializer-i2c-handle", 0);
+	if (!serializer_node) {
+		DRM_INFO("failed to find fpdlink-serializer-i2c-handle node at %pOF\n",
+				fpdlink_node);
+		return -ENODEV;
+	}
+
+	serializer_bridge = of_drm_find_bridge(serializer_node);
+
+
+	if (!serializer_bridge) {
+		DRM_INFO("failed to find serializer bridge for %pOF\n",
+				serializer_node);
+		return -ENODEV;
+	}
+
+	fpdlink_bridge->serializer =
+				drm_bridge_to_fpdlink_dev(serializer_bridge);
+	fpdlink_bridge->serializer->index = bridge->encoder->index;
+
+	deserializer_node = of_parse_phandle(fpdlink_node,
+			"fpdlink-deserializer-i2c-handle", 0);
+	if (!deserializer_node) {
+		DRM_INFO("failed to find fpdlink-deserializer-i2c-handle node at %pOF\n",
+				fpdlink_node);
+		return -ENODEV;
+	}
+
+	deserializer_bridge = of_drm_find_bridge(deserializer_node);
+	if (!deserializer_bridge) {
+		DRM_INFO("failed to find deserializer bridge for %pOF\n",
+				deserializer_node);
+		return -ENODEV;
+	}
+
+	fpdlink_bridge->deserializer =
+				drm_bridge_to_fpdlink_dev(deserializer_bridge);
+	fpdlink_bridge->deserializer->index = bridge->encoder->index;
+	fpdlink_bridge->index = bridge->encoder->index;
+	fpdlink_bridge->link_status = not_detected;
+	fpdlink_bridge->pixel_clk_status = not_detected;
+	return ret;
+}
+
+static const struct drm_bridge_funcs fpdlink_bridge_funcs = {
+	.attach		= fpdlink_attach,
+	.pre_enable	= fpdlink_pre_enable,
+	.enable		= fpdlink_enable,
+};
+
+
+
+static int fpdlink_probe(struct platform_device *pdev)
+{
+	struct fpdlink *fpdlink_bridge;
+	int gpio_pin;
+	struct device_node *np;
+
+	fpdlink_bridge = devm_kzalloc(&pdev->dev, sizeof(*fpdlink_bridge),
+					GFP_KERNEL);
+	if (!fpdlink_bridge)
+		return -ENOMEM;
+
+	mutex_init(&fpdlink_bridge->lock);
+
+
+	platform_set_drvdata(pdev, fpdlink_bridge);
+
+	fpdlink_bridge->bridge.funcs = &fpdlink_bridge_funcs;
+	np = pdev->dev.of_node;
+	fpdlink_bridge->bridge.of_node = np;
+	fpdlink_bridge->fpdlink_node = np;
+
+	gpio_pin = of_get_named_gpio(np, "disp-en-pin", 0);
+
+	drm_bridge_add(&fpdlink_bridge->bridge);
+	return 0;
+}
+
+static int fpdlink_remove(struct platform_device *pdev)
+{
+	struct fpdlink *fpdlink_bridge = platform_get_drvdata(pdev);
+
+	drm_bridge_remove(&fpdlink_bridge->bridge);
+	return 0;
+}
+
+static const struct of_device_id fpdlink_match[] = {
+	{ .compatible = "ti,fpdlink" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fpdlink_match);
+
+static struct platform_driver ti_fpdlink_driver = {
+	.probe	= fpdlink_probe,
+	.remove	= fpdlink_remove,
+	.driver		= {
+		.name		= "ti-fpdlink",
+		.of_match_table	= fpdlink_match,
+	},
+};
+module_platform_driver(ti_fpdlink_driver);
+
+MODULE_AUTHOR("Vince Kim <vince.k.kim@gmail.com>");
+MODULE_DESCRIPTION("TI FPDlink driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.h b/drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.h
new file mode 100644
index 000000000000..073d4b4601f3
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti-fpdlink/ti-fpdlink.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI FPD-LinkIII interface bridge driver header file
+ *
+ * Copyright (C) 2019 Lucid Motors Inc.
+ *
+ * Contact: Vince Kim <vince.k.kim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __TI_FPDLINK_H__
+#define __TI_FPDLINK_H__
+#include <linux/list.h>
+#include <linux/ctype.h>
+#include <drm/drm_mode_object.h>
+#include <drm/drm_modes.h>
+
+struct fpdlink_dev;
+
+enum clk_status {
+	not_detected = 0,
+	detected = 1,
+};
+
+struct fpdlink_dev_funcs {
+	int (*enable)(struct fpdlink_dev *dev);
+	void (*disable)(struct fpdlink_dev *dev);
+	int (*reset)(struct fpdlink_dev *dev);
+	int (*enable_i2c_passthrough)(struct fpdlink_dev *dev);
+	bool (*link_detect)(struct fpdlink_dev *dev);
+	bool (*pixel_clk_detect)(struct fpdlink_dev *dev);
+	int (*config)(struct fpdlink_dev *dev);
+	int (*reg_write)(struct fpdlink_dev *dev, u8 reg, u8 val);
+};
+
+struct fpdlink_dev {
+	struct drm_bridge	bridge;
+	struct drm_connector	connector;
+	struct device		*dev;
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct mutex		lock;
+
+	const struct fpdlink_dev_funcs *funcs;
+
+	char gpio_name[20];
+	unsigned int index;
+	bool	detected;
+	int gpio_power_en;
+	enum clk_status pixel_clk_status;
+	enum clk_status link_status;
+	int config_array_size;
+	u8 *config_array;
+};
+
+static inline struct fpdlink_dev *
+drm_bridge_to_fpdlink_dev(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct fpdlink_dev, bridge);
+}
+#endif
-- 
2.17.1

