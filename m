Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B9921835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ciRLBiY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfLQDU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:20:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46743 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfLQDUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:20:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id k20so5398615pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqrDhJWgamLEnJ0f+brWH5beGZW3pxf2EqtCOMwdJgg=;
        b=ciRLBiY63+o+8cMoR1Kw48sNUnjhyOCQZtFN2AexGo3e5cIwHq1miF7ZBa7MvDakPj
         /XjXlF1uV+68e45tDtV3jKx4Mo7VbE05xzqMQ+dyNh64lG84W/oJE6YZRej99Sv8KTzb
         KOIl/O69xGS4G0jgY7L+2CUeit4CwKF9N3QYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqrDhJWgamLEnJ0f+brWH5beGZW3pxf2EqtCOMwdJgg=;
        b=ekxITzgGbyCHy8WHD33OYDgpc6KoWloWQSjfghZDiXH3nuq7HyMhiu73rsrmy3znZ4
         LgayZ5WcFAccx4wxG0e/aLmDpSqtGF02Z10j/1zJ8GKBnc9ute3WgKSsKUbVhbR9o8c1
         qkVw6u3pwRRWxmS1o1g8riyWHDqZNFKA0Z7OFNYGeL2eaJ9OvyH9keiUJyPT7WVTchN6
         MZ3IBu8tPOeTcD1VLvXtJqt8fEPtsh3UpUM3XjESMKcdyC6AL0t9dROVsjmGS5N0kJZE
         uVQzrazpSO0iWBvdQKngyNAex1U99jRa4Zo5l6N/8T5l8tXyy+AFfai+MtgPlsOu/2C0
         cNqQ==
X-Gm-Message-State: APjAAAVapN05xpH2JQkOgHxZwqsATSKsLdnd+6pr7nI1c1eVdAc+EHEA
        MTZIaETbPFHjr285CCRMRIxhFQ==
X-Google-Smtp-Source: APXvYqw5ABjXI02YnEoGwgEOZOpJzyu7CZRg0ZYyfTMRaQSNW88K9oAZ4u+zuKSnSQ3smW8TIFh0rQ==
X-Received: by 2002:a17:90a:2710:: with SMTP id o16mr3311690pje.110.1576552854487;
        Mon, 16 Dec 2019 19:20:54 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:20:54 -0800 (PST)
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
Subject: [RFC][PATCH 03/15] videobuf2: add V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Date:   Tue, 17 Dec 2019 12:20:22 +0900
Message-Id: <20191217032034.54897-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting or clearing V4L2_FLAG_MEMORY_NON_CONSISTENT flag
user-space should be able to set or clear queue's NON_CONSISTENT
->dma_attrs. Queue's ->dma_attrs are passed to the underlying
allocator in __vb2_buf_mem_alloc(), so user-space will be able
to request consistent or non-consistent memory allocations.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/media/uapi/v4l/buffer.rst | 19 +++++++++++++++++++
 include/uapi/linux/videodev2.h          |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/media/uapi/v4l/buffer.rst b/Documentation/media/uapi/v4l/buffer.rst
index 9149b57728e5..b08b5609f5f3 100644
--- a/Documentation/media/uapi/v4l/buffer.rst
+++ b/Documentation/media/uapi/v4l/buffer.rst
@@ -705,6 +705,25 @@ Buffer Flags
 
 .. c:type:: v4l2_memory
 
+Memory Consistency Flags
+========================
+
+.. tabularcolumns:: |p{7.0cm}|p{2.2cm}|p{8.3cm}|
+
+.. cssclass:: longtable
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       3 1 4
+
+    * .. _`V4L2_FLAG_MEMORY_NON_CONSISTENT`:
+
+      - ``V4L2_FLAG_MEMORY_NON_CONSISTENT``
+      - 0x00000001
+      - Set DMA_ATTR_NON_CONSISTENT queue memory consistency bit,
+	so all queue buffers may be allocated in non-consistent memory.
+
 enum v4l2_memory
 ================
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 04481c717fee..d352997f2b62 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -189,6 +189,8 @@ enum v4l2_memory {
 	V4L2_MEMORY_DMABUF           = 4,
 };
 
+#define V4L2_FLAG_MEMORY_NON_CONSISTENT		(1 << 0)
+
 /* see also http://vektor.theorem.ca/graphics/ycbcr/ */
 enum v4l2_colorspace {
 	/*
-- 
2.24.1.735.g03f4e72817-goog

