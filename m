Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6256A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TkZntt8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfLQDVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:21:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35054 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfLQDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so2794727plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKpso3dYUpegkM+13TDZVLSc9HejGiHeDBGlLaBiNPU=;
        b=TkZntt8fEmKw6hceaNO9bkAbi74L8qrJ0OFAzLrKVD5utQiR4HzeU6o/8ucDhZlH6C
         njwJ21Q3JOKkRMBoXxWeV7/7ldlqmM0rmhMo04rGOIdrl9khww28BnfekRpilL/aLP2C
         0FYhDqxL1CKVQmJc7ifSPfMbTo+ybynMjgdK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKpso3dYUpegkM+13TDZVLSc9HejGiHeDBGlLaBiNPU=;
        b=JnpH/SgioILw4BZcYm1p0F6Cwyvo2V2vJI6mYp2Hlp2h8pDqk7T1etX/EBHVrxKLpZ
         Fr03Dwym7iYhu6ofsdgXKdOfqazrkMMIP14jBLiU4RIC99N6RMzDY0C8VrGC2+tUy6cj
         Q/zfEBLovKnCWBjoqG4FNV3f/NZnJvp5jYGE9eQY0M4tdMbM25J85Q5CVw1JhymyjrLO
         efhE2VdZYrZkodHhFDdgsxGopldPkJe1QSq/LbLJTirm2xOOit7ESFFQXln6xibP+yY+
         EB+Ilck4HTwggNuiVyAixUzP261Y2LzAiGoh5eKw8UeC0+R4xxy8EKjr7UuuOVxChlY1
         ctkg==
X-Gm-Message-State: APjAAAW/bm3a3dpx61OXkip1eLIERmYX4BDp238dwqOhjL83Po5ztl54
        HK85iuSMLhYV4QonIKoNYvM7uQ==
X-Google-Smtp-Source: APXvYqxPugT4hclwDVA+EXjf2wIQk1iSgic+RebeA058Lav/MO7sUXve5wYCEQ0D7qGywpjHfB61Nw==
X-Received: by 2002:a17:90a:c790:: with SMTP id gn16mr3487094pjb.76.1576552881605;
        Mon, 16 Dec 2019 19:21:21 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:21 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 11/15] videobuf2: add begin/end cpu_access callbacks to dma-contig
Date:   Tue, 17 Dec 2019 12:20:30 +0900
Message-Id: <20191217032034.54897-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide begin_cpu_access() and end_cpu_access() callbacks for
cache synchronisation on exported buffers.

The patch also adds a new helper function - vb2_dc_buffer_consistent(),
which returns true is if the buffer is consistent (DMA_ATTR_NON_CONSISTENT
bit cleared), so then we don't need to sync anything.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../common/videobuf2/videobuf2-dma-contig.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index d0c9dffe49e5..a387260fb321 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -42,6 +42,11 @@ struct vb2_dc_buf {
 	struct dma_buf_attachment	*db_attach;
 };
 
+static inline bool vb2_dc_buffer_consistent(unsigned long attr)
+{
+	return !(attr & DMA_ATTR_NON_CONSISTENT);
+}
+
 /*********************************************/
 /*        scatterlist table functions        */
 /*********************************************/
@@ -335,6 +340,32 @@ static void vb2_dc_dmabuf_ops_release(struct dma_buf *dbuf)
 	vb2_dc_put(dbuf->priv);
 }
 
+static int vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
+					      enum dma_data_direction direction)
+{
+	struct vb2_dc_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	if (vb2_dc_buffer_consistent(buf->attrs))
+		return 0;
+
+	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	return 0;
+}
+
+static int vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
+					    enum dma_data_direction direction)
+{
+	struct vb2_dc_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	if (vb2_dc_buffer_consistent(buf->attrs))
+		return 0;
+
+	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	return 0;
+}
+
 static void *vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf)
 {
 	struct vb2_dc_buf *buf = dbuf->priv;
@@ -353,6 +384,8 @@ static const struct dma_buf_ops vb2_dc_dmabuf_ops = {
 	.detach = vb2_dc_dmabuf_ops_detach,
 	.map_dma_buf = vb2_dc_dmabuf_ops_map,
 	.unmap_dma_buf = vb2_dc_dmabuf_ops_unmap,
+	.begin_cpu_access = vb2_dc_dmabuf_ops_begin_cpu_access,
+	.end_cpu_access = vb2_dc_dmabuf_ops_end_cpu_access,
 	.vmap = vb2_dc_dmabuf_ops_vmap,
 	.mmap = vb2_dc_dmabuf_ops_mmap,
 	.release = vb2_dc_dmabuf_ops_release,
-- 
2.24.1.735.g03f4e72817-goog

