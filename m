Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A0C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D3620644
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437795AbfIUMuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 08:50:14 -0400
Received: from mx1.riseup.net ([198.252.153.129]:47176 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405593AbfIUMuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 08:50:14 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 5F6C51B932C;
        Sat, 21 Sep 2019 05:49:40 -0700 (PDT)
X-Riseup-User-ID: E904BF54A9D00DEAC807850919DC7C9386AA0504DF66F720342B6B7C22BA1A3A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id A3A7F120063;
        Sat, 21 Sep 2019 05:49:36 -0700 (PDT)
From:   =?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?= <joonas.kylmala@iki.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     paul.kocialkowski@bootlin.com, GNUtoo@cyberdimension.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        =?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?= <joonas.kylmala@iki.fi>
Subject: [PATCH] drm/panel: samsung: s6e8aa0: Add backlight control support
Date:   Sat, 21 Sep 2019 15:48:43 +0300
Message-Id: <20190921124843.6967-1-joonas.kylmala@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the backlight brightness controllable from the
userspace.

Signed-off-by: Joonas Kylmälä <joonas.kylmala@iki.fi>
---
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c | 82 ++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index dbced6501204..aa75934f5bed 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -10,8 +10,12 @@
  * Eunchul Kim <chulspro.kim@samsung.com>
  * Tomasz Figa <t.figa@samsung.com>
  * Andrzej Hajda <a.hajda@samsung.com>
+ *
+ * Derived from panel-samsung-s6e63m0.c:
+ *  Copyright (C) 2019 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
 */
 
+#include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -85,6 +89,8 @@
 #define AID_2				(0x6)
 #define AID_3				(0x7)
 
+#define MAX_BRIGHTNESS (GAMMA_LEVEL_NUM - 1)
+
 typedef u8 s6e8aa0_gamma_table[GAMMA_TABLE_LEN];
 
 struct s6e8aa0_variant {
@@ -95,6 +101,7 @@ struct s6e8aa0_variant {
 struct s6e8aa0 {
 	struct device *dev;
 	struct drm_panel panel;
+	struct backlight_device *bl_dev;
 
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset_gpio;
@@ -110,7 +117,6 @@ struct s6e8aa0 {
 	u8 version;
 	u8 id;
 	const struct s6e8aa0_variant *variant;
-	int brightness;
 
 	/* This field is tested by functions directly accessing DSI bus before
 	 * transfer, transfer is skipped if it is set. In case of transfer
@@ -321,9 +327,10 @@ static void s6e8aa0_etc_elvss_control(struct s6e8aa0 *ctx)
 
 static void s6e8aa0_elvss_nvm_set_v142(struct s6e8aa0 *ctx)
 {
+	struct backlight_device *bd = ctx->bl_dev;
 	u8 br;
 
-	switch (ctx->brightness) {
+	switch (bd->props.brightness) {
 	case 0 ... 6: /* 30cd ~ 100cd */
 		br = 0xdf;
 		break;
@@ -762,24 +769,6 @@ static const struct s6e8aa0_variant s6e8aa0_variants[] = {
 	}
 };
 
-static void s6e8aa0_brightness_set(struct s6e8aa0 *ctx)
-{
-	const u8 *gamma;
-
-	if (ctx->error)
-		return;
-
-	gamma = ctx->variant->gamma_tables[ctx->brightness];
-
-	if (ctx->version >= 142)
-		s6e8aa0_elvss_nvm_set(ctx);
-
-	s6e8aa0_dcs_write(ctx, gamma, GAMMA_TABLE_LEN);
-
-	/* update gamma table. */
-	s6e8aa0_dcs_write_seq_static(ctx, 0xf7, 0x03);
-}
-
 static void s6e8aa0_panel_init(struct s6e8aa0 *ctx)
 {
 	s6e8aa0_apply_level_1_key(ctx);
@@ -791,7 +780,7 @@ static void s6e8aa0_panel_init(struct s6e8aa0 *ctx)
 
 	s6e8aa0_panel_cond_set(ctx);
 	s6e8aa0_display_condition_set(ctx);
-	s6e8aa0_brightness_set(ctx);
+	backlight_enable(ctx->bl_dev);
 	s6e8aa0_etc_source_control(ctx);
 	s6e8aa0_etc_pentile_control(ctx);
 	s6e8aa0_elvss_nvm_set(ctx);
@@ -974,6 +963,53 @@ static int s6e8aa0_parse_dt(struct s6e8aa0 *ctx)
 	return 0;
 }
 
+static int s6e8aa0_set_brightness(struct backlight_device *bd)
+{
+	struct s6e8aa0 *ctx = bl_get_data(bd);
+	const u8 *gamma;
+
+	if (ctx->error)
+		return;
+
+	gamma = ctx->variant->gamma_tables[bd->props.brightness];
+
+	if (ctx->version >= 142)
+		s6e8aa0_elvss_nvm_set(ctx);
+
+	s6e8aa0_dcs_write(ctx, gamma, GAMMA_TABLE_LEN);
+
+	/* update gamma table. */
+	s6e8aa0_dcs_write_seq_static(ctx, 0xf7, 0x03);
+
+	return s6e8aa0_clear_error(ctx);
+}
+
+static const struct backlight_ops s6e8aa0_backlight_ops = {
+	.update_status	= s6e8aa0_set_brightness,
+};
+
+static int s6e8aa0_backlight_register(struct s6e8aa0 *ctx)
+{
+	struct backlight_properties props = {
+		.type		= BACKLIGHT_RAW,
+		.brightness	= MAX_BRIGHTNESS,
+		.max_brightness = MAX_BRIGHTNESS
+	};
+	struct device *dev = ctx->dev;
+	int ret = 0;
+
+	ctx->bl_dev = devm_backlight_device_register(dev, "panel", dev, ctx,
+						     &s6e8aa0_backlight_ops,
+						     &props);
+	if (IS_ERR(ctx->bl_dev)) {
+		ret = PTR_ERR(ctx->bl_dev);
+		DRM_DEV_ERROR(dev, "error registering backlight device (%d)\n",
+			      ret);
+	}
+
+	return ret;
+}
+
 static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -1015,7 +1051,9 @@ static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
-	ctx->brightness = GAMMA_LEVEL_NUM - 1;
+	ret = s6e8aa0_backlight_register(ctx);
+	if (ret < 0)
+		return ret;
 
 	drm_panel_init(&ctx->panel, dev, &s6e8aa0_drm_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-- 
2.11.0

