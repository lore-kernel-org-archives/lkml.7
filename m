Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F952C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450792073D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KnyvSEpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGJCRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:17:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38005 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfGJCRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:17:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so376980plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pjfsy9rhDDSQLRF2c0ELoxpFQi0Wl/hYf+k+fsHKXE=;
        b=KnyvSEptEQBRJwTGRUTY8PGPYjnCYLeEBEvkphUgK6mwTu5SWaCLT43F8rzZhqtQQJ
         L/uNfZBv5wq2d8G3BLF283g2RVF3ZId0+nDz66B2y6vGllJU0T3/yHpOowc6abM3ybKO
         1zcaQFtSDYujVUFfRDhzMbdHWwpy2xD/qgKf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pjfsy9rhDDSQLRF2c0ELoxpFQi0Wl/hYf+k+fsHKXE=;
        b=tXbuAd2b9r1k+Pu5j6PrB19VzO5sb11DPAlO+LhvDokgtACo9WhMmfWwkiDMjwZCu5
         7JYPoqs5A2C4gCOGxCscChFMl0gwopUE0J9sp4jU/TSjzDQnvTS0BZk/4KXXCI8gxZjz
         2EhiiDOoUoQ3xHW+KyGhqIfsL69OO99kJUT29LNNctdmLNQVo0B4c4k5LnVSVdDszZ8o
         FwISKzcfalAmOkoQB69/j0HSRDk0qNbuRrkqQH/OWDaruTO52NdoHJdq1vKltkT50UHz
         b5lIxTsULGnLekLt5QbGtdWC4+qqisF+oWn2xEkwWAWfOIr3vhyvosidiL4Vd38JDGNr
         XgbQ==
X-Gm-Message-State: APjAAAW1E0C0wIZbB095TTw5Fx1FHISh+EhnQAmvK8HSGijO9Ne5xusx
        txcRMDEC/ghNq+0/PeKi2r6JAPoSpTw=
X-Google-Smtp-Source: APXvYqwF3S1BnldvZbLiGWX8z/EpBjWWQ5qhe7Uy3EG5dlfo3/q6v/vfgLPA9f62WGcPr7Ec4W8GLA==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr34203286pla.50.1562725027336;
        Tue, 09 Jul 2019 19:17:07 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id f17sm326296pgv.16.2019.07.09.19.17.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 19:17:06 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v7 3/4] drm/connector: Split out orientation quirk detection
Date:   Tue,  9 Jul 2019 19:16:58 -0700
Message-Id: <20190710021659.177950-4-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190710021659.177950-1-dbasehore@chromium.org>
References: <20190710021659.177950-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every platform needs quirk detection for panel orientation, so
split the drm_connector_init_panel_orientation_property into two
functions. One for platforms without the need for quirks, and the
other for platforms that need quirks.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/drm_connector.c         | 45 ++++++++++++++++++-------
 drivers/gpu/drm/i915/display/intel_dp.c |  4 +--
 drivers/gpu/drm/i915/display/vlv_dsi.c  |  2 +-
 include/drm/drm_connector.h             |  2 ++
 4 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b3f2cf7eae9c..52777d647494 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1892,31 +1892,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
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
@@ -1939,6 +1931,35 @@ int drm_connector_init_panel_orientation_property(
 }
 EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
 
+/**
+ * drm_connector_init_panel_orientation_property_quirk -
+ *	initialize the connecters panel_orientation property with a quirk
+ *	override
+ * @connector: connector for which to init the panel-orientation property.
+ * @width: width in pixels of the panel, used for panel quirk detection
+ * @height: height in pixels of the panel, used for panel quirk detection
+ *
+ * This function will check for platform specific (e.g. DMI based) quirks
+ * overriding display_info.panel_orientation first, then if panel_orientation
+ * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
+ * "panel orientation" property to the connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_init_panel_orientation_property_quirk(
+	struct drm_connector *connector, int width, int height)
+{
+	int orientation_quirk;
+
+	orientation_quirk = drm_get_panel_orientation_quirk(width, height);
+	if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
+		connector->display_info.panel_orientation = orientation_quirk;
+
+	return drm_connector_init_panel_orientation_property(connector);
+}
+EXPORT_SYMBOL(drm_connector_init_panel_orientation_property_quirk);
+
 int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 				    struct drm_property *property,
 				    uint64_t value)
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0bdb7ecc5a81..975196c86e50 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7063,8 +7063,8 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	intel_panel_setup_backlight(connector, pipe);
 
 	if (fixed_mode)
-		drm_connector_init_panel_orientation_property(
-			connector, fixed_mode->hdisplay, fixed_mode->vdisplay);
+		drm_connector_init_panel_orientation_property_quirk(connector,
+				fixed_mode->hdisplay, fixed_mode->vdisplay);
 
 	return true;
 
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index e272d826210a..dd7fa806f95c 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1662,7 +1662,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
 
 		connector->base.display_info.panel_orientation =
 			vlv_dsi_get_panel_orientation(connector);
-		drm_connector_init_panel_orientation_property(
+		drm_connector_init_panel_orientation_property_quirk(
 				&connector->base,
 				connector->panel.fixed_mode->hdisplay,
 				connector->panel.fixed_mode->vdisplay);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index ca745d9feaf5..940254b06767 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1512,6 +1512,8 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
 void drm_connector_set_vrr_capable_property(
 		struct drm_connector *connector, bool capable);
 int drm_connector_init_panel_orientation_property(
+	struct drm_connector *connector);
+int drm_connector_init_panel_orientation_property_quirk(
 	struct drm_connector *connector, int width, int height);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
-- 
2.22.0.410.gd8fdbe21b5-goog

