Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62A3C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597EF20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfDQHz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:29 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52115 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbfDQHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:25 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BA820200012;
        Wed, 17 Apr 2019 07:55:19 +0000 (UTC)
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
Subject: [PATCH 07/20] drm/fb: Move from drm_format_info to image_format_info
Date:   Wed, 17 Apr 2019 09:54:33 +0200
Message-Id: <edd86c9ab073f426da9f36a6b8523401da671f3c.1555487650.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start converting the DRM drivers by changing the struct drm_framebuffer
structure to hold a pointer to image_format_info instead, and converting
everyone that depends on it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/Kconfig                         |  1 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c          |  4 ++--
 drivers/gpu/drm/arm/malidp_drv.c                |  2 +-
 drivers/gpu/drm/arm/malidp_planes.c             |  8 ++++----
 drivers/gpu/drm/armada/armada_fb.c              |  2 +-
 drivers/gpu/drm/armada/armada_overlay.c         |  2 +-
 drivers/gpu/drm/armada/armada_plane.c           |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c |  2 +-
 drivers/gpu/drm/bochs/bochs.h                   |  4 +++-
 drivers/gpu/drm/bochs/bochs_hw.c                |  2 +-
 drivers/gpu/drm/drm_fb_cma_helper.c             |  4 ++--
 drivers/gpu/drm/drm_fb_helper.c                 | 14 +++++++-------
 drivers/gpu/drm/drm_format_helper.c             |  4 ++--
 drivers/gpu/drm/drm_fourcc.c                    |  8 ++++----
 drivers/gpu/drm/drm_framebuffer.c               | 10 +++++-----
 drivers/gpu/drm/drm_gem_framebuffer_helper.c    |  4 ++--
 drivers/gpu/drm/exynos/exynos_drm_fb.c          |  2 +-
 drivers/gpu/drm/gma500/framebuffer.c            |  2 +-
 drivers/gpu/drm/i915/i915_drv.h                 |  6 ++++--
 drivers/gpu/drm/i915/intel_display.c            | 10 +++++-----
 drivers/gpu/drm/imx/ipuv3-plane.c               |  4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_fb.c           |  6 +++---
 drivers/gpu/drm/meson/meson_overlay.c           | 12 ++++++------
 drivers/gpu/drm/msm/msm_fb.c                    | 10 +++++-----
 drivers/gpu/drm/omapdrm/omap_fb.c               |  6 +++---
 drivers/gpu/drm/radeon/radeon_fb.c              |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c      |  6 +++---
 drivers/gpu/drm/stm/ltdc.c                      |  2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c           |  6 +++---
 drivers/gpu/drm/sun4i/sun4i_frontend.c          | 18 +++++++++---------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c          |  4 ++--
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c         |  6 ++++--
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h         |  5 +++--
 drivers/gpu/drm/tegra/fb.c                      |  4 ++--
 drivers/gpu/drm/zte/zx_plane.c                  |  2 +-
 include/drm/drm_fourcc.h                        |  4 +++-
 include/drm/drm_framebuffer.h                   |  4 ++--
 include/drm/drm_mode_config.h                   |  5 +++--
 38 files changed, 106 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 39d5f7562f1c..a5bef1c83e7f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -12,6 +12,7 @@ menuconfig DRM
 	select FB_CMDLINE
 	select I2C
 	select I2C_ALGOBIT
+	select IMAGE_FORMATS
 	select DMA_SHARED_BUFFER
 	select SYNC_FILE
 	help
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 6edae6458be8..159b8d792102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -121,7 +121,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 					 struct drm_mode_fb_cmd2 *mode_cmd,
 					 struct drm_gem_object **gobj_p)
 {
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	struct amdgpu_device *adev = rfbdev->adev;
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
@@ -133,7 +133,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 	u32 cpp;
 
 	info = drm_get_format_info(adev->ddev, mode_cmd);
-	cpp = drm_format_info_plane_cpp(info, 0);
+	cpp = image_format_info_plane_cpp(info, 0);
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = amdgpu_align_pitch(adev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 21725c9b9f5e..9e5240c2d5c7 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -294,7 +294,7 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
 				    const struct drm_mode_fb_cmd2 *mode_cmd)
 {
 	int n_superblocks = 0;
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	struct drm_gem_object *objs = NULL;
 	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
 	u32 afbc_superblock_width = 0, afbc_size = 0;
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 361c02988375..9874f98f2aa5 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -529,7 +529,7 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 	for (i = 0; i < ms->n_planes; i++) {
 		u8 alignment = malidp_hw_get_pitch_align(mp->hwdev, rotated);
 
-		if (((fb->pitches[i] * drm_format_info_block_height(fb->format, i))
+		if (((fb->pitches[i] * image_format_info_block_height(fb->format, i))
 				& (alignment - 1)) && !(fb->modifier)) {
 			DRM_DEBUG_KMS("Invalid pitch %u for plane %d\n",
 				      fb->pitches[i], i);
@@ -537,8 +537,8 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 		}
 	}
 
-	block_w = drm_format_info_block_width(fb->format, 0);
-	block_h = drm_format_info_block_height(fb->format, 0);
+	block_w = image_format_info_block_width(fb->format, 0);
+	block_h = image_format_info_block_height(fb->format, 0);
 	if (fb->width % block_w || fb->height % block_h) {
 		DRM_DEBUG_KMS("Buffer width/height needs to be a multiple of tile sizes");
 		return -EINVAL;
@@ -633,7 +633,7 @@ static void malidp_de_set_plane_pitches(struct malidp_plane *mp,
 	 * in a tile.
 	 */
 	for (i = 0; i < num_strides; ++i) {
-		unsigned int block_h = drm_format_info_block_height(mp->base.state->fb->format, i);
+		unsigned int block_h = image_format_info_block_height(mp->base.state->fb->format, i);
 
 		malidp_hw_write(mp->hwdev, pitches[i] * block_h,
 				mp->layer->base +
diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index a2f6472eb482..10e9ab534658 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -87,7 +87,7 @@ struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
 struct drm_framebuffer *armada_fb_create(struct drm_device *dev,
 	struct drm_file *dfile, const struct drm_mode_fb_cmd2 *mode)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev, mode);
+	const struct image_format_info *info = drm_get_format_info(dev, mode);
 	struct armada_gem_object *obj;
 	struct armada_framebuffer *dfb;
 	int ret;
diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 8d770641fcc4..1acb026b2c6b 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -107,7 +107,7 @@ static void armada_drm_overlay_plane_atomic_update(struct drm_plane *plane,
 	if (old_state->src.x1 != state->src.x1 ||
 	    old_state->src.y1 != state->src.y1 ||
 	    old_state->fb != state->fb) {
-		const struct drm_format_info *format;
+		const struct image_format_info *format;
 		u16 src_x, pitches[3];
 		u32 addrs[2][3];
 
diff --git a/drivers/gpu/drm/armada/armada_plane.c b/drivers/gpu/drm/armada/armada_plane.c
index 9f36423dd394..2e32fb2ccfb8 100644
--- a/drivers/gpu/drm/armada/armada_plane.c
+++ b/drivers/gpu/drm/armada/armada_plane.c
@@ -39,7 +39,7 @@ void armada_drm_plane_calc(struct drm_plane_state *state, u32 addrs[2][3],
 	u16 pitches[3], bool interlaced)
 {
 	struct drm_framebuffer *fb = state->fb;
-	const struct drm_format_info *format = fb->format;
+	const struct image_format_info *format = fb->format;
 	unsigned int num_planes = format->num_planes;
 	unsigned int x = state->src.x1 >> 16;
 	unsigned int y = state->src.y1 >> 16;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index fdd607ad27fe..abaa9ebe5f34 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -360,7 +360,7 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
 {
 	unsigned int cfg = ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 | state->ahb_id;
 	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
-	const struct drm_format_info *format = state->base.fb->format;
+	const struct image_format_info *format = state->base.fb->format;
 
 	/*
 	 * Rotation optimization is not working on RGB888 (rotation is still
diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 341cc9d1bab4..20b0a56af5ff 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -107,6 +107,8 @@ static inline u64 bochs_bo_mmap_offset(struct bochs_bo *bo)
 
 /* ---------------------------------------------------------------------- */
 
+struct image_format_info;
+
 /* bochs_hw.c */
 int bochs_hw_init(struct drm_device *dev);
 void bochs_hw_fini(struct drm_device *dev);
@@ -114,7 +116,7 @@ void bochs_hw_fini(struct drm_device *dev);
 void bochs_hw_setmode(struct bochs_device *bochs,
 		      struct drm_display_mode *mode);
 void bochs_hw_setformat(struct bochs_device *bochs,
-			const struct drm_format_info *format);
+			const struct image_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
 		      int x, int y, u64 addr);
 int bochs_hw_load_edid(struct bochs_device *bochs);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 3e04b2f0ec08..1ef1179fd6e8 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -234,7 +234,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 }
 
 void bochs_hw_setformat(struct bochs_device *bochs,
-			const struct drm_format_info *format)
+			const struct image_format_info *format)
 {
 	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
 			 (format->format >>  0) & 0xff,
diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 5f8074ffe7d9..52d1639faed1 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -74,8 +74,8 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
 	struct drm_gem_cma_object *obj;
 	dma_addr_t paddr;
 	u8 h_div = 1, v_div = 1;
-	u32 block_w = drm_format_info_block_width(fb->format, plane);
-	u32 block_h = drm_format_info_block_height(fb->format, plane);
+	u32 block_w = image_format_info_block_width(fb->format, plane);
+	u32 block_h = image_format_info_block_height(fb->format, plane);
 	u32 block_size = fb->format->char_per_block[plane];
 	u32 sample_x;
 	u32 sample_y;
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 4fcbb9caaf68..c28060af95f0 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -767,7 +767,7 @@ static void drm_fb_helper_dirty_blit_real(struct drm_fb_helper *fb_helper,
 					  struct drm_clip_rect *clip)
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
-	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
+	unsigned int cpp = image_format_info_plane_cpp(fb->format, 0);
 	size_t offset = clip->y1 * fb->pitches[0] + clip->x1 * cpp;
 	void *src = fb_helper->fbdev->screen_buffer + offset;
 	void *dst = fb_helper->buffer->vaddr + offset;
@@ -1698,8 +1698,8 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		var->pixclock = 0;
 	}
 
-	if ((drm_format_info_block_width(fb->format, 0) > 1) ||
-	    (drm_format_info_block_height(fb->format, 0) > 1))
+	if ((image_format_info_block_width(fb->format, 0) > 1) ||
+	    (image_format_info_block_height(fb->format, 0) > 1))
 		return -EINVAL;
 
 	/*
@@ -1932,9 +1932,9 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 		DRM_DEBUG("test CRTC %d primary plane\n", i);
 
 		for (j = 0; j < plane->format_count; j++) {
-			const struct drm_format_info *fmt;
+			const struct image_format_info *fmt;
 
-			fmt = drm_format_info(plane->format_types[j]);
+			fmt = image_format_drm_lookup(plane->format_types[j]);
 
 			/*
 			 * Do not consider YUV or other complicated formats
@@ -2055,8 +2055,8 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
 
-	WARN_ON((drm_format_info_block_width(fb->format, 0) > 1) ||
-		(drm_format_info_block_height(fb->format, 0) > 1));
+	WARN_ON((image_format_info_block_width(fb->format, 0) > 1) ||
+		(image_format_info_block_height(fb->format, 0) > 1));
 	info->pseudo_palette = fb_helper->pseudo_palette;
 	info->var.xres_virtual = fb->width;
 	info->var.yres_virtual = fb->height;
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 14d85eb1989d..5b49526ab6fa 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -36,7 +36,7 @@ static unsigned int clip_offset(struct drm_rect *clip,
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip)
 {
-	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
+	unsigned int cpp = image_format_info_plane_cpp(fb->format, 0);
 	size_t len = (clip->x2 - clip->x1) * cpp;
 	unsigned int y, lines = clip->y2 - clip->y1;
 
@@ -63,7 +63,7 @@ void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
 			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip)
 {
-	unsigned int cpp = drm_format_info_plane_cpp(fb->format, 0);
+	unsigned int cpp = image_format_info_plane_cpp(fb->format, 0);
 	unsigned int offset = clip_offset(clip, fb->pitches[0], cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
 	unsigned int y, lines = clip->y2 - clip->y1;
diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 35b459d186c5..6537f4906c50 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -313,20 +313,20 @@ EXPORT_SYMBOL(drm_format_info);
  * @mode_cmd: metadata from the userspace fb creation request
  *
  * Returns:
- * The instance of struct drm_format_info that describes the pixel format, or
+ * The instance of struct image_format_info that describes the pixel format, or
  * NULL if the format is unsupported.
  */
-const struct drm_format_info *
+const struct image_format_info *
 drm_get_format_info(struct drm_device *dev,
 		    const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	const struct drm_format_info *info = NULL;
+	const struct image_format_info *info = NULL;
 
 	if (dev->mode_config.funcs->get_format_info)
 		info = dev->mode_config.funcs->get_format_info(mode_cmd);
 
 	if (!info)
-		info = drm_format_info(mode_cmd->pixel_format);
+		info = image_format_drm_lookup(mode_cmd->pixel_format);
 
 	return info;
 }
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index d8d75e25f6fb..db7aee1fc8fd 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -146,7 +146,7 @@ int drm_mode_addfb_ioctl(struct drm_device *dev,
 }
 
 static int fb_plane_width(int width,
-			  const struct drm_format_info *format, int plane)
+			  const struct image_format_info *format, int plane)
 {
 	if (plane == 0)
 		return width;
@@ -155,7 +155,7 @@ static int fb_plane_width(int width,
 }
 
 static int fb_plane_height(int height,
-			   const struct drm_format_info *format, int plane)
+			   const struct image_format_info *format, int plane)
 {
 	if (plane == 0)
 		return height;
@@ -166,11 +166,11 @@ static int fb_plane_height(int height,
 static int framebuffer_check(struct drm_device *dev,
 			     const struct drm_mode_fb_cmd2 *r)
 {
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	int i;
 
 	/* check if the format is supported at all */
-	info = __drm_format_info(r->pixel_format);
+	info = __image_format_drm_lookup(r->pixel_format);
 	if (!info) {
 		struct drm_format_name_buf format_name;
 
@@ -197,7 +197,7 @@ static int framebuffer_check(struct drm_device *dev,
 		unsigned int width = fb_plane_width(r->width, info, i);
 		unsigned int height = fb_plane_height(r->height, info, i);
 		unsigned int block_size = info->char_per_block[i];
-		u64 min_pitch = drm_format_info_min_pitch(info, i, width);
+		u64 min_pitch = image_format_info_min_pitch(info, i, width);
 
 		if (!block_size && (r->modifier[i] == DRM_FORMAT_MOD_LINEAR)) {
 			DRM_DEBUG_KMS("Format requires non-linear modifier for plane %d\n", i);
diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 65edb1ccb185..b54a12dd6712 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -149,7 +149,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
 			     const struct drm_mode_fb_cmd2 *mode_cmd,
 			     const struct drm_framebuffer_funcs *funcs)
 {
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	struct drm_gem_object *objs[4];
 	struct drm_framebuffer *fb;
 	int ret, i;
@@ -171,7 +171,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
 		}
 
 		min_size = (height - 1) * mode_cmd->pitches[i]
-			 + drm_format_info_min_pitch(info, i, width)
+			 + image_format_info_min_pitch(info, i, width)
 			 + mode_cmd->offsets[i];
 
 		if (objs[i]->size < min_size) {
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index 1f11ab0f8e9d..713b3e07d7f2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -98,7 +98,7 @@ static struct drm_framebuffer *
 exynos_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		      const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev, mode_cmd);
+	const struct image_format_info *info = drm_get_format_info(dev, mode_cmd);
 	struct exynos_drm_gem *exynos_gem[MAX_FB_BUFFER];
 	struct drm_framebuffer *fb;
 	int i;
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 1794ab90b2cc..562c250b9e7e 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -225,7 +225,7 @@ static int psb_framebuffer_init(struct drm_device *dev,
 					const struct drm_mode_fb_cmd2 *mode_cmd,
 					struct gtt_range *gt)
 {
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	int ret;
 
 	/*
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 35d0782c077e..6040ec11d643 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -376,6 +376,8 @@ enum i915_cache_level {
 
 #define I915_COLOR_UNEVICTABLE (-1) /* a non-vma sharing the address space */
 
+struct image_format_info;
+
 struct intel_fbc {
 	/* This is always the inner lock when overlapping with struct_mutex and
 	 * it's the outer lock when overlapping with stolen_lock. */
@@ -432,7 +434,7 @@ struct intel_fbc {
 		} plane;
 
 		struct {
-			const struct drm_format_info *format;
+			const struct image_format_info *format;
 			unsigned int stride;
 		} fb;
 	} state_cache;
@@ -455,7 +457,7 @@ struct intel_fbc {
 		} crtc;
 
 		struct {
-			const struct drm_format_info *format;
+			const struct image_format_info *format;
 			unsigned int stride;
 		} fb;
 
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 3bd40a4a6739..6a0c4f505593 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -2431,15 +2431,15 @@ static unsigned int intel_fb_modifier_to_tiling(u64 fb_modifier)
  * us a ratio of one byte in the CCS for each 8x16 pixels in the
  * main surface.
  */
-static const struct drm_format_info ccs_formats[] = {
+static const struct image_format_info ccs_formats[] = {
 	{ .format = DRM_FORMAT_XRGB8888, .depth = 24, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
 	{ .format = DRM_FORMAT_XBGR8888, .depth = 24, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
 	{ .format = DRM_FORMAT_ARGB8888, .depth = 32, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
 	{ .format = DRM_FORMAT_ABGR8888, .depth = 32, .num_planes = 2, .cpp = { 4, 1, }, .hsub = 8, .vsub = 16, },
 };
 
-static const struct drm_format_info *
-lookup_format_info(const struct drm_format_info formats[],
+static const struct image_format_info *
+lookup_format_info(const struct image_format_info formats[],
 		   int num_formats, u32 format)
 {
 	int i;
@@ -2452,7 +2452,7 @@ lookup_format_info(const struct drm_format_info formats[],
 	return NULL;
 }
 
-static const struct drm_format_info *
+static const struct image_format_info *
 intel_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
 {
 	switch (cmd->modifier[0]) {
@@ -5019,7 +5019,7 @@ static int
 skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
 		  unsigned int scaler_user, int *scaler_id,
 		  int src_w, int src_h, int dst_w, int dst_h,
-		  const struct drm_format_info *format, bool need_scaler)
+		  const struct image_format_info *format, bool need_scaler)
 {
 	struct intel_crtc_scaler_state *scaler_state =
 		&crtc_state->scaler_state;
diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
index 4a54a5c192d2..f1e399085288 100644
--- a/drivers/gpu/drm/imx/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3-plane.c
@@ -553,7 +553,7 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 	unsigned long alpha_eba = 0;
 	enum ipu_color_space ics;
 	unsigned int axi_id = 0;
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	u8 burstsize, num_bursts;
 	u32 width, height;
 	int active;
@@ -627,7 +627,7 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 
 	width = drm_rect_width(&state->src) >> 16;
 	height = drm_rect_height(&state->src) >> 16;
-	info = drm_format_info(fb->format->format);
+	info = fb->format;
 	ipu_calculate_bursts(width, info->cpp[0], fb->pitches[0],
 			     &burstsize, &num_bursts);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index 0d5334a5a9a7..6b40bbb1e2ba 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -32,7 +32,7 @@ static struct drm_framebuffer *mtk_drm_framebuffer_init(struct drm_device *dev,
 					const struct drm_mode_fb_cmd2 *mode,
 					struct drm_gem_object *obj)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev, mode);
+	const struct image_format_info *info = drm_get_format_info(dev, mode);
 	struct drm_framebuffer *fb;
 	int ret;
 
@@ -89,7 +89,7 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
 					       struct drm_file *file,
 					       const struct drm_mode_fb_cmd2 *cmd)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev, cmd);
+	const struct image_format_info *info = drm_get_format_info(dev, cmd);
 	struct drm_framebuffer *fb;
 	struct drm_gem_object *gem;
 	unsigned int width = cmd->width;
@@ -104,7 +104,7 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
 	if (!gem)
 		return ERR_PTR(-ENOENT);
 
-	bpp = drm_format_info_plane_cpp(info, 0);
+	bpp = image_format_info_plane_cpp(info, 0);
 	size = (height - 1) * cmd->pitches[0] + width * bpp;
 	size += cmd->offsets[0];
 
diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 55b3f2f2e608..3a0aee9367e0 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -466,8 +466,8 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 		priv->viu.vd1_addr2 = gem->paddr + fb->offsets[2];
 		priv->viu.vd1_stride2 = fb->pitches[2];
 		priv->viu.vd1_height2 =
-			drm_format_info_plane_height(fb->format,
-						fb->height, 2);
+			image_format_info_plane_height(fb->format,
+						       fb->height, 2);
 		DRM_DEBUG("plane 2 addr 0x%x stride %d height %d\n",
 			 priv->viu.vd1_addr2,
 			 priv->viu.vd1_stride2,
@@ -478,8 +478,8 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 		priv->viu.vd1_addr1 = gem->paddr + fb->offsets[1];
 		priv->viu.vd1_stride1 = fb->pitches[1];
 		priv->viu.vd1_height1 =
-			drm_format_info_plane_height(fb->format,
-						fb->height, 1);
+			image_format_info_plane_height(fb->format,
+						       fb->height, 1);
 		DRM_DEBUG("plane 1 addr 0x%x stride %d height %d\n",
 			 priv->viu.vd1_addr1,
 			 priv->viu.vd1_stride1,
@@ -490,8 +490,8 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 		priv->viu.vd1_addr0 = gem->paddr + fb->offsets[0];
 		priv->viu.vd1_stride0 = fb->pitches[0];
 		priv->viu.vd1_height0 =
-			drm_format_info_plane_height(fb->format,
-						fb->height, 0);
+			image_format_info_plane_height(fb->format,
+						       fb->height, 0);
 		DRM_DEBUG("plane 0 addr 0x%x stride %d height %d\n",
 			 priv->viu.vd1_addr0,
 			 priv->viu.vd1_stride0,
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 29e45f2144b5..68bf59d797db 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -106,8 +106,8 @@ const struct msm_format *msm_framebuffer_format(struct drm_framebuffer *fb)
 struct drm_framebuffer *msm_framebuffer_create(struct drm_device *dev,
 		struct drm_file *file, const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev,
-								 mode_cmd);
+	const struct image_format_info *info = drm_get_format_info(dev,
+								   mode_cmd);
 	struct drm_gem_object *bos[4] = {0};
 	struct drm_framebuffer *fb;
 	int ret, i, n = info->num_planes;
@@ -137,8 +137,8 @@ struct drm_framebuffer *msm_framebuffer_create(struct drm_device *dev,
 static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 		const struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev,
-								 mode_cmd);
+	const struct image_format_info *info = drm_get_format_info(dev,
+								   mode_cmd);
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
 	struct msm_framebuffer *msm_fb = NULL;
@@ -181,7 +181,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 		unsigned int min_size;
 
 		min_size = (height - 1) * mode_cmd->pitches[i]
-			 + width * drm_format_info_plane_cpp(info, i)
+			 + width * image_format_info_plane_cpp(info, i)
 			 + mode_cmd->offsets[i];
 
 		if (bos[i]->size < min_size) {
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 6557b2d6e16e..1d4143adf829 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -298,8 +298,8 @@ void omap_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
 struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
 		struct drm_file *file, const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev,
-								 mode_cmd);
+	const struct image_format_info *info = drm_get_format_info(dev,
+								   mode_cmd);
 	unsigned int num_planes = info->num_planes;
 	struct drm_gem_object *bos[4];
 	struct drm_framebuffer *fb;
@@ -329,7 +329,7 @@ struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
 struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 		const struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos)
 {
-	const struct drm_format_info *format = NULL;
+	const struct image_format_info *format = NULL;
 	struct omap_framebuffer *omap_fb = NULL;
 	struct drm_framebuffer *fb = NULL;
 	unsigned int pitch = mode_cmd->pitches[0];
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index dbf596fc4339..2c23c2311b1b 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -125,7 +125,7 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 					 struct drm_mode_fb_cmd2 *mode_cmd,
 					 struct drm_gem_object **gobj_p)
 {
-	const struct drm_format_info *info;
+	const struct image_format_info *info;
 	struct radeon_device *rdev = rfbdev->rdev;
 	struct drm_gem_object *gobj = NULL;
 	struct radeon_bo *rbo = NULL;
@@ -137,7 +137,7 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 	u32 cpp;
 
 	info = drm_get_format_info(rdev->ddev, mode_cmd);
-	cpp = drm_format_info_plane_cpp(info, 0);
+	cpp = image_format_info_plane_cpp(info, 0);
 
 	/* need to align pitch with crtc limits */
 	mode_cmd->pitches[0] = radeon_align_pitch(rdev, mode_cmd->width, cpp,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 57873c99ae29..69b64ba9dcfa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -74,8 +74,8 @@ static struct drm_framebuffer *
 rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 			const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev,
-								 mode_cmd);
+	const struct image_format_info *info = drm_get_format_info(dev,
+								   mode_cmd);
 	struct drm_framebuffer *fb;
 	struct drm_gem_object *objs[ROCKCHIP_MAX_FB_BUFFER];
 	struct drm_gem_object *obj;
@@ -98,7 +98,7 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 
 		min_size = (height - 1) * mode_cmd->pitches[i] +
 			mode_cmd->offsets[i] +
-			width * drm_format_info_plane_cpp(info, i);
+			width * image_format_info_plane_cpp(info, i);
 
 		if (obj->size < min_size) {
 			drm_gem_object_put_unlocked(obj);
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 6bb3cd3a1a01..30efc822b2ce 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -779,7 +779,7 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
 
 	/* Configures the color frame buffer pitch in bytes & line length */
 	pitch_in_bytes = fb->pitches[0];
-	line_length = drm_format_info_plane_cpp(fb->format, 0) *
+	line_length = image_format_info_plane_cpp(fb->format, 0) *
 		      (x1 - x0 + 1) + (ldev->caps.bus_width >> 3) - 1;
 	val = ((pitch_in_bytes << 16) | line_length);
 	reg_update_bits(ldev->regs, LTDC_L1CFBLR + lofs,
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 4e5922c89d7b..92766f8995d9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -203,7 +203,7 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	const struct drm_format_info *format = fb->format;
+	const struct image_format_info *format = fb->format;
 	const uint32_t fmt = format->format;
 	u32 val = SUN4I_BACKEND_IYUVCTL_EN;
 	int i;
@@ -222,8 +222,8 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN);
 
 	/* TODO: Add support for the multi-planar YUV formats */
-	if (drm_format_info_is_yuv_packed(format) &&
-	    drm_format_info_is_yuv_sampling_422(format))
+	if (image_format_info_is_yuv_packed(format) &&
+	    image_format_info_is_yuv_sampling_422(format))
 		val |= SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV422;
 	else
 		DRM_DEBUG_DRIVER("Unsupported YUV format (0x%x)\n", fmt);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 346c8071bd38..75c2f9886768 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -241,18 +241,18 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
 static int
-sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
+sun4i_frontend_drm_format_to_input_fmt(const struct image_format_info *format,
 				       u32 *val)
 {
 	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
-	else if (drm_format_info_is_yuv_sampling_411(format))
+	else if (image_format_info_is_yuv_sampling_411(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV411;
-	else if (drm_format_info_is_yuv_sampling_420(format))
+	else if (image_format_info_is_yuv_sampling_420(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
-	else if (drm_format_info_is_yuv_sampling_422(format))
+	else if (image_format_info_is_yuv_sampling_422(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
-	else if (drm_format_info_is_yuv_sampling_444(format))
+	else if (image_format_info_is_yuv_sampling_444(format))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444;
 	else
 		return -EINVAL;
@@ -261,7 +261,7 @@ sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 }
 
 static int
-sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
+sun4i_frontend_drm_format_to_input_mode(const struct image_format_info *format,
 					uint64_t modifier, u32 *val)
 {
 	bool tiled = (modifier == DRM_FORMAT_MOD_ALLWINNER_TILED);
@@ -287,11 +287,11 @@ sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
 }
 
 static int
-sun4i_frontend_drm_format_to_input_sequence(const struct drm_format_info *format,
+sun4i_frontend_drm_format_to_input_sequence(const struct image_format_info *format,
 					    u32 *val)
 {
 	/* Planar formats have an explicit input sequence. */
-	if (drm_format_info_is_yuv_planar(format)) {
+	if (image_format_info_is_yuv_planar(format)) {
 		*val = 0;
 		return 0;
 	}
@@ -401,7 +401,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	const struct drm_format_info *format = fb->format;
+	const struct image_format_info *format = fb->format;
 	uint64_t modifier = fb->modifier;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index bb8e026d6405..2f64c056d68d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -75,7 +75,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 				       unsigned int zpos)
 {
 	struct drm_plane_state *state = plane->state;
-	const struct drm_format_info *format = state->fb->format;
+	const struct image_format_info *format = state->fb->format;
 	u32 src_w, src_h, dst_w, dst_h;
 	u32 bld_base, ch_base;
 	u32 outsize, insize;
@@ -267,7 +267,7 @@ static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	const struct drm_format_info *format = fb->format;
+	const struct image_format_info *format = fb->format;
 	struct drm_gem_cma_object *gem;
 	u32 dx, dy, src_x, src_y;
 	dma_addr_t paddr;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
index 7ba75011adf9..1d22331af5fe 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -9,6 +9,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/image-formats.h>
+
 #include "sun8i_vi_scaler.h"
 
 static const u32 lan3coefftab32_left[480] = {
@@ -869,7 +871,7 @@ static int sun8i_vi_scaler_coef_index(unsigned int step)
 
 static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
 				      u32 hstep, u32 vstep,
-				      const struct drm_format_info *format)
+				      const struct image_format_info *format)
 {
 	const u32 *ch_left, *ch_right, *cy;
 	int offset, i;
@@ -926,7 +928,7 @@ void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable)
 void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
 			   u32 hscale, u32 vscale, u32 hphase, u32 vphase,
-			   const struct drm_format_info *format)
+			   const struct image_format_info *format)
 {
 	u32 chphase, cvphase;
 	u32 insize, outsize;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
index 68f6593b369a..878a689e532a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -9,7 +9,6 @@
 #ifndef _SUN8I_VI_SCALER_H_
 #define _SUN8I_VI_SCALER_H_
 
-#include <drm/drm_fourcc.h>
 #include "sun8i_mixer.h"
 
 #define DE2_VI_SCALER_UNIT_BASE 0x20000
@@ -69,10 +68,12 @@
 #define SUN50I_SCALER_VSU_ANGLE_SHIFT(x)		(((x) << 16) & 0xF)
 #define SUN50I_SCALER_VSU_ANGLE_OFFSET(x)		((x) & 0xFF)
 
+struct image_format_info;
+
 void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool enable);
 void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
 			   u32 hscale, u32 vscale, u32 hphase, u32 vphase,
-			   const struct drm_format_info *format);
+			   const struct image_format_info *format);
 
 #endif
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index d1042196a30f..5b99741704fc 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -131,7 +131,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 					struct drm_file *file,
 					const struct drm_mode_fb_cmd2 *cmd)
 {
-	const struct drm_format_info *info = drm_get_format_info(drm, cmd);
+	const struct image_format_info *info = drm_get_format_info(drm, cmd);
 	struct tegra_bo *planes[4];
 	struct drm_gem_object *gem;
 	struct drm_framebuffer *fb;
@@ -149,7 +149,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 			goto unreference;
 		}
 
-		bpp = drm_format_info_plane_cpp(info, i);
+		bpp = image_format_info_plane_cpp(info, i);
 
 		size = (height - 1) * cmd->pitches[i] +
 		       width * bpp + cmd->offsets[i];
diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index d97a4dff515d..7895ba52709a 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -222,7 +222,7 @@ static void zx_vl_plane_atomic_update(struct drm_plane *plane,
 		cma_obj = drm_fb_cma_get_gem_obj(fb, i);
 		paddr = cma_obj->paddr + fb->offsets[i];
 		paddr += src_y * fb->pitches[i];
-		paddr += src_x * drm_format_info_plane_cpp(fb->format, i);
+		paddr += src_x * image_format_info_plane_cpp(fb->format, i);
 		zx_writel(paddr_reg, paddr);
 		paddr_reg += 4;
 	}
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 4ef8ccb5d236..38f152b5da08 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -49,6 +49,7 @@
 
 struct drm_device;
 struct drm_mode_fb_cmd2;
+struct image_format_info;
 
 /**
  * struct drm_format_info - information about a DRM format
@@ -323,7 +324,8 @@ int drm_format_info_plane_height(const struct drm_format_info *info, int height,
 
 const struct drm_format_info *__drm_format_info(u32 format);
 const struct drm_format_info *drm_format_info(u32 format);
-const struct drm_format_info *
+
+const struct image_format_info *
 drm_get_format_info(struct drm_device *dev,
 		    const struct drm_mode_fb_cmd2 *mode_cmd);
 uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index c23016748e3f..dc7dc48c8580 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -24,6 +24,7 @@
 #define __DRM_FRAMEBUFFER_H__
 
 #include <linux/ctype.h>
+#include <linux/image-formats.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 
@@ -32,7 +33,6 @@
 struct drm_clip_rect;
 struct drm_device;
 struct drm_file;
-struct drm_format_info;
 struct drm_framebuffer;
 struct drm_gem_object;
 
@@ -135,7 +135,7 @@ struct drm_framebuffer {
 	/**
 	 * @format: framebuffer format information
 	 */
-	const struct drm_format_info *format;
+	const struct image_format_info *format;
 	/**
 	 * @funcs: framebuffer vfunc table
 	 */
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 7f60e8eb269a..717fb536078b 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -35,9 +35,10 @@ struct drm_file;
 struct drm_device;
 struct drm_atomic_state;
 struct drm_mode_fb_cmd2;
-struct drm_format_info;
 struct drm_display_mode;
 
+struct image_format_info;
+
 /**
  * struct drm_mode_config_funcs - basic driver provided mode setting functions
  *
@@ -89,7 +90,7 @@ struct drm_mode_config_funcs {
 	 * The format information specific to the given fb metadata, or
 	 * NULL if none is found.
 	 */
-	const struct drm_format_info *(*get_format_info)(const struct drm_mode_fb_cmd2 *mode_cmd);
+	const struct image_format_info *(*get_format_info)(const struct drm_mode_fb_cmd2 *mode_cmd);
 
 	/**
 	 * @output_poll_changed:
-- 
git-series 0.9.1
