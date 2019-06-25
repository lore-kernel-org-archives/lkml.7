Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F4FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC6A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfFYRFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:05:36 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34132 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfFYRF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:05:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4E704FB05;
        Tue, 25 Jun 2019 19:05:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H3d_FJEAHz_q; Tue, 25 Jun 2019 19:05:24 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6C67448E38; Tue, 25 Jun 2019 19:05:19 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: [PATCH 4/4] drm/panel: jh057n0090: Add regulator support
Date:   Tue, 25 Jun 2019 19:05:19 +0200
Message-Id: <b239f1db7a1f67988a9bd1ed62f6a1cf1dce944c.1561482165.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1561482165.git.agx@sigxcpu.org>
References: <cover.1561482165.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to specify regulators for vcc and iovcc. According to the data
sheet the panel wants vcc (2.8V) and iovcc (1.8V) and there's no startup
dependency between the two.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../drm/panel/panel-rocktech-jh057n00900.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index b8a069055fbc..f8f6f087b9bc 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <video/display_timing.h>
 #include <video/mipi_display.h>
 
@@ -47,6 +48,8 @@ struct jh057n {
 	struct drm_panel panel;
 	struct gpio_desc *reset_gpio;
 	struct backlight_device *backlight;
+	struct regulator *vcc;
+	struct regulator *iovcc;
 	bool prepared;
 
 	struct dentry *debugfs;
@@ -160,6 +163,8 @@ static int jh057n_unprepare(struct drm_panel *panel)
 		return 0;
 
 	mipi_dsi_dcs_set_display_off(dsi);
+	regulator_disable(ctx->iovcc);
+	regulator_disable(ctx->vcc);
 	ctx->prepared = false;
 
 	return 0;
@@ -174,6 +179,13 @@ static int jh057n_prepare(struct drm_panel *panel)
 		return 0;
 
 	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
+	ret = regulator_enable(ctx->vcc);
+	if (ret < 0)
+		return ret;
+	ret = regulator_enable(ctx->iovcc);
+	if (ret < 0)
+		return ret;
+
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	usleep_range(20, 40);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -301,6 +313,13 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(ctx->backlight))
 		return PTR_ERR(ctx->backlight);
 
+	ctx->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(ctx->vcc))
+		return PTR_ERR(ctx->vcc);
+	ctx->iovcc = devm_regulator_get(dev, "iovcc");
+	if (IS_ERR(ctx->iovcc))
+		return PTR_ERR(ctx->iovcc);
+
 	drm_panel_init(&ctx->panel);
 	ctx->panel.dev = dev;
 	ctx->panel.funcs = &jh057n_drm_funcs;
-- 
2.20.1

