Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B67C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2620989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJn8MF4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE1F5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:57:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41609 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1F5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:57:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so5931402pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 22:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cr9DmSACRWwElyIdEHB89TB8XJbyBXhOtgtfrfFd+As=;
        b=lJn8MF4x1HkyIltXYODtNrg4J77wXJh8CFt67BY9rXXkXlF51O6cU+Xu0FPWwPdNhk
         RT1aBio7YPXERIIawoepiMUa4XcacM2UkznVqVf91jBTWx1wjUOYIaQuhW77rzyCBIm9
         k4q4NcNF5sau6zfSqyacDY342REoHZglVWWCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cr9DmSACRWwElyIdEHB89TB8XJbyBXhOtgtfrfFd+As=;
        b=H3I8TiXyNs0p2XVX7Bm0SNucq9DxqXGMqi996w97Ai0ZgNDVDBIJoYzPcHDn+bmsB6
         4usABE61gCfGgnAoA0RlCt4Ubded8NRTUUapHVN9k87tCgdzBXvIs69VoHvMe6MczWva
         d5ltFGBqc6I8s3zxc7kGTqm3XQq1PWWVFPMJQfWELXiIME/gZULsM6HTukjAeS1/0f6B
         oQh/llKHSxHiZOE5kQakhelN0lbkAXQ/cBS6fwpTnMGB3P5UMm2Tm2gqstGAs854QFO8
         8eNyeEBOh79IMHgLLYRvT01P541T3mJz7zA4M17NBJyfzGXwemtCwnmgnpTKmScBwKUH
         ykLQ==
X-Gm-Message-State: APjAAAU5F9FpY34C+5+XEJNFHJ2R9gUXcuswh5SvMHf/R22U4EoIkfPf
        4RGC2DepxSXaFEuav1JHW/ddOg==
X-Google-Smtp-Source: APXvYqy03VLJViisJT0RdWU5mPiOVRUaticUKnNz6A0I2rwSJlG2Gu+pAoIhuJLih5ErtxTaNrZKNA==
X-Received: by 2002:a65:64d5:: with SMTP id t21mr57064762pgv.310.1559023039265;
        Mon, 27 May 2019 22:57:19 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id w1sm13950551pfg.51.2019.05.27.22.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 22:57:18 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv1 03/12] media: mtk-vcodec: constify formats
Date:   Tue, 28 May 2019 14:56:26 +0900
Message-Id: <20190528055635.12109-4-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190528055635.12109-1-acourbot@chromium.org>
References: <20190528055635.12109-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formats are read-only internal memory structures, so make them const.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 19 ++++++++++---------
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  2 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 19 ++++++++++---------
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 851903867bc9..2175883e22d4 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -32,7 +32,7 @@
 #define DFT_CFG_WIDTH	MTK_VDEC_MIN_W
 #define DFT_CFG_HEIGHT	MTK_VDEC_MIN_H
 
-static struct mtk_video_fmt mtk_video_formats[] = {
+static const struct mtk_video_fmt mtk_video_formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_H264,
 		.type = MTK_FMT_DEC,
@@ -76,9 +76,9 @@ static const struct mtk_codec_framesizes mtk_vdec_framesizes[] = {
 #define NUM_SUPPORTED_FRAMESIZE ARRAY_SIZE(mtk_vdec_framesizes)
 #define NUM_FORMATS ARRAY_SIZE(mtk_video_formats)
 
-static struct mtk_video_fmt *mtk_vdec_find_format(struct v4l2_format *f)
+static const struct mtk_video_fmt *mtk_vdec_find_format(struct v4l2_format *f)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 	unsigned int k;
 
 	for (k = 0; k < NUM_FORMATS; k++) {
@@ -279,7 +279,7 @@ static void mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
 static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
 				unsigned int pixelformat)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 	struct mtk_q_data *dst_q_data;
 	unsigned int k;
 
@@ -652,7 +652,8 @@ static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 	}
 }
 
-static int vidioc_try_fmt(struct v4l2_format *f, struct mtk_video_fmt *fmt)
+static int vidioc_try_fmt(struct v4l2_format *f,
+			  const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 	int i;
@@ -725,7 +726,7 @@ static int vidioc_try_fmt(struct v4l2_format *f, struct mtk_video_fmt *fmt)
 static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 
 	fmt = mtk_vdec_find_format(f);
 	if (!fmt) {
@@ -740,7 +741,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 
 	fmt = mtk_vdec_find_format(f);
 	if (!fmt) {
@@ -834,7 +835,7 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	struct v4l2_pix_format_mplane *pix_mp;
 	struct mtk_q_data *q_data;
 	int ret = 0;
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 
 	mtk_v4l2_debug(3, "[%d]", ctx->id);
 
@@ -933,7 +934,7 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 
 static int vidioc_enum_fmt(struct v4l2_fmtdesc *f, bool output_queue)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 	int i, j = 0;
 
 	for (i = 0; i < NUM_FORMATS; i++) {
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 5da42f555b52..109c7578a8b2 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -137,7 +137,7 @@ struct mtk_q_data {
 	enum v4l2_field	field;
 	unsigned int	bytesperline[MTK_VCODEC_MAX_PLANES];
 	unsigned int	sizeimage[MTK_VCODEC_MAX_PLANES];
-	struct mtk_video_fmt	*fmt;
+	const struct mtk_video_fmt	*fmt;
 };
 
 /**
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 50351adafc47..2d5a61c06287 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -37,7 +37,7 @@
 
 static void mtk_venc_worker(struct work_struct *work);
 
-static struct mtk_video_fmt mtk_video_formats[] = {
+static const struct mtk_video_fmt mtk_video_formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12M,
 		.type = MTK_FMT_FRAME,
@@ -166,7 +166,7 @@ static const struct v4l2_ctrl_ops mtk_vcodec_enc_ctrl_ops = {
 
 static int vidioc_enum_fmt(struct v4l2_fmtdesc *f, bool output_queue)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 	int i, j = 0;
 
 	for (i = 0; i < NUM_FORMATS; ++i) {
@@ -274,9 +274,9 @@ static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_ctx *ctx,
 	return &ctx->q_data[MTK_Q_DATA_DST];
 }
 
-static struct mtk_video_fmt *mtk_venc_find_format(struct v4l2_format *f)
+static const struct mtk_video_fmt *mtk_venc_find_format(struct v4l2_format *f)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 	unsigned int k;
 
 	for (k = 0; k < NUM_FORMATS; k++) {
@@ -291,7 +291,8 @@ static struct mtk_video_fmt *mtk_venc_find_format(struct v4l2_format *f)
 /* V4L2 specification suggests the driver corrects the format struct if any of
  * the dimensions is unsupported
  */
-static int vidioc_try_fmt(struct v4l2_format *f, struct mtk_video_fmt *fmt)
+static int vidioc_try_fmt(struct v4l2_format *f,
+			  const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 	int i;
@@ -427,7 +428,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data;
 	int i, ret;
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
 	if (!vq) {
@@ -489,7 +490,7 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data;
 	int ret, i;
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
@@ -588,7 +589,7 @@ static int vidioc_venc_g_fmt(struct file *file, void *priv,
 static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 					 struct v4l2_format *f)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 
 	fmt = mtk_venc_find_format(f);
@@ -607,7 +608,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 					 struct v4l2_format *f)
 {
-	struct mtk_video_fmt *fmt;
+	const struct mtk_video_fmt *fmt;
 
 	fmt = mtk_venc_find_format(f);
 	if (!fmt) {
-- 
2.22.0.rc1.257.g3120a18244-goog

