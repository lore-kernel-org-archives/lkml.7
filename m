Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65BCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A4F20449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369991;
	bh=vkdvi2fMDm0vIzJWEIrxL0C3hSmVsFQBynfHR/Y1rvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0OLLHPJO67Q1uOwIj0+nAfVPeGmJkoRH/UMxERcCkCBW/tDp2QYl+89RdpnwnFib0
	 yeskpFEzsTZ6cRBcNvL+eVKf2JS/r7d7QXdNKFVFiV/zfLpQcWNLPZs8W0quVtijim
	 bUb59wyBXMy+2TGaPTwfRpm8C3DUjdAETpJyeBIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfDDJ0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733045AbfDDJNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E6D2075E;
        Thu,  4 Apr 2019 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369194;
        bh=vkdvi2fMDm0vIzJWEIrxL0C3hSmVsFQBynfHR/Y1rvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfYHSxACmln5axSysPlnPhK7l3h1wglVeYU0RyLplLr+SR5THdAipaN0dtpsoCIS0
         oM/+pwx4UhZkr4NUMsU/WDIEFk+7cKkGArMXgBFHQa8fjqZGBDmIQv2dI4F5R4FcvT
         CxPw2smypFI8ZMZNaRuFmcl5DINl3E50UIAwApE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 119/246] media: rockchip/vpu: Correct return type for mem2mem buffer helpers
Date:   Thu,  4 Apr 2019 10:46:59 +0200
Message-Id: <20190404084623.321623739@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 29701c3612fa025d5e8dc64c7a4ae8dc4763912e ]

Fix the assigned type of mem2mem buffer handling API.
Namely, these functions:

 v4l2_m2m_next_buf
 v4l2_m2m_last_buf
 v4l2_m2m_buf_remove
 v4l2_m2m_next_src_buf
 v4l2_m2m_next_dst_buf
 v4l2_m2m_last_src_buf
 v4l2_m2m_last_dst_buf
 v4l2_m2m_src_buf_remove
 v4l2_m2m_dst_buf_remove

return a struct vb2_v4l2_buffer, and not a struct vb2_buffer.

Fixing this is necessary to fix the mem2mem buffer handling API,
changing the return to the correct struct vb2_v4l2_buffer instead
of a void pointer.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c | 6 +++---
 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
index 5282236d1bb1..06daea66fb49 100644
--- a/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rk3288_vpu_hw_jpeg_enc.c
@@ -80,7 +80,7 @@ rk3288_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
 void rk3288_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
 {
 	struct rockchip_vpu_dev *vpu = ctx->dev;
-	struct vb2_buffer *src_buf, *dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct rockchip_vpu_jpeg_ctx jpeg_ctx;
 	u32 reg;
 
@@ -88,7 +88,7 @@ void rk3288_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
 	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
 
 	memset(&jpeg_ctx, 0, sizeof(jpeg_ctx));
-	jpeg_ctx.buffer = vb2_plane_vaddr(dst_buf, 0);
+	jpeg_ctx.buffer = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
 	jpeg_ctx.width = ctx->dst_fmt.width;
 	jpeg_ctx.height = ctx->dst_fmt.height;
 	jpeg_ctx.quality = ctx->jpeg_quality;
@@ -99,7 +99,7 @@ void rk3288_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
 			   VEPU_REG_ENC_CTRL);
 
 	rk3288_vpu_set_src_img_ctrl(vpu, ctx);
-	rk3288_vpu_jpeg_enc_set_buffers(vpu, ctx, src_buf);
+	rk3288_vpu_jpeg_enc_set_buffers(vpu, ctx, &src_buf->vb2_buf);
 	rk3288_vpu_jpeg_enc_set_qtable(vpu,
 				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
 				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
diff --git a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
index dbc86d95fe3b..3d438797692e 100644
--- a/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
+++ b/drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_jpeg_enc.c
@@ -111,7 +111,7 @@ rk3399_vpu_jpeg_enc_set_qtable(struct rockchip_vpu_dev *vpu,
 void rk3399_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
 {
 	struct rockchip_vpu_dev *vpu = ctx->dev;
-	struct vb2_buffer *src_buf, *dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct rockchip_vpu_jpeg_ctx jpeg_ctx;
 	u32 reg;
 
@@ -119,7 +119,7 @@ void rk3399_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
 	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
 
 	memset(&jpeg_ctx, 0, sizeof(jpeg_ctx));
-	jpeg_ctx.buffer = vb2_plane_vaddr(dst_buf, 0);
+	jpeg_ctx.buffer = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
 	jpeg_ctx.width = ctx->dst_fmt.width;
 	jpeg_ctx.height = ctx->dst_fmt.height;
 	jpeg_ctx.quality = ctx->jpeg_quality;
@@ -130,7 +130,7 @@ void rk3399_vpu_jpeg_enc_run(struct rockchip_vpu_ctx *ctx)
 			   VEPU_REG_ENCODE_START);
 
 	rk3399_vpu_set_src_img_ctrl(vpu, ctx);
-	rk3399_vpu_jpeg_enc_set_buffers(vpu, ctx, src_buf);
+	rk3399_vpu_jpeg_enc_set_buffers(vpu, ctx, &src_buf->vb2_buf);
 	rk3399_vpu_jpeg_enc_set_qtable(vpu,
 				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 0),
 				       rockchip_vpu_jpeg_get_qtable(&jpeg_ctx, 1));
-- 
2.19.1



