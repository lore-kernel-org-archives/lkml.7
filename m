Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658EDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B51F2072B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IlxyAEG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfLQDVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:21:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43929 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfLQDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id p27so5401897pli.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFEIyoVpgIiZPWgOi7cYDTwwo0QeHnWmkB+lTxTskhE=;
        b=IlxyAEG9H/d0X8DB0Z97LY5Y3XW0s5ZYxQ3MmndkfKOb0ZiUNZvSCxwCfJQGOQ/HJT
         uoVYD/BmTAPepE2OnS+P6ouBsghsigzA1bA/Ko72rb9HNKMwDgWRzGQLPRJXtI86l/5E
         NL82cHZA0XI3Hs3aSjMb1LXFeCy3LWPlQaDkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFEIyoVpgIiZPWgOi7cYDTwwo0QeHnWmkB+lTxTskhE=;
        b=YVbWo5VQWMA746ApHgu701mWVKquw1+LwD6F+zz+E1BfKQiLgskBCSg3w2AVRObTff
         LUF3NFr0QKxP8Emjsaq8hXDUPIUYeKUeU5aW0czI7T9jpImiGan/jXXo1yfZUtodGbuy
         Pc9+NdKSUrbgpKBVaDYN+imdiccml4YZ1jnTd0ROJE2aQrqEqqIKAAc5MdQcy1DBWrAX
         3xw4QFtHO9n9VbL7XC889hmtCavkPx9JMV7Jyw/JM9Ou9FfJ78WbgWbmRxsb350P556U
         rmAEMojSQSED6/xs8jEIa9D+CVutZ4Tl2hz6Xf354T7AHBckuTJEViKPBvoqrqELa7IM
         Pb4w==
X-Gm-Message-State: APjAAAUNEcgXB8h2CLK+kbDoGX8qSu8pj/47xWYBkAODlYMVqP36uo5M
        l+5ZigNK5MWqmHDVPkaqtQjaVQ==
X-Google-Smtp-Source: APXvYqzSX2fZ/19yWoefdlEe3u9XKfYlWYyOFbp2pV5FyZoP76hMRJsxZLzKzJ7hQKjOUUMcizqTow==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9mr8152934pln.230.1576552892689;
        Mon, 16 Dec 2019 19:21:32 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:32 -0800 (PST)
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
Subject: [RFC][PATCH 14/15] videobuf2: don't test db_attach in dma-contig prepare and finish
Date:   Tue, 17 Dec 2019 12:20:33 +0900
Message-Id: <20191217032034.54897-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We moved cache management decision making to the upper layer and
rely on buffer's need_cache_sync flags and videobuf2 core. If the
upper layer (core) has decided to invoke ->prepare() or ->finish()
then we must sync.

For DMABUF ->need_cache_sync_on_prepare and ->need_cache_sync_on_flush
are always false so videobuf core does not call ->prepare() and
->finish() on such buffers.

Additionally, scratch the DMABUF comment.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index a387260fb321..6ea0961149d7 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -100,8 +100,7 @@ static void vb2_dc_prepare(void *buf_priv)
 	struct vb2_dc_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (!sgt || buf->db_attach)
+	if (!sgt)
 		return;
 
 	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
@@ -113,8 +112,7 @@ static void vb2_dc_finish(void *buf_priv)
 	struct vb2_dc_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (!sgt || buf->db_attach)
+	if (!sgt)
 		return;
 
 	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
-- 
2.24.1.735.g03f4e72817-goog

