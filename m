Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67701C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362FB20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfDQHzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:08 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54417 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbfDQHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:06 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9F5D14000E;
        Wed, 17 Apr 2019 07:55:02 +0000 (UTC)
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
        linux-media@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>
Subject: [PATCH 04/20] drm/fourcc: Pass the format_info pointer to drm_format_plane_width/height
Date:   Wed, 17 Apr 2019 09:54:30 +0200
Message-Id: <194fd02a37172de6f2a799fee5c98ced5e7e9d76.1555487650.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
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
