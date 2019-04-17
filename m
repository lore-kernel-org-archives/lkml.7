Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EAEC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C778B20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfDQHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:49 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43169 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbfDQHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:34 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C2C4F240006;
        Wed, 17 Apr 2019 07:55:29 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 11/20] drm/i915: Convert to generic image format library
Date:   Wed, 17 Apr 2019 09:54:37 +0200
Message-Id: <9561d4a4a7c95e0c10c58a3a57f7bde9190fe1e8.1555487650.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a generic image format libary, let's convert drivers to
use it so that we can deprecate the old DRM one.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/i915/intel_display.c | 4 ++--
 drivers/gpu/drm/i915/intel_pm.c      | 6 +++---
 drivers/gpu/drm/i915/intel_sprite.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 6a0c4f505593..c745e1172dc9 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -8094,7 +8094,7 @@ i9xx_get_initial_plane_config(struct intel_crtc *crtc,
 
 	pixel_format = val & DISPPLANE_PIXFORMAT_MASK;
 	fourcc = i9xx_format_to_fourcc(pixel_format);
-	fb->format = drm_format_info(fourcc);
+	fb->format = image_format_drm_lookup(fourcc);
 
 	if (IS_HASWELL(dev_priv) || IS_BROADWELL(dev_priv)) {
 		offset = I915_READ(DSPOFFSET(i9xx_plane));
@@ -9194,7 +9194,7 @@ skylake_get_initial_plane_config(struct intel_crtc *crtc,
 
 	fourcc = skl_format_to_fourcc(pixel_format,
 				      val & PLANE_CTL_ORDER_RGBX, alpha);
-	fb->format = drm_format_info(fourcc);
+	fb->format = image_format_drm_lookup(fourcc);
 
 	tiling = val & PLANE_CTL_TILED_MASK;
 	switch (tiling) {
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 7357bddf9ad9..3b490ea1baf0 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -3928,7 +3928,7 @@ skl_ddb_get_pipe_allocation_limits(struct drm_i915_private *dev_priv,
 }
 
 static int skl_compute_wm_params(const struct intel_crtc_state *crtc_state,
-				 int width, const struct drm_format_info *format,
+				 int width, const struct image_format_info *format,
 				 u64 modifier, unsigned int rotation,
 				 u32 plane_pixel_rate, struct skl_wm_params *wp,
 				 int color_plane);
@@ -3949,7 +3949,7 @@ skl_cursor_allocation(const struct intel_crtc_state *crtc_state,
 	struct skl_wm_params wp;
 
 	ret = skl_compute_wm_params(crtc_state, 256,
-				    drm_format_info(DRM_FORMAT_ARGB8888),
+				    image_format_drm_lookup(DRM_FORMAT_ARGB8888),
 				    DRM_FORMAT_MOD_LINEAR,
 				    DRM_MODE_ROTATE_0,
 				    crtc_state->pixel_rate, &wp, 0);
@@ -4644,7 +4644,7 @@ skl_adjusted_plane_pixel_rate(const struct intel_crtc_state *cstate,
 
 static int
 skl_compute_wm_params(const struct intel_crtc_state *crtc_state,
-		      int width, const struct drm_format_info *format,
+		      int width, const struct image_format_info *format,
 		      u64 modifier, unsigned int rotation,
 		      u32 plane_pixel_rate, struct skl_wm_params *wp,
 		      int color_plane)
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index e35601b1f878..152b58267671 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -325,8 +325,8 @@ skl_plane_max_stride(struct intel_plane *plane,
 		     u32 pixel_format, u64 modifier,
 		     unsigned int rotation)
 {
-	const struct drm_format_info *info = drm_format_info(pixel_format);
-	int cpp = drm_format_info_plane_cpp(info, 0);
+	const struct image_format_info *info = image_format_drm_lookup(pixel_format);
+	int cpp = image_format_info_plane_cpp(info, 0);
 
 	/*
 	 * "The stride in bytes must not exceed the
-- 
git-series 0.9.1
