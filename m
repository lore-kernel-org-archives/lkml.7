Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB37C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66E720449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370000;
	bh=0oUbaL/CjHomNdN3lIEdufG9DvVJsY4uleHk1KIbQvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e3LU92AZJwo2DEoxccoipa4//ky84mo3qwzQIscSDjvTHRC4dkkZZ82R11pqeJ4/0
	 zmmAM2hkrkOCzGQZPfiw5SPBwy69hIc0xyCmykTpj7fDfCcG3i0Qc0dnuSrXvnPS6k
	 AVXAv6GVJ3kQS5xmwzvPz2CkeC5oau9NtNrHeFo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfDDJNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733198AbfDDJNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F9C2075E;
        Thu,  4 Apr 2019 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369181;
        bh=0oUbaL/CjHomNdN3lIEdufG9DvVJsY4uleHk1KIbQvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ex/nEk2aDh6Smfa94TgziDp9ARdcrqLGiNU0/Ct6wkRAG16Stm2CnBBCAAf8fxOj7
         zePlLLffpFE99FDkEJMmwBDX2FUzLQKDQtk/wG4MxGWZVLvSbAOFh4NZQtXFM8Jpdn
         1lzV69uCnpxKeKi08NXkWN6wVzMk1/B/u7oaFS+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 114/246] media: s5p-jpeg: Correct return type for mem2mem buffer helpers
Date:   Thu,  4 Apr 2019 10:46:54 +0200
Message-Id: <20190404084623.144391089@linuxfoundation.org>
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

[ Upstream commit 4a88f89885c7cf65c62793f385261a6e3315178a ]

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
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 38 ++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 3f9000b70385..4b47d9f42117 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -793,14 +793,14 @@ static void skip(struct s5p_jpeg_buffer *buf, long len);
 static void exynos4_jpeg_parse_decode_h_tbl(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
-	struct vb2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	struct vb2_v4l2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	struct s5p_jpeg_buffer jpeg_buffer;
 	unsigned int word;
 	int c, x, components;
 
 	jpeg_buffer.size = 2; /* Ls */
 	jpeg_buffer.data =
-		(unsigned long)vb2_plane_vaddr(vb, 0) + ctx->out_q.sos + 2;
+		(unsigned long)vb2_plane_vaddr(&vb->vb2_buf, 0) + ctx->out_q.sos + 2;
 	jpeg_buffer.curr = 0;
 
 	word = 0;
@@ -830,14 +830,14 @@ static void exynos4_jpeg_parse_decode_h_tbl(struct s5p_jpeg_ctx *ctx)
 static void exynos4_jpeg_parse_huff_tbl(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
-	struct vb2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	struct vb2_v4l2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	struct s5p_jpeg_buffer jpeg_buffer;
 	unsigned int word;
 	int c, i, n, j;
 
 	for (j = 0; j < ctx->out_q.dht.n; ++j) {
 		jpeg_buffer.size = ctx->out_q.dht.len[j];
-		jpeg_buffer.data = (unsigned long)vb2_plane_vaddr(vb, 0) +
+		jpeg_buffer.data = (unsigned long)vb2_plane_vaddr(&vb->vb2_buf, 0) +
 				   ctx->out_q.dht.marker[j];
 		jpeg_buffer.curr = 0;
 
@@ -889,13 +889,13 @@ static void exynos4_jpeg_parse_huff_tbl(struct s5p_jpeg_ctx *ctx)
 static void exynos4_jpeg_parse_decode_q_tbl(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
-	struct vb2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	struct vb2_v4l2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	struct s5p_jpeg_buffer jpeg_buffer;
 	int c, x, components;
 
 	jpeg_buffer.size = ctx->out_q.sof_len;
 	jpeg_buffer.data =
-		(unsigned long)vb2_plane_vaddr(vb, 0) + ctx->out_q.sof;
+		(unsigned long)vb2_plane_vaddr(&vb->vb2_buf, 0) + ctx->out_q.sof;
 	jpeg_buffer.curr = 0;
 
 	skip(&jpeg_buffer, 5); /* P, Y, X */
@@ -920,14 +920,14 @@ static void exynos4_jpeg_parse_decode_q_tbl(struct s5p_jpeg_ctx *ctx)
 static void exynos4_jpeg_parse_q_tbl(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
-	struct vb2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	struct vb2_v4l2_buffer *vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	struct s5p_jpeg_buffer jpeg_buffer;
 	unsigned int word;
 	int c, i, j;
 
 	for (j = 0; j < ctx->out_q.dqt.n; ++j) {
 		jpeg_buffer.size = ctx->out_q.dqt.len[j];
-		jpeg_buffer.data = (unsigned long)vb2_plane_vaddr(vb, 0) +
+		jpeg_buffer.data = (unsigned long)vb2_plane_vaddr(&vb->vb2_buf, 0) +
 				   ctx->out_q.dqt.marker[j];
 		jpeg_buffer.curr = 0;
 
@@ -2072,15 +2072,15 @@ static void s5p_jpeg_device_run(void *priv)
 {
 	struct s5p_jpeg_ctx *ctx = priv;
 	struct s5p_jpeg *jpeg = ctx->jpeg;
-	struct vb2_buffer *src_buf, *dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	unsigned long src_addr, dst_addr, flags;
 
 	spin_lock_irqsave(&ctx->jpeg->slock, flags);
 
 	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
-	src_addr = vb2_dma_contig_plane_dma_addr(src_buf, 0);
-	dst_addr = vb2_dma_contig_plane_dma_addr(dst_buf, 0);
+	src_addr = vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
+	dst_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 
 	s5p_jpeg_reset(jpeg->regs);
 	s5p_jpeg_poweron(jpeg->regs);
@@ -2153,7 +2153,7 @@ static void exynos4_jpeg_set_img_addr(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
 	struct s5p_jpeg_fmt *fmt;
-	struct vb2_buffer *vb;
+	struct vb2_v4l2_buffer *vb;
 	struct s5p_jpeg_addr jpeg_addr = {};
 	u32 pix_size, padding_bytes = 0;
 
@@ -2172,7 +2172,7 @@ static void exynos4_jpeg_set_img_addr(struct s5p_jpeg_ctx *ctx)
 		vb = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
 	}
 
-	jpeg_addr.y = vb2_dma_contig_plane_dma_addr(vb, 0);
+	jpeg_addr.y = vb2_dma_contig_plane_dma_addr(&vb->vb2_buf, 0);
 
 	if (fmt->colplanes == 2) {
 		jpeg_addr.cb = jpeg_addr.y + pix_size - padding_bytes;
@@ -2190,7 +2190,7 @@ static void exynos4_jpeg_set_img_addr(struct s5p_jpeg_ctx *ctx)
 static void exynos4_jpeg_set_jpeg_addr(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
-	struct vb2_buffer *vb;
+	struct vb2_v4l2_buffer *vb;
 	unsigned int jpeg_addr = 0;
 
 	if (ctx->mode == S5P_JPEG_ENCODE)
@@ -2198,7 +2198,7 @@ static void exynos4_jpeg_set_jpeg_addr(struct s5p_jpeg_ctx *ctx)
 	else
 		vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 
-	jpeg_addr = vb2_dma_contig_plane_dma_addr(vb, 0);
+	jpeg_addr = vb2_dma_contig_plane_dma_addr(&vb->vb2_buf, 0);
 	if (jpeg->variant->version == SJPEG_EXYNOS5433 &&
 	    ctx->mode == S5P_JPEG_DECODE)
 		jpeg_addr += ctx->out_q.sos;
@@ -2314,7 +2314,7 @@ static void exynos3250_jpeg_set_img_addr(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
 	struct s5p_jpeg_fmt *fmt;
-	struct vb2_buffer *vb;
+	struct vb2_v4l2_buffer *vb;
 	struct s5p_jpeg_addr jpeg_addr = {};
 	u32 pix_size;
 
@@ -2328,7 +2328,7 @@ static void exynos3250_jpeg_set_img_addr(struct s5p_jpeg_ctx *ctx)
 		fmt = ctx->cap_q.fmt;
 	}
 
-	jpeg_addr.y = vb2_dma_contig_plane_dma_addr(vb, 0);
+	jpeg_addr.y = vb2_dma_contig_plane_dma_addr(&vb->vb2_buf, 0);
 
 	if (fmt->colplanes == 2) {
 		jpeg_addr.cb = jpeg_addr.y + pix_size;
@@ -2346,7 +2346,7 @@ static void exynos3250_jpeg_set_img_addr(struct s5p_jpeg_ctx *ctx)
 static void exynos3250_jpeg_set_jpeg_addr(struct s5p_jpeg_ctx *ctx)
 {
 	struct s5p_jpeg *jpeg = ctx->jpeg;
-	struct vb2_buffer *vb;
+	struct vb2_v4l2_buffer *vb;
 	unsigned int jpeg_addr = 0;
 
 	if (ctx->mode == S5P_JPEG_ENCODE)
@@ -2354,7 +2354,7 @@ static void exynos3250_jpeg_set_jpeg_addr(struct s5p_jpeg_ctx *ctx)
 	else
 		vb = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 
-	jpeg_addr = vb2_dma_contig_plane_dma_addr(vb, 0);
+	jpeg_addr = vb2_dma_contig_plane_dma_addr(&vb->vb2_buf, 0);
 	exynos3250_jpeg_jpgadr(jpeg->regs, jpeg_addr);
 }
 
-- 
2.19.1



