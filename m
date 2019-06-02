Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16B5C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6656427983
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TPZAiC74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFBQtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:49:02 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44042 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfFBQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559494137; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yoh79A9vOKy8F2QhbB5uW3qHOnplpZ9XXBdJu3msis4=;
        b=TPZAiC74+YgwvHGWstQsM+BTuiDwhTpD1T7KZIRLcFthfY+xXaxganzzsQuFct9Y+3L5q/
        rRQNud34jcf+JV2XEZI5sPJDRCS6jNAFV9LdnubNlUbQpO0JcboJVzlyapvoqcjsx6u86q
        DUij//nI52I6NLQYYuFqoO82okakEtw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sam@ravnborg.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] drm/panel: Add Novatek NT39016 panel support
Date:   Sun,  2 Jun 2019 18:48:44 +0200
Message-Id: <20190602164844.15659-2-paul@crapouillou.net>
In-Reply-To: <20190602164844.15659-1-paul@crapouillou.net>
References: <20190602164844.15659-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for display panels built around the Novatek NT39016 display
controller, as found on e.g. the King Display KD035G6-54NT 24-bit
320x240 3.5" LCD panel which equips the GCW Zero open-source handheld
gaming console.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 368 ++++++++++++++++++
 3 files changed, 378 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt39016.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index e281fc544742..10b411b507cc 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -111,6 +111,15 @@ config DRM_PANEL_LG_LG4573
 	  Say Y here if you want to enable support for LG4573 RGB panel.
 	  To compile this driver as a module, choose M here.
 
+config DRM_PANEL_NOVATEK_NT39016
+	tristate "Novatek NT39016 RGB/SPI panel"
+	depends on OF && SPI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select REGMAP_SPI
+	help
+	  Say Y here if you want to enable support for the panels built
+	  around the Novatek NT39016 display controller.
+
 config DRM_PANEL_OLIMEX_LCD_OLINUXINO
 	tristate "Olimex LCD-OLinuXino panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 78e3dc376bdd..c2c47fc99343 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
 obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) += panel-jdi-lt070me05000.o
 obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
 obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
+obj-$(CONFIG_DRM_PANEL_NOVATEK_NT39016) += panel-novatek-nt39016.o
 obj-$(CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO) += panel-olimex-lcd-olinuxino.o
 obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) += panel-orisetech-otm8009a.o
 obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
new file mode 100644
index 000000000000..2738d145d452
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Novatek NT39016 TFT LCD panel driver
+ *
+ * Copyright (C) 2017, Maarten ter Huurne <maarten@treewalker.org>
+ * Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <uapi/linux/media-bus-format.h>
+
+
+enum nt39016_regs {
+	NT39016_REG_SYSTEM,
+	NT39016_REG_TIMING,
+	NT39016_REG_OP,
+	NT39016_REG_DATA_IN,
+	NT39016_REG_SRC_TIMING_DELAY,
+	NT39016_REG_GATE_TIMING_DELAY,
+	NT39016_REG_RESERVED,
+	NT39016_REG_INITIAL_FUNC,
+	NT39016_REG_CONTRAST,
+	NT39016_REG_BRIGHTNESS,
+	NT39016_REG_HUE_SATURATION,
+	NT39016_REG_RB_SUBCONTRAST,
+	NT39016_REG_R_SUBBRIGHTNESS,
+	NT39016_REG_B_SUBBRIGHTNESS,
+	NT39016_REG_VCOMDC,
+	NT39016_REG_VCOMAC,
+	NT39016_REG_VGAM2,
+	NT39016_REG_VGAM34,
+	NT39016_REG_VGAM56,
+	NT39016_REG_VCOMDC_TRIM = 0x1e,
+	NT39016_REG_DISPLAY_MODE = 0x20,
+};
+
+struct nt39016_panel_info {
+	struct drm_display_mode display_mode;
+	u16 width_mm, height_mm;
+	u32 bus_format, bus_flags;
+};
+
+struct nt39016 {
+	struct drm_panel drm_panel;
+	struct device *dev;
+	struct regmap *map;
+	struct regulator *supply;
+	const struct nt39016_panel_info *panel_info;
+
+	struct gpio_desc *reset_gpio;
+
+	struct backlight_device *backlight;
+};
+
+static inline struct nt39016 *to_nt39016(struct drm_panel *panel)
+{
+	return container_of(panel, struct nt39016, drm_panel);
+}
+
+#define RV(REG, VAL) { .reg = (REG), .def = (VAL), .delay_us = 2 }
+static const struct reg_sequence nt39016_panel_regs[] = {
+	RV(NT39016_REG_SYSTEM, 0x04),
+	RV(NT39016_REG_TIMING, 0x00),
+	RV(NT39016_REG_OP, 0x03),
+	RV(NT39016_REG_DATA_IN, 0xCC),
+	RV(NT39016_REG_SRC_TIMING_DELAY, 0x46),
+	RV(NT39016_REG_GATE_TIMING_DELAY, 0x05),
+	RV(NT39016_REG_RESERVED, 0x00),
+	RV(NT39016_REG_INITIAL_FUNC, 0x00),
+	RV(NT39016_REG_CONTRAST, 0x08),
+	RV(NT39016_REG_BRIGHTNESS, 0x40),
+	RV(NT39016_REG_HUE_SATURATION, 0x88),
+	RV(NT39016_REG_RB_SUBCONTRAST, 0x88),
+	RV(NT39016_REG_R_SUBBRIGHTNESS, 0x20),
+	RV(NT39016_REG_B_SUBBRIGHTNESS, 0x20),
+	RV(NT39016_REG_VCOMDC, 0x67),
+	RV(NT39016_REG_VCOMAC, 0xA4),
+	RV(NT39016_REG_VGAM2, 0x04),
+	RV(NT39016_REG_VGAM34, 0x24),
+	RV(NT39016_REG_VGAM56, 0x24),
+	RV(NT39016_REG_DISPLAY_MODE, 0x00),
+};
+#undef RV
+
+static const struct regmap_range nt39016_regmap_no_ranges[] = {
+	regmap_reg_range(0x13, 0x1D),
+	regmap_reg_range(0x1F, 0x1F),
+};
+
+static const struct regmap_access_table nt39016_regmap_access_table = {
+	.no_ranges = nt39016_regmap_no_ranges,
+	.n_no_ranges = ARRAY_SIZE(nt39016_regmap_no_ranges),
+};
+
+static const struct regmap_config nt39016_regmap_config = {
+	.reg_bits = 6,
+	.pad_bits = 2,
+	.val_bits = 8,
+
+	.max_register = NT39016_REG_DISPLAY_MODE,
+	.wr_table = &nt39016_regmap_access_table,
+	.write_flag_mask = 0x02,
+
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int nt39016_prepare(struct drm_panel *drm_panel)
+{
+	struct nt39016 *panel = to_nt39016(drm_panel);
+	int err;
+
+	err = regulator_enable(panel->supply);
+	if (err) {
+		dev_err(panel->dev, "Failed to enable power supply: %i", err);
+		return err;
+	}
+
+	/*
+	 * Reset the NT39016.
+	 * The documentation says the reset pulse should be at least 40 us to
+	 * pass the glitch filter, but when testing I see some resets fail and
+	 * some succeed when using a 70 us delay, so we use 100 us instead.
+	 */
+	gpiod_set_value_cansleep(panel->reset_gpio, 1);
+	usleep_range(100, 1000);
+	gpiod_set_value_cansleep(panel->reset_gpio, 0);
+	udelay(2);
+
+	/* Init all registers. */
+	err = regmap_multi_reg_write(panel->map, nt39016_panel_regs,
+				     ARRAY_SIZE(nt39016_panel_regs));
+	if (err) {
+		dev_err(panel->dev, "Failed to init registers: %i", err);
+		goto err_disable_regulator;
+	}
+
+	return 0;
+
+err_disable_regulator:
+	regulator_disable(panel->supply);
+	return err;
+}
+
+static int nt39016_unprepare(struct drm_panel *drm_panel)
+{
+	struct nt39016 *panel = to_nt39016(drm_panel);
+
+	gpiod_set_value_cansleep(panel->reset_gpio, 1);
+
+	regulator_disable(panel->supply);
+
+	return 0;
+}
+
+static int nt39016_enable(struct drm_panel *drm_panel)
+{
+	struct nt39016 *panel = to_nt39016(drm_panel);
+	int err;
+
+	err = regmap_write(panel->map, NT39016_REG_SYSTEM, 0x07);
+	if (err) {
+		dev_err(panel->dev, "Unable to enable panel: %i", err);
+		return err;
+	}
+
+	/* Wait for the picture to be ready before enabling backlight */
+	msleep(150);
+
+	if (panel->backlight) {
+		panel->backlight->props.state &= ~BL_CORE_FBBLANK;
+		panel->backlight->props.power = FB_BLANK_UNBLANK;
+		backlight_update_status(panel->backlight);
+	}
+
+	return 0;
+}
+
+static int nt39016_disable(struct drm_panel *drm_panel)
+{
+	struct nt39016 *panel = to_nt39016(drm_panel);
+	int err;
+
+	if (panel->backlight) {
+		panel->backlight->props.power = FB_BLANK_POWERDOWN;
+		panel->backlight->props.state |= BL_CORE_FBBLANK;
+		backlight_update_status(panel->backlight);
+	}
+
+	err = regmap_write(panel->map, NT39016_REG_SYSTEM, 0x05);
+	if (err) {
+		dev_err(panel->dev, "Unable to disable panel: %i", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int nt39016_get_modes(struct drm_panel *drm_panel)
+{
+	struct nt39016 *panel = to_nt39016(drm_panel);
+	const struct nt39016_panel_info *panel_info = panel->panel_info;
+	struct drm_connector *connector = drm_panel->connector;
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(drm_panel->drm, &panel_info->display_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.bpc = 8;
+	connector->display_info.width_mm = panel_info->width_mm;
+	connector->display_info.height_mm = panel_info->height_mm;
+
+	drm_display_info_set_bus_formats(&connector->display_info,
+					 &panel_info->bus_format, 1);
+	connector->display_info.bus_flags = panel_info->bus_flags;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs nt39016_funcs = {
+	.prepare	= nt39016_prepare,
+	.unprepare	= nt39016_unprepare,
+	.enable		= nt39016_enable,
+	.disable	= nt39016_disable,
+	.get_modes	= nt39016_get_modes,
+};
+
+static int nt39016_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct nt39016 *panel;
+	int err;
+
+	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
+	if (!panel)
+		return -ENOMEM;
+
+	panel->dev = dev;
+	spi_set_drvdata(spi, panel);
+
+	panel->panel_info = of_device_get_match_data(dev);
+	if (!panel->panel_info)
+		return -EINVAL;
+
+	panel->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(panel->supply)) {
+		dev_err(dev, "Failed to get power supply");
+		return PTR_ERR(panel->supply);
+	}
+
+	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(panel->reset_gpio)) {
+		dev_err(dev, "Failed to get reset GPIO");
+		return PTR_ERR(panel->reset_gpio);
+	}
+
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_3 | SPI_3WIRE;
+	err = spi_setup(spi);
+	if (err) {
+		dev_err(dev, "Failed to setup SPI");
+		return err;
+	}
+
+	panel->map = devm_regmap_init_spi(spi, &nt39016_regmap_config);
+	if (IS_ERR(panel->map)) {
+		dev_err(dev, "Failed to init regmap");
+		return PTR_ERR(panel->map);
+	}
+
+	panel->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(panel->backlight)) {
+		err = PTR_ERR(panel->backlight);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get backlight handle");
+		return err;
+	}
+
+	drm_panel_init(&panel->drm_panel);
+	panel->drm_panel.dev = dev;
+	panel->drm_panel.funcs = &nt39016_funcs;
+
+	err = drm_panel_add(&panel->drm_panel);
+	if (err < 0) {
+		dev_err(dev, "Failed to register panel");
+		goto err_free_backlight;
+	}
+
+	return 0;
+
+err_free_backlight:
+	if (panel->backlight)
+		put_device(&panel->backlight->dev);
+
+	return err;
+}
+
+static int nt39016_remove(struct spi_device *spi)
+{
+	struct nt39016 *panel = spi_get_drvdata(spi);
+
+	drm_panel_remove(&panel->drm_panel);
+
+	nt39016_disable(&panel->drm_panel);
+	nt39016_unprepare(&panel->drm_panel);
+
+	if (panel->backlight)
+		put_device(&panel->backlight->dev);
+
+	return 0;
+}
+
+static const struct nt39016_panel_info kd035g6_info = {
+	.display_mode = {
+		.clock = 6000,
+		.hdisplay = 320,
+		.hsync_start = 320 + 10,
+		.hsync_end = 320 + 10 + 50,
+		.htotal = 320 + 10 + 50 + 20,
+		.vdisplay = 240,
+		.vsync_start = 240 + 5,
+		.vsync_end = 240 + 5 + 1,
+		.vtotal = 240 + 5 + 1 + 4,
+		.vrefresh = 60,
+		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
+	.width_mm = 71,
+	.height_mm = 53,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
+};
+
+static const struct of_device_id nt39016_of_match[] = {
+	{ .compatible = "kingdisplay,kd035g6-54nt", .data = &kd035g6_info },
+	{},
+};
+MODULE_DEVICE_TABLE(of, nt39016_of_match);
+
+static struct spi_driver nt39016_driver = {
+	.driver = {
+		.name = "nt39016",
+		.of_match_table = nt39016_of_match,
+	},
+	.probe = nt39016_probe,
+	.remove = nt39016_remove,
+};
+
+module_spi_driver(nt39016_driver);
+
+MODULE_AUTHOR("Maarten ter Huurne <maarten@treewalker.org>");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0.593.g511ec345e18

