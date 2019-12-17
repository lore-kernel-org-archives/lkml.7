Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CFDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F3421835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YVDNNgjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLQDUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:20:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37533 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfLQDUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:20:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so5418363plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gw2WS97E5ShS4EFOOCzORU1xpTlrM5Z/donDWDF7mI=;
        b=YVDNNgjM5etiFQrJcTUTaollxlxvDIKwIvPu2HtyAPe++/UBQSrkXOF7/m9WgS14NU
         Nec4nDWahlnGX0mjpbyTqhtxEfsAcEPDjd6cRFSkqlIJXnYX5pyEg2ae5wewd7j7g58N
         68NqpsQEc+/pSLg8LYCtQy9kfaNbZRoAIy+3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gw2WS97E5ShS4EFOOCzORU1xpTlrM5Z/donDWDF7mI=;
        b=MliGZafr2kiqSYvZoDh/yMhsVcUNyuiWojhKQ+CBMbwRr23gsSTx4eHMB0zx30Luc4
         5cNZKF8htnym66hzNpY0aK93vsiOXygiFKVZIg5f7bvV4oy9/qH0c8VLDf2XHljNmOuX
         yGqf1jRgAejgdegcJVRVtQD6wXzHTZIOFHQwEzGbhbp6vBbnn1r3CCQw1AiXVaVilQHq
         03FCrC8i6KV6kets05hbAAiA9AmfW1wXT0JtwFRk047pJ6cQV+0cyhvrd5Vyjl8GBm0H
         bCCG8Ip5nsAQygMyLSGof+byTa2jqRwWl/EoxM2iAC5GQ8z3HM95mCbJJglqH8QQ/UOY
         35dQ==
X-Gm-Message-State: APjAAAUukXDZrXU0J1qbA4KuvBEGTn4EPwVB8ikdvoF0DMx+jEvv5SqC
        IKSjTWlYd+4wCp7RtS3xLXGEVw==
X-Google-Smtp-Source: APXvYqzXQPTSjofGjWn62rO0KIyfidaxbVkZuEOZ9EyPk6iQ9ahpXwmaqzpUpWu9UAP4nsApVBNuLg==
X-Received: by 2002:a17:902:6b0a:: with SMTP id o10mr19518464plk.15.1576552847255;
        Mon, 16 Dec 2019 19:20:47 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:20:46 -0800 (PST)
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
Subject: [RFC][PATCH 01/15] videobuf2: add cache management members
Date:   Tue, 17 Dec 2019 12:20:20 +0900
Message-Id: <20191217032034.54897-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend vb2_buffer and vb2_queue structs with cache management
members.

V4L2 UAPI already contains two buffer flags which user-space,
supposedly, can use to control buffer cache sync:

- V4L2_BUF_FLAG_NO_CACHE_INVALIDATE
- V4L2_BUF_FLAG_NO_CACHE_CLEAN

None of these, however, do anything at the moment. This patch
set is intended to change it.

Since user-space cache management hints are supposed to be
implemented on a per-buffer basis we need to extend vb2_buffer
struct with two new memebers ->need_cache_sync_on_prepare and
->need_cache_sync_on_finish, which will store corresponding
user-space hints.

In order to preserve the existing behaviour, user-space cache
managements flags will be handled only by those drivers that
permit user-space cache hints. That's the purpose of vb2_queue
->allow_cache_hints member. Driver must set ->allow_cache_hints
during queue initialisation to enable cache management hints
mechanism.

Only drivers that set ->allow_cache_hints during queue initialisation
will handle user-space cache management hints. Otherwise hints
will be ignored.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/media/videobuf2-core.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index a2b2208b02da..026004180440 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -263,6 +263,10 @@ struct vb2_buffer {
 	 *			after the 'buf_finish' op is called.
 	 * copied_timestamp:	the timestamp of this capture buffer was copied
 	 *			from an output buffer.
+	 * need_cache_sync_on_prepare: do not sync/invalidate cache from
+	 * 			buffer's ->prepare() callback.
+	 * need_cache_sync_on_finish: do not sync/invalidate cache from buffer's
+	 * 			->finish() callback.
 	 * queued_entry:	entry on the queued buffers list, which holds
 	 *			all buffers queued from userspace
 	 * done_entry:		entry on the list that stores all buffers ready
@@ -273,6 +277,8 @@ struct vb2_buffer {
 	unsigned int		synced:1;
 	unsigned int		prepared:1;
 	unsigned int		copied_timestamp:1;
+	unsigned int		need_cache_sync_on_prepare:1;
+	unsigned int		need_cache_sync_on_finish:1;
 
 	struct vb2_plane	planes[VB2_MAX_PLANES];
 	struct list_head	queued_entry;
@@ -491,6 +497,9 @@ struct vb2_buf_ops {
  * @uses_requests: requests are used for this queue. Set to 1 the first time
  *		a request is queued. Set to 0 when the queue is canceled.
  *		If this is 1, then you cannot queue buffers directly.
+ * @allow_cache_hints: when set user-space can pass cache management hints in
+ * 		order to skip cache flush/invalidation on ->prepare() or/and
+ * 		->finish().
  * @lock:	pointer to a mutex that protects the &struct vb2_queue. The
  *		driver can set this to a mutex to let the v4l2 core serialize
  *		the queuing ioctls. If the driver wants to handle locking
@@ -564,6 +573,7 @@ struct vb2_queue {
 	unsigned			requires_requests:1;
 	unsigned			uses_qbuf:1;
 	unsigned			uses_requests:1;
+	unsigned			allow_cache_hints:1;
 
 	struct mutex			*lock;
 	void				*owner;
-- 
2.24.1.735.g03f4e72817-goog

