Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951CDC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61138217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfEJLJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:09:13 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42149 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfEJLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:09:08 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DE2B8FF807;
        Fri, 10 May 2019 11:09:01 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>
Subject: [PATCH v2 5/6] drm/fourcc: Pass the format_info pointer to drm_format_plane_width/height
Date:   Fri, 10 May 2019 13:08:50 +0200
Message-Id: <514af1d489d80b8b1767e3716b663ce5103da6eb.1557486447.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, the drm_format_plane_height/width functions were operating on the
format's fourcc and was doing a lookup to retrieve the drm_format_info
structure and return the cpp.

However, this is inefficient since in most cases, we will have the
drm_format_info pointer already available so we shouldn't have to perform a
new lookup. Some drm_fourcc functions also already operate on the
drm_format_info pointer for that reason, so the API is quite inconsistent
there.

Let's follow the latter pattern and remove the extra lookup while being a
bit more consistent.

In order to be extra consistent, also rename that function to
drm_format_info_plane_cpp and to a static function in the header to match
the current policy. The parameters order have also be changed to match the
other functions prototype.

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/drm_fourcc.c          | 48 +----------------------------
 drivers/gpu/drm/meson/meson_overlay.c | 12 +++----
 include/drm/drm_fourcc.h              | 46 +++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 5f63fc74e265..35b459d186c5 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -333,54 +333,6 @@ drm_get_format_info(struct drm_device *dev,
 EXPORT_SYMBOL(drm_get_format_info);
 
 /**
- * drm_format_plane_width - width of the plane given the first plane
- * @width: width of the first plane
- * @format: pixel format
- * @plane: plane index
- *
- * Returns:
- * The width of @plane, given that the width of the first plane is @width.
- */
-int drm_format_plane_width(int width, uint32_t format, int plane)
-{
-	const struct drm_format_info *info;
-
-	info = drm_format_info(format);
-	if (!info || plane >= info->num_planes)
-		return 0;
-
-	if (plane == 0)
-		return width;
-
-	return width / info->hsub;
-}
-EXPORT_SYMBOL(drm_format_plane_width);
-
-/**
- * drm_format_plane_height - height of the plane given the first plane
- * @height: height of the first plane
- * @format: pixel format
- * @plane: plane index
- *
- * Returns:
- * The height of @plane, given that the height of the first plane is @height.
- */
-int drm_format_plane_height(int height, uint32_t format, int plane)
-{
-	const struct drm_format_info *info;
-
-	info = drm_format_info(format);
-	if (!info || plane >= info->num_planes)
-		return 0;
-
-	if (plane == 0)
-		return height;
-
-	return height / info->vsub;
-}
-EXPORT_SYMBOL(drm_format_plane_height);
-
-/**
  * drm_format_info_block_width - width in pixels of block.
  * @info: pixel format info
  * @plane: plane index
diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index fb8515b2860c..55b3f2f2e608 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -466,8 +466,8 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 		priv->viu.vd1_addr2 = gem->paddr + fb->offsets[2];
 		priv->viu.vd1_stride2 = fb->pitches[2];
 		priv->viu.vd1_height2 =
-			drm_format_plane_height(fb->height,
-						fb->format->format, 2);
+			drm_format_info_plane_height(fb->format,
+						fb->height, 2);
 		DRM_DEBUG("plane 2 addr 0x%x stride %d height %d\n",
 			 priv->viu.vd1_addr2,
 			 priv->viu.vd1_stride2,
@@ -478,8 +478,8 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 		priv->viu.vd1_addr1 = gem->paddr + fb->offsets[1];
 		priv->viu.vd1_stride1 = fb->pitches[1];
 		priv->viu.vd1_height1 =
-			drm_format_plane_height(fb->height,
-						fb->format->format, 1);
+			drm_format_info_plane_height(fb->format,
+						fb->height, 1);
 		DRM_DEBUG("plane 1 addr 0x%x stride %d height %d\n",
 			 priv->viu.vd1_addr1,
 			 priv->viu.vd1_stride1,
@@ -490,8 +490,8 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 		priv->viu.vd1_addr0 = gem->paddr + fb->offsets[0];
 		priv->viu.vd1_stride0 = fb->pitches[0];
 		priv->viu.vd1_height0 =
-			drm_format_plane_height(fb->height,
-						fb->format->format, 0);
+			drm_format_info_plane_height(fb->format,
+						fb->height, 0);
 		DRM_DEBUG("plane 0 addr 0x%x stride %d height %d\n",
 			 priv->viu.vd1_addr0,
 			 priv->viu.vd1_stride0,
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 6b5a82b31bc4..4ef8ccb5d236 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -277,6 +277,50 @@ int drm_format_info_plane_cpp(const struct drm_format_info *info, int plane)
 	return info->cpp[plane];
 }
 
+/**
+ * drm_format_info_plane_width - width of the plane given the first plane
+ * @format: pixel format info
+ * @width: width of the first plane
+ * @plane: plane index
+ *
+ * Returns:
+ * The width of @plane, given that the width of the first plane is @width.
+ */
+static inline
+int drm_format_info_plane_width(const struct drm_format_info *info, int width,
+				int plane)
+{
+	if (!info || plane >= info->num_planes)
+		return 0;
+
+	if (plane == 0)
+		return width;
+
+	return width / info->hsub;
+}
+
+/**
+ * drm_format_info_plane_height - height of the plane given the first plane
+ * @format: pixel format info
+ * @height: height of the first plane
+ * @plane: plane index
+ *
+ * Returns:
+ * The height of @plane, given that the height of the first plane is @height.
+ */
+static inline
+int drm_format_info_plane_height(const struct drm_format_info *info, int height,
+				 int plane)
+{
+	if (!info || plane >= info->num_planes)
+		return 0;
+
+	if (plane == 0)
+		return height;
+
+	return height / info->vsub;
+}
+
 const struct drm_format_info *__drm_format_info(u32 format);
 const struct drm_format_info *drm_format_info(u32 format);
 const struct drm_format_info *
@@ -285,8 +329,6 @@ drm_get_format_info(struct drm_device *dev,
 uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
 uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
 				     uint32_t bpp, uint32_t depth);
-int drm_format_plane_width(int width, uint32_t format, int plane);
-int drm_format_plane_height(int height, uint32_t format, int plane);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
-- 
git-series 0.9.1
