Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD7C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999472080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7yVPhw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgAGJpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:45:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43118 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgAGJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:45:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so27241308pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sf+dKygnoGuBAl0Gm6RSOooq1hpx1tc4bjkND4HWKw0=;
        b=B7yVPhw0+TTp7TBSp/vb39XEYKfl3xAAiB5erDI5V7LdIX1LYpf2OnteL1W5yBRSD+
         w1FSf5c2avFchip8igPgFCIsPT0E1AT9UjXDInqDQSF0wXcf89GDuYuslW8KoXKZNbIP
         0PKkCcYc7qgrDMpZ96yz32yewjTXbgn/bx5Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sf+dKygnoGuBAl0Gm6RSOooq1hpx1tc4bjkND4HWKw0=;
        b=o6aMtPf10hN0Q5txWAUEK6roYaA1lDKRTNs287aB+xnPMK1AqGxdx0zNqVIFqF19PO
         riQblNeMi6CaPoA9ge/O/zzsy2HwS9YGoZupT8hbyV5YW0qS1ZN8pK9YV5ppoHjrTTGl
         ELll1ZP9d1XOMCRgbnyFM2VKLiZ//4aC6UrmGcw9g8cljKQNhwCicrJoWV5cWjBFgN/I
         jRiVD9imBYP1FEkRp8rB3b80N84BBO5AUr5qvLesSNQI0ze9uVPBrZPaNeYJKuI47OpZ
         bJRYEOB+JOE6O4sXsy5E978+w0EyE3LeDOKBEJEzGdKQe1iiY1R6RdrW+thz0r6SQ1Y2
         mUAg==
X-Gm-Message-State: APjAAAVJ3Gg+KKfkOIIi2jGlivcq9eVFyrcPnQhRAjq+ehT4NPb2lSDQ
        iLnujcxAuDqo3mjqYHig2AJyFw==
X-Google-Smtp-Source: APXvYqyvF5i0/Mjk1sGa94/M4CC/2LJf5/FxDsRcxTVn7F1b0xY/rzENpPeLkjKrkXnRcGIoWq5QlA==
X-Received: by 2002:a65:4381:: with SMTP id m1mr117664977pgp.68.1578390310384;
        Tue, 07 Jan 2020 01:45:10 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id t63sm82287349pfb.70.2020.01.07.01.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:45:09 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] media: mtk-vcodec: use v4l2_m2m_buffer where appropriate
Date:   Tue,  7 Jan 2020 18:44:48 +0900
Message-Id: <20200107094448.111656-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite using M2M in both the decoder and encoder, this driver used
vb2_v4l2_buffer as its base buffer structure, and placed a list_head
right after the buffer declaration in order to match the layout of a
v4l2_m2m_buffer. This is very dangerous as it means the driver will
break should the layout of v4l2_m2m_buffer change.

Fix this by directly using v4l2_m2m_buffer and updating the sites that
accessed the buffer accordingly.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 64 ++++++++++---------
 .../platform/mtk-vcodec/mtk_vcodec_dec.h      |  7 +-
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  2 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 14 ++--
 .../platform/mtk-vcodec/mtk_vcodec_enc.h      |  8 +--
 5 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 858727824889..eb89127cb1de 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -104,6 +104,7 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
 {
 	struct vdec_fb *disp_frame_buffer = NULL;
 	struct mtk_video_dec_buf *dstbuf;
+	struct vb2_v4l2_buffer *vb;
 
 	mtk_v4l2_debug(3, "[%d]", ctx->id);
 	if (vdec_if_get_param(ctx,
@@ -121,25 +122,26 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
 
 	dstbuf = container_of(disp_frame_buffer, struct mtk_video_dec_buf,
 				frame_buffer);
+	vb = &dstbuf->m2m_buf.vb;
 	mutex_lock(&ctx->lock);
 	if (dstbuf->used) {
-		vb2_set_plane_payload(&dstbuf->vb.vb2_buf, 0,
+		vb2_set_plane_payload(&vb->vb2_buf, 0,
 					ctx->picinfo.fb_sz[0]);
 		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
-			vb2_set_plane_payload(&dstbuf->vb.vb2_buf, 1,
+			vb2_set_plane_payload(&vb->vb2_buf, 1,
 					      ctx->picinfo.fb_sz[1]);
 
 		mtk_v4l2_debug(2,
 				"[%d]status=%x queue id=%d to done_list %d",
 				ctx->id, disp_frame_buffer->status,
-				dstbuf->vb.vb2_buf.index,
+				vb->vb2_buf.index,
 				dstbuf->queued_in_vb2);
 
-		v4l2_m2m_buf_done(&dstbuf->vb, VB2_BUF_STATE_DONE);
+		v4l2_m2m_buf_done(vb, VB2_BUF_STATE_DONE);
 		ctx->decoded_frame_cnt++;
 	}
 	mutex_unlock(&ctx->lock);
-	return &dstbuf->vb.vb2_buf;
+	return &vb->vb2_buf;
 }
 
 /*
@@ -154,6 +156,7 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_video_dec_buf *dstbuf;
 	struct vdec_fb *free_frame_buffer = NULL;
+	struct vb2_v4l2_buffer *vb;
 
 	if (vdec_if_get_param(ctx,
 				GET_PARAM_FREE_FRAME_BUFFER,
@@ -171,6 +174,7 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 
 	dstbuf = container_of(free_frame_buffer, struct mtk_video_dec_buf,
 				frame_buffer);
+	vb = &dstbuf->m2m_buf.vb;
 
 	mutex_lock(&ctx->lock);
 	if (dstbuf->used) {
@@ -187,9 +191,9 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 			mtk_v4l2_debug(2,
 				"[%d]status=%x queue id=%d to rdy_queue %d",
 				ctx->id, free_frame_buffer->status,
-				dstbuf->vb.vb2_buf.index,
+				vb->vb2_buf.index,
 				dstbuf->queued_in_vb2);
-			v4l2_m2m_buf_queue(ctx->m2m_ctx, &dstbuf->vb);
+			v4l2_m2m_buf_queue(ctx->m2m_ctx, vb);
 		} else if ((dstbuf->queued_in_vb2 == false) &&
 			   (dstbuf->queued_in_v4l2 == true)) {
 			/*
@@ -205,8 +209,8 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 			mtk_v4l2_debug(2,
 					"[%d]status=%x queue id=%d to rdy_queue",
 					ctx->id, free_frame_buffer->status,
-					dstbuf->vb.vb2_buf.index);
-			v4l2_m2m_buf_queue(ctx->m2m_ctx, &dstbuf->vb);
+					vb->vb2_buf.index);
+			v4l2_m2m_buf_queue(ctx->m2m_ctx, vb);
 			dstbuf->queued_in_vb2 = true;
 		} else {
 			/*
@@ -219,14 +223,14 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 			 */
 			mtk_v4l2_debug(3, "[%d]status=%x err queue id=%d %d %d",
 					ctx->id, free_frame_buffer->status,
-					dstbuf->vb.vb2_buf.index,
+					vb->vb2_buf.index,
 					dstbuf->queued_in_vb2,
 					dstbuf->queued_in_v4l2);
 		}
 		dstbuf->used = false;
 	}
 	mutex_unlock(&ctx->lock);
-	return &dstbuf->vb.vb2_buf;
+	return &vb->vb2_buf;
 }
 
 static void clean_display_buffer(struct mtk_vcodec_ctx *ctx)
@@ -365,8 +369,10 @@ static void mtk_vdec_worker(struct work_struct *work)
 		return;
 	}
 
-	src_buf_info = container_of(src_buf, struct mtk_video_dec_buf, vb);
-	dst_buf_info = container_of(dst_buf, struct mtk_video_dec_buf, vb);
+	src_buf_info = container_of(src_buf, struct mtk_video_dec_buf,
+				    m2m_buf.vb);
+	dst_buf_info = container_of(dst_buf, struct mtk_video_dec_buf,
+				    m2m_buf.vb);
 
 	pfb = &dst_buf_info->frame_buffer;
 	pfb->base_y.va = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
@@ -397,11 +403,11 @@ static void mtk_vdec_worker(struct work_struct *work)
 
 		vdec_if_decode(ctx, NULL, NULL, &res_chg);
 		clean_display_buffer(ctx);
-		vb2_set_plane_payload(&dst_buf_info->vb.vb2_buf, 0, 0);
+		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
 		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
-			vb2_set_plane_payload(&dst_buf_info->vb.vb2_buf, 1, 0);
+			vb2_set_plane_payload(&dst_buf->vb2_buf, 1, 0);
 		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
-		v4l2_m2m_buf_done(&dst_buf_info->vb, VB2_BUF_STATE_DONE);
+		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
 		clean_free_buffer(ctx);
 		v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
 		return;
@@ -417,10 +423,8 @@ static void mtk_vdec_worker(struct work_struct *work)
 	}
 	mtk_v4l2_debug(3, "[%d] Bitstream VA=%p DMA=%pad Size=%zx vb=%p",
 			ctx->id, buf.va, &buf.dma_addr, buf.size, src_buf);
-	dst_buf_info->vb.vb2_buf.timestamp
-			= src_buf_info->vb.vb2_buf.timestamp;
-	dst_buf_info->vb.timecode
-			= src_buf_info->vb.timecode;
+	dst_buf->vb2_buf.timestamp = src_buf->vb2_buf.timestamp;
+	dst_buf->timecode = src_buf->timecode;
 	mutex_lock(&ctx->lock);
 	dst_buf_info->used = true;
 	mutex_unlock(&ctx->lock);
@@ -434,7 +438,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 			ctx->id,
 			src_buf->vb2_buf.index,
 			buf.size,
-			src_buf_info->vb.vb2_buf.timestamp,
+			src_buf->vb2_buf.timestamp,
 			dst_buf->vb2_buf.index,
 			ret, res_chg);
 		src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
@@ -443,14 +447,14 @@ static void mtk_vdec_worker(struct work_struct *work)
 			src_buf_info->error = true;
 			mutex_unlock(&ctx->lock);
 		}
-		v4l2_m2m_buf_done(&src_buf_info->vb, VB2_BUF_STATE_ERROR);
+		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
 	} else if (res_chg == false) {
 		/*
 		 * we only return src buffer with VB2_BUF_STATE_DONE
 		 * when decode success without resolution change
 		 */
 		src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
-		v4l2_m2m_buf_done(&src_buf_info->vb, VB2_BUF_STATE_DONE);
+		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
 	}
 
 	dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
@@ -522,7 +526,8 @@ static int vidioc_decoder_cmd(struct file *file, void *priv,
 			mtk_v4l2_debug(1, "Capture stream is off. No need to flush.");
 			return 0;
 		}
-		v4l2_m2m_buf_queue(ctx->m2m_ctx, &ctx->empty_flush_buf->vb);
+		v4l2_m2m_buf_queue(ctx->m2m_ctx,
+				   &ctx->empty_flush_buf->m2m_buf.vb);
 		v4l2_m2m_try_schedule(ctx->m2m_ctx);
 		break;
 
@@ -1148,7 +1153,8 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
 	 */
 	if (vb->vb2_queue->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		vb2_v4l2 = to_vb2_v4l2_buffer(vb);
-		buf = container_of(vb2_v4l2, struct mtk_video_dec_buf, vb);
+		buf = container_of(vb2_v4l2, struct mtk_video_dec_buf,
+				   m2m_buf.vb);
 		mutex_lock(&ctx->lock);
 		if (buf->used == false) {
 			v4l2_m2m_buf_queue(ctx->m2m_ctx, vb2_v4l2);
@@ -1175,7 +1181,7 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
 		mtk_v4l2_err("No src buffer");
 		return;
 	}
-	buf = container_of(src_buf, struct mtk_video_dec_buf, vb);
+	buf = container_of(src_buf, struct mtk_video_dec_buf, m2m_buf.vb);
 	if (buf->lastframe) {
 		/* This shouldn't happen. Just in case. */
 		mtk_v4l2_err("Invalid flush buffer.");
@@ -1256,7 +1262,7 @@ static void vb2ops_vdec_buf_finish(struct vb2_buffer *vb)
 	bool buf_error;
 
 	vb2_v4l2 = container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
-	buf = container_of(vb2_v4l2, struct mtk_video_dec_buf, vb);
+	buf = container_of(vb2_v4l2, struct mtk_video_dec_buf, m2m_buf.vb);
 	mutex_lock(&ctx->lock);
 	if (vb->vb2_queue->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		buf->queued_in_v4l2 = false;
@@ -1276,7 +1282,7 @@ static int vb2ops_vdec_buf_init(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vb2_v4l2 = container_of(vb,
 					struct vb2_v4l2_buffer, vb2_buf);
 	struct mtk_video_dec_buf *buf = container_of(vb2_v4l2,
-					struct mtk_video_dec_buf, vb);
+					struct mtk_video_dec_buf, m2m_buf.vb);
 
 	if (vb->vb2_queue->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		buf->used = false;
@@ -1309,7 +1315,7 @@ static void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		while ((src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx))) {
 			struct mtk_video_dec_buf *buf_info = container_of(
-					src_buf, struct mtk_video_dec_buf, vb);
+				 src_buf, struct mtk_video_dec_buf, m2m_buf.vb);
 			if (!buf_info->lastframe)
 				v4l2_m2m_buf_done(src_buf,
 						VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
index e0c5338bde3d..cf26b6c1486a 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
@@ -9,7 +9,7 @@
 #define _MTK_VCODEC_DEC_H_
 
 #include <media/videobuf2-core.h>
-#include <media/videobuf2-v4l2.h>
+#include <media/v4l2-mem2mem.h>
 
 #define VCODEC_CAPABILITY_4K_DISABLED	0x10
 #define VCODEC_DEC_4K_CODED_WIDTH	4096U
@@ -33,7 +33,7 @@ struct vdec_fb {
 
 /**
  * struct mtk_video_dec_buf - Private data related to each VB2 buffer.
- * @b:		VB2 buffer
+ * @m2m_buf:	M2M buffer
  * @list:	link list
  * @used:	Capture buffer contain decoded frame data and keep in
  *			codec data structure
@@ -47,8 +47,7 @@ struct vdec_fb {
  * Note : These status information help us track and debug buffer state
  */
 struct mtk_video_dec_buf {
-	struct vb2_v4l2_buffer	vb;
-	struct list_head	list;
+	struct v4l2_m2m_buffer	m2m_buf;
 
 	bool	used;
 	bool	queued_in_vb2;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 944771ee5f5c..100ae8c5e702 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -137,7 +137,7 @@ static int fops_vcodec_open(struct file *file)
 	}
 	src_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
 				V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
-	ctx->empty_flush_buf->vb.vb2_buf.vb2_queue = src_vq;
+	ctx->empty_flush_buf->m2m_buf.vb.vb2_buf.vb2_queue = src_vq;
 	ctx->empty_flush_buf->lastframe = true;
 	mtk_vcodec_dec_set_default_params(ctx);
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 6aad53d97d74..d469ff6464b2 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -795,13 +795,14 @@ static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
 			container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
 
 	struct mtk_video_enc_buf *mtk_buf =
-			container_of(vb2_v4l2, struct mtk_video_enc_buf, vb);
+			container_of(vb2_v4l2, struct mtk_video_enc_buf,
+				     m2m_buf.vb);
 
 	if ((vb->vb2_queue->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) &&
 	    (ctx->param_change != MTK_ENCODE_PARAM_NONE)) {
 		mtk_v4l2_debug(1, "[%d] Before id=%d encode parameter change %x",
 			       ctx->id,
-			       mtk_buf->vb.vb2_buf.index,
+			       vb2_v4l2->vb2_buf.index,
 			       ctx->param_change);
 		mtk_buf->param_change = ctx->param_change;
 		mtk_buf->enc_params = ctx->enc_params;
@@ -983,7 +984,8 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 	struct venc_enc_param enc_prm;
 	struct vb2_v4l2_buffer *vb2_v4l2 = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
 	struct mtk_video_enc_buf *mtk_buf =
-			container_of(vb2_v4l2, struct mtk_video_enc_buf, vb);
+			container_of(vb2_v4l2, struct mtk_video_enc_buf,
+				     m2m_buf.vb);
 
 	int ret = 0;
 
@@ -995,7 +997,7 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 		enc_prm.bitrate = mtk_buf->enc_params.bitrate;
 		mtk_v4l2_debug(1, "[%d] id=%d, change param br=%d",
 				ctx->id,
-				mtk_buf->vb.vb2_buf.index,
+				vb2_v4l2->vb2_buf.index,
 				enc_prm.bitrate);
 		ret |= venc_if_set_param(ctx,
 					 VENC_SET_PARAM_ADJUST_BITRATE,
@@ -1006,7 +1008,7 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 				   mtk_buf->enc_params.framerate_denom;
 		mtk_v4l2_debug(1, "[%d] id=%d, change param fr=%d",
 			       ctx->id,
-			       mtk_buf->vb.vb2_buf.index,
+			       vb2_v4l2->vb2_buf.index,
 			       enc_prm.frm_rate);
 		ret |= venc_if_set_param(ctx,
 					 VENC_SET_PARAM_ADJUST_FRAMERATE,
@@ -1023,7 +1025,7 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 	if (!ret && mtk_buf->param_change & MTK_ENCODE_PARAM_FORCE_INTRA) {
 		mtk_v4l2_debug(1, "[%d] id=%d, change param force I=%d",
 				ctx->id,
-				mtk_buf->vb.vb2_buf.index,
+				vb2_v4l2->vb2_buf.index,
 				mtk_buf->enc_params.force_intra);
 		if (mtk_buf->enc_params.force_intra)
 			ret |= venc_if_set_param(ctx,
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
index a9c9f86b9c83..513ee7993e34 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
@@ -9,7 +9,7 @@
 #define _MTK_VCODEC_ENC_H_
 
 #include <media/videobuf2-core.h>
-#include <media/videobuf2-v4l2.h>
+#include <media/v4l2-mem2mem.h>
 
 #define MTK_VENC_IRQ_STATUS_SPS	0x1
 #define MTK_VENC_IRQ_STATUS_PPS	0x2
@@ -23,15 +23,15 @@
 
 /**
  * struct mtk_video_enc_buf - Private data related to each VB2 buffer.
- * @vb: Pointer to related VB2 buffer.
+ * @m2m_buf:	M2M buffer
  * @list:	list that buffer link to
  * @param_change: Types of encode parameter change before encoding this
  *				buffer
  * @enc_params: Encode parameters changed before encode this buffer
  */
 struct mtk_video_enc_buf {
-	struct vb2_v4l2_buffer vb;
-	struct list_head list;
+	struct v4l2_m2m_buffer m2m_buf;
+
 	u32 param_change;
 	struct mtk_enc_params enc_params;
 };
-- 
2.24.1.735.g03f4e72817-goog

