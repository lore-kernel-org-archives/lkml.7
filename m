Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CBC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD572080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hBI5kWhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfFKEEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:04:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41226 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388995AbfFKEEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:04:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so6152819pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRf5zwh2omhJlMBygQXOHV94QlDCvtVP6qLo6sclvew=;
        b=hBI5kWhyOvyp1E+jRaOMnfLP/satVRSFRP8f6NRNyVUCGpgshs8WxNVYT2q0NV/2gj
         wPweK/9YAhTa7JtVa4YtP2wEqtfpY4oObASG+1jPXLuAcs6ScW9XvYt1hu3mmb1W4mC3
         qnv5BgzYpqfI2qcra266da1Q0lOBymxK6SKqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRf5zwh2omhJlMBygQXOHV94QlDCvtVP6qLo6sclvew=;
        b=Om68q54KzMaHnHfeRDFAzkXITswmkwS1O70VYKRj+LZEVnl6Doyn1OluJXk7LBs1BP
         gms/cIruB6YyoefOGtbpq3db/JVp3mQPOCqBjln9agC9h+QkZtxbu5Dnhc1tYOOz3Vvq
         de1A6yOst2OZF9KAeO6giplQ76roV+mu/uV1DJLzRKwTjq05bnSO1+LUYZz7J33VIQby
         KM5CAGx/6Ystpb3ckIg2ayHKNiHCAFe8dByM8eJfK9EWNbrHj0btSyaGSHMc6FauGkPr
         OkR4yRBZpw/Y9yr/zEpO45V8qUoplRXiosaFxzjTEg+yIsfrvIQTg9bnq5fixl5bsi7l
         VbWw==
X-Gm-Message-State: APjAAAWBPMGXFj/3toL+Woior+N20E1e8uKHl6xEMG2nxGOpCG+PCtqW
        E5YqI984+fXNSUGkhzSeFoe3BEVw8Kk=
X-Google-Smtp-Source: APXvYqzw8Zl9pN/Pa5y81l8eb8hfV6D4yF7M05gc2/1u6/QOO7gYQ1T3DU+QBeRduFts4YBZE+xKeg==
X-Received: by 2002:a62:6303:: with SMTP id x3mr62758208pfb.261.1560225840106;
        Mon, 10 Jun 2019 21:04:00 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id y133sm13301185pfb.28.2019.06.10.21.03.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 21:03:59 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 4/5] drm/connector: Split out orientation quirk detection
Date:   Mon, 10 Jun 2019 21:03:49 -0700
Message-Id: <20190611040350.90064-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190611040350.90064-1-dbasehore@chromium.org>
References: <20190611040350.90064-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the orientation quirk detection from the code to add
an orientation property to a panel. This is used only for legacy x86
systems, yet we'd like to start using this on devicetree systems where
quirk detection like this is not needed.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/drm_connector.c | 16 ++++------------
 drivers/gpu/drm/i915/intel_dp.c | 14 +++++++++++---
 drivers/gpu/drm/i915/vlv_dsi.c  | 14 ++++++++++----
 include/drm/drm_connector.h     |  2 +-
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index e17586aaa80f..58a09b65028b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1894,31 +1894,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
  * drm_connector_init_panel_orientation_property -
  *	initialize the connecters panel_orientation property
  * @connector: connector for which to init the panel-orientation property.
- * @width: width in pixels of the panel, used for panel quirk detection
- * @height: height in pixels of the panel, used for panel quirk detection
  *
  * This function should only be called for built-in panels, after setting
  * connector->display_info.panel_orientation first (if known).
  *
- * This function will check for platform specific (e.g. DMI based) quirks
- * overriding display_info.panel_orientation first, then if panel_orientation
- * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
- * "panel orientation" property to the connector.
+ * This function will check if the panel_orientation is not
+ * DRM_MODE_PANEL_ORIENTATION_UNKNOWN. If not, it will attach the "panel
+ * orientation" property to the connector.
  *
  * Returns:
  * Zero on success, negative errno on failure.
  */
 int drm_connector_init_panel_orientation_property(
-	struct drm_connector *connector, int width, int height)
+	struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
 	struct drm_display_info *info = &connector->display_info;
 	struct drm_property *prop;
-	int orientation_quirk;
-
-	orientation_quirk = drm_get_panel_orientation_quirk(width, height);
-	if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
-		info->panel_orientation = orientation_quirk;
 
 	if (info->panel_orientation == DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
 		return 0;
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index b099a9dc28fd..72ab090ea97a 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -40,6 +40,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_hdcp.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_utils.h>
 #include <drm/i915_drm.h>
 
 #include "i915_debugfs.h"
@@ -7281,9 +7282,16 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	intel_connector->panel.backlight.power = intel_edp_backlight_power;
 	intel_panel_setup_backlight(connector, pipe);
 
-	if (fixed_mode)
-		drm_connector_init_panel_orientation_property(
-			connector, fixed_mode->hdisplay, fixed_mode->vdisplay);
+	if (fixed_mode) {
+		int orientation = drm_get_panel_orientation_quirk(
+				fixed_mode->hdisplay, fixed_mode->vdisplay);
+
+		if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
+			connector->display_info.panel_orientation =
+				orientation;
+
+		drm_connector_init_panel_orientation_property(connector);
+	}
 
 	return true;
 
diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_dsi.c
index bfe2891eac37..27f86a787f60 100644
--- a/drivers/gpu/drm/i915/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/vlv_dsi.c
@@ -30,6 +30,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_utils.h>
 
 #include "i915_drv.h"
 #include "intel_atomic.h"
@@ -1650,6 +1651,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
 
 	if (connector->panel.fixed_mode) {
 		u32 allowed_scalers;
+		int orientation;
 
 		allowed_scalers = BIT(DRM_MODE_SCALE_ASPECT) | BIT(DRM_MODE_SCALE_FULLSCREEN);
 		if (!HAS_GMCH(dev_priv))
@@ -1660,12 +1662,16 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
 
 		connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
-		connector->base.display_info.panel_orientation =
-			vlv_dsi_get_panel_orientation(connector);
-		drm_connector_init_panel_orientation_property(
-				&connector->base,
+		orientation = drm_get_panel_orientation_quirk(
 				connector->panel.fixed_mode->hdisplay,
 				connector->panel.fixed_mode->vdisplay);
+		if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
+			connector->base.display_info.panel_orientation = orientation;
+		else
+			connector->base.display_info.panel_orientation =
+				vlv_dsi_get_panel_orientation(connector);
+
+		drm_connector_init_panel_orientation_property(&connector->base);
 	}
 }
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 47e749b74e5f..c2992f7a0dd5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1370,7 +1370,7 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
 void drm_connector_set_vrr_capable_property(
 		struct drm_connector *connector, bool capable);
 int drm_connector_init_panel_orientation_property(
-	struct drm_connector *connector, int width, int height);
+	struct drm_connector *connector);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

