Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95061C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FD2205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfFZKiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:38:10 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54510 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfFZKh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:37:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 94CBBFB02;
        Wed, 26 Jun 2019 12:37:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qUAc3Ui--vey; Wed, 26 Jun 2019 12:37:54 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A7A9748EB0; Wed, 26 Jun 2019 12:37:51 +0200 (CEST)
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
Subject: [PATCH v2 4/4] drm/panel: jh057n00900: Add regulator support
Date:   Wed, 26 Jun 2019 12:37:51 +0200
Message-Id: <f78611fb26329e50ec1533810fbb76562f2f4e48.1561542477.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1561542477.git.agx@sigxcpu.org>
References: <cover.1561542477.git.agx@sigxcpu.org>
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
 .../drm/panel/panel-rocktech-jh057n00900.c    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index b8a069055fbc..1274b54f2672 100644
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
@@ -174,6 +179,19 @@ static int jh057n_prepare(struct drm_panel *panel)
 		return 0;
 
 	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
+	ret = regulator_enable(ctx->vcc);
+	if (ret < 0) {
+		DRM_DEV_ERROR(ctx->dev,
+			      "Failed to enable vcc supply: %d\n", ret);
+		return ret;
+	}
+	ret = regulator_enable(ctx->iovcc);
+	if (ret < 0) {
+		DRM_DEV_ERROR(ctx->dev,
+			      "Failed to enable iovcc supply: %d\n", ret);
+		goto disable_vcc;
+	}
+
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	usleep_range(20, 40);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -189,6 +207,10 @@ static int jh057n_prepare(struct drm_panel *panel)
 	ctx->prepared = true;
 
 	return 0;
+
+disable_vcc:
+	regulator_disable(ctx->vcc);
+	return ret;
 }
 
 static const struct drm_display_mode default_mode = {
@@ -301,6 +323,25 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(ctx->backlight))
 		return PTR_ERR(ctx->backlight);
 
+	ctx->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(ctx->vcc)) {
+		ret = PTR_ERR(ctx->vcc);
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev,
+				      "Failed to request vcc regulator: %d\n",
+				      ret);
+		return ret;
+	}
+	ctx->iovcc = devm_regulator_get(dev, "iovcc");
+	if (IS_ERR(ctx->iovcc)) {
+		ret = PTR_ERR(ctx->iovcc);
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev,
+				      "Failed to request iovcc regulator: %d\n",
+				      ret);
+		return ret;
+	}
+
 	drm_panel_init(&ctx->panel);
 	ctx->panel.dev = dev;
 	ctx->panel.funcs = &jh057n_drm_funcs;
-- 
2.20.1

