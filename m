Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66ACC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B759722C97
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfGYOSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:18:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44678 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGYOSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:18:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7A3FF28B83C
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 2/7] media: hantro: Simplify the controls creation logic
Date:   Thu, 25 Jul 2019 11:17:51 -0300
Message-Id: <20190725141756.2518-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725141756.2518-1-ezequiel@collabora.com>
References: <20190725141756.2518-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

v4l2_ctrl_new_custom() should work for any kind of control, including
standard ones. With that change, we automatically get support for
menu controls.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/hantro/hantro.h     |  2 --
 drivers/staging/media/hantro/hantro_drv.c | 28 +++++++----------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index 4d7cb7780bde..81e25dfc98b7 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -113,12 +113,10 @@ enum hantro_codec_mode {
 
 /*
  * struct hantro_ctrl - helper type to declare supported controls
- * @id:		V4L2 control ID (V4L2_CID_xxx)
  * @codec:	codec id this control belong to (HANTRO_JPEG_ENCODER, etc.)
  * @cfg:	control configuration
  */
 struct hantro_ctrl {
-	unsigned int id;
 	unsigned int codec;
 	struct v4l2_ctrl_config cfg;
 };
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 4eae1dbb1ac8..ff2dcbf43e81 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -264,31 +264,29 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
 
 static struct hantro_ctrl controls[] = {
 	{
-		.id = V4L2_CID_JPEG_COMPRESSION_QUALITY,
 		.codec = HANTRO_JPEG_ENCODER,
 		.cfg = {
+			.id = V4L2_CID_JPEG_COMPRESSION_QUALITY,
 			.min = 5,
 			.max = 100,
 			.step = 1,
 			.def = 50,
+			.ops = &hantro_ctrl_ops,
 		},
 	}, {
-		.id = V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS,
 		.codec = HANTRO_MPEG2_DECODER,
 		.cfg = {
-			.elem_size = sizeof(struct v4l2_ctrl_mpeg2_slice_params),
+			.id = V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS,
 		},
 	}, {
-		.id = V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION,
 		.codec = HANTRO_MPEG2_DECODER,
 		.cfg = {
-			.elem_size = sizeof(struct v4l2_ctrl_mpeg2_quantization),
+			.id = V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION,
 		},
 	}, {
-		.id = V4L2_CID_MPEG_VIDEO_VP8_FRAME_HEADER,
 		.codec = HANTRO_VP8_DECODER,
 		.cfg = {
-			.elem_size = sizeof(struct v4l2_ctrl_vp8_frame_header),
+			.id = V4L2_CID_MPEG_VIDEO_VP8_FRAME_HEADER,
 		},
 	},
 };
@@ -304,22 +302,12 @@ static int hantro_ctrls_setup(struct hantro_dev *vpu,
 	for (i = 0; i < num_ctrls; i++) {
 		if (!(allowed_codecs & controls[i].codec))
 			continue;
-		if (!controls[i].cfg.elem_size) {
-			v4l2_ctrl_new_std(&ctx->ctrl_handler,
-					  &hantro_ctrl_ops,
-					  controls[i].id, controls[i].cfg.min,
-					  controls[i].cfg.max,
-					  controls[i].cfg.step,
-					  controls[i].cfg.def);
-		} else {
-			controls[i].cfg.id = controls[i].id;
-			v4l2_ctrl_new_custom(&ctx->ctrl_handler,
-					     &controls[i].cfg, NULL);
-		}
 
+		v4l2_ctrl_new_custom(&ctx->ctrl_handler,
+				     &controls[i].cfg, NULL);
 		if (ctx->ctrl_handler.error) {
 			vpu_err("Adding control (%d) failed %d\n",
-				controls[i].id,
+				controls[i].cfg.id,
 				ctx->ctrl_handler.error);
 			v4l2_ctrl_handler_free(&ctx->ctrl_handler);
 			return ctx->ctrl_handler.error;
-- 
2.22.0

