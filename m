Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDFC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8102E2176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfDQHzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:19 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:48045 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfDQHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:18 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8074E20000F;
        Wed, 17 Apr 2019 07:55:14 +0000 (UTC)
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
Subject: [PATCH 19/20] lib: image-formats: Add more functions
Date:   Wed, 17 Apr 2019 09:54:45 +0200
Message-Id: <382f72c5938f538c8489cb2032050f4be252ad59.1555487650.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4L2 drivers typically need a few more helpers compared to DRM drivers, so
let's add them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/linux/image-formats.h | 42 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/include/linux/image-formats.h b/include/linux/image-formats.h
index b78b8e861fc9..a2cf3528bd31 100644
--- a/include/linux/image-formats.h
+++ b/include/linux/image-formats.h
@@ -388,6 +388,48 @@ uint64_t image_format_info_min_pitch(const struct image_format_info *info,
 			    image_format_info_block_height(info, plane));
 }
 
+/**
+ * image_format_info_plane_stride - determine the stride value
+ * @format: pointer to the image_format_info
+ * @width: plane width
+ * @plane: plane index
+ *
+ * Returns:
+ * The bytes per pixel value for the specified plane.
+ */
+static inline
+unsigned int image_format_info_plane_stride(const struct image_format_info *format,
+					    unsigned int width, int plane)
+{
+	if (!format || plane >= format->num_planes)
+		return 0;
+
+	return image_format_info_plane_width(format, width, plane) *
+		image_format_info_plane_cpp(format, plane);
+}
+
+/**
+ * image_format_info_plane_size - determine the size value
+ * @format: pointer to the image_format_info
+ * @width: plane width
+ * @height: plane width
+ * @plane: plane index
+ *
+ * Returns:
+ * The size of the plane buffer.
+ */
+static inline
+unsigned int image_format_info_plane_size(const struct image_format_info *format,
+					  unsigned int width, unsigned int height,
+					  int plane)
+{
+	if (!format || plane >= format->num_planes)
+		return 0;
+
+	return image_format_info_plane_stride(format, width, plane) *
+		image_format_info_plane_height(format, height, plane);
+}
+
 const struct image_format_info *__image_format_drm_lookup(u32 drm);
 const struct image_format_info *__image_format_v4l2_lookup(u32 v4l2);
 const struct image_format_info *image_format_drm_lookup(u32 drm);
-- 
git-series 0.9.1
