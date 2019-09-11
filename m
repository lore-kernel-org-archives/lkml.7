Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2039BC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D881D20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RtnXpoYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfIKSOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:14:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfIKSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:14:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id t1so10500359plq.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXhdF34fWpCmU0rbmWA1E+x/O7viGYJ2RgC8HYIROiY=;
        b=RtnXpoYfLAC4rtL4bjrCmE3G/t40XxkLPu1f2NPVTKsBUY/Nn+kVJEeLhS+wDklRXZ
         Qp8eb+ZWa3o4lE4//hp7YBwKhX5JgdtLRGJp7rvmS4YG9U63+TwOiLej1RE6aJqn/EoD
         WYF2kwM264l5jO5pkiy3QQOg66CiAVVz9maZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXhdF34fWpCmU0rbmWA1E+x/O7viGYJ2RgC8HYIROiY=;
        b=ZztbdEbP/Z/IZhQNaRlMkJ2d3QrReRlQNVpqH5BPiweTr/nBoWiGTMEDfRoVhsO9Sg
         9rmYneeeGlZdI5oN7JsGEjhGnpWrkSNUsBgU+JLYHzuLXU6H8QoG4qDqNvf+NYO4yiBG
         syQF2r8sQhDE8eW5qaExtYo3mavASPP9K7Azoj5yy5AAmhPlvFmf/mgOsavEgh3nlikj
         dYejikJUKRhSrdIRseaHy6cLF3xajl6B4I/S8u1HfGhAT9nop49Qp6JYk4Re3QmcvnFw
         QKzXKdLYW/N1Lyr5fohyE+LEpAH4ZkUEqOjCuv105UUoNoCxtPYl9ySwoNpI4sB6g2rY
         qR7Q==
X-Gm-Message-State: APjAAAXeyqTWpuRWkkjcCyRQTZYjrwP8be+O7cktEYfcNMnXgjFy/Ta+
        UkoaVhjKeUqDWKGKxFsw3Pbfgg==
X-Google-Smtp-Source: APXvYqwijnVpSCyrOk2zNhhDUxXV/lyUbYRDrb2kuDeMwHY0Qts6nLLyXGJqlZOF6xxnhwAcdwSRMw==
X-Received: by 2002:a17:902:7c13:: with SMTP id x19mr39596513pll.322.1568225654889;
        Wed, 11 Sep 2019 11:14:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id x8sm22730241pfn.106.2019.09.11.11.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:14:13 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v4 2/2] drm/virtio: Use vmalloc for command buffer allocations.
Date:   Wed, 11 Sep 2019 11:14:03 -0700
Message-Id: <20190911181403.40909-3-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace requested command buffer allocations could be too large
to make as a contiguous allocation.  Use vmalloc if necessary to
satisfy those allocations.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  4 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 78 +++++++++++++++++++++++---
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index f5083c538f9c..9af1ec62434f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -143,7 +143,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			goto out_unused_fd;
 	}
 
-	buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
+	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
 		goto out_unresv;
@@ -172,7 +172,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	return 0;
 
 out_memdup:
-	kfree(buf);
+	kvfree(buf);
 out_unresv:
 	if (buflist)
 		virtio_gpu_array_unlock_resv(buflist);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5a64c776138d..9f9b782dd332 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -155,7 +155,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 {
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
-	kfree(vbuf->data_buf);
+	kvfree(vbuf->data_buf);
 	kmem_cache_free(vgdev->vbufs, vbuf);
 }
 
@@ -256,13 +256,54 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
+/* Create sg_table from a vmalloc'd buffer. */
+static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
+{
+	int ret, s, i;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+	struct page *pg;
+
+	if (WARN_ON(!PAGE_ALIGNED(data)))
+		return NULL;
+
+	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return NULL;
+
+	*sg_ents = DIV_ROUND_UP(size, PAGE_SIZE);
+	ret = sg_alloc_table(sgt, *sg_ents, GFP_KERNEL);
+	if (ret) {
+		kfree(sgt);
+		return NULL;
+	}
+
+	for_each_sg(sgt->sgl, sg, *sg_ents, i) {
+		pg = vmalloc_to_page(data);
+		if (!pg) {
+			sg_free_table(sgt);
+			kfree(sgt);
+			return NULL;
+		}
+
+		s = min_t(int, PAGE_SIZE, size);
+		sg_set_page(sg, pg, s, 0);
+
+		size -= s;
+		data += s;
+	}
+
+	return sgt;
+}
+
 static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
-						struct virtio_gpu_vbuffer *vbuf)
+						struct virtio_gpu_vbuffer *vbuf,
+						struct scatterlist *vout)
 		__releases(&vgdev->ctrlq.qlock)
 		__acquires(&vgdev->ctrlq.qlock)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
-	struct scatterlist *sgs[3], vcmd, vout, vresp;
+	struct scatterlist *sgs[3], vcmd, vresp;
 	int outcnt = 0, incnt = 0;
 	bool notify = false;
 	int ret;
@@ -274,9 +315,8 @@ static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	sgs[outcnt + incnt] = &vcmd;
 	outcnt++;
 
-	if (vbuf->data_size) {
-		sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
-		sgs[outcnt + incnt] = &vout;
+	if (vout) {
+		sgs[outcnt + incnt] = vout;
 		outcnt++;
 	}
 
@@ -308,7 +348,24 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 						struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
+	struct scatterlist *vout = NULL, sg;
+	struct sg_table *sgt = NULL;
 	bool notify;
+	int outcnt = 0;
+
+	if (vbuf->data_size) {
+		if (is_vmalloc_addr(vbuf->data_buf)) {
+			sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
+					     &outcnt);
+			if (!sgt)
+				return -ENOMEM;
+			vout = sgt->sgl;
+		} else {
+			sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
+			vout = &sg;
+			outcnt = 1;
+		}
+	}
 
 again:
 	spin_lock(&vgdev->ctrlq.qlock);
@@ -321,7 +378,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	 * to wait for free space, which can result in fence ids being
 	 * submitted out-of-order.
 	 */
-	if (vq->num_free < 3) {
+	if (vq->num_free < 2 + outcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= 3);
 		goto again;
@@ -334,10 +391,15 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			virtio_gpu_array_unlock_resv(vbuf->objs);
 		}
 	}
-	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf, vout);
 	spin_unlock(&vgdev->ctrlq.qlock);
 	if (notify)
 		virtqueue_notify(vgdev->ctrlq.vq);
+
+	if (sgt) {
+		sg_free_table(sgt);
+		kfree(sgt);
+	}
 }
 
 static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-- 
2.23.0.162.g0b9fbb3734-goog

