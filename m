Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB1EC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F0120835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfDQHzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:24 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41191 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfDQHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:22 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E9A3324000D;
        Wed, 17 Apr 2019 07:55:16 +0000 (UTC)
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
Subject: [PATCH 20/20] media: sun6i: Convert to the image format API
Date:   Wed, 17 Apr 2019 09:54:46 +0200
Message-Id: <124f97b2e1d34fcceb0e553aaaa280afbb441d07.1555487650.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The image format API allows us to remove some of the computation we need to
handle the various video formats.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c     | 89 ++---------
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h     | 49 +------
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h |  6 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c   | 11 +-
 4 files changed, 31 insertions(+), 124 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 4c79eb64a7a7..cad90d4528f8 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/fs.h>
+#include <linux/image-formats.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ioctl.h>
@@ -497,72 +498,27 @@ static void sun6i_csi_set_format(struct sun6i_csi_dev *sdev)
 static void sun6i_csi_set_window(struct sun6i_csi_dev *sdev)
 {
 	struct sun6i_csi_config *config = &sdev->csi.config;
-	u32 bytesperline_y;
-	u32 bytesperline_c;
+	const struct image_format_info *info =
+		image_format_v4l2_lookup(config->pixelformat);
 	int *planar_offset = sdev->planar_offset;
-	u32 width = config->width;
-	u32 height = config->height;
-	u32 hor_len = width;
+	u32 bytesperline_y = image_format_info_plane_stride(info, config->width, 0);
+	u32 bytesperline_c = image_format_info_plane_stride(info, config->width, 1);
+	unsigned int offset, i;
 
-	switch (config->pixelformat) {
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-		dev_dbg(sdev->dev,
-			"Horizontal length should be 2 times of width for packed YUV formats!\n");
-		hor_len = width * 2;
-		break;
-	default:
-		break;
+	offset = 0;
+	for (i = 0; i < info->num_planes; i++) {
+		planar_offset[i] = offset;
+
+		offset += image_format_info_plane_size(info, config->width,
+						       config->height, i);
 	}
 
 	regmap_write(sdev->regmap, CSI_CH_HSIZE_REG,
-		     CSI_CH_HSIZE_HOR_LEN(hor_len) |
+		     CSI_CH_HSIZE_HOR_LEN(bytesperline_c) |
 		     CSI_CH_HSIZE_HOR_START(0));
 	regmap_write(sdev->regmap, CSI_CH_VSIZE_REG,
-		     CSI_CH_VSIZE_VER_LEN(height) |
+		     CSI_CH_VSIZE_VER_LEN(config->height) |
 		     CSI_CH_VSIZE_VER_START(0));
-
-	planar_offset[0] = 0;
-	switch (config->pixelformat) {
-	case V4L2_PIX_FMT_HM12:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		bytesperline_y = width;
-		bytesperline_c = width;
-		planar_offset[1] = bytesperline_y * height;
-		planar_offset[2] = -1;
-		break;
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-		bytesperline_y = width;
-		bytesperline_c = width / 2;
-		planar_offset[1] = bytesperline_y * height;
-		planar_offset[2] = planar_offset[1] +
-				bytesperline_c * height / 2;
-		break;
-	case V4L2_PIX_FMT_YUV422P:
-		bytesperline_y = width;
-		bytesperline_c = width / 2;
-		planar_offset[1] = bytesperline_y * height;
-		planar_offset[2] = planar_offset[1] +
-				bytesperline_c * height;
-		break;
-	default: /* raw */
-		dev_dbg(sdev->dev,
-			"Calculating pixelformat(0x%x)'s bytesperline as a packed format\n",
-			config->pixelformat);
-		bytesperline_y = (sun6i_csi_get_bpp(config->pixelformat) *
-				  config->width) / 8;
-		bytesperline_c = 0;
-		planar_offset[1] = -1;
-		planar_offset[2] = -1;
-		break;
-	}
-
 	regmap_write(sdev->regmap, CSI_CH_BUF_LEN_REG,
 		     CSI_CH_BUF_LEN_BUF_LEN_C(bytesperline_c) |
 		     CSI_CH_BUF_LEN_BUF_LEN_Y(bytesperline_y));
@@ -588,15 +544,16 @@ int sun6i_csi_update_config(struct sun6i_csi *csi,
 void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr)
 {
 	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
+	struct sun6i_csi_config *config = &sdev->csi.config;
+	const struct image_format_info *info =
+		image_format_v4l2_lookup(config->pixelformat);
+	unsigned int i;
+
+	for (i = 0; i < info->num_planes; i++) {
+		regmap_write(sdev->regmap, CSI_CH_BUF_REG(i, 0),
+			     (addr + sdev->planar_offset[i]) >> 2);
 
-	regmap_write(sdev->regmap, CSI_CH_F0_BUFA_REG,
-		     (addr + sdev->planar_offset[0]) >> 2);
-	if (sdev->planar_offset[1] != -1)
-		regmap_write(sdev->regmap, CSI_CH_F1_BUFA_REG,
-			     (addr + sdev->planar_offset[1]) >> 2);
-	if (sdev->planar_offset[2] != -1)
-		regmap_write(sdev->regmap, CSI_CH_F2_BUFA_REG,
-			     (addr + sdev->planar_offset[2]) >> 2);
+	}
 }
 
 void sun6i_csi_set_stream(struct sun6i_csi *csi, bool enable)
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index c626821aaedb..f3472d8821ab 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -86,53 +86,4 @@ void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr);
  */
 void sun6i_csi_set_stream(struct sun6i_csi *csi, bool enable);
 
-/* get bpp form v4l2 pixformat */
-static inline int sun6i_csi_get_bpp(unsigned int pixformat)
-{
-	switch (pixformat) {
-	case V4L2_PIX_FMT_SBGGR8:
-	case V4L2_PIX_FMT_SGBRG8:
-	case V4L2_PIX_FMT_SGRBG8:
-	case V4L2_PIX_FMT_SRGGB8:
-	case V4L2_PIX_FMT_JPEG:
-		return 8;
-	case V4L2_PIX_FMT_SBGGR10:
-	case V4L2_PIX_FMT_SGBRG10:
-	case V4L2_PIX_FMT_SGRBG10:
-	case V4L2_PIX_FMT_SRGGB10:
-		return 10;
-	case V4L2_PIX_FMT_SBGGR12:
-	case V4L2_PIX_FMT_SGBRG12:
-	case V4L2_PIX_FMT_SGRBG12:
-	case V4L2_PIX_FMT_SRGGB12:
-	case V4L2_PIX_FMT_HM12:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-		return 12;
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-	case V4L2_PIX_FMT_YUV422P:
-	case V4L2_PIX_FMT_RGB565:
-	case V4L2_PIX_FMT_RGB565X:
-		return 16;
-	case V4L2_PIX_FMT_RGB24:
-	case V4L2_PIX_FMT_BGR24:
-		return 24;
-	case V4L2_PIX_FMT_RGB32:
-	case V4L2_PIX_FMT_BGR32:
-		return 32;
-	default:
-		WARN(1, "Unsupported pixformat: 0x%x\n", pixformat);
-		break;
-	}
-
-	return 0;
-}
-
 #endif /* __SUN6I_CSI_H__ */
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
index 703fa14bb313..7c19d2bcbd7c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
@@ -74,11 +74,7 @@
 #define CSI_CH_SCALE_REG		0x4c
 #define CSI_CH_SCALE_QUART_EN			BIT(0)
 
-#define CSI_CH_F0_BUFA_REG		0x50
-
-#define CSI_CH_F1_BUFA_REG		0x58
-
-#define CSI_CH_F2_BUFA_REG		0x60
+#define CSI_CH_BUF_REG(plane, chan)	(0x50 + (plane) * 8 + (chan) * 4)
 
 #define CSI_CH_STA_REG			0x6c
 #define CSI_CH_STA_FIELD_STA_MASK		BIT(2)
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index f0dfe68486d1..0c783140c3a0 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -5,6 +5,7 @@
  * Author: Yong Deng <yong.deng@magewell.com>
  */
 
+#include <linux/image-formats.h>
 #include <linux/of.h>
 
 #include <media/v4l2-device.h>
@@ -351,17 +352,19 @@ static int sun6i_video_try_fmt(struct sun6i_video *video,
 			       struct v4l2_format *f)
 {
 	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
-	int bpp;
+	const struct image_format_info *info;
 
 	if (!is_pixformat_valid(pixfmt->pixelformat))
 		pixfmt->pixelformat = supported_pixformats[0];
 
+	info = image_format_v4l2_lookup(pixfmt->pixelformat);
+
 	v4l_bound_align_image(&pixfmt->width, MIN_WIDTH, MAX_WIDTH, 1,
 			      &pixfmt->height, MIN_HEIGHT, MAX_WIDTH, 1, 1);
 
-	bpp = sun6i_csi_get_bpp(pixfmt->pixelformat);
-	pixfmt->bytesperline = (pixfmt->width * bpp) >> 3;
-	pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height;
+	pixfmt->bytesperline = image_format_info_plane_stride(info, pixfmt->width, 0);
+	pixfmt->sizeimage = image_format_info_plane_size(info, pixfmt->width,
+							 pixfmt->height, 0);
 
 	if (pixfmt->field == V4L2_FIELD_ANY)
 		pixfmt->field = V4L2_FIELD_NONE;
-- 
git-series 0.9.1
