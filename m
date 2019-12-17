Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE9FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C96D218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BBtVGsMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfLQDVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:21:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34753 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfLQDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id l127so4944399pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9bAWCFHMKxSYudc9xD0mtxl2wph3ZizEkb+ltF/fPnw=;
        b=BBtVGsMs2whxo8gii2bpcI+p/QNQAnqcFhqYz4KHXqpr6gixuGZiqazsuOXfgEd31W
         0NACv8eevYTpBfRxG02yAOShCwGqI1Fs7roWvTYQMUNAMPa7DdFMaiUBKE5W0hF59KCn
         BH5JRiI0Dn6x4z3XKFHNHyJK8pL5xFO50IW3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bAWCFHMKxSYudc9xD0mtxl2wph3ZizEkb+ltF/fPnw=;
        b=eYxVuiN5Y1jtEmbHDNWp3m0OhRfEcViwuZv7U+3sSUQM9B3fE9KXWpF1E9oqaEND6H
         FBAImxdFR7auPTMnJYITJ7yHrBbM/VqWcN71OdHNHvaYPCUeeq0AWE/lg4cwGtTETNY5
         gNr07Nx1zdUoBx+lYTBOnnOGjIKKuYk/4V/qJ2Lk9uqD5z8zCjpM6Hj6zZx0w7AYN4Me
         urLsFNxYJGJVbYu2qUiQdetfbBWti68k+QKYtLbo0A5l2aRBbi3fisJZC/cEHAjYgjWV
         89b5le+laxq8e6G6iHJgrl/h4Cd66xHLJVOo7iOVwZ4LEbdoM9SpUrTEoxXhSy6UHWQi
         17Sw==
X-Gm-Message-State: APjAAAVUJD7VkKwAn0VEPWLV+z4088K0uht/MscBSaCd41VfjLFEj2Nf
        X3rt+8pcs5q4dwnn40bv/n031Q==
X-Google-Smtp-Source: APXvYqyZLTtmMRSnUha4K7/FcPhyMSiJtduh+2WvfTUf+qckUNomryze1L6EP3IgVb1v2AShg3jObQ==
X-Received: by 2002:a65:58ce:: with SMTP id e14mr22577119pgu.153.1576552878016;
        Mon, 16 Dec 2019 19:21:18 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:17 -0800 (PST)
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
Subject: [RFC][PATCH 10/15] videobuf2: let user-space know when driver supports cache hints
Date:   Tue, 17 Dec 2019 12:20:29 +0900
Message-Id: <20191217032034.54897-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS to fill_buf_caps(), which
is set when queue supports user-space cache management hints.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/media/uapi/v4l/vidioc-reqbufs.rst | 5 +++++
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 2 ++
 include/uapi/linux/videodev2.h                  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
index 9b69a61d9fd4..13eab807fdfb 100644
--- a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
+++ b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
@@ -166,6 +166,11 @@ aborting or finishing any DMA in progress, an implicit
       - Only valid for stateless decoders. If set, then userspace can set the
         ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` flag to hold off on returning the
 	capture buffer until the OUTPUT timestamp changes.
+    * - ``V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS``
+      - 0x00000040
+      - This buffer supports :ref:`V4L2_BUF_FLAG_NO_CACHE_INVALIDATE` and
+        :ref:`V4L2_BUF_FLAG_NO_CACHE_CLEAN` user-space cache hints.
+
 
 Return Value
 ============
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 48d123a1ac2a..1762849288ae 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -684,6 +684,8 @@ static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_DMABUF;
 	if (q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
+	if (q->allow_cache_hints)
+		*caps |= V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS;
 #ifdef CONFIG_MEDIA_CONTROLLER_REQUEST_API
 	if (q->supports_requests)
 		*caps |= V4L2_BUF_CAP_SUPPORTS_REQUESTS;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 82e2ded5a136..b5d6b8d4ae93 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -932,6 +932,7 @@ struct v4l2_requestbuffers {
 #define V4L2_BUF_CAP_SUPPORTS_REQUESTS			(1 << 3)
 #define V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS		(1 << 4)
 #define V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF	(1 << 5)
+#define V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS		(1 << 6)
 
 /**
  * struct v4l2_plane - plane info for multi-planar buffers
-- 
2.24.1.735.g03f4e72817-goog

