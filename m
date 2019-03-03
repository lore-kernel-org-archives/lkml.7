Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EFC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9159720863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PrwOAW6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCCUHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:07:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45873 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfCCUHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:07:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id 125so1235856pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ddJd4dulKq8qLv0Nr8jn11sI+uQBlMB+ABdZPToNh4=;
        b=PrwOAW6KrUDIWeJA7Nid+eVHNGLXeF1E34SX3txDLcJ3JcFBYjnGIegZIWRyRXhfv7
         +V1g2ArZnOlniI70vArkSqgBn4TSsWWw6ZnGtmiWNwEE6YxhD3s1VneiVvCjyNAxKr1J
         LKgbPXpXAVcC9iJS3ql6lxkzfIbg57yOib8wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ddJd4dulKq8qLv0Nr8jn11sI+uQBlMB+ABdZPToNh4=;
        b=bjDsWvtd/Mgg8oRUq5DKePHZp1f06ai5fhnmHMkOOZ9K7IGsfFE4cyrGFg1aZWyhLj
         yGqLepOqFxHyUEkSYmNJHuNgIfbYZW1LO11q97dma+oZIVukNy8KcIqwIawj+aEVd80q
         WnW+Tp3oqFLPXFgeXbukCh5iqDeaMj13hi9bhAzR/C4s5HPAhj5eBg6QxPMTdkf/sLBF
         31RWdh0AIvEFir8ugEFw2liq96gf5Qtn4WDhQgAQrMIWl98KCCLUbgv2H/JROEJsziQN
         Udru9xx6pbny8PziRYab1HJZGOF3+dXim/QFTdj13jpwuRsanWUDf3U8ji2Uh6uWMvUJ
         MGNQ==
X-Gm-Message-State: AHQUAuZMxw2BF48/yZwPcgPYtvYH1qq6D1xyHcj7872rXvu+qmMLbz95
        luCUPrtg39+zIRZg4RFw6XzFWQ==
X-Google-Smtp-Source: APXvYqy77Zt+UaksisqdUvt6HvzVuWi2RMDmHUSLvQPVimRWGFD3xFJF2AF9IesfxhV+pWSEIm1ruw==
X-Received: by 2002:a62:4815:: with SMTP id v21mr16184705pfa.167.1551643623971;
        Sun, 03 Mar 2019 12:07:03 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id j14sm5654021pfn.77.2019.03.03.12.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:07:03 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/4] drm/panel: Add Novatek NT35596 panel driver
Date:   Mon,  4 Mar 2019 01:36:18 +0530
Message-Id: <20190303200618.17581-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303200618.17581-1-jagan@amarulasolutions.com>
References: <20190303200618.17581-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Novatek NT35596 is a single-chip IC solution for small or medium-sized
LTPS TFT LCD panels. NT35596 provides  several system interfaces like
MIPI/SPI/I2C.

Currently added support for Microtech MTF050FHDI-03 is 1080x1920,
4-lane MIPI DSI LCD panel which has inbuilt NT35596 IC chip.

NT35596 support several regulators on the chip, among those only 4
regulators like VCI, VDDI/DVDD, AVDD, AVEE are used during power-on
sequence. Right now driver added code for 3-regulator based power-on
sequence since MTF050FHDI-03 panel support. This power-on sequence may
be moved to panel_desc in future, if there is any new panel would come
up with other type of sequence.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt35596.c | 860 ++++++++++++++++++
 4 files changed, 880 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt35596.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 125d87a23374..d560f1bdd504 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4840,6 +4840,12 @@ S:	Maintained
 F:	drivers/gpu/drm/tinydrm/hx8357d.c
 F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
 
+DRM DRIVER FOR NOVATEK NT35596 MIPI-DSI LCD PANELS
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-novatek-nt35596.c
+F:	Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
+
 DRM DRIVER FOR INTEL I810 VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/i810/
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 5c2c7e8e6ade..c39aaf40445c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -119,6 +119,19 @@ config DRM_PANEL_LG_LG4573
 	  Say Y here if you want to enable support for LG4573 RGB panel.
 	  To compile this driver as a module, choose M here.
 
+config DRM_PANEL_NOVATEK_NT35596
+	tristate "Novatek NT35596 panel driver"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the Novatek NT35596
+	  panel controller driver.
+
+	  Novatek NT35596 is a single-chip IC solution for small or medium
+	  sized LTPS TFT LCD panels. NT35596 provides several system interfaces
+	  like MIPI/SPI/I2C.
+
 config DRM_PANEL_OLIMEX_LCD_OLINUXINO
 	tristate "Olimex LCD-OLinuXino panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 3a853ea5cff9..05bc93348345 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
 obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) += panel-jdi-lt070me05000.o
 obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
 obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
+obj-$(CONFIG_DRM_PANEL_NOVATEK_NT35596) += panel-novatek-nt35596.o
 obj-$(CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO) += panel-olimex-lcd-olinuxino.o
 obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) += panel-orisetech-otm8009a.o
 obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35596.c b/drivers/gpu/drm/panel/panel-novatek-nt35596.c
new file mode 100644
index 000000000000..ad740ee891fb
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35596.c
@@ -0,0 +1,860 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+#include <linux/backlight.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#define NT35596_CMD_LEN			2
+
+struct nt35596_panel_desc {
+	const struct drm_display_mode	*mode;
+	unsigned int			lanes;
+	unsigned long			flags;
+	enum mipi_dsi_pixel_format	format;
+	const struct nt35596_init_cmd	*panel_cmds;
+	unsigned int			num_panel_cmds;
+};
+
+struct nt35596 {
+	struct drm_panel		panel;
+	struct mipi_dsi_device		*dsi;
+	const struct nt35596_panel_desc *desc;
+
+	struct backlight_device		*backlight;
+	struct regulator		*dvdd;
+	struct regulator		*avdd;
+	struct regulator		*avee;
+	struct gpio_desc		*reset;
+};
+
+static inline struct nt35596 *panel_to_nt35596(struct drm_panel *panel)
+{
+	return container_of(panel, struct nt35596, panel);
+}
+
+struct nt35596_init_cmd {
+	u8 data[NT35596_CMD_LEN];
+};
+
+static const struct nt35596_init_cmd microtech_mtf050fhdi_cmds[] = {
+	{ .data = { 0xFF, 0xEE } },
+	{ .data = { 0xFB, 0x01 } },
+	{ .data = { 0x1F, 0x45 } },
+	{ .data = { 0x24, 0x4F } },
+	{ .data = { 0x38, 0xC8 } },
+	{ .data = { 0x39, 0x2C } },
+	{ .data = { 0x1E, 0xBB } },
+	{ .data = { 0x1D, 0x0F } },
+	{ .data = { 0x7E, 0xB1 } },
+
+	/* Enter CMD1, Turn-on Tear ON */
+	{ .data = { 0xFF, 0x00 } },
+	{ .data = { 0xFB, 0x01 } },
+	{ .data = { 0x35, 0x01 } },
+	{ .data = { 0xBA, 0x03 } },
+
+	/* CMD2 Page0 */
+	{ .data = { 0xFF, 0x01 } },
+	{ .data = { 0xFB, 0x01 } },
+	{ .data = { 0x00, 0x01 } },
+	{ .data = { 0x01, 0x55 } },
+	{ .data = { 0x02, 0x40 } },
+	{ .data = { 0x05, 0x00 } },
+	{ .data = { 0x06, 0x1B } },
+	{ .data = { 0x07, 0x24 } },
+	{ .data = { 0x08, 0x0C } },
+	{ .data = { 0x0B, 0x87 } },
+	{ .data = { 0x0C, 0x87 } },
+	{ .data = { 0x0E, 0xB0 } },
+	{ .data = { 0x0F, 0xB3 } },
+	{ .data = { 0x11, 0x10 } },
+	{ .data = { 0x12, 0x10 } },
+	{ .data = { 0x13, 0x05 } },
+	{ .data = { 0x14, 0x4A } },
+	{ .data = { 0x15, 0x18 } },
+	{ .data = { 0x16, 0x18 } },
+	{ .data = { 0x18, 0x00 } },
+	{ .data = { 0x19, 0x77 } },
+	{ .data = { 0x1A, 0x55 } },
+	{ .data = { 0x1B, 0x13 } },
+	{ .data = { 0x1C, 0x00 } },
+	{ .data = { 0x1D, 0x00 } },
+	{ .data = { 0x1E, 0x13 } },
+	{ .data = { 0x1F, 0x00 } },
+	{ .data = { 0x23, 0x00 } },
+	{ .data = { 0x24, 0x00 } },
+	{ .data = { 0x25, 0x00 } },
+	{ .data = { 0x26, 0x00 } },
+	{ .data = { 0x27, 0x00 } },
+	{ .data = { 0x28, 0x00 } },
+	{ .data = { 0x35, 0x00 } },
+	{ .data = { 0x66, 0x00 } },
+	{ .data = { 0x58, 0x82 } },
+	{ .data = { 0x59, 0x02 } },
+	{ .data = { 0x5A, 0x02 } },
+	{ .data = { 0x5B, 0x02 } },
+	{ .data = { 0x5C, 0x82 } },
+	{ .data = { 0x5D, 0x82 } },
+	{ .data = { 0x5E, 0x02 } },
+	{ .data = { 0x5F, 0x02 } },
+	{ .data = { 0x72, 0x31 } },
+
+	/* CMD2 Page4 */
+	{ .data = { 0xFF, 0x05 } },
+	{ .data = { 0xFB, 0x01 } },
+	{ .data = { 0x00, 0x01 } },
+	{ .data = { 0x01, 0x0B } },
+	{ .data = { 0x02, 0x0C } },
+	{ .data = { 0x03, 0x09 } },
+	{ .data = { 0x04, 0x0A } },
+	{ .data = { 0x05, 0x00 } },
+	{ .data = { 0x06, 0x0F } },
+	{ .data = { 0x07, 0x10 } },
+	{ .data = { 0x08, 0x00 } },
+	{ .data = { 0x09, 0x00 } },
+	{ .data = { 0x0A, 0x00 } },
+	{ .data = { 0x0B, 0x00 } },
+	{ .data = { 0x0C, 0x00 } },
+	{ .data = { 0x0D, 0x13 } },
+	{ .data = { 0x0E, 0x15 } },
+	{ .data = { 0x0F, 0x17 } },
+	{ .data = { 0x10, 0x01 } },
+	{ .data = { 0x11, 0x0B } },
+	{ .data = { 0x12, 0x0C } },
+	{ .data = { 0x13, 0x09 } },
+	{ .data = { 0x14, 0x0A } },
+	{ .data = { 0x15, 0x00 } },
+	{ .data = { 0x16, 0x0F } },
+	{ .data = { 0x17, 0x10 } },
+	{ .data = { 0x18, 0x00 } },
+	{ .data = { 0x19, 0x00 } },
+	{ .data = { 0x1A, 0x00 } },
+	{ .data = { 0x1B, 0x00 } },
+	{ .data = { 0x1C, 0x00 } },
+	{ .data = { 0x1D, 0x13 } },
+	{ .data = { 0x1E, 0x15 } },
+	{ .data = { 0x1F, 0x17 } },
+	{ .data = { 0x20, 0x00 } },
+	{ .data = { 0x21, 0x03 } },
+	{ .data = { 0x22, 0x01 } },
+	{ .data = { 0x23, 0x40 } },
+	{ .data = { 0x24, 0x40 } },
+	{ .data = { 0x25, 0xED } },
+	{ .data = { 0x29, 0x58 } },
+	{ .data = { 0x2A, 0x12 } },
+	{ .data = { 0x2B, 0x01 } },
+	{ .data = { 0x4B, 0x06 } },
+	{ .data = { 0x4C, 0x11 } },
+	{ .data = { 0x4D, 0x20 } },
+	{ .data = { 0x4E, 0x02 } },
+	{ .data = { 0x4F, 0x02 } },
+	{ .data = { 0x50, 0x20 } },
+	{ .data = { 0x51, 0x61 } },
+	{ .data = { 0x52, 0x01 } },
+	{ .data = { 0x53, 0x63 } },
+	{ .data = { 0x54, 0x77 } },
+	{ .data = { 0x55, 0xED } },
+	{ .data = { 0x5B, 0x00 } },
+	{ .data = { 0x5C, 0x00 } },
+	{ .data = { 0x5D, 0x00 } },
+	{ .data = { 0x5E, 0x00 } },
+	{ .data = { 0x5F, 0x15 } },
+	{ .data = { 0x60, 0x75 } },
+	{ .data = { 0x61, 0x00 } },
+	{ .data = { 0x62, 0x00 } },
+	{ .data = { 0x63, 0x00 } },
+	{ .data = { 0x64, 0x00 } },
+	{ .data = { 0x65, 0x00 } },
+	{ .data = { 0x66, 0x00 } },
+	{ .data = { 0x67, 0x00 } },
+	{ .data = { 0x68, 0x04 } },
+	{ .data = { 0x69, 0x00 } },
+	{ .data = { 0x6A, 0x00 } },
+	{ .data = { 0x6C, 0x40 } },
+	{ .data = { 0x75, 0x01 } },
+	{ .data = { 0x76, 0x01 } },
+	{ .data = { 0x7A, 0x80 } },
+	{ .data = { 0x7B, 0xC5 } },
+	{ .data = { 0x7C, 0xD8 } },
+	{ .data = { 0x7D, 0x60 } },
+	{ .data = { 0x7F, 0x10 } },
+	{ .data = { 0x80, 0x81 } },
+	{ .data = { 0x83, 0x05 } },
+	{ .data = { 0x93, 0x08 } },
+	{ .data = { 0x94, 0x10 } },
+	{ .data = { 0x8A, 0x00 } },
+	{ .data = { 0x9B, 0x0F } },
+	{ .data = { 0xEA, 0xFF } },
+	{ .data = { 0xEC, 0x00 } },
+
+	/* CMD2 Page0 */
+	{ .data = { 0xFF, 0x01 } },
+	{ .data = { 0xFB, 0x01 } },
+	{ .data = { 0x75, 0x00 } },
+	{ .data = { 0x76, 0x8E } },
+	{ .data = { 0x77, 0x00 } },
+	{ .data = { 0x78, 0x90 } },
+	{ .data = { 0x79, 0x00 } },
+	{ .data = { 0x7A, 0xB2 } },
+	{ .data = { 0x7B, 0x00 } },
+	{ .data = { 0x7C, 0xC7 } },
+	{ .data = { 0x7D, 0x00 } },
+	{ .data = { 0x7E, 0xD7 } },
+	{ .data = { 0x7F, 0x00 } },
+	{ .data = { 0x80, 0xE9 } },
+	{ .data = { 0x81, 0x00 } },
+	{ .data = { 0x82, 0xF9 } },
+	{ .data = { 0x83, 0x01 } },
+	{ .data = { 0x84, 0x01 } },
+	{ .data = { 0x85, 0x01 } },
+	{ .data = { 0x86, 0x0B } },
+	{ .data = { 0x87, 0x01 } },
+	{ .data = { 0x88, 0x3A } },
+	{ .data = { 0x89, 0x01 } },
+	{ .data = { 0x8A, 0x5D } },
+	{ .data = { 0x8B, 0x01 } },
+	{ .data = { 0x8C, 0x94 } },
+	{ .data = { 0x8D, 0x01 } },
+	{ .data = { 0x8E, 0xBC } },
+	{ .data = { 0x8F, 0x02 } },
+	{ .data = { 0x90, 0x00 } },
+	{ .data = { 0x91, 0x02 } },
+	{ .data = { 0x92, 0x39 } },
+	{ .data = { 0x93, 0x02 } },
+	{ .data = { 0x94, 0x3A } },
+	{ .data = { 0x95, 0x02 } },
+	{ .data = { 0x96, 0x6B } },
+	{ .data = { 0x97, 0x02 } },
+	{ .data = { 0x98, 0xA2 } },
+	{ .data = { 0x99, 0x02 } },
+	{ .data = { 0x9A, 0xC7 } },
+	{ .data = { 0x9B, 0x02 } },
+	{ .data = { 0x9C, 0xFB } },
+	{ .data = { 0x9D, 0x03 } },
+	{ .data = { 0x9E, 0x20 } },
+	{ .data = { 0x9F, 0x03 } },
+	{ .data = { 0xA0, 0x54 } },
+	{ .data = { 0xA2, 0x03 } },
+	{ .data = { 0xA3, 0x6D } },
+	{ .data = { 0xA4, 0x03 } },
+	{ .data = { 0xA5, 0x80 } },
+	{ .data = { 0xA6, 0x03 } },
+	{ .data = { 0xA7, 0x81 } },
+	{ .data = { 0xA9, 0x03 } },
+	{ .data = { 0xAA, 0xC7 } },
+	{ .data = { 0xAB, 0x03 } },
+	{ .data = { 0xAC, 0xF0 } },
+	{ .data = { 0xAD, 0x03 } },
+	{ .data = { 0xAE, 0xF8 } },
+	{ .data = { 0xAF, 0x03 } },
+	{ .data = { 0xB0, 0xFD } },
+	{ .data = { 0xB1, 0x03 } },
+	{ .data = { 0xB2, 0xFE } },
+	{ .data = { 0xB3, 0x00 } },
+	{ .data = { 0xB4, 0x8E } },
+	{ .data = { 0xB5, 0x00 } },
+	{ .data = { 0xB6, 0x90 } },
+	{ .data = { 0xB7, 0x00 } },
+	{ .data = { 0xB8, 0xB2 } },
+	{ .data = { 0xB9, 0x00 } },
+	{ .data = { 0xBA, 0xC7 } },
+	{ .data = { 0xBB, 0x00 } },
+	{ .data = { 0xBC, 0xD7 } },
+	{ .data = { 0xBD, 0x00 } },
+	{ .data = { 0xBE, 0xE9 } },
+	{ .data = { 0xBF, 0x00 } },
+	{ .data = { 0xC0, 0xF9 } },
+	{ .data = { 0xC1, 0x01 } },
+	{ .data = { 0xC2, 0x01 } },
+	{ .data = { 0xC3, 0x01 } },
+	{ .data = { 0xC4, 0x0B } },
+	{ .data = { 0xC5, 0x01 } },
+	{ .data = { 0xC6, 0x3A } },
+	{ .data = { 0xC7, 0x01 } },
+	{ .data = { 0xC8, 0x5D } },
+	{ .data = { 0xC9, 0x01 } },
+	{ .data = { 0xCA, 0x94 } },
+	{ .data = { 0xCB, 0x01 } },
+	{ .data = { 0xCC, 0xBC } },
+	{ .data = { 0xCD, 0x02 } },
+	{ .data = { 0xCE, 0x00 } },
+	{ .data = { 0xCF, 0x02 } },
+	{ .data = { 0xD0, 0x39 } },
+	{ .data = { 0xD1, 0x02 } },
+	{ .data = { 0xD2, 0x3A } },
+	{ .data = { 0xD3, 0x02 } },
+	{ .data = { 0xD4, 0x6B } },
+	{ .data = { 0xD5, 0x02 } },
+	{ .data = { 0xD6, 0xA2 } },
+	{ .data = { 0xD7, 0x02 } },
+	{ .data = { 0xD8, 0xC7 } },
+	{ .data = { 0xD9, 0x02 } },
+	{ .data = { 0xDA, 0xFB } },
+	{ .data = { 0xDB, 0x03 } },
+	{ .data = { 0xDC, 0x20 } },
+	{ .data = { 0xDD, 0x03 } },
+	{ .data = { 0xDE, 0x54 } },
+	{ .data = { 0xDF, 0x03 } },
+	{ .data = { 0xE0, 0x6D } },
+	{ .data = { 0xE1, 0x03 } },
+	{ .data = { 0xE2, 0x80 } },
+	{ .data = { 0xE3, 0x03 } },
+	{ .data = { 0xE4, 0x81 } },
+	{ .data = { 0xE5, 0x03 } },
+	{ .data = { 0xE6, 0xC7 } },
+	{ .data = { 0xE7, 0x03 } },
+	{ .data = { 0xE8, 0xF0 } },
+	{ .data = { 0xE9, 0x03 } },
+	{ .data = { 0xEA, 0xF8 } },
+	{ .data = { 0xEB, 0x03 } },
+	{ .data = { 0xEC, 0xFD } },
+	{ .data = { 0xED, 0x03 } },
+	{ .data = { 0xEE, 0xFE } },
+	{ .data = { 0xEF, 0x00 } },
+	{ .data = { 0xF0, 0x03 } },
+	{ .data = { 0xF1, 0x00 } },
+	{ .data = { 0xF2, 0x0B } },
+	{ .data = { 0xF3, 0x00 } },
+	{ .data = { 0xF4, 0x0D } },
+	{ .data = { 0xF5, 0x00 } },
+	{ .data = { 0xF6, 0x4A } },
+	{ .data = { 0xF7, 0x00 } },
+	{ .data = { 0xF8, 0x71 } },
+	{ .data = { 0xF9, 0x00 } },
+	{ .data = { 0xFA, 0x8C } },
+
+	/* CMD2 Page1 */
+	{ .data = { 0xFF, 0x02 } },
+	{ .data = { 0xFB, 0x01 } },
+	{ .data = { 0x00, 0x00 } },
+	{ .data = { 0x01, 0xA1 } },
+	{ .data = { 0x02, 0x00 } },
+	{ .data = { 0x03, 0xB6 } },
+	{ .data = { 0x04, 0x00 } },
+	{ .data = { 0x05, 0xC9 } },
+	{ .data = { 0x06, 0x00 } },
+	{ .data = { 0x07, 0xFD } },
+	{ .data = { 0x08, 0x01 } },
+	{ .data = { 0x09, 0x29 } },
+	{ .data = { 0x0A, 0x01 } },
+	{ .data = { 0x0B, 0x6B } },
+	{ .data = { 0x0C, 0x01 } },
+	{ .data = { 0x0D, 0x9E } },
+	{ .data = { 0x0E, 0x01 } },
+	{ .data = { 0x0F, 0xEB } },
+	{ .data = { 0x10, 0x02 } },
+	{ .data = { 0x11, 0x25 } },
+	{ .data = { 0x12, 0x02 } },
+	{ .data = { 0x13, 0x27 } },
+	{ .data = { 0x14, 0x02 } },
+	{ .data = { 0x15, 0x5C } },
+	{ .data = { 0x16, 0x02 } },
+	{ .data = { 0x17, 0x95 } },
+	{ .data = { 0x18, 0x02 } },
+	{ .data = { 0x19, 0xBA } },
+	{ .data = { 0x1A, 0x02 } },
+	{ .data = { 0x1B, 0xEC } },
+	{ .data = { 0x1C, 0x03 } },
+	{ .data = { 0x1D, 0x0C } },
+	{ .data = { 0x1E, 0x03 } },
+	{ .data = { 0x1F, 0x34 } },
+	{ .data = { 0x20, 0x03 } },
+	{ .data = { 0x21, 0x3F } },
+	{ .data = { 0x22, 0x03 } },
+	{ .data = { 0x23, 0x48 } },
+	{ .data = { 0x24, 0x03 } },
+	{ .data = { 0x25, 0x49 } },
+	{ .data = { 0x26, 0x03 } },
+	{ .data = { 0x27, 0x6B } },
+	{ .data = { 0x28, 0x03 } },
+	{ .data = { 0x29, 0x7E } },
+	{ .data = { 0x2A, 0x03 } },
+	{ .data = { 0x2B, 0x8F } },
+	{ .data = { 0x2D, 0x03 } },
+	{ .data = { 0x2F, 0x9E } },
+	{ .data = { 0x30, 0x03 } },
+	{ .data = { 0x31, 0xA0 } },
+	{ .data = { 0x32, 0x00 } },
+	{ .data = { 0x33, 0x03 } },
+	{ .data = { 0x34, 0x00 } },
+	{ .data = { 0x35, 0x0B } },
+	{ .data = { 0x36, 0x00 } },
+	{ .data = { 0x37, 0x0D } },
+	{ .data = { 0x38, 0x00 } },
+	{ .data = { 0x39, 0x4A } },
+	{ .data = { 0x3A, 0x00 } },
+	{ .data = { 0x3B, 0x71 } },
+	{ .data = { 0x3D, 0x00 } },
+	{ .data = { 0x3F, 0x8C } },
+	{ .data = { 0x40, 0x00 } },
+	{ .data = { 0x41, 0xA1 } },
+	{ .data = { 0x42, 0x00 } },
+	{ .data = { 0x43, 0xB6 } },
+	{ .data = { 0x44, 0x00 } },
+	{ .data = { 0x45, 0xC9 } },
+	{ .data = { 0x46, 0x00 } },
+	{ .data = { 0x47, 0xFD } },
+	{ .data = { 0x48, 0x01 } },
+	{ .data = { 0x49, 0x29 } },
+	{ .data = { 0x4A, 0x01 } },
+	{ .data = { 0x4B, 0x6B } },
+	{ .data = { 0x4C, 0x01 } },
+	{ .data = { 0x4D, 0x9E } },
+	{ .data = { 0x4E, 0x01 } },
+	{ .data = { 0x4F, 0xEB } },
+	{ .data = { 0x50, 0x02 } },
+	{ .data = { 0x51, 0x25 } },
+	{ .data = { 0x52, 0x02 } },
+	{ .data = { 0x53, 0x27 } },
+	{ .data = { 0x54, 0x02 } },
+	{ .data = { 0x55, 0x5C } },
+	{ .data = { 0x56, 0x02 } },
+	{ .data = { 0x58, 0x95 } },
+	{ .data = { 0x59, 0x02 } },
+	{ .data = { 0x5A, 0xBA } },
+	{ .data = { 0x5B, 0x02 } },
+	{ .data = { 0x5C, 0xEC } },
+	{ .data = { 0x5D, 0x03 } },
+	{ .data = { 0x5E, 0x0C } },
+	{ .data = { 0x5F, 0x03 } },
+	{ .data = { 0x60, 0x34 } },
+	{ .data = { 0x61, 0x03 } },
+	{ .data = { 0x62, 0x3F } },
+	{ .data = { 0x63, 0x03 } },
+	{ .data = { 0x64, 0x48 } },
+	{ .data = { 0x65, 0x03 } },
+	{ .data = { 0x66, 0x49 } },
+	{ .data = { 0x67, 0x03 } },
+	{ .data = { 0x68, 0x6B } },
+	{ .data = { 0x69, 0x03 } },
+	{ .data = { 0x6A, 0x7E } },
+	{ .data = { 0x6B, 0x03 } },
+	{ .data = { 0x6C, 0x8F } },
+	{ .data = { 0x6D, 0x03 } },
+	{ .data = { 0x6E, 0x9E } },
+	{ .data = { 0x6F, 0x03 } },
+	{ .data = { 0x70, 0xA0 } },
+	{ .data = { 0x71, 0x00 } },
+	{ .data = { 0x72, 0xFB } },
+	{ .data = { 0x73, 0x00 } },
+	{ .data = { 0x74, 0xFD } },
+	{ .data = { 0x75, 0x01 } },
+	{ .data = { 0x76, 0x05 } },
+	{ .data = { 0x77, 0x01 } },
+	{ .data = { 0x78, 0x0D } },
+	{ .data = { 0x79, 0x01 } },
+	{ .data = { 0x7A, 0x17 } },
+	{ .data = { 0x7B, 0x01 } },
+	{ .data = { 0x7C, 0x1F } },
+	{ .data = { 0x7D, 0x01 } },
+	{ .data = { 0x7E, 0x28 } },
+	{ .data = { 0x7F, 0x01 } },
+	{ .data = { 0x80, 0x32 } },
+	{ .data = { 0x81, 0x01 } },
+	{ .data = { 0x82, 0x38 } },
+	{ .data = { 0x83, 0x01 } },
+	{ .data = { 0x84, 0x53 } },
+	{ .data = { 0x85, 0x01 } },
+	{ .data = { 0x86, 0x72 } },
+	{ .data = { 0x87, 0x01 } },
+	{ .data = { 0x88, 0x9B } },
+	{ .data = { 0x89, 0x01 } },
+	{ .data = { 0x8A, 0xC3 } },
+	{ .data = { 0x8B, 0x02 } },
+	{ .data = { 0x8C, 0x01 } },
+	{ .data = { 0x8D, 0x02 } },
+	{ .data = { 0x8E, 0x36 } },
+	{ .data = { 0x8F, 0x02 } },
+	{ .data = { 0x90, 0x37 } },
+	{ .data = { 0x91, 0x02 } },
+	{ .data = { 0x92, 0x69 } },
+	{ .data = { 0x93, 0x02 } },
+	{ .data = { 0x94, 0xA1 } },
+	{ .data = { 0x95, 0x02 } },
+	{ .data = { 0x96, 0xC8 } },
+	{ .data = { 0x97, 0x02 } },
+	{ .data = { 0x98, 0xFF } },
+	{ .data = { 0x99, 0x03 } },
+	{ .data = { 0x9A, 0x26 } },
+	{ .data = { 0x9B, 0x03 } },
+	{ .data = { 0x9C, 0x69 } },
+	{ .data = { 0x9D, 0x03 } },
+	{ .data = { 0x9E, 0x88 } },
+	{ .data = { 0x9F, 0x03 } },
+	{ .data = { 0xA0, 0xF8 } },
+	{ .data = { 0xA2, 0x03 } },
+	{ .data = { 0xA3, 0xF9 } },
+	{ .data = { 0xA4, 0x03 } },
+	{ .data = { 0xA5, 0xFE } },
+	{ .data = { 0xA6, 0x03 } },
+	{ .data = { 0xA7, 0xFE } },
+	{ .data = { 0xA9, 0x03 } },
+	{ .data = { 0xAA, 0xFE } },
+	{ .data = { 0xAB, 0x03 } },
+	{ .data = { 0xAC, 0xFE } },
+	{ .data = { 0xAD, 0x03 } },
+	{ .data = { 0xAE, 0xFE } },
+	{ .data = { 0xAF, 0x00 } },
+	{ .data = { 0xB0, 0xFB } },
+	{ .data = { 0xB1, 0x00 } },
+	{ .data = { 0xB2, 0xFD } },
+	{ .data = { 0xB3, 0x01 } },
+	{ .data = { 0xB4, 0x05 } },
+	{ .data = { 0xB5, 0x01 } },
+	{ .data = { 0xB6, 0x0D } },
+	{ .data = { 0xB7, 0x01 } },
+	{ .data = { 0xB8, 0x17 } },
+	{ .data = { 0xB9, 0x01 } },
+	{ .data = { 0xBA, 0x1F } },
+	{ .data = { 0xBB, 0x01 } },
+	{ .data = { 0xBC, 0x28 } },
+	{ .data = { 0xBD, 0x01 } },
+	{ .data = { 0xBE, 0x32 } },
+	{ .data = { 0xBF, 0x01 } },
+	{ .data = { 0xC0, 0x38 } },
+	{ .data = { 0xC1, 0x01 } },
+	{ .data = { 0xC2, 0x53 } },
+	{ .data = { 0xC3, 0x01 } },
+	{ .data = { 0xC4, 0x72 } },
+	{ .data = { 0xC5, 0x01 } },
+	{ .data = { 0xC6, 0x9B } },
+	{ .data = { 0xC7, 0x01 } },
+	{ .data = { 0xC8, 0xC3 } },
+	{ .data = { 0xC9, 0x02 } },
+	{ .data = { 0xCA, 0x01 } },
+	{ .data = { 0xCB, 0x02 } },
+	{ .data = { 0xCC, 0x36 } },
+	{ .data = { 0xCD, 0x02 } },
+	{ .data = { 0xCE, 0x37 } },
+	{ .data = { 0xCF, 0x02 } },
+	{ .data = { 0xD0, 0x69 } },
+	{ .data = { 0xD1, 0x02 } },
+	{ .data = { 0xD2, 0xA1 } },
+	{ .data = { 0xD3, 0x02 } },
+	{ .data = { 0xD4, 0xC8 } },
+	{ .data = { 0xD5, 0x02 } },
+	{ .data = { 0xD6, 0xFF } },
+	{ .data = { 0xD7, 0x03 } },
+	{ .data = { 0xD8, 0x26 } },
+	{ .data = { 0xD9, 0x03 } },
+	{ .data = { 0xDA, 0x69 } },
+	{ .data = { 0xDB, 0x03 } },
+	{ .data = { 0xDC, 0x88 } },
+	{ .data = { 0xDD, 0x03 } },
+	{ .data = { 0xDE, 0xF8 } },
+	{ .data = { 0xDF, 0x03 } },
+	{ .data = { 0xE0, 0xF9 } },
+	{ .data = { 0xE1, 0x03 } },
+	{ .data = { 0xE2, 0xFE } },
+	{ .data = { 0xE3, 0x03 } },
+	{ .data = { 0xE4, 0xFE } },
+	{ .data = { 0xE5, 0x03 } },
+	{ .data = { 0xE6, 0xFE } },
+	{ .data = { 0xE7, 0x03 } },
+	{ .data = { 0xE8, 0xFE } },
+	{ .data = { 0xE9, 0x03 } },
+	{ .data = { 0xEA, 0xFE } },
+
+	/* CMD1, VBP/VFP settings */
+	{ .data = { 0xFF, 0x00 } },
+	{ .data = { 0xD3, 0x14 } },
+	{ .data = { 0xD4, 0x14 } },
+
+	/* Exit CMD1, Turn-off Tear ON */
+	{ .data = { 0xFF, 0x00 } },
+	{ .data = { 0x35, 0x00 } },
+};
+
+static int nt35596_power_on(struct nt35596 *nt35596)
+{
+	int ret;
+
+	ret = regulator_enable(nt35596->dvdd);
+	if (ret)
+		return ret;
+
+	/* T_power_ramp_up for VDDI */
+	msleep(2);
+
+	ret = regulator_enable(nt35596->avdd);
+	if (ret)
+		return ret;
+
+	/* T_power_ramp_up for AVDD/AVEE */
+	msleep(5);
+
+	ret = regulator_enable(nt35596->avee);
+	if (ret)
+		return ret;
+
+	msleep(10);
+
+	gpiod_set_value(nt35596->reset, 0);
+
+	msleep(120);
+
+	gpiod_set_value(nt35596->reset, 1);
+
+	return 0;
+}
+
+static int nt35596_power_off(struct nt35596 *nt35596)
+{
+	gpiod_set_value(nt35596->reset, 0);
+
+	msleep(10);
+
+	regulator_disable(nt35596->avee);
+
+	/* T_power_ramp_down for AVEE/AVDD */
+	msleep(5);
+
+	regulator_disable(nt35596->avdd);
+
+	/* T_power_ramp_down for VDDI */
+	msleep(2);
+
+	regulator_disable(nt35596->dvdd);
+
+	return 0;
+}
+
+static int nt35596_prepare(struct drm_panel *panel)
+{
+	struct nt35596 *nt35596 = panel_to_nt35596(panel);
+	struct mipi_dsi_device *dsi = nt35596->dsi;
+	const struct nt35596_panel_desc *desc = nt35596->desc;
+	int ret, i;
+
+	ret = nt35596_power_on(nt35596);
+	if (ret)
+		return ret;
+
+	msleep(120);
+
+	for (i = 0; i < desc->num_panel_cmds; i++) {
+		const struct nt35596_init_cmd *cmd = &desc->panel_cmds[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
+						NT35596_CMD_LEN);
+		if (ret < 0) {
+			DRM_DEV_ERROR(panel->dev,
+				      "failed to write cmd %d: %d\n", i, ret);
+			goto power_off;
+		}
+	}
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		DRM_DEV_ERROR(panel->dev,
+			      "failed to exit from sleep mode: %d\n", ret);
+		goto power_off;
+	}
+
+	return 0;
+
+power_off:
+	if (nt35596_power_off(nt35596))
+		DRM_DEV_ERROR(panel->dev, "failed to power off\n");
+	return ret;
+}
+
+static int nt35596_enable(struct drm_panel *panel)
+{
+	struct nt35596 *nt35596 = panel_to_nt35596(panel);
+
+	msleep(120);
+
+	mipi_dsi_dcs_set_display_on(nt35596->dsi);
+	backlight_enable(nt35596->backlight);
+
+	return 0;
+}
+
+static int nt35596_disable(struct drm_panel *panel)
+{
+	struct nt35596 *nt35596 = panel_to_nt35596(panel);
+
+	backlight_disable(nt35596->backlight);
+	return mipi_dsi_dcs_set_display_off(nt35596->dsi);
+}
+
+static int nt35596_unprepare(struct drm_panel *panel)
+{
+	struct nt35596 *nt35596 = panel_to_nt35596(panel);
+
+	mipi_dsi_dcs_enter_sleep_mode(nt35596->dsi);
+
+	msleep(120);
+
+	nt35596_power_off(nt35596);
+
+	return 0;
+}
+
+static int nt35596_get_modes(struct drm_panel *panel)
+{
+	struct nt35596 *nt35596 = panel_to_nt35596(panel);
+	const struct drm_display_mode *desc_mode = nt35596->desc->mode;
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, desc_mode);
+	if (!mode) {
+		DRM_DEV_ERROR(&nt35596->dsi->dev,
+			      "failed to add mode %ux%ux@%u\n",
+			      desc_mode->hdisplay,
+			      desc_mode->vdisplay,
+			      desc_mode->vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(panel->connector, mode);
+
+	panel->connector->display_info.width_mm = desc_mode->width_mm;
+	panel->connector->display_info.height_mm = desc_mode->height_mm;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs nt35596_funcs = {
+	.disable	= nt35596_disable,
+	.unprepare	= nt35596_unprepare,
+	.prepare	= nt35596_prepare,
+	.enable		= nt35596_enable,
+	.get_modes	= nt35596_get_modes,
+};
+
+static const struct drm_display_mode microtech_mtf050fhdi_mode = {
+	.clock		= 147000,
+
+	.hdisplay	= 1080,
+	.hsync_start	= 1080 + 408,
+	.hsync_end	= 1080 + 408 + 4,
+	.htotal		= 1080 + 408 + 4 + 38,
+
+	.vdisplay	= 1920,
+	.vsync_start	= 1920 + 9,
+	.vsync_end	= 1920 + 9 + 12,
+	.vtotal		= 1920 + 9 + 12 + 9,
+	.vrefresh	= 50,
+
+	.width_mm	= 64,
+	.height_mm	= 118,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct nt35596_panel_desc microtech_mtf050fhdi_desc = {
+	.mode		= &microtech_mtf050fhdi_mode,
+	.lanes		= 4,
+	.flags		= MIPI_DSI_MODE_VIDEO_BURST,
+	.format		= MIPI_DSI_FMT_RGB888,
+	.panel_cmds	= microtech_mtf050fhdi_cmds,
+	.num_panel_cmds	= ARRAY_SIZE(microtech_mtf050fhdi_cmds),
+};
+
+static int nt35596_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	const struct nt35596_panel_desc *desc;
+	struct nt35596 *nt35596;
+	int ret;
+
+	nt35596 = devm_kzalloc(&dsi->dev, sizeof(*nt35596), GFP_KERNEL);
+	if (!nt35596)
+		return -ENOMEM;
+
+	desc = of_device_get_match_data(&dsi->dev);
+	dsi->mode_flags = desc->flags;
+	dsi->format = desc->format;
+	dsi->lanes = desc->lanes;
+
+	drm_panel_init(&nt35596->panel);
+	nt35596->panel.dev = &dsi->dev;
+	nt35596->panel.funcs = &nt35596_funcs;
+
+	nt35596->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
+	if (IS_ERR(nt35596->dvdd)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get dvdd regulator\n");
+		return PTR_ERR(nt35596->dvdd);
+	}
+
+	nt35596->avdd = devm_regulator_get(&dsi->dev, "avdd");
+	if (IS_ERR(nt35596->avdd)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get avdd regulator\n");
+		return PTR_ERR(nt35596->avdd);
+	}
+
+	nt35596->avee = devm_regulator_get(&dsi->dev, "avee");
+	if (IS_ERR(nt35596->avee)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get avee regulator\n");
+		return PTR_ERR(nt35596->avee);
+	}
+
+	nt35596->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(nt35596->reset)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(nt35596->reset);
+	}
+
+	nt35596->backlight = devm_of_find_backlight(&dsi->dev);
+	if (IS_ERR(nt35596->backlight))
+		return PTR_ERR(nt35596->backlight);
+
+	ret = drm_panel_add(&nt35596->panel);
+	if (ret < 0)
+		return ret;
+
+	mipi_dsi_set_drvdata(dsi, nt35596);
+	nt35596->dsi = dsi;
+	nt35596->desc = desc;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int nt35596_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct nt35596 *nt35596 = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&nt35596->panel);
+
+	return 0;
+}
+
+static const struct of_device_id nt35596_of_match[] = {
+	{
+		.compatible = "microtech,mtf050fhdi-03",
+		.data = &microtech_mtf050fhdi_desc,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, nt35596_of_match);
+
+static struct mipi_dsi_driver nt35596_driver = {
+	.probe = nt35596_dsi_probe,
+	.remove = nt35596_dsi_remove,
+	.driver = {
+		.name = "nt35596-nt35596",
+		.of_match_table = nt35596_of_match,
+	},
+};
+module_mipi_dsi_driver(nt35596_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Novatek NT35596 MIPI-DSI LCD panel");
+MODULE_LICENSE("GPL");
-- 
2.18.0.321.gffc6fa0e3

