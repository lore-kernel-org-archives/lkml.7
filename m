Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E26C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1355721835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AuyeJPrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLQDUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:20:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45304 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfLQDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:20:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so6715598pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQU25h5Spo3bbOg5zOxdwOlScB+ZgzGM7jWNIFKX5qo=;
        b=AuyeJPrs+C5UHSNUQ1/hQz67goI/N0/Nb7veYBfr9IiTDOqWSusJ64kUodFVC+g3ju
         au+IMXsBOOZJm/80/2yPSIoD4G7H/AuV0fgOMGhlZ+l9PRwgliwtPFaMCOCxbynLR6Xq
         X4KY88/Vc75Hfm3bFXlrPJ0Sn1Jd+guYRU5jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQU25h5Spo3bbOg5zOxdwOlScB+ZgzGM7jWNIFKX5qo=;
        b=H0wTRcu4fDnuUls+W+PEljg5XcI3afkAfX9Q81yL7VCSlEvVCQqCf4uoXwromDoukn
         kYmmNdXPjHmTjbkFtWKNxDBP3BsannVvK3Jj+wTrdTJcEzjRFhIp+LtW2/4prvmjk20a
         tNOzLaANDPGPxntDK4zhuuusYerMq0w1xk/+L5C3JM1qbsY/HWElztVii0WHNsbU8KSn
         QmDJlX2eL4XEvpic+f8F05WEypoQ6zs6ARTy1TEfYbVGK1HH3k2dii9BDR7KI/nUz4qZ
         FSrKJmB/y6cgRAqUWkkECpoaWiJRZtVDEB/XjX8QC/WkJWrK1bEcQFa98zUSnWefXvXJ
         UUJQ==
X-Gm-Message-State: APjAAAUIRN9jI7nedM8JZp4HVN4rCuOMnKsjhF3QSnE2UX15rPTxro/d
        pMW1n7unVqesFY//QqgUIDpRtpbd8II=
X-Google-Smtp-Source: APXvYqyJzexYK0ODH7UR7ZIPwhL2sqGBeU3kvXT48fiBc4VyqOBa54ERKTM3FDd+ldv7CbjUZmf5Rw==
X-Received: by 2002:a62:d449:: with SMTP id u9mr20535023pfl.225.1576552851080;
        Mon, 16 Dec 2019 19:20:51 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:20:50 -0800 (PST)
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
Subject: [RFC][PATCH 02/15] videobuf2: handle V4L2 buffer cache flags
Date:   Tue, 17 Dec 2019 12:20:21 +0900
Message-Id: <20191217032034.54897-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set video buffer cache management flags corresponding to V4L2 cache
flags.

Both ->prepare() and ->finish() cache management hints should be
passed during this stage (buffer preparation), because there is no
other way for user-space to skip ->finish() cache flush.

There are two possible alternative approaches:
- The first one is to move cache sync from ->finish() to dqbuf().
  But this breaks some drivers, that need to fix-up buffers before
  dequeueing them.

- The second one is to move ->finish() call from ->done() to dqbuf.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-v4l2.c   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index e652f4318284..2fccfe2a57f8 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -337,6 +337,27 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 	return 0;
 }
 
+static void set_buffer_cache_hints(struct vb2_queue *q,
+				   struct vb2_buffer *vb,
+				   struct v4l2_buffer *b)
+{
+	vb->need_cache_sync_on_prepare = 1;
+
+	if (q->dma_dir != DMA_TO_DEVICE)
+		vb->need_cache_sync_on_finish = 1;
+	else
+		vb->need_cache_sync_on_finish = 0;
+
+	if (!q->allow_cache_hints)
+		return;
+
+	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
+		vb->need_cache_sync_on_finish = 0;
+
+	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_CLEAN)
+		vb->need_cache_sync_on_prepare = 0;
+}
+
 static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
 				    struct v4l2_buffer *b, bool is_prepare,
 				    struct media_request **p_req)
@@ -381,6 +402,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 	}
 
 	if (!vb->prepared) {
+		set_buffer_cache_hints(q, vb, b);
 		/* Copy relevant information provided by the userspace */
 		memset(vbuf->planes, 0,
 		       sizeof(vbuf->planes[0]) * vb->num_planes);
-- 
2.24.1.735.g03f4e72817-goog

