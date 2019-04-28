Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE61C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCB72067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM5kQmIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfD1TJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:09:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35078 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfD1TJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:09:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so4114916pgs.2;
        Sun, 28 Apr 2019 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6/O/VbZitIzQ6radjmwu/2LTYKS18f235Ies7Oh8ng=;
        b=IM5kQmIhWVuFzz3W+IN/t4g18IVjUR2DhPN4AZPCL9sd09Xn/DUza3Zm4l0seues2U
         g8Dzn2Gn4WLfgr2sFQHJH0wNi+TN5dh0vfvehky2DUn+J6IQ5vQAtYbLNXvIRk+QeIhy
         qGVDddFrlrgjFWDvC2yjB/+ILbxuqeABqlosHw8ASrTA1AB6/RIzRdzxKxC6/qMHQJvE
         lecfeO8Xp5gKNS68YGqka/Wtuhl9+ICiMxf2VGYzG2hATQ0uE0hJDIQpKcBGQ243PNhd
         jYpPSkWZBRJfCSyx6qozm3z5SXiFlsuELGJrBzW26Z5XeKtwpBp32oJy0zMeVKqIXdYT
         12Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6/O/VbZitIzQ6radjmwu/2LTYKS18f235Ies7Oh8ng=;
        b=k6hmd1GFqd81ppx87dGvdu17bu8/Aed3oALEmpDSmnEYhmQd+OIVseFfTkBM732o7S
         XcjZGwyMRyHEumztTAKQXvlp9Yg13lJphQ3+Rwy2w0lpFwkuNENc0ARnG/50Cj8Ijh/l
         Td3XByA8amAR3U5gK6d3NEGjekA2I0IBWINE8Q0eKzqhdyExib/Syqgw0ssDD8tbduWQ
         nWdXyPiOpwAnNxUVokB2wOQ4YqIax8WgUegJ8EgrPxV4yX1pncloZMmQ/UAtjoMCKtkO
         A74srXIlEYC/hkcuSg8G1O1Ian1TCmLNbyjuCMRl1xYi6l6P+TGsSJt+3lAgdf3fGmY5
         cnQA==
X-Gm-Message-State: APjAAAUEjOE/KsBUQsZj0uVn25RbiroesadvgChrtXuufoGnoiO7B3NU
        iMo5bmQMFgGomjTuVXVftqy3mack
X-Google-Smtp-Source: APXvYqzkPsXoDekwviOeaN1YfQKJSE92Qv5V8O6CpFHDSdllX2PYF9o2hvBJHtHcSQv0CgXeldv6YQ==
X-Received: by 2002:a63:5020:: with SMTP id e32mr41681909pgb.215.1556478575062;
        Sun, 28 Apr 2019 12:09:35 -0700 (PDT)
Received: from majic.sklembedded.com (c-73-202-231-77.hsd1.ca.comcast.net. [73.202.231.77])
        by smtp.googlemail.com with ESMTPSA id o14sm34204712pgn.4.2019.04.28.12.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 12:09:34 -0700 (PDT)
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
        Rui Miguel Silva <rmfrfs@gmail.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/8] media: staging/imx: Remove capture_device_set_format
Date:   Sun, 28 Apr 2019 12:09:13 -0700
Message-Id: <20190428190916.26567-6-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428190916.26567-1-slongerbeam@gmail.com>
References: <20190428190916.26567-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't propagate the source pad format to the connected capture device.
It's now the responsibility of userspace to call VIDIOC_S_FMT on the
capture device to ensure the capture format and compose rectangle
are compatible with the connected source. To check this, validate
the capture format with the source before streaming starts.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c   | 16 +----
 drivers/staging/media/imx/imx-media-capture.c | 64 +++++++++++++------
 drivers/staging/media/imx/imx-media-csi.c     | 16 +----
 drivers/staging/media/imx/imx-media.h         |  2 -
 drivers/staging/media/imx/imx7-media-csi.c    | 18 +-----
 5 files changed, 50 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index afaa3a8b15e9..63334fd61492 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -906,9 +906,7 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 		       struct v4l2_subdev_format *sdformat)
 {
 	struct prp_priv *priv = sd_to_priv(sd);
-	struct imx_media_video_dev *vdev = priv->vdev;
 	const struct imx_media_pixfmt *cc;
-	struct v4l2_pix_format vdev_fmt;
 	struct v4l2_mbus_framefmt *fmt;
 	int ret = 0;
 
@@ -945,19 +943,9 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 			priv->cc[PRPENCVF_SRC_PAD] = outcc;
 	}
 
-	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY)
-		goto out;
-
-	priv->cc[sdformat->pad] = cc;
+	if (sdformat->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		priv->cc[sdformat->pad] = cc;
 
-	/* propagate output pad format to capture device */
-	imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt,
-				      &priv->format_mbus[PRPENCVF_SRC_PAD],
-				      priv->cc[PRPENCVF_SRC_PAD]);
-	mutex_unlock(&priv->lock);
-	imx_media_capture_device_set_format(vdev, &vdev_fmt);
-
-	return 0;
 out:
 	mutex_unlock(&priv->lock);
 	return ret;
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 555f6204660b..b77a67bda47c 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -205,7 +205,8 @@ static int capture_g_fmt_vid_cap(struct file *file, void *fh,
 
 static int __capture_try_fmt_vid_cap(struct capture_priv *priv,
 				     struct v4l2_subdev_format *fmt_src,
-				     struct v4l2_format *f)
+				     struct v4l2_format *f,
+				     struct v4l2_rect *compose)
 {
 	const struct imx_media_pixfmt *cc, *cc_src;
 
@@ -247,6 +248,13 @@ static int __capture_try_fmt_vid_cap(struct capture_priv *priv,
 
 	imx_media_mbus_fmt_to_pix_fmt(&f->fmt.pix, &fmt_src->format, cc);
 
+	if (compose) {
+		compose->left = 0;
+		compose->top = 0;
+		compose->width = fmt_src->format.width;
+		compose->height = fmt_src->format.height;
+	}
+
 	return 0;
 }
 
@@ -263,7 +271,7 @@ static int capture_try_fmt_vid_cap(struct file *file, void *fh,
 	if (ret)
 		return ret;
 
-	return __capture_try_fmt_vid_cap(priv, &fmt_src, f);
+	return __capture_try_fmt_vid_cap(priv, &fmt_src, f, NULL);
 }
 
 static int capture_s_fmt_vid_cap(struct file *file, void *fh,
@@ -271,6 +279,7 @@ static int capture_s_fmt_vid_cap(struct file *file, void *fh,
 {
 	struct capture_priv *priv = video_drvdata(file);
 	struct v4l2_subdev_format fmt_src;
+	struct v4l2_rect compose;
 	int ret;
 
 	if (vb2_is_busy(&priv->q)) {
@@ -284,17 +293,14 @@ static int capture_s_fmt_vid_cap(struct file *file, void *fh,
 	if (ret)
 		return ret;
 
-	ret = __capture_try_fmt_vid_cap(priv, &fmt_src, f);
+	ret = __capture_try_fmt_vid_cap(priv, &fmt_src, f, &compose);
 	if (ret)
 		return ret;
 
 	priv->vdev.fmt.fmt.pix = f->fmt.pix;
 	priv->vdev.cc = imx_media_find_format(f->fmt.pix.pixelformat,
 					      CS_SEL_ANY, true);
-	priv->vdev.compose.left = 0;
-	priv->vdev.compose.top = 0;
-	priv->vdev.compose.width = fmt_src.format.width;
-	priv->vdev.compose.height = fmt_src.format.height;
+	priv->vdev.compose = compose;
 
 	return 0;
 }
@@ -524,6 +530,33 @@ static void capture_buf_queue(struct vb2_buffer *vb)
 	spin_unlock_irqrestore(&priv->q_lock, flags);
 }
 
+static int capture_validate_fmt(struct capture_priv *priv)
+{
+	struct v4l2_subdev_format fmt_src;
+	struct v4l2_rect compose;
+	struct v4l2_format f;
+	int ret;
+
+	fmt_src.pad = priv->src_sd_pad;
+	fmt_src.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+	ret = v4l2_subdev_call(priv->src_sd, pad, get_fmt, NULL, &fmt_src);
+	if (ret)
+		return ret;
+
+	v4l2_fill_pix_format(&f.fmt.pix, &fmt_src.format);
+
+	ret = __capture_try_fmt_vid_cap(priv, &fmt_src, &f, &compose);
+	if (ret)
+		return ret;
+
+	return (priv->vdev.fmt.fmt.pix.width != f.fmt.pix.width ||
+		priv->vdev.fmt.fmt.pix.height != f.fmt.pix.height ||
+		priv->vdev.cc->cs !=
+		ipu_pixelformat_to_colorspace(f.fmt.pix.pixelformat) ||
+		priv->vdev.compose.width != compose.width ||
+		priv->vdev.compose.height != compose.height) ? -EINVAL : 0;
+}
+
 static int capture_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct capture_priv *priv = vb2_get_drv_priv(vq);
@@ -531,6 +564,10 @@ static int capture_start_streaming(struct vb2_queue *vq, unsigned int count)
 	unsigned long flags;
 	int ret;
 
+	ret = capture_validate_fmt(priv);
+	if (ret)
+		goto return_bufs;
+
 	ret = imx_media_pipeline_set_stream(priv->md, &priv->src_sd->entity,
 					    true);
 	if (ret) {
@@ -654,19 +691,6 @@ static struct video_device capture_videodev = {
 	.device_caps	= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING,
 };
 
-void imx_media_capture_device_set_format(struct imx_media_video_dev *vdev,
-					 struct v4l2_pix_format *pix)
-{
-	struct capture_priv *priv = to_capture_priv(vdev);
-
-	mutex_lock(&priv->mutex);
-	priv->vdev.fmt.fmt.pix = *pix;
-	priv->vdev.cc = imx_media_find_format(pix->pixelformat, CS_SEL_ANY,
-					      true);
-	mutex_unlock(&priv->mutex);
-}
-EXPORT_SYMBOL_GPL(imx_media_capture_device_set_format);
-
 struct imx_media_buffer *
 imx_media_capture_device_next_buf(struct imx_media_video_dev *vdev)
 {
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 09b89a72eaa2..68c2b1a3066a 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1506,10 +1506,8 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 		       struct v4l2_subdev_format *sdformat)
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
-	struct imx_media_video_dev *vdev = priv->vdev;
 	struct v4l2_fwnode_endpoint upstream_ep = { .bus_type = 0 };
 	const struct imx_media_pixfmt *cc;
-	struct v4l2_pix_format vdev_fmt;
 	struct v4l2_mbus_framefmt *fmt;
 	struct v4l2_rect *crop, *compose;
 	int ret;
@@ -1561,19 +1559,9 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 		}
 	}
 
-	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY)
-		goto out;
-
-	priv->cc[sdformat->pad] = cc;
+	if (sdformat->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		priv->cc[sdformat->pad] = cc;
 
-	/* propagate IDMAC output pad format to capture device */
-	imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt,
-				      &priv->format_mbus[CSI_SRC_PAD_IDMAC],
-				      priv->cc[CSI_SRC_PAD_IDMAC]);
-	mutex_unlock(&priv->lock);
-	imx_media_capture_device_set_format(vdev, &vdev_fmt);
-
-	return 0;
 out:
 	mutex_unlock(&priv->lock);
 	return ret;
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index ddea972b7bc4..f928697b0491 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -278,8 +278,6 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev);
 void imx_media_capture_device_unregister(struct imx_media_video_dev *vdev);
 struct imx_media_buffer *
 imx_media_capture_device_next_buf(struct imx_media_video_dev *vdev);
-void imx_media_capture_device_set_format(struct imx_media_video_dev *vdev,
-					 struct v4l2_pix_format *pix);
 void imx_media_capture_device_error(struct imx_media_video_dev *vdev);
 
 /* subdev group ids */
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index f2037aba6e0e..0ec4c57259f9 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1031,11 +1031,8 @@ static int imx7_csi_set_fmt(struct v4l2_subdev *sd,
 			    struct v4l2_subdev_format *sdformat)
 {
 	struct imx7_csi *csi = v4l2_get_subdevdata(sd);
-	struct imx_media_video_dev *vdev = csi->vdev;
 	const struct imx_media_pixfmt *outcc;
 	struct v4l2_mbus_framefmt *outfmt;
-	struct v4l2_pix_format vdev_fmt;
-	struct v4l2_rect vdev_compose;
 	const struct imx_media_pixfmt *cc;
 	struct v4l2_mbus_framefmt *fmt;
 	struct v4l2_subdev_format format;
@@ -1080,19 +1077,8 @@ static int imx7_csi_set_fmt(struct v4l2_subdev *sd,
 			csi->cc[IMX7_CSI_PAD_SRC] = outcc;
 	}
 
-	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY)
-		goto out_unlock;
-
-	csi->cc[sdformat->pad] = cc;
-
-	/* propagate output pad format to capture device */
-	imx_media_mbus_fmt_to_pix_fmt(&vdev_fmt, &vdev_compose,
-				      &csi->format_mbus[IMX7_CSI_PAD_SRC],
-				      csi->cc[IMX7_CSI_PAD_SRC]);
-	mutex_unlock(&csi->lock);
-	imx_media_capture_device_set_format(vdev, &vdev_fmt, &vdev_compose);
-
-	return 0;
+	if (sdformat->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		csi->cc[sdformat->pad] = cc;
 
 out_unlock:
 	mutex_unlock(&csi->lock);
-- 
2.17.1

