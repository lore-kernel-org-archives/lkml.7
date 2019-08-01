Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F43C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEA520679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbfHAQhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:37:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39214 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHAQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:37:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 4CE8328C6AC
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     kernel@collabora.com, narmstrong@baylibre.com,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Provide ddc symlink in connector sysfs directory
Date:   Thu,  1 Aug 2019 18:36:38 +0200
Message-Id: <20190801163638.17957-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7cacac43-737e-1ddb-2951-394fcf9ad0b2@baylibre.com>
References: <7cacac43-737e-1ddb-2951-394fcf9ad0b2@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ddc pointer provided by the generic connector.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
This is the same patch as in the series:

https://www.spinics.net/lists/dri-devel/msg220128.html

but this time without a bug.

radeon_add_legacy_connector() uses a local ddc variable, but it has
not been declared in the previous version of this patch.

Compile tested.

 drivers/gpu/drm/radeon/radeon_connectors.c | 143 +++++++++++++++------
 1 file changed, 107 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index c60d1a44d22a..62d37eddf99c 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1870,6 +1870,7 @@ radeon_add_atom_connector(struct drm_device *dev,
 	struct radeon_connector_atom_dig *radeon_dig_connector;
 	struct drm_encoder *encoder;
 	struct radeon_encoder *radeon_encoder;
+	struct i2c_adapter *ddc = NULL;
 	uint32_t subpixel_order = SubPixelNone;
 	bool shared_ddc = false;
 	bool is_dp_bridge = false;
@@ -1947,17 +1948,21 @@ radeon_add_atom_connector(struct drm_device *dev,
 		radeon_connector->con_priv = radeon_dig_connector;
 		if (i2c_bus->valid) {
 			radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
-			if (radeon_connector->ddc_bus)
+			if (radeon_connector->ddc_bus) {
 				has_aux = true;
-			else
+				ddc = &radeon_connector->ddc_bus->adapter;
+			} else {
 				DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+			}
 		}
 		switch (connector_type) {
 		case DRM_MODE_CONNECTOR_VGA:
 		case DRM_MODE_CONNECTOR_DVIA:
 		default:
-			drm_connector_init(dev, &radeon_connector->base,
-					   &radeon_dp_connector_funcs, connector_type);
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_dp_connector_funcs,
+						    connector_type,
+						    ddc);
 			drm_connector_helper_add(&radeon_connector->base,
 						 &radeon_dp_connector_helper_funcs);
 			connector->interlace_allowed = true;
@@ -1979,8 +1984,10 @@ radeon_add_atom_connector(struct drm_device *dev,
 		case DRM_MODE_CONNECTOR_HDMIA:
 		case DRM_MODE_CONNECTOR_HDMIB:
 		case DRM_MODE_CONNECTOR_DisplayPort:
-			drm_connector_init(dev, &radeon_connector->base,
-					   &radeon_dp_connector_funcs, connector_type);
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_dp_connector_funcs,
+						    connector_type,
+						    ddc);
 			drm_connector_helper_add(&radeon_connector->base,
 						 &radeon_dp_connector_helper_funcs);
 			drm_object_attach_property(&radeon_connector->base.base,
@@ -2027,8 +2034,10 @@ radeon_add_atom_connector(struct drm_device *dev,
 			break;
 		case DRM_MODE_CONNECTOR_LVDS:
 		case DRM_MODE_CONNECTOR_eDP:
-			drm_connector_init(dev, &radeon_connector->base,
-					   &radeon_lvds_bridge_connector_funcs, connector_type);
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_lvds_bridge_connector_funcs,
+						    connector_type,
+						    ddc);
 			drm_connector_helper_add(&radeon_connector->base,
 						 &radeon_dp_connector_helper_funcs);
 			drm_object_attach_property(&radeon_connector->base.base,
@@ -2042,13 +2051,18 @@ radeon_add_atom_connector(struct drm_device *dev,
 	} else {
 		switch (connector_type) {
 		case DRM_MODE_CONNECTOR_VGA:
-			drm_connector_init(dev, &radeon_connector->base, &radeon_vga_connector_funcs, connector_type);
-			drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 			if (i2c_bus->valid) {
 				radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 				if (!radeon_connector->ddc_bus)
 					DRM_ERROR("VGA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				else
+					ddc = &radeon_connector->ddc_bus->adapter;
 			}
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_vga_connector_funcs,
+						    connector_type,
+						    ddc);
+			drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 			radeon_connector->dac_load_detect = true;
 			drm_object_attach_property(&radeon_connector->base.base,
 						      rdev->mode_info.load_detect_property,
@@ -2067,13 +2081,18 @@ radeon_add_atom_connector(struct drm_device *dev,
 			connector->doublescan_allowed = true;
 			break;
 		case DRM_MODE_CONNECTOR_DVIA:
-			drm_connector_init(dev, &radeon_connector->base, &radeon_vga_connector_funcs, connector_type);
-			drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 			if (i2c_bus->valid) {
 				radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 				if (!radeon_connector->ddc_bus)
 					DRM_ERROR("DVIA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				else
+					ddc = &radeon_connector->ddc_bus->adapter;
 			}
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_vga_connector_funcs,
+						    connector_type,
+						    ddc);
+			drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 			radeon_connector->dac_load_detect = true;
 			drm_object_attach_property(&radeon_connector->base.base,
 						      rdev->mode_info.load_detect_property,
@@ -2098,13 +2117,18 @@ radeon_add_atom_connector(struct drm_device *dev,
 				goto failed;
 			radeon_dig_connector->igp_lane_info = igp_lane_info;
 			radeon_connector->con_priv = radeon_dig_connector;
-			drm_connector_init(dev, &radeon_connector->base, &radeon_dvi_connector_funcs, connector_type);
-			drm_connector_helper_add(&radeon_connector->base, &radeon_dvi_connector_helper_funcs);
 			if (i2c_bus->valid) {
 				radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 				if (!radeon_connector->ddc_bus)
 					DRM_ERROR("DVI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				else
+					ddc = &radeon_connector->ddc_bus->adapter;
 			}
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_dvi_connector_funcs,
+						    connector_type,
+						    ddc);
+			drm_connector_helper_add(&radeon_connector->base, &radeon_dvi_connector_helper_funcs);
 			subpixel_order = SubPixelHorizontalRGB;
 			drm_object_attach_property(&radeon_connector->base.base,
 						      rdev->mode_info.coherent_mode_property,
@@ -2155,13 +2179,18 @@ radeon_add_atom_connector(struct drm_device *dev,
 				goto failed;
 			radeon_dig_connector->igp_lane_info = igp_lane_info;
 			radeon_connector->con_priv = radeon_dig_connector;
-			drm_connector_init(dev, &radeon_connector->base, &radeon_dvi_connector_funcs, connector_type);
-			drm_connector_helper_add(&radeon_connector->base, &radeon_dvi_connector_helper_funcs);
 			if (i2c_bus->valid) {
 				radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 				if (!radeon_connector->ddc_bus)
 					DRM_ERROR("HDMI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				else
+					ddc = &radeon_connector->ddc_bus->adapter;
 			}
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_dvi_connector_funcs,
+						    connector_type,
+						    ddc);
+			drm_connector_helper_add(&radeon_connector->base, &radeon_dvi_connector_helper_funcs);
 			drm_object_attach_property(&radeon_connector->base.base,
 						      rdev->mode_info.coherent_mode_property,
 						      1);
@@ -2205,15 +2234,20 @@ radeon_add_atom_connector(struct drm_device *dev,
 				goto failed;
 			radeon_dig_connector->igp_lane_info = igp_lane_info;
 			radeon_connector->con_priv = radeon_dig_connector;
-			drm_connector_init(dev, &radeon_connector->base, &radeon_dp_connector_funcs, connector_type);
-			drm_connector_helper_add(&radeon_connector->base, &radeon_dp_connector_helper_funcs);
 			if (i2c_bus->valid) {
 				radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
-				if (radeon_connector->ddc_bus)
+				if (radeon_connector->ddc_bus) {
 					has_aux = true;
-				else
+					ddc = &radeon_connector->ddc_bus->adapter;
+				} else {
 					DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				}
 			}
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_dp_connector_funcs,
+						    connector_type,
+						    ddc);
+			drm_connector_helper_add(&radeon_connector->base, &radeon_dp_connector_helper_funcs);
 			subpixel_order = SubPixelHorizontalRGB;
 			drm_object_attach_property(&radeon_connector->base.base,
 						      rdev->mode_info.coherent_mode_property,
@@ -2255,15 +2289,20 @@ radeon_add_atom_connector(struct drm_device *dev,
 				goto failed;
 			radeon_dig_connector->igp_lane_info = igp_lane_info;
 			radeon_connector->con_priv = radeon_dig_connector;
-			drm_connector_init(dev, &radeon_connector->base, &radeon_edp_connector_funcs, connector_type);
-			drm_connector_helper_add(&radeon_connector->base, &radeon_dp_connector_helper_funcs);
 			if (i2c_bus->valid) {
 				radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
-				if (radeon_connector->ddc_bus)
+				if (radeon_connector->ddc_bus) {
 					has_aux = true;
-				else
+					ddc = &radeon_connector->ddc_bus->adapter;
+				} else {
 					DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				}
 			}
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_edp_connector_funcs,
+						    connector_type,
+						    ddc);
+			drm_connector_helper_add(&radeon_connector->base, &radeon_dp_connector_helper_funcs);
 			drm_object_attach_property(&radeon_connector->base.base,
 						      dev->mode_config.scaling_mode_property,
 						      DRM_MODE_SCALE_FULLSCREEN);
@@ -2274,7 +2313,10 @@ radeon_add_atom_connector(struct drm_device *dev,
 		case DRM_MODE_CONNECTOR_SVIDEO:
 		case DRM_MODE_CONNECTOR_Composite:
 		case DRM_MODE_CONNECTOR_9PinDIN:
-			drm_connector_init(dev, &radeon_connector->base, &radeon_tv_connector_funcs, connector_type);
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_tv_connector_funcs,
+						    connector_type,
+						    ddc);
 			drm_connector_helper_add(&radeon_connector->base, &radeon_tv_connector_helper_funcs);
 			radeon_connector->dac_load_detect = true;
 			drm_object_attach_property(&radeon_connector->base.base,
@@ -2294,13 +2336,18 @@ radeon_add_atom_connector(struct drm_device *dev,
 				goto failed;
 			radeon_dig_connector->igp_lane_info = igp_lane_info;
 			radeon_connector->con_priv = radeon_dig_connector;
-			drm_connector_init(dev, &radeon_connector->base, &radeon_lvds_connector_funcs, connector_type);
-			drm_connector_helper_add(&radeon_connector->base, &radeon_lvds_connector_helper_funcs);
 			if (i2c_bus->valid) {
 				radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 				if (!radeon_connector->ddc_bus)
 					DRM_ERROR("LVDS: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				else
+					ddc = &radeon_connector->ddc_bus->adapter;
 			}
+			drm_connector_init_with_ddc(dev, &radeon_connector->base,
+						    &radeon_lvds_connector_funcs,
+						    connector_type,
+						    ddc);
+			drm_connector_helper_add(&radeon_connector->base, &radeon_lvds_connector_helper_funcs);
 			drm_object_attach_property(&radeon_connector->base.base,
 						      dev->mode_config.scaling_mode_property,
 						      DRM_MODE_SCALE_FULLSCREEN);
@@ -2344,6 +2391,7 @@ radeon_add_legacy_connector(struct drm_device *dev,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_connector *connector;
 	struct radeon_connector *radeon_connector;
+	struct i2c_adapter *ddc = NULL;
 	uint32_t subpixel_order = SubPixelNone;
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
@@ -2378,13 +2426,18 @@ radeon_add_legacy_connector(struct drm_device *dev,
 
 	switch (connector_type) {
 	case DRM_MODE_CONNECTOR_VGA:
-		drm_connector_init(dev, &radeon_connector->base, &radeon_vga_connector_funcs, connector_type);
-		drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 		if (i2c_bus->valid) {
 			radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 			if (!radeon_connector->ddc_bus)
 				DRM_ERROR("VGA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+			else
+				ddc = &radeon_connector->ddc_bus->adapter;
 		}
+		drm_connector_init_with_ddc(dev, &radeon_connector->base,
+					    &radeon_vga_connector_funcs,
+					    connector_type,
+					    ddc);
+		drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 		radeon_connector->dac_load_detect = true;
 		drm_object_attach_property(&radeon_connector->base.base,
 					      rdev->mode_info.load_detect_property,
@@ -2395,13 +2448,18 @@ radeon_add_legacy_connector(struct drm_device *dev,
 		connector->doublescan_allowed = true;
 		break;
 	case DRM_MODE_CONNECTOR_DVIA:
-		drm_connector_init(dev, &radeon_connector->base, &radeon_vga_connector_funcs, connector_type);
-		drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 		if (i2c_bus->valid) {
 			radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 			if (!radeon_connector->ddc_bus)
 				DRM_ERROR("DVIA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+			else
+				ddc = &radeon_connector->ddc_bus->adapter;
 		}
+		drm_connector_init_with_ddc(dev, &radeon_connector->base,
+					    &radeon_vga_connector_funcs,
+					    connector_type,
+					    ddc);
+		drm_connector_helper_add(&radeon_connector->base, &radeon_vga_connector_helper_funcs);
 		radeon_connector->dac_load_detect = true;
 		drm_object_attach_property(&radeon_connector->base.base,
 					      rdev->mode_info.load_detect_property,
@@ -2413,13 +2471,18 @@ radeon_add_legacy_connector(struct drm_device *dev,
 		break;
 	case DRM_MODE_CONNECTOR_DVII:
 	case DRM_MODE_CONNECTOR_DVID:
-		drm_connector_init(dev, &radeon_connector->base, &radeon_dvi_connector_funcs, connector_type);
-		drm_connector_helper_add(&radeon_connector->base, &radeon_dvi_connector_helper_funcs);
 		if (i2c_bus->valid) {
 			radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 			if (!radeon_connector->ddc_bus)
 				DRM_ERROR("DVI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+			else
+				ddc = &radeon_connector->ddc_bus->adapter;
 		}
+		drm_connector_init_with_ddc(dev, &radeon_connector->base,
+					    &radeon_dvi_connector_funcs,
+					    connector_type,
+					    ddc);
+		drm_connector_helper_add(&radeon_connector->base, &radeon_dvi_connector_helper_funcs);
 		if (connector_type == DRM_MODE_CONNECTOR_DVII) {
 			radeon_connector->dac_load_detect = true;
 			drm_object_attach_property(&radeon_connector->base.base,
@@ -2436,7 +2499,10 @@ radeon_add_legacy_connector(struct drm_device *dev,
 	case DRM_MODE_CONNECTOR_SVIDEO:
 	case DRM_MODE_CONNECTOR_Composite:
 	case DRM_MODE_CONNECTOR_9PinDIN:
-		drm_connector_init(dev, &radeon_connector->base, &radeon_tv_connector_funcs, connector_type);
+		drm_connector_init_with_ddc(dev, &radeon_connector->base,
+					    &radeon_tv_connector_funcs,
+					    connector_type,
+					    ddc);
 		drm_connector_helper_add(&radeon_connector->base, &radeon_tv_connector_helper_funcs);
 		radeon_connector->dac_load_detect = true;
 		/* RS400,RC410,RS480 chipset seems to report a lot
@@ -2458,13 +2524,18 @@ radeon_add_legacy_connector(struct drm_device *dev,
 		connector->doublescan_allowed = false;
 		break;
 	case DRM_MODE_CONNECTOR_LVDS:
-		drm_connector_init(dev, &radeon_connector->base, &radeon_lvds_connector_funcs, connector_type);
-		drm_connector_helper_add(&radeon_connector->base, &radeon_lvds_connector_helper_funcs);
 		if (i2c_bus->valid) {
 			radeon_connector->ddc_bus = radeon_i2c_lookup(rdev, i2c_bus);
 			if (!radeon_connector->ddc_bus)
 				DRM_ERROR("LVDS: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+			else
+				ddc = &radeon_connector->ddc_bus->adapter;
 		}
+		drm_connector_init_with_ddc(dev, &radeon_connector->base,
+					    &radeon_lvds_connector_funcs,
+					    connector_type,
+					    ddc);
+		drm_connector_helper_add(&radeon_connector->base, &radeon_lvds_connector_helper_funcs);
 		drm_object_attach_property(&radeon_connector->base.base,
 					      dev->mode_config.scaling_mode_property,
 					      DRM_MODE_SCALE_FULLSCREEN);
-- 
2.17.1

