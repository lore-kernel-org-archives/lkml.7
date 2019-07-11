Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA394C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C321208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfICzL+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfGKUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:45:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38387 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbfGKUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:45:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so3297349pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aElOUa28IDV+Ms9r3bfrgzJICeP4nyAIWqfUYkJpGGU=;
        b=KfICzL+zhG+iFMQSO5h96qlDv0Q4R/M/HLlUjjPtDF9xvFcNiGBvMnMsRpT42iQc5+
         VS+bdk6ElH393b/7aREvh0oD+MbpUJc8/K8fBwW0gyrE4dwHL9SJyrTnP8s6ZkA7Fozg
         oeo+8/OoXqIFNmDvQ3vDWDTuEVHa3i+PzTU9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aElOUa28IDV+Ms9r3bfrgzJICeP4nyAIWqfUYkJpGGU=;
        b=Dg2iiBP14AdT5I3ze0maqF0Dr3fVV3pJMkE4+7IBSch5yAEND0oGUQ99ojDcjpxNmc
         qhbQ19940MyZ+TBcFWgcX1UN4EzlCFDgh59dltKiExrtJ9Nwap3VbfRi0D/ljpjTTJDF
         js3iIbU9MNKtpAvjQ565I/D/CkBGkv5IjEfushPlvYnuLk9omZu8lCnfgL1/5TdfavG2
         FtmByNtpw56v4inC9meleMLpYbjBN+9q5womxolG9v8gkYmPP3JbPeviPf7YjwqMhiqS
         oMneYWUKogkJOCy57bIExds9qivAhHWUzuPc1u9vVK1uhURuyKa3GKBBcbgAfH9G42ku
         KSNA==
X-Gm-Message-State: APjAAAXre47JMIg1dObJarvGFsSxdFhrxGFVHpGeN+QMTXg5QWqeTxjg
        djcsS3WRpUAJq6TvqwQ3Wy00+A==
X-Google-Smtp-Source: APXvYqxWtmbfQ6xXRJMgZcr6q9t9MQEgBglf68LAJcm3jnErkAO8JgOtdlvX+3xb7vGMLCQ/B1BfZQ==
X-Received: by 2002:a63:e010:: with SMTP id e16mr2005549pgh.285.1562877901085;
        Thu, 11 Jul 2019 13:45:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f17sm5320110pgv.16.2019.07.11.13.45.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 13:45:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Doug Anderson <dianders@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v6 1/3] drm/panel: simple: Add ability to override typical timing
Date:   Thu, 11 Jul 2019 13:34:53 -0700
Message-Id: <20190711203455.125667-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711203455.125667-1-dianders@chromium.org>
References: <20190711203455.125667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

This patch adds the ability to override the typical display timing for a
given panel. This is useful for devices which have timing constraints
that do not apply across the entire display driver (eg: to avoid
crosstalk between panel and digitizer on certain laptops). The rules are
as follows:

- panel must not specify fixed mode (since the override mode will
  either be the same as the fixed mode, or we'll be unable to
  check the bounds of the overried)
- panel must specify at least one display_timing range which will be
  used to ensure the override mode fits within its bounds

Changes in v2:
 - Parse the full display-timings node (using the native-mode) (Rob)
Changes in v3:
 - No longer parse display-timings subnode, use panel-timing (Rob)
Changes in v4:
 - Don't add mode from timing if override was specified (Thierry)
 - Add warning if timing and fixed mode was specified (Thierry)
 - Don't add fixed mode if timing was specified (Thierry)
 - Refactor/rename a bit to avoid extra indentation from "if" tests
 - i should be unsigned (Thierry)
 - Add annoying WARN_ONs for some cases (Thierry)
 - Simplify 'No display_timing found' handling (Thierry)
 - Rename to panel_simple_parse_override_mode() (Thierry)
Changes in v5:
 - Added Heiko's Tested-by
Changes in v6:
 - Rebased to drm-misc next
 - Added tags

Cc: Doug Anderson <dianders@chromium.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---

 drivers/gpu/drm/panel/panel-simple.c | 109 +++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index af6bf5611b4e..1bee197821ef 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -30,6 +30,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <video/display_timing.h>
+#include <video/of_display_timing.h>
 #include <video/videomode.h>
 
 #include <drm/drm_crtc.h>
@@ -92,6 +93,8 @@ struct panel_simple {
 	struct i2c_adapter *ddc;
 
 	struct gpio_desc *enable_gpio;
+
+	struct drm_display_mode override_mode;
 };
 
 static inline struct panel_simple *to_panel_simple(struct drm_panel *panel)
@@ -99,16 +102,13 @@ static inline struct panel_simple *to_panel_simple(struct drm_panel *panel)
 	return container_of(panel, struct panel_simple, base);
 }
 
-static int panel_simple_get_fixed_modes(struct panel_simple *panel)
+static unsigned int panel_simple_get_timings_modes(struct panel_simple *panel)
 {
 	struct drm_connector *connector = panel->base.connector;
 	struct drm_device *drm = panel->base.drm;
 	struct drm_display_mode *mode;
 	unsigned int i, num = 0;
 
-	if (!panel->desc)
-		return 0;
-
 	for (i = 0; i < panel->desc->num_timings; i++) {
 		const struct display_timing *dt = &panel->desc->timings[i];
 		struct videomode vm;
@@ -132,6 +132,16 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 		num++;
 	}
 
+	return num;
+}
+
+static unsigned int panel_simple_get_fixed_modes(struct panel_simple *panel)
+{
+	struct drm_connector *connector = panel->base.connector;
+	struct drm_device *drm = panel->base.drm;
+	struct drm_display_mode *mode;
+	unsigned int i, num = 0;
+
 	for (i = 0; i < panel->desc->num_modes; i++) {
 		const struct drm_display_mode *m = &panel->desc->modes[i];
 
@@ -153,6 +163,44 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
 		num++;
 	}
 
+	return num;
+}
+
+static int panel_simple_get_non_edid_modes(struct panel_simple *panel)
+{
+	struct drm_connector *connector = panel->base.connector;
+	struct drm_device *drm = panel->base.drm;
+	struct drm_display_mode *mode;
+	bool has_override = panel->override_mode.type;
+	unsigned int num = 0;
+
+	if (!panel->desc)
+		return 0;
+
+	if (has_override) {
+		mode = drm_mode_duplicate(drm, &panel->override_mode);
+		if (mode) {
+			drm_mode_probed_add(connector, mode);
+			num = 1;
+		} else {
+			dev_err(drm->dev, "failed to add override mode\n");
+		}
+	}
+
+	/* Only add timings if override was not there or failed to validate */
+	if (num == 0 && panel->desc->num_timings)
+		num = panel_simple_get_timings_modes(panel);
+
+	/*
+	 * Only add fixed modes if timings/override added no mode.
+	 *
+	 * We should only ever have either the display timings specified
+	 * or a fixed mode. Anything else is rather bogus.
+	 */
+	WARN_ON(panel->desc->num_timings && panel->desc->num_modes);
+	if (num == 0)
+		num = panel_simple_get_fixed_modes(panel);
+
 	connector->display_info.bpc = panel->desc->bpc;
 	connector->display_info.width_mm = panel->desc->size.width;
 	connector->display_info.height_mm = panel->desc->size.height;
@@ -269,7 +317,7 @@ static int panel_simple_get_modes(struct drm_panel *panel)
 	}
 
 	/* add hard-coded panel modes */
-	num += panel_simple_get_fixed_modes(p);
+	num += panel_simple_get_non_edid_modes(p);
 
 	return num;
 }
@@ -300,10 +348,58 @@ static const struct drm_panel_funcs panel_simple_funcs = {
 	.get_timings = panel_simple_get_timings,
 };
 
+#define PANEL_SIMPLE_BOUNDS_CHECK(to_check, bounds, field) \
+	(to_check->field.typ >= bounds->field.min && \
+	 to_check->field.typ <= bounds->field.max)
+static void panel_simple_parse_override_mode(struct device *dev,
+					     struct panel_simple *panel,
+					     const struct display_timing *ot)
+{
+	const struct panel_desc *desc = panel->desc;
+	struct videomode vm;
+	unsigned int i;
+
+	if (WARN_ON(desc->num_modes)) {
+		dev_err(dev, "Reject override mode: panel has a fixed mode\n");
+		return;
+	}
+	if (WARN_ON(!desc->num_timings)) {
+		dev_err(dev, "Reject override mode: no timings specified\n");
+		return;
+	}
+
+	for (i = 0; i < panel->desc->num_timings; i++) {
+		const struct display_timing *dt = &panel->desc->timings[i];
+
+		if (!PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hactive) ||
+		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hfront_porch) ||
+		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hback_porch) ||
+		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hsync_len) ||
+		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vactive) ||
+		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vfront_porch) ||
+		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vback_porch) ||
+		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vsync_len))
+			continue;
+
+		if (ot->flags != dt->flags)
+			continue;
+
+		videomode_from_timing(ot, &vm);
+		drm_display_mode_from_videomode(&vm, &panel->override_mode);
+		panel->override_mode.type |= DRM_MODE_TYPE_DRIVER |
+					     DRM_MODE_TYPE_PREFERRED;
+		break;
+	}
+
+	if (WARN_ON(!panel->override_mode.type))
+		dev_err(dev, "Reject override mode: No display_timing found\n");
+}
+
 static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 {
 	struct device_node *backlight, *ddc;
 	struct panel_simple *panel;
+	struct display_timing dt;
 	int err;
 
 	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
@@ -349,6 +445,9 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 		}
 	}
 
+	if (!of_get_display_timing(dev->of_node, "panel-timing", &dt))
+		panel_simple_parse_override_mode(dev, panel, &dt);
+
 	drm_panel_init(&panel->base);
 	panel->base.dev = dev;
 	panel->base.funcs = &panel_simple_funcs;
-- 
2.22.0.410.gd8fdbe21b5-goog

