Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329CBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058C52072B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VOwSHww6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfLQDVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:21:41 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44285 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfLQDVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:36 -0500
Received: by mail-pj1-f65.google.com with SMTP id w5so3896243pjh.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2nJ0J7FGVQs+cpVk65h/j8h/oCaBmyGaNfS1BBVfwU=;
        b=VOwSHww64UK8lVnbq0iie30j1G3kCzbmqDSOhcMLrOe1O+CLUVhFWniqYW7RexNBge
         nBo2pt0lpjO6GvdrKabkT2piCGI88RcSxWH3bpSny9qWrYjuqDmoiDmhe/6CIfeLvSxg
         Z91V+OE6M3KYE5Cl5zKnukl8t0LV2JfH5n3ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2nJ0J7FGVQs+cpVk65h/j8h/oCaBmyGaNfS1BBVfwU=;
        b=ossd0AQIRa5P9WMOf6hm1Gr0guZW2YNaJkqOsL3X405wxwlbF1g0/DN/OE0qoOPSt8
         L8mRJgpz6HSV84QOKSTbwcNOSn3IzmmRwEtGsqRilOPaFglfxEXcOk7fOhY6pIZbuX6T
         a8ybkFConw7QHDSGJFrGRacz4Ha3F5iBn1n6a1yRuwmIV0ZezICw29IiaQ2+0NGotCxf
         DPFqaAhI41rUF6E+dqPayqqpmkN76kAqNqrHEx/tdKRbSTvpgNCcoPO769AUAHUl1gtO
         pwWSGkFJhddD6/Guql9c9wYzMlrFDUI7NOVkn9O8180QEMLaQDXuoxfbG0UfyoqK45dg
         3poQ==
X-Gm-Message-State: APjAAAVVrXeTq5TUcfUVl6aGffIWTMgzoXoIQ/vJ8NjXZ5okyMDXnBM3
        ziyhNFmBIcZgkbH0lRzRV+/ytA==
X-Google-Smtp-Source: APXvYqxAjpVAxx2qEeWMjQAtg7fvYC66i2cf6WUgxx/HIt3Z3bLSSdGnEBg84jo3LiW5Fp8gRLMzXw==
X-Received: by 2002:a17:90a:f005:: with SMTP id bt5mr3433452pjb.16.1576552896240;
        Mon, 16 Dec 2019 19:21:36 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:35 -0800 (PST)
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
Subject: [RFC][PATCH 15/15] videobuf2: don't test db_attach in dma-sg prepare and finish
Date:   Tue, 17 Dec 2019 12:20:34 +0900
Message-Id: <20191217032034.54897-16-senozhatsky@chromium.org>
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

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index bfc99a0cb7b9..1fd25eda0bf2 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -198,10 +198,6 @@ static void vb2_dma_sg_prepare(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (buf->db_attach)
-		return;
-
 	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
 			       buf->dma_dir);
 }
@@ -211,10 +207,6 @@ static void vb2_dma_sg_finish(void *buf_priv)
 	struct vb2_dma_sg_buf *buf = buf_priv;
 	struct sg_table *sgt = buf->dma_sgt;
 
-	/* DMABUF exporter will flush the cache for us */
-	if (buf->db_attach)
-		return;
-
 	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
 }
 
-- 
2.24.1.735.g03f4e72817-goog

