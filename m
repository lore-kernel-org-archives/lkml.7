Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE47EC4321B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8684420878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6wFhL+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfDZB1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:27:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38273 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbfDZB1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 21:27:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so748004pgl.5;
        Thu, 25 Apr 2019 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bs9QmySNy6EI2QvZ7E+BvIo9VVaHRvBdmmCGKxCyH9s=;
        b=K6wFhL+41CGplj1cFZd/AwkC7ohRkRPbtzytBNP5+NzLAk0njepqGFLUmgekRCTcpS
         WF+aTUdLV8P0kyH8rVK8wdBiOkvXNgpza1hpINiAv/3fmCYTRAsBPvGqhIIOkCx6mupC
         GnMUryXbOzeoYy6O8opWp7oBn3gakH07CA86cD6UynCXWvwz8WYMF32QbrPmkrDpr3XL
         V/xcIcK4VaJLLG/XIvHeZcI+yT8ViyHwdkmBxaQ/Xu+o5gk5ka5wqAvO09HK3+H05qO1
         yH3dS+L1gqhDZZj1J8wCee5ME8OICB6wjVUuqbs0DWecBhvo3iAK78PUvbjw7E6pNosX
         z4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bs9QmySNy6EI2QvZ7E+BvIo9VVaHRvBdmmCGKxCyH9s=;
        b=Uq/hA1o8PaYY7V3BfzZcQ+U5cMF6IguKhj2hq5iaLe36dt21ygMy8lgLZZO7mgfn/l
         G+Ywq6BxTy+3K2Ae9BHtoebkASKTfhf8rQZ8rAW1CUgzmSiUOckW3qaqPsmENc9HlC8J
         Gcd+llR6KCAmaMZsKAg/kLQHCTHPhSFDCuxBNaa/Of9GgDTYzNVfJ3LWCDQfEXCeVy1n
         tC8Q/eFRZCP9AqmRwlkfU+G521z15ptS+yPQ4uHUi19tKARYJx6rArnryw36i7vrGrCm
         DiuFh23YB9fXTDmgYh8LZiKNg8LALTJjpiObA5qV6jhh6Fun1jm96B+oCev6yfWZqQgY
         10zQ==
X-Gm-Message-State: APjAAAVvWWd3UdK6ie1jJVX6QjHiAUehHuYLvt7/RkrwBIFm9KMw3Bj8
        6pvjJTECsczv4rLPkwV/db1Tk+h+
X-Google-Smtp-Source: APXvYqyQJOVdzojulIQ/Z9t07n1GduemhfgzZAKK9LLsBLMVV18WqSmDEeeXVw9+mNiDdDk9b6ULpQ==
X-Received: by 2002:a62:304:: with SMTP id 4mr42523102pfd.99.1556242021880;
        Thu, 25 Apr 2019 18:27:01 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id l184sm46494230pfc.98.2019.04.25.18.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 18:27:01 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] Revert "media: imx: Set capture compose rectangle in capture_device_set_format"
Date:   Thu, 25 Apr 2019 18:26:45 -0700
Message-Id: <20190426012647.7128-5-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426012647.7128-1-slongerbeam@gmail.com>
References: <20190426012647.7128-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rvert this commit, as imx_media_capture_device_set_format() will be
removed.

This reverts commit 5964cbd8692252615370b77eb96764dd70c2f837.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c   |  5 ++--
 drivers/staging/media/imx/imx-media-capture.c | 24 +++++++++----------
 drivers/staging/media/imx/imx-media-csi.c     |  5 ++--
 drivers/staging/media/imx/imx-media-utils.c   | 20 ++++------------
 drivers/staging/media/imx/imx-media.h         |  6 ++---
 5 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 8242d88dfb82..afaa3a8b15e9 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -910,7 +910,6 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 	const struct imx_media_pixfmt *cc;
 	struct v4l2_pix_format vdev_fmt;
 	struct v4l2_mbus_framefmt *fmt;
-	struct v4l2_rect vdev_compose;
 	int ret = 0;
 
 	if (sdformat->pad >= PRPENCVF_NUM_PADS)
@@ -952,11 +951,11 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 	priv->cc[sdformat->pad] = cc;
 
 	/* propagate output pad format to capture device */
-	imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt, &vdev_compose,
+	imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt,
 				      &priv->format_mbus[PRPENCVF_SRC_PAD],
 				      priv->cc[PRPENCVF_SRC_PAD]);
 	mutex_unlock(&priv->lock);
-	imx_media_capture_device_set_format(vdev, &vdev_fmt, &vdev_compose);
+	imx_media_capture_device_set_format(vdev, &vdev_fmt);
 
 	return 0;
 out:
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 335084a6b0cd..555f6204660b 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -205,8 +205,7 @@ static int capture_g_fmt_vid_cap(struct file *file, void *fh,
 
 static int __capture_try_fmt_vid_cap(struct capture_priv *priv,
 				     struct v4l2_subdev_format *fmt_src,
-				     struct v4l2_format *f,
-				     struct v4l2_rect *compose)
+				     struct v4l2_format *f)
 {
 	const struct imx_media_pixfmt *cc, *cc_src;
 
@@ -246,8 +245,7 @@ static int __capture_try_fmt_vid_cap(struct capture_priv *priv,
 		}
 	}
 
-	imx_media_mbus_fmt_to_pix_fmt(&f->fmt.pix, compose,
-				      &fmt_src->format, cc);
+	imx_media_mbus_fmt_to_pix_fmt(&f->fmt.pix, &fmt_src->format, cc);
 
 	return 0;
 }
@@ -265,7 +263,7 @@ static int capture_try_fmt_vid_cap(struct file *file, void *fh,
 	if (ret)
 		return ret;
 
-	return __capture_try_fmt_vid_cap(priv, &fmt_src, f, NULL);
+	return __capture_try_fmt_vid_cap(priv, &fmt_src, f);
 }
 
 static int capture_s_fmt_vid_cap(struct file *file, void *fh,
@@ -273,7 +271,6 @@ static int capture_s_fmt_vid_cap(struct file *file, void *fh,
 {
 	struct capture_priv *priv = video_drvdata(file);
 	struct v4l2_subdev_format fmt_src;
-	struct v4l2_rect compose;
 	int ret;
 
 	if (vb2_is_busy(&priv->q)) {
@@ -287,14 +284,17 @@ static int capture_s_fmt_vid_cap(struct file *file, void *fh,
 	if (ret)
 		return ret;
 
-	ret = __capture_try_fmt_vid_cap(priv, &fmt_src, f, &compose);
+	ret = __capture_try_fmt_vid_cap(priv, &fmt_src, f);
 	if (ret)
 		return ret;
 
 	priv->vdev.fmt.fmt.pix = f->fmt.pix;
 	priv->vdev.cc = imx_media_find_format(f->fmt.pix.pixelformat,
 					      CS_SEL_ANY, true);
-	priv->vdev.compose = compose;
+	priv->vdev.compose.left = 0;
+	priv->vdev.compose.top = 0;
+	priv->vdev.compose.width = fmt_src.format.width;
+	priv->vdev.compose.height = fmt_src.format.height;
 
 	return 0;
 }
@@ -655,8 +655,7 @@ static struct video_device capture_videodev = {
 };
 
 void imx_media_capture_device_set_format(struct imx_media_video_dev *vdev,
-					 const struct v4l2_pix_format *pix,
-					 const struct v4l2_rect *compose)
+					 struct v4l2_pix_format *pix)
 {
 	struct capture_priv *priv = to_capture_priv(vdev);
 
@@ -664,7 +663,6 @@ void imx_media_capture_device_set_format(struct imx_media_video_dev *vdev,
 	priv->vdev.fmt.fmt.pix = *pix;
 	priv->vdev.cc = imx_media_find_format(pix->pixelformat, CS_SEL_ANY,
 					      true);
-	priv->vdev.compose = *compose;
 	mutex_unlock(&priv->mutex);
 }
 EXPORT_SYMBOL_GPL(imx_media_capture_device_set_format);
@@ -770,8 +768,10 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
 	}
 
 	vdev->fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-	imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix, &vdev->compose,
+	imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix,
 				      &fmt_src.format, NULL);
+	vdev->compose.width = fmt_src.format.width;
+	vdev->compose.height = fmt_src.format.height;
 	vdev->cc = imx_media_find_format(vdev->fmt.fmt.pix.pixelformat,
 					 CS_SEL_ANY, false);
 
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index c70fa6b509ae..09b89a72eaa2 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1512,7 +1512,6 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	struct v4l2_pix_format vdev_fmt;
 	struct v4l2_mbus_framefmt *fmt;
 	struct v4l2_rect *crop, *compose;
-	struct v4l2_rect vdev_compose;
 	int ret;
 
 	if (sdformat->pad >= CSI_NUM_PADS)
@@ -1568,11 +1567,11 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	priv->cc[sdformat->pad] = cc;
 
 	/* propagate IDMAC output pad format to capture device */
-	imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt, &vdev_compose,
+	imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt,
 				      &priv->format_mbus[CSI_SRC_PAD_IDMAC],
 				      priv->cc[CSI_SRC_PAD_IDMAC]);
 	mutex_unlock(&priv->lock);
-	imx_media_capture_device_set_format(vdev, &vdev_fmt, &vdev_compose);
+	imx_media_capture_device_set_format(vdev, &vdev_fmt);
 
 	return 0;
 out:
diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 8a6e57652402..a80ef0b087ad 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -577,8 +577,7 @@ void imx_media_fill_default_mbus_fields(struct v4l2_mbus_framefmt *tryfmt,
 EXPORT_SYMBOL_GPL(imx_media_fill_default_mbus_fields);
 
 int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
-				  struct v4l2_rect *compose,
-				  const struct v4l2_mbus_framefmt *mbus,
+				  struct v4l2_mbus_framefmt *mbus,
 				  const struct imx_media_pixfmt *cc)
 {
 	u32 width;
@@ -625,17 +624,6 @@ int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 	pix->sizeimage = cc->planar ? ((stride * pix->height * cc->bpp) >> 3) :
 			 stride * pix->height;
 
-	/*
-	 * set capture compose rectangle, which is fixed to the
-	 * source subdevice mbus format.
-	 */
-	if (compose) {
-		compose->left = 0;
-		compose->top = 0;
-		compose->width = mbus->width;
-		compose->height = mbus->height;
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_pix_fmt);
@@ -647,11 +635,13 @@ int imx_media_mbus_fmt_to_ipu_image(struct ipu_image *image,
 
 	memset(image, 0, sizeof(*image));
 
-	ret = imx_media_mbus_fmt_to_pix_fmt(&image->pix, &image->rect,
-					    mbus, NULL);
+	ret = imx_media_mbus_fmt_to_pix_fmt(&image->pix, mbus, NULL);
 	if (ret)
 		return ret;
 
+	image->rect.width = mbus->width;
+	image->rect.height = mbus->height;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_ipu_image);
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index 71e20f53ed7b..ddea972b7bc4 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -174,8 +174,7 @@ void imx_media_fill_default_mbus_fields(struct v4l2_mbus_framefmt *tryfmt,
 					struct v4l2_mbus_framefmt *fmt,
 					bool ic_route);
 int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
-				  struct v4l2_rect *compose,
-				  const struct v4l2_mbus_framefmt *mbus,
+				  struct v4l2_mbus_framefmt *mbus,
 				  const struct imx_media_pixfmt *cc);
 int imx_media_mbus_fmt_to_ipu_image(struct ipu_image *image,
 				    struct v4l2_mbus_framefmt *mbus);
@@ -280,8 +279,7 @@ void imx_media_capture_device_unregister(struct imx_media_video_dev *vdev);
 struct imx_media_buffer *
 imx_media_capture_device_next_buf(struct imx_media_video_dev *vdev);
 void imx_media_capture_device_set_format(struct imx_media_video_dev *vdev,
-					 const struct v4l2_pix_format *pix,
-					 const struct v4l2_rect *compose);
+					 struct v4l2_pix_format *pix);
 void imx_media_capture_device_error(struct imx_media_video_dev *vdev);
 
 /* subdev group ids */
-- 
2.17.1

