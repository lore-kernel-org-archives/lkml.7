Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE98C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A60B207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfLCPGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:06:20 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48467 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:06:17 -0500
X-Originating-IP: 90.76.211.102
Received: from localhost.localdomain (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4611E1BF20F;
        Tue,  3 Dec 2019 15:06:13 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 3/3] WIP: drm/logicvc: Add plane colorkey support
Date:   Tue,  3 Dec 2019 16:06:06 +0100
Message-Id: <20191203150606.317062-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203150606.317062-1-paul.kocialkowski@bootlin.com>
References: <20191203150606.317062-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/logicvc/logicvc_drm.h   |   3 +
 drivers/gpu/drm/logicvc/logicvc_layer.c | 147 +++++++++++++++++++++++-
 drivers/gpu/drm/logicvc/logicvc_layer.h |   7 ++
 3 files changed, 153 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.h b/drivers/gpu/drm/logicvc/logicvc_drm.h
index cc728d5a4aee..52f3c09b9659 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.h
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.h
@@ -55,6 +55,9 @@ struct logicvc_drm {
 	struct list_head layers_list;
 	struct logicvc_crtc *crtc;
 	struct logicvc_interface *interface;
+
+	struct drm_property *colorkey_enabled_property;
+	struct drm_property *colorkey_value_property;
 };
 
 #endif
diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index c7b092d592ad..ce821781e148 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -22,6 +22,8 @@
 
 #define logicvc_layer(p) \
 	container_of(p, struct logicvc_layer, drm_plane)
+#define logicvc_layer_state(p) \
+	container_of(p, struct logicvc_layer_state, drm_plane_state)
 
 static uint32_t logicvc_layer_formats_rgb16[] = {
 	DRM_FORMAT_RGB565,
@@ -131,6 +133,7 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
 	struct logicvc_layer *layer = logicvc_layer(drm_plane);
 	struct logicvc_drm *logicvc = layer->logicvc;
 	struct drm_plane_state *state = drm_plane->state;
+	struct logicvc_layer_state *layer_state = logicvc_layer_state(state);
 	struct drm_crtc *drm_crtc = &logicvc->crtc->drm_crtc;
 	struct drm_display_mode *mode = &drm_crtc->state->adjusted_mode;
 	struct drm_framebuffer *fb = state->fb;
@@ -206,6 +209,15 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
 			     alpha);
 	}
 
+	/* Layer colorkey */
+
+	if (layer_state->colorkey_enabled) {
+		reg = layer_state->colorkey_value;
+
+		regmap_write(logicvc->regmap,
+			     LOGICVC_LAYER_COLOR_KEY_REG(index), reg);
+	}
+
 	/* Layer control */
 
 	reg = LOGICVC_LAYER_CTRL_ENABLE;
@@ -213,7 +225,8 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
 	if (logicvc_layer_format_inverted(fb->format->format))
 		reg |= LOGICVC_LAYER_CTRL_PIXEL_FORMAT_INVERT;
 
-	reg |= LOGICVC_LAYER_CTRL_COLOR_KEY_DISABLE;
+	if (!layer_state->colorkey_enabled)
+		reg |= LOGICVC_LAYER_CTRL_COLOR_KEY_DISABLE;
 
 	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), reg);
 }
@@ -234,13 +247,112 @@ static struct drm_plane_helper_funcs logicvc_plane_helper_funcs = {
 	.atomic_disable		= logicvc_plane_atomic_disable,
 };
 
+static void logicvc_plane_reset(struct drm_plane *drm_plane)
+{
+	struct logicvc_layer *layer = logicvc_layer(drm_plane);
+	struct logicvc_drm *logicvc = layer->logicvc;
+	struct logicvc_layer_state *layer_state;
+
+	if (drm_plane->state) {
+		layer_state = logicvc_layer_state(drm_plane->state);
+		__drm_atomic_helper_plane_destroy_state(drm_plane->state);
+		devm_kfree(logicvc->drm->dev, layer_state);
+		drm_plane->state = NULL;
+	}
+
+	layer_state = devm_kzalloc(logicvc->drm->dev, sizeof(*layer_state),
+				   GFP_KERNEL);
+	if (!layer_state)
+		return;
+
+	__drm_atomic_helper_plane_reset(drm_plane,
+					&layer_state->drm_plane_state);
+}
+
+static struct drm_plane_state *logicvc_plane_atomic_duplicate_state(struct drm_plane *drm_plane)
+{
+	struct logicvc_layer *layer = logicvc_layer(drm_plane);
+	struct logicvc_drm *logicvc = layer->logicvc;
+	struct logicvc_layer_state *layer_state_current;
+	struct logicvc_layer_state *layer_state;
+
+	if (WARN_ON(!drm_plane->state))
+		return NULL;
+
+	layer_state_current = logicvc_layer_state(drm_plane->state);
+	layer_state = devm_kzalloc(logicvc->drm->dev, sizeof(*layer_state),
+				   GFP_KERNEL);
+	if (!layer_state)
+		return NULL;
+
+	layer_state->colorkey_enabled = layer_state_current->colorkey_enabled;
+	layer_state->colorkey_value = layer_state_current->colorkey_value;
+
+	__drm_atomic_helper_plane_duplicate_state(drm_plane,
+						  &layer_state->drm_plane_state);
+
+	return &layer_state->drm_plane_state;
+}
+
+static void logicvc_plane_destroy_state(struct drm_plane *drm_plane,
+					struct drm_plane_state *state)
+{
+	struct logicvc_layer *layer = logicvc_layer(drm_plane);
+	struct logicvc_drm *logicvc = layer->logicvc;
+	struct logicvc_layer_state *layer_state = logicvc_layer_state(state);
+
+	__drm_atomic_helper_plane_destroy_state(&layer_state->drm_plane_state);
+
+	devm_kfree(logicvc->drm->dev, layer_state);
+}
+
+static int logicvc_plane_atomic_set_property(struct drm_plane *drm_plane,
+					     struct drm_plane_state *state,
+					     struct drm_property *property,
+					     uint64_t value)
+{
+	struct logicvc_layer *layer = logicvc_layer(drm_plane);
+	struct logicvc_drm *logicvc = layer->logicvc;
+	struct logicvc_layer_state *layer_state = logicvc_layer_state(state);
+
+	if (property == logicvc->colorkey_enabled_property)
+		layer_state->colorkey_enabled = !!value;
+	else if (property == logicvc->colorkey_value_property)
+		layer_state->colorkey_value = (uint32_t)value;
+	else
+		return -ENOENT;
+
+	return 0;
+}
+
+static int logicvc_plane_atomic_get_property(struct drm_plane *drm_plane,
+					     const struct drm_plane_state *state,
+					     struct drm_property *property,
+					     uint64_t *value)
+{
+	struct logicvc_layer *layer = logicvc_layer(drm_plane);
+	struct logicvc_drm *logicvc = layer->logicvc;
+	struct logicvc_layer_state *layer_state = logicvc_layer_state(state);
+
+	if (property == logicvc->colorkey_enabled_property)
+		*value = layer_state->colorkey_enabled;
+	else if (property == logicvc->colorkey_value_property)
+		*value = layer_state->colorkey_value;
+	else
+		return -ENOENT;
+
+	return 0;
+}
+
 static const struct drm_plane_funcs logicvc_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
-	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
-	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	.reset			= logicvc_plane_reset,
+	.atomic_duplicate_state	= logicvc_plane_atomic_duplicate_state,
+	.atomic_destroy_state	= logicvc_plane_destroy_state,
+	.atomic_set_property	= logicvc_plane_atomic_set_property,
+	.atomic_get_property	= logicvc_plane_atomic_get_property,
 };
 
 int logicvc_layer_buffer_find_setup(struct logicvc_layer *layer,
@@ -508,6 +620,11 @@ static int logicvc_layer_init(struct logicvc_drm *logicvc,
 
 	drm_plane_create_zpos_immutable_property(&layer->drm_plane, zpos);
 
+	drm_object_attach_property(&layer->drm_plane.base,
+				   logicvc->colorkey_enabled_property, 0);
+	drm_object_attach_property(&layer->drm_plane.base,
+				   logicvc->colorkey_value_property, 0);
+
 	DRM_DEBUG_DRIVER("Registering layer #%d\n", index);
 
 	layer->formats = formats;
@@ -545,6 +662,7 @@ void logicvc_layers_attach_crtc(struct logicvc_drm *logicvc)
 
 int logicvc_layers_init(struct logicvc_drm *logicvc)
 {
+	struct drm_device *drm = logicvc->drm;
 	struct device_node *of_node = logicvc->drm->dev->of_node;
 	struct device_node *layer_node = NULL;
 	struct device_node *layers_node;
@@ -552,6 +670,17 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 	struct logicvc_layer *next;
 	int ret = 0;
 
+	logicvc->colorkey_enabled_property =
+		drm_property_create_bool(drm, 0, "colorkey_enabled");
+	if (!logicvc->colorkey_enabled_property)
+		goto error;
+
+	logicvc->colorkey_value_property =
+		drm_property_create_range(drm, 0, "colorkey_value",
+					  0, 0xffffffff);
+	if (!logicvc->colorkey_value_property)
+		goto error;
+
 	layers_node = of_get_child_by_name(of_node, "layers");
 	if (!layers_node) {
 		DRM_ERROR("No layers node found in the description\n");
@@ -590,5 +719,15 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 	list_for_each_entry_safe(layer, next, &logicvc->layers_list, list)
 		logicvc_layer_fini(logicvc, layer);
 
+	if (logicvc->colorkey_value_property) {
+		drm_property_destroy(drm, logicvc->colorkey_value_property);
+		logicvc->colorkey_value_property = NULL;
+	}
+
+	if (logicvc->colorkey_enabled_property) {
+		drm_property_destroy(drm, logicvc->colorkey_enabled_property);
+		logicvc->colorkey_enabled_property = NULL;
+	}
+
 	return ret;
 }
diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.h b/drivers/gpu/drm/logicvc/logicvc_layer.h
index 71b3f177b093..2fb161217081 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.h
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.h
@@ -39,6 +39,13 @@ struct logicvc_layer_formats {
 	uint32_t *formats;
 };
 
+struct logicvc_layer_state {
+	struct drm_plane_state drm_plane_state;
+
+	bool colorkey_enabled;
+	uint32_t colorkey_value;
+};
+
 struct logicvc_layer {
 	struct logicvc_drm *logicvc;
 
-- 
2.24.0

