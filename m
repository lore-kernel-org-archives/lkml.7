Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B0E21909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126247;
	bh=sfOF722TNCF3FSCRFAza7gIMuAbO4yl0a052G13OuWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ajb2mzTQy22R13cXId7D+kU7MnOJWp0ekyEkX/AFJALZTBYUjPZ91sp2VChr60Pwu
	 apSu+z4HSsTXgMHZ8vbY71dW0ydqL+oUs5L6fjFSG/dmnyVXniUTqZJgT+r7agFNBj
	 jlPwes+juihuPagWS99nq2aW5iMSgaE54QG9FC6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbfDXRR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388615AbfDXRRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:23 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B4F21917;
        Wed, 24 Apr 2019 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126243;
        bh=sfOF722TNCF3FSCRFAza7gIMuAbO4yl0a052G13OuWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQVsibIlCEbCmY8LdFa8eYNOuHRXwEGrN0ZdgPmtr9aS5QetiMnJrhi0LYo6lMd8P
         46RuFbeWwWObIp2dmzejrCShxuZoyqbXI3ctFZZY8mqB/6BarOcns3iHWWf6MTZURB
         KzpXG1QnWY4hldhh3wUwBNiGQ0v1zy0oGhuz10UE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 040/168] media: s5p-g2d: Correct return type for mem2mem buffer helpers
Date:   Wed, 24 Apr 2019 19:08:04 +0200
Message-Id: <20190424170926.152119632@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e1936d9d27da..2b939555cccb 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -497,7 +497,7 @@ static void device_run(void *prv)
 {
 	struct g2d_ctx *ctx = prv;
 	struct g2d_dev *dev = ctx->dev;
-	struct vb2_buffer *src, *dst;
+	struct vb2_v4l2_buffer *src, *dst;
 	unsigned long flags;
 	u32 cmd = 0;
 
@@ -512,10 +512,10 @@ static void device_run(void *prv)
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



