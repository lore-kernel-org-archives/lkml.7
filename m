Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D693C48BDF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749E22070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zx53hxni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfFVDlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 23:41:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35792 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfFVDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 23:41:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so4537286pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=biEG8A6qsnV8USdVJ9nRUdT2fnx/q2QcIpfVntaLX94=;
        b=Zx53hxnih2E32q65qzSC5ntPSnd5FHE3CxkhySxwxWWHvxETmcUO4m6MiX3kwp9rEJ
         9PXuQi7aJB4u00x5PsCNcGV13f7suZavL+WDWv55eRXS7c4C9ddZKPap163QUU8mi9Qg
         05kaes90KsHnVRr1ZtZX5hjmf+LTOJCpxWIh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=biEG8A6qsnV8USdVJ9nRUdT2fnx/q2QcIpfVntaLX94=;
        b=fbs7xqUL7DpEJomHxkVbweEx2fxS3C77aV27ejMROZ4XI37p7G2Gqa5Rfus52maJHL
         uB4/yuyDXruMKpH5RdYd22iSKZJAl4syZHDUPLQZs3qbyLo8YOwrpv07DF23Fg+Q/QyD
         C15EPuu/eyV7Rr6PrAeE1V9VQ6p+EqyszwCfcYETG8aL5xZMg/nfg8KKPNxwUWmo2joQ
         enGuMK5Am36++1dbz01Zy45pHpITyS1DZqSaQX2vVv1K/0MLGZ+Ib6blU6bf4Ng1ufkQ
         MSeC3TmZLObCFs/wstSsSci/k+N9xvglo0dfs7zMUS3ck6Xe09Usjv0eyGCbT6DCkdHM
         4gKw==
X-Gm-Message-State: APjAAAWcqqq2vkrfXxAI1zqNBTRm8HSkYW1XQWwNTxzP6Uhz1opu2VaV
        SgdSoLWWLIdADsa55KXGMFV07kCa1WY=
X-Google-Smtp-Source: APXvYqytWmA7aAS/phT/5ypa5EiAkWDfppuTe2MWhgSEUdreXiQBGnjXzaLIU4ep5INT6zIkSkAE4A==
X-Received: by 2002:a17:90a:26a1:: with SMTP id m30mr11036201pje.59.1561174874575;
        Fri, 21 Jun 2019 20:41:14 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id u128sm4756688pfu.26.2019.06.21.20.41.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 20:41:14 -0700 (PDT)
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
Subject: [PATCH v3 3/4] drm/connector: Split out orientation quirk detection
Date:   Fri, 21 Jun 2019 20:41:04 -0700
Message-Id: <20190622034105.188454-4-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190622034105.188454-1-dbasehore@chromium.org>
References: <20190622034105.188454-1-dbasehore@chromium.org>
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
 drivers/gpu/drm/drm_connector.c | 45 ++++++++++++++++++++++++---------
 drivers/gpu/drm/i915/intel_dp.c |  4 +--
 drivers/gpu/drm/i915/vlv_dsi.c  |  5 ++--
 include/drm/drm_connector.h     |  2 ++
 4 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index e17586aaa80f..c4b01adf927a 100644
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
@@ -1941,6 +1933,35 @@ int drm_connector_init_panel_orientation_property(
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
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index b099a9dc28fd..7d4e61cf5463 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -7282,8 +7282,8 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	intel_panel_setup_backlight(connector, pipe);
 
 	if (fixed_mode)
-		drm_connector_init_panel_orientation_property(
-			connector, fixed_mode->hdisplay, fixed_mode->vdisplay);
+		drm_connector_init_panel_orientation_property_quirk(connector,
+				fixed_mode->hdisplay, fixed_mode->vdisplay);
 
 	return true;
 
diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_dsi.c
index bfe2891eac37..fa9833dbe359 100644
--- a/drivers/gpu/drm/i915/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/vlv_dsi.c
@@ -1650,6 +1650,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
 
 	if (connector->panel.fixed_mode) {
 		u32 allowed_scalers;
+		int orientation;
 
 		allowed_scalers = BIT(DRM_MODE_SCALE_ASPECT) | BIT(DRM_MODE_SCALE_FULLSCREEN);
 		if (!HAS_GMCH(dev_priv))
@@ -1660,9 +1661,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
 
 		connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
-		connector->base.display_info.panel_orientation =
-			vlv_dsi_get_panel_orientation(connector);
-		drm_connector_init_panel_orientation_property(
+		drm_connector_init_panel_orientation_property_quirk(
 				&connector->base,
 				connector->panel.fixed_mode->hdisplay,
 				connector->panel.fixed_mode->vdisplay);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 47e749b74e5f..0468fd9a4418 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1370,6 +1370,8 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
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

