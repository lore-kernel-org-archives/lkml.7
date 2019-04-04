Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4892C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847E12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371756;
	bh=Swgsv4Gt59HeH8luEsQc2lH7XTqcuHh8zqBtyERinZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsrQi/StWf/Fs2DBqSuD3W5L+FsULRhbWLVCj4mGcNQ/uYV9SwofrhX8kRnmm7bza
	 bkgrYMwAXfw3oFJn8zEfHcESfdnq/wnpDqish8fb8pDrsFDETnqHMP7C1QOceGPwL0
	 V66BOPbdTLZeUJVaa4Aio0P+ETgmi7A4HTJX9PUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfDDJzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbfDDIvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEAB21738;
        Thu,  4 Apr 2019 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367879;
        bh=Swgsv4Gt59HeH8luEsQc2lH7XTqcuHh8zqBtyERinZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXYVN5wsNiRHFWZ9XOT/pOke8gdZAJliZPK7qRLgB4jKsIb+X8eaM//Ccrcdprpya
         24Y+XJCXBv3GgThdJAWnJImRx9XqPmCYlhzI7WTO7sHm6ajb9nieTQ3GTlfkOyqhlU
         QmC70jXhHZT96CJOZZHiElzSaMdr0qmx4pPOVR/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 47/91] media: s5p-g2d: Correct return type for mem2mem buffer helpers
Date:   Thu,  4 Apr 2019 10:47:31 +0200
Message-Id: <20190404084538.191081566@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 30fa627b32230737bc3f678067e2adfecf956987 ]

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
 drivers/media/platform/s5p-g2d/g2d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index 62c0dec30b59..5f6ccf492111 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -498,7 +498,7 @@ static void device_run(void *prv)
 {
 	struct g2d_ctx *ctx = prv;
 	struct g2d_dev *dev = ctx->dev;
-	struct vb2_buffer *src, *dst;
+	struct vb2_v4l2_buffer *src, *dst;
 	unsigned long flags;
 	u32 cmd = 0;
 
@@ -513,10 +513,10 @@ static void device_run(void *prv)
 	spin_lock_irqsave(&dev->ctrl_lock, flags);
 
 	g2d_set_src_size(dev, &ctx->in);
-	g2d_set_src_addr(dev, vb2_dma_contig_plane_dma_addr(src, 0));
+	g2d_set_src_addr(dev, vb2_dma_contig_plane_dma_addr(&src->vb2_buf, 0));
 
 	g2d_set_dst_size(dev, &ctx->out);
-	g2d_set_dst_addr(dev, vb2_dma_contig_plane_dma_addr(dst, 0));
+	g2d_set_dst_addr(dev, vb2_dma_contig_plane_dma_addr(&dst->vb2_buf, 0));
 
 	g2d_set_rop4(dev, ctx->rop);
 	g2d_set_flip(dev, ctx->flip);
-- 
2.19.1



