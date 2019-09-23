Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D772AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9541920820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439567AbfIWMqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:46:13 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:40908 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfIWMqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:46:13 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Sep 2019 08:46:02 EDT
Received: from hjc?rock-chips.com (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id DC29D36A;
        Mon, 23 Sep 2019 20:40:02 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P10893T140454720919296S1569242369031174_;
        Mon, 23 Sep 2019 20:40:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0fd37b72fe62d59ebbe910ed58dc72ff>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Sandy Huang <hjc@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lyude Paul <lyude@redhat.com>, Dave Airlie <airlied@redhat.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/36] drm/i915: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:38:52 +0800
Message-Id: <1569242365-182133-4-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242365-182133-1-git-send-email-hjc@rock-chips.com>
References: <1569242365-182133-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/i915/display/intel_atomic_plane.c |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c      | 28 +++++++++++------------
 drivers/gpu/drm/i915/display/intel_fbc.c          |  8 +++----
 drivers/gpu/drm/i915/display/intel_fbdev.c        |  6 ++---
 drivers/gpu/drm/i915/display/intel_sprite.c       |  4 ++--
 drivers/gpu/drm/i915/i915_debugfs.c               |  4 ++--
 drivers/gpu/drm/i915/intel_pm.c                   | 28 +++++++++++------------
 7 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 30bd4e7..2e93234 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -123,7 +123,7 @@ unsigned int intel_plane_data_rate(const struct intel_crtc_state *crtc_state,
 	if (!plane_state->base.visible)
 		return 0;
 
-	cpp = fb->format->cpp[0];
+	cpp = fb->format->bpp[0] / 8;
 
 	/*
 	 * Based on HSD#:1408715493
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 21c71fd..732db3f 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1912,7 +1912,7 @@ static unsigned int
 intel_tile_width_bytes(const struct drm_framebuffer *fb, int color_plane)
 {
 	struct drm_i915_private *dev_priv = to_i915(fb->dev);
-	unsigned int cpp = fb->format->cpp[color_plane];
+	unsigned int cpp = fb->format->bpp[color_plane] / 8;
 
 	switch (fb->modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
@@ -1969,7 +1969,7 @@ static void intel_tile_dims(const struct drm_framebuffer *fb, int color_plane,
 			    unsigned int *tile_height)
 {
 	unsigned int tile_width_bytes = intel_tile_width_bytes(fb, color_plane);
-	unsigned int cpp = fb->format->cpp[color_plane];
+	unsigned int cpp = fb->format->bpp[color_plane] / 8;
 
 	*tile_width = tile_width_bytes / cpp;
 	*tile_height = intel_tile_size(to_i915(fb->dev)) / tile_width_bytes;
@@ -2207,7 +2207,7 @@ u32 intel_fb_xy_to_linear(int x, int y,
 			  int color_plane)
 {
 	const struct drm_framebuffer *fb = state->base.fb;
-	unsigned int cpp = fb->format->cpp[color_plane];
+	unsigned int cpp = fb->format->bpp[color_plane] / 8;
 	unsigned int pitch = state->color_plane[color_plane].stride;
 
 	return y * pitch + x * cpp;
@@ -2267,7 +2267,7 @@ static u32 intel_adjust_aligned_offset(int *x, int *y,
 				       u32 old_offset, u32 new_offset)
 {
 	struct drm_i915_private *dev_priv = to_i915(fb->dev);
-	unsigned int cpp = fb->format->cpp[color_plane];
+	unsigned int cpp = fb->format->bpp[color_plane] / 8;
 
 	WARN_ON(new_offset > old_offset);
 
@@ -2335,7 +2335,7 @@ static u32 intel_compute_aligned_offset(struct drm_i915_private *dev_priv,
 					unsigned int rotation,
 					u32 alignment)
 {
-	unsigned int cpp = fb->format->cpp[color_plane];
+	unsigned int cpp = fb->format->bpp[color_plane] / 8;
 	u32 offset, offset_aligned;
 
 	if (alignment)
@@ -2655,7 +2655,7 @@ intel_fill_fb_info(struct drm_i915_private *dev_priv,
 		int x, y;
 		int ret;
 
-		cpp = fb->format->cpp[i];
+		cpp = fb->format->bpp[i] / 8;
 		width = drm_framebuffer_plane_width(fb->width, fb, i);
 		height = drm_framebuffer_plane_height(fb->height, fb, i);
 
@@ -2840,7 +2840,7 @@ intel_plane_remap_gtt(struct intel_plane_state *plane_state)
 	for (i = 0; i < num_planes; i++) {
 		unsigned int hsub = i ? fb->format->hsub : 1;
 		unsigned int vsub = i ? fb->format->vsub : 1;
-		unsigned int cpp = fb->format->cpp[i];
+		unsigned int cpp = fb->format->bpp[i] / 8;
 		unsigned int tile_width, tile_height;
 		unsigned int width, height;
 		unsigned int pitch_tiles;
@@ -3286,7 +3286,7 @@ static int skl_max_plane_width(const struct drm_framebuffer *fb,
 			       int color_plane,
 			       unsigned int rotation)
 {
-	int cpp = fb->format->cpp[color_plane];
+	int cpp = fb->format->bpp[color_plane] / 8;
 
 	switch (fb->modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
@@ -3311,7 +3311,7 @@ static int glk_max_plane_width(const struct drm_framebuffer *fb,
 			       int color_plane,
 			       unsigned int rotation)
 {
-	int cpp = fb->format->cpp[color_plane];
+	int cpp = fb->format->bpp[color_plane] / 8;
 
 	switch (fb->modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
@@ -3426,7 +3426,7 @@ static int skl_check_main_surface(struct intel_plane_state *plane_state)
 	 * TODO: linear and Y-tiled seem fine, Yf untested,
 	 */
 	if (fb->modifier == I915_FORMAT_MOD_X_TILED) {
-		int cpp = fb->format->cpp[0];
+		int cpp = fb->format->bpp[0] / 8;
 
 		while ((x + w) * cpp > plane_state->color_plane[0].stride) {
 			if (offset == 0) {
@@ -8513,7 +8513,7 @@ i9xx_get_initial_plane_config(struct intel_crtc *crtc,
 
 	DRM_DEBUG_KMS("%s/%s with fb: size=%dx%d@%d, offset=%x, pitch %d, size 0x%x\n",
 		      crtc->base.name, plane->base.name, fb->width, fb->height,
-		      fb->format->cpp[0] * 8, base, fb->pitches[0],
+		      fb->format->bpp[0], base, fb->pitches[0],
 		      plane_config->size);
 
 	plane_config->fb = intel_fb;
@@ -9753,7 +9753,7 @@ skylake_get_initial_plane_config(struct intel_crtc *crtc,
 
 	DRM_DEBUG_KMS("%s/%s with fb: size=%dx%d@%d, offset=%x, pitch %d, size 0x%x\n",
 		      crtc->base.name, plane->base.name, fb->width, fb->height,
-		      fb->format->cpp[0] * 8, base, fb->pitches[0],
+		      fb->format->bpp[0], base, fb->pitches[0],
 		      plane_config->size);
 
 	plane_config->fb = intel_fb;
@@ -10350,7 +10350,7 @@ static u32 intel_cursor_base(const struct intel_plane_state *plane_state)
 	if (HAS_GMCH(dev_priv) &&
 	    plane_state->base.rotation & DRM_MODE_ROTATE_180)
 		base += (plane_state->base.crtc_h *
-			 plane_state->base.crtc_w - 1) * fb->format->cpp[0];
+			 plane_state->base.crtc_w - 1) * fb->format->bpp[0] / 8;
 
 	return base;
 }
@@ -10728,7 +10728,7 @@ static int i9xx_check_cursor(struct intel_crtc_state *crtc_state,
 	WARN_ON(plane_state->base.visible &&
 		plane_state->color_plane[0].stride != fb->pitches[0]);
 
-	if (fb->pitches[0] != plane_state->base.crtc_w * fb->format->cpp[0]) {
+	if (fb->pitches[0] != plane_state->base.crtc_w * fb->format->bpp[0] / 8) {
 		DRM_DEBUG_KMS("Invalid cursor stride (%u) (cursor width %d)\n",
 			      fb->pitches[0], plane_state->base.crtc_w);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index d36cada..7911c49 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -172,7 +172,7 @@ static void g4x_fbc_activate(struct drm_i915_private *dev_priv)
 	u32 dpfc_ctl;
 
 	dpfc_ctl = DPFC_CTL_PLANE(params->crtc.i9xx_plane) | DPFC_SR_EN;
-	if (params->fb.format->cpp[0] == 2)
+	if (params->fb.format->bpp[0] == 16)
 		dpfc_ctl |= DPFC_CTL_LIMIT_2X;
 	else
 		dpfc_ctl |= DPFC_CTL_LIMIT_1X;
@@ -219,7 +219,7 @@ static void ilk_fbc_activate(struct drm_i915_private *dev_priv)
 	int threshold = dev_priv->fbc.threshold;
 
 	dpfc_ctl = DPFC_CTL_PLANE(params->crtc.i9xx_plane);
-	if (params->fb.format->cpp[0] == 2)
+	if (params->fb.format->bpp[0] == 16)
 		threshold++;
 
 	switch (threshold) {
@@ -302,7 +302,7 @@ static void gen7_fbc_activate(struct drm_i915_private *dev_priv)
 	if (IS_IVYBRIDGE(dev_priv))
 		dpfc_ctl |= IVB_DPFC_CTL_PLANE(params->crtc.i9xx_plane);
 
-	if (params->fb.format->cpp[0] == 2)
+	if (params->fb.format->bpp[0] == 16)
 		threshold++;
 
 	switch (threshold) {
@@ -498,7 +498,7 @@ static int intel_fbc_alloc_cfb(struct intel_crtc *crtc)
 	WARN_ON(drm_mm_node_allocated(&fbc->compressed_fb));
 
 	size = intel_fbc_calculate_cfb_size(dev_priv, &fbc->state_cache);
-	fb_cpp = fbc->state_cache.fb.format->cpp[0];
+	fb_cpp = fbc->state_cache.fb.format->bpp[0] / 8;
 
 	ret = find_compression_threshold(dev_priv, &fbc->compressed_fb,
 					 size, fb_cpp);
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 1edd44e..ae98063 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -373,7 +373,7 @@ static bool intel_fbdev_init_bios(struct drm_device *dev,
 		 * rather than the current pipe's, since they differ.
 		 */
 		cur_size = crtc->state->adjusted_mode.crtc_hdisplay;
-		cur_size = cur_size * fb->base.format->cpp[0];
+		cur_size = cur_size * fb->base.format->bpp[0] / 8;
 		if (fb->base.pitches[0] < cur_size) {
 			DRM_DEBUG_KMS("fb not wide enough for plane %c (%d vs %d)\n",
 				      pipe_name(intel_crtc->pipe),
@@ -389,7 +389,7 @@ static bool intel_fbdev_init_bios(struct drm_device *dev,
 			      pipe_name(intel_crtc->pipe),
 			      crtc->state->adjusted_mode.crtc_hdisplay,
 			      crtc->state->adjusted_mode.crtc_vdisplay,
-			      fb->base.format->cpp[0] * 8,
+			      fb->base.format->bpp[0],
 			      cur_size);
 
 		if (cur_size > max_size) {
@@ -410,7 +410,7 @@ static bool intel_fbdev_init_bios(struct drm_device *dev,
 		goto out;
 	}
 
-	ifbdev->preferred_bpp = fb->base.format->cpp[0] * 8;
+	ifbdev->preferred_bpp = fb->base.format->bpp[0];
 	ifbdev->fb = fb;
 
 	drm_framebuffer_get(&ifbdev->fb->base);
diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
index 004b520..bdcdbe4 100644
--- a/drivers/gpu/drm/i915/display/intel_sprite.c
+++ b/drivers/gpu/drm/i915/display/intel_sprite.c
@@ -336,7 +336,7 @@ skl_plane_max_stride(struct intel_plane *plane,
 		     unsigned int rotation)
 {
 	const struct drm_format_info *info = drm_format_info(pixel_format);
-	int cpp = info->cpp[0];
+	int cpp = info->bpp[0] / 8;
 
 	/*
 	 * "The stride in bytes must not exceed the
@@ -1350,7 +1350,7 @@ g4x_sprite_check_scaling(struct intel_crtc_state *crtc_state,
 	int src_x, src_y, src_w, src_h, crtc_w, crtc_h;
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->base.adjusted_mode;
-	unsigned int cpp = fb->format->cpp[0];
+	unsigned int cpp = fb->format->bpp[0] / 8;
 	unsigned int width_bytes;
 	int min_width, min_height;
 
diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 62cf34d..a51ed85 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -1631,7 +1631,7 @@ static int i915_gem_framebuffer_info(struct seq_file *m, void *data)
 			   fbdev_fb->base.width,
 			   fbdev_fb->base.height,
 			   fbdev_fb->base.format->depth,
-			   fbdev_fb->base.format->cpp[0] * 8,
+			   fbdev_fb->base.format->bpp[0],
 			   fbdev_fb->base.modifier,
 			   drm_framebuffer_read_refcount(&fbdev_fb->base));
 		describe_obj(m, intel_fb_obj(&fbdev_fb->base));
@@ -1649,7 +1649,7 @@ static int i915_gem_framebuffer_info(struct seq_file *m, void *data)
 			   fb->base.width,
 			   fb->base.height,
 			   fb->base.format->depth,
-			   fb->base.format->cpp[0] * 8,
+			   fb->base.format->bpp[0],
 			   fb->base.modifier,
 			   drm_framebuffer_read_refcount(&fb->base));
 		describe_obj(m, intel_fb_obj(&fb->base));
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index d9a7a13..a70b372 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -873,7 +873,7 @@ static void pineview_update_wm(struct intel_crtc *unused_crtc)
 			&crtc->config->base.adjusted_mode;
 		const struct drm_framebuffer *fb =
 			crtc->base.primary->state->fb;
-		int cpp = fb->format->cpp[0];
+		int cpp = fb->format->bpp[0] / 8;
 		int clock = adjusted_mode->crtc_clock;
 
 		/* Display SR */
@@ -1131,7 +1131,7 @@ static u16 g4x_compute_wm(const struct intel_crtc_state *crtc_state,
 	    level != G4X_WM_LEVEL_NORMAL)
 		cpp = 4;
 	else
-		cpp = plane_state->base.fb->format->cpp[0];
+		cpp = plane_state->base.fb->format->bpp[0] / 8;
 
 	clock = adjusted_mode->crtc_clock;
 	htotal = adjusted_mode->crtc_htotal;
@@ -1624,7 +1624,7 @@ static u16 vlv_compute_wm_level(const struct intel_crtc_state *crtc_state,
 	if (!intel_wm_plane_visible(crtc_state, plane_state))
 		return 0;
 
-	cpp = plane_state->base.fb->format->cpp[0];
+	cpp = plane_state->base.fb->format->bpp[0] / 8;
 	clock = adjusted_mode->crtc_clock;
 	htotal = adjusted_mode->crtc_htotal;
 	width = crtc_state->pipe_src_w;
@@ -2216,7 +2216,7 @@ static void i965_update_wm(struct intel_crtc *unused_crtc)
 		int clock = adjusted_mode->crtc_clock;
 		int htotal = adjusted_mode->crtc_htotal;
 		int hdisplay = crtc->config->pipe_src_w;
-		int cpp = fb->format->cpp[0];
+		int cpp = fb->format->bpp[0] / 8;
 		int entries;
 
 		entries = intel_wm_method2(clock, htotal,
@@ -2299,7 +2299,7 @@ static void i9xx_update_wm(struct intel_crtc *unused_crtc)
 		if (IS_GEN(dev_priv, 2))
 			cpp = 4;
 		else
-			cpp = fb->format->cpp[0];
+			cpp = fb->format->bpp[0] / 8;
 
 		planea_wm = intel_calculate_wm(adjusted_mode->crtc_clock,
 					       wm_info, fifo_size, cpp,
@@ -2326,7 +2326,7 @@ static void i9xx_update_wm(struct intel_crtc *unused_crtc)
 		if (IS_GEN(dev_priv, 2))
 			cpp = 4;
 		else
-			cpp = fb->format->cpp[0];
+			cpp = fb->format->bpp[0] / 8;
 
 		planeb_wm = intel_calculate_wm(adjusted_mode->crtc_clock,
 					       wm_info, fifo_size, cpp,
@@ -2378,7 +2378,7 @@ static void i9xx_update_wm(struct intel_crtc *unused_crtc)
 		if (IS_I915GM(dev_priv) || IS_I945GM(dev_priv))
 			cpp = 4;
 		else
-			cpp = fb->format->cpp[0];
+			cpp = fb->format->bpp[0] / 8;
 
 		entries = intel_wm_method2(clock, htotal, hdisplay, cpp,
 					   sr_latency_ns / 100);
@@ -2506,7 +2506,7 @@ static u32 ilk_compute_pri_wm(const struct intel_crtc_state *cstate,
 	if (!intel_wm_plane_visible(cstate, pstate))
 		return 0;
 
-	cpp = pstate->base.fb->format->cpp[0];
+	cpp = pstate->base.fb->format->bpp[0] / 8;
 
 	method1 = ilk_wm_method1(cstate->pixel_rate, cpp, mem_value);
 
@@ -2538,7 +2538,7 @@ static u32 ilk_compute_spr_wm(const struct intel_crtc_state *cstate,
 	if (!intel_wm_plane_visible(cstate, pstate))
 		return 0;
 
-	cpp = pstate->base.fb->format->cpp[0];
+	cpp = pstate->base.fb->format->bpp[0] / 8;
 
 	method1 = ilk_wm_method1(cstate->pixel_rate, cpp, mem_value);
 	method2 = ilk_wm_method2(cstate->pixel_rate,
@@ -2564,7 +2564,7 @@ static u32 ilk_compute_cur_wm(const struct intel_crtc_state *cstate,
 	if (!intel_wm_plane_visible(cstate, pstate))
 		return 0;
 
-	cpp = pstate->base.fb->format->cpp[0];
+	cpp = pstate->base.fb->format->bpp[0] / 8;
 
 	return ilk_wm_method2(cstate->pixel_rate,
 			      cstate->base.adjusted_mode.crtc_htotal,
@@ -2581,7 +2581,7 @@ static u32 ilk_compute_fbc_wm(const struct intel_crtc_state *cstate,
 	if (!intel_wm_plane_visible(cstate, pstate))
 		return 0;
 
-	cpp = pstate->base.fb->format->cpp[0];
+	cpp = pstate->base.fb->format->bpp[0] / 8;
 
 	return ilk_wm_fbc(pri_val, drm_rect_width(&pstate->base.dst), cpp);
 }
@@ -4168,7 +4168,7 @@ int skl_check_pipe_max_pixel_rate(struct intel_crtc *intel_crtc,
 		intel_pstate = to_intel_plane_state(pstate);
 		plane_downscale = skl_plane_downscale_amount(cstate,
 							     intel_pstate);
-		bpp = pstate->fb->format->cpp[0] * 8;
+		bpp = pstate->fb->format->bpp[0];
 		if (bpp == 64)
 			plane_downscale = mul_fixed16(plane_downscale,
 						      fp_9_div_8);
@@ -4240,7 +4240,7 @@ skl_plane_relative_data_rate(const struct intel_crtc_state *cstate,
 
 	rate = mul_round_up_u32_fixed16(data_rate, down_scale_amount);
 
-	rate *= fb->format->cpp[plane];
+	rate *= fb->format->bpp[plane] / 8;
 	return rate;
 }
 
@@ -4671,7 +4671,7 @@ skl_compute_wm_params(const struct intel_crtc_state *crtc_state,
 	if (color_plane == 1 && wp->is_planar)
 		wp->width /= 2;
 
-	wp->cpp = format->cpp[color_plane];
+	wp->cpp = format->bpp[color_plane] / 8;
 	wp->plane_pixel_rate = plane_pixel_rate;
 
 	if (INTEL_GEN(dev_priv) >= 11 &&
-- 
2.7.4



