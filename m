Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0443C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A92D218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ui0YYV/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLQDVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:21:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46746 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLQDVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so5398712pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YT5zPdi996NXjchiwCDqVrjFoOKLt3bLnZH+tVb9/cU=;
        b=Ui0YYV/vw7P9G0lo0Y1sMgKALXnDBU/1UuD8ANc+wq1Yx7zco/LjVCgBzjejWw2DGQ
         0SNg0OnPnCC4ixuLPiBkPfPEOhibXdreAC4HTi+Mq4S6LJGSe7sMpAhKOak33ma2EWxy
         aias37z7+v1UA3EQLPmFro4zEdMJnB74zEHAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YT5zPdi996NXjchiwCDqVrjFoOKLt3bLnZH+tVb9/cU=;
        b=c/Qo5nY0Dmqm+ILn7Zh8fVYlasdaR+JNeBiziaznKfOlaEJlnNk8rtEXR1KiQlMNys
         /O65Fj7MO0770TZczP4Nik//1UHExldcplu8wj8LKPeLh9Y0Dqo/XVyuTb/PtbLVvXxJ
         FLlQ96fC08ZZ2uVolu8lpJJk5JxTO8lUxzZEaqC6wdWratpKWb3StekBmYZsOJTyPTvz
         EPBMcwSa55JXTrfkxexJqkNdukicFY3WLxTeXngSVcEcCFUvGbKjGOLklGkJW8BOFMAL
         YXnTYvw9MMUlelF6gCVxowFeFlXnfLA0in5XOshAgWYmgFeaMeSpQWNie+LvBcFmbyOH
         nOpg==
X-Gm-Message-State: APjAAAUBnA7zoFi33BPDBhqX+k9ESHJ5tCsgfwZVbXtJ+hIFrWGetgZZ
        D3gs3Fw5WJ9P2xw09wqidXeZjl5TQkM=
X-Google-Smtp-Source: APXvYqxzE0ZN2M7MmqYjMlHuc5TaV0+MgkaG2yIcNH/4jH6GMMY2mueWihj+lF2Qdzbxj3sAqtQ19g==
X-Received: by 2002:a17:90a:2201:: with SMTP id c1mr3355615pje.31.1576552861030;
        Mon, 16 Dec 2019 19:21:01 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:00 -0800 (PST)
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
Subject: [RFC][PATCH 05/15] videobuf2: handle V4L2_FLAG_MEMORY_NON_CONSISTENT in REQBUFS
Date:   Tue, 17 Dec 2019 12:20:24 +0900
Message-Id: <20191217032034.54897-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lets user-space to request a non-consistent memory
allocation during REQBUFS ioctl call. We use one bit of a
->reserved[1] member of struct v4l2_requestbuffers, which is
now renamed to ->flags.

There is just 1 four-byte reserved area in v4l2_requestbuffers
struct, therefore for backward compatibility ->reserved and
->flags were put into anonymous union.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/media/uapi/v4l/vidioc-reqbufs.rst | 14 ++++++++++++--
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 14 ++++++++++++--
 drivers/media/v4l2-core/v4l2-ioctl.c            |  3 ---
 include/uapi/linux/videodev2.h                  |  5 ++++-
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
index d0c643db477a..9b69a61d9fd4 100644
--- a/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
+++ b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
@@ -112,10 +112,20 @@ aborting or finishing any DMA in progress, an implicit
 	``V4L2_MEMORY_MMAP`` and ``type`` set to the buffer type. This will
 	free any previously allocated buffers, so this is typically something
 	that will be done at the start of the application.
-    * - __u32
+    * - union
+      - (anonymous)
+    * -
+      - __u32
+      - ``flags``\ [1]
+      - Specifies additional buffer management attributes. E.g. when
+        ``V4L2_FLAG_MEMORY_NON_CONSISTENT`` set vb2 backends may be allocated
+        in non-consistent memory.
+    * -
+      - __u32
       - ``reserved``\ [1]
       - A place holder for future extensions. Drivers and applications
-	must set the array to zero.
+	must set the array to zero, unless application wants to specify
+        buffer management ``flags``.
 
 .. tabularcolumns:: |p{6.1cm}|p{2.2cm}|p{8.7cm}|
 
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index f1e88c9398c7..0eabb589684f 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -693,9 +693,15 @@ static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
 int vb2_reqbufs(struct vb2_queue *q, struct v4l2_requestbuffers *req)
 {
 	int ret = vb2_verify_memory_type(q, req->memory, req->type);
+	bool consistent = true;
+
+	if (req->flags & V4L2_FLAG_MEMORY_NON_CONSISTENT)
+		consistent = false;
 
 	fill_buf_caps(q, &req->capabilities);
-	return ret ? ret : vb2_core_reqbufs(q, req->memory, true, &req->count);
+	if (ret)
+		return ret;
+	return vb2_core_reqbufs(q, req->memory, consistent, &req->count);
 }
 EXPORT_SYMBOL_GPL(vb2_reqbufs);
 
@@ -939,13 +945,17 @@ int vb2_ioctl_reqbufs(struct file *file, void *priv,
 {
 	struct video_device *vdev = video_devdata(file);
 	int res = vb2_verify_memory_type(vdev->queue, p->memory, p->type);
+	bool consistent = true;
 
 	fill_buf_caps(vdev->queue, &p->capabilities);
 	if (res)
 		return res;
 	if (vb2_queue_is_busy(vdev, file))
 		return -EBUSY;
-	res = vb2_core_reqbufs(vdev->queue, p->memory, true, &p->count);
+	if (p->flags & V4L2_FLAG_MEMORY_NON_CONSISTENT)
+		consistent = false;
+
+	res = vb2_core_reqbufs(vdev->queue, p->memory, consistent, &p->count);
 	/* If count == 0, then the owner has released all buffers and he
 	   is no longer owner of the queue. Otherwise we have a new owner. */
 	if (res == 0)
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 003b7422aeef..225d06819bce 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1973,9 +1973,6 @@ static int v4l_reqbufs(const struct v4l2_ioctl_ops *ops,
 
 	if (ret)
 		return ret;
-
-	CLEAR_AFTER_FIELD(p, capabilities);
-
 	return ops->vidioc_reqbufs(file, fh, p);
 }
 
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index d352997f2b62..73a4854f71bd 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -919,7 +919,10 @@ struct v4l2_requestbuffers {
 	__u32			type;		/* enum v4l2_buf_type */
 	__u32			memory;		/* enum v4l2_memory */
 	__u32			capabilities;
-	__u32			reserved[1];
+	union {
+		__u32		flags;
+		__u32		reserved[1];
+	};
 };
 
 /* capabilities for struct v4l2_requestbuffers and v4l2_create_buffers */
-- 
2.24.1.735.g03f4e72817-goog

