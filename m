Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0B62082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKy7sYUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbfIEWAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:00:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40617 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbfIEWAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:00:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so2797123pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awe/FZlFt6W5mRsQyenuEisLmRJCTiud4/jehSXxi7c=;
        b=CKy7sYUyzN84ffQMtrtNbVCew5ZTFIWqKsxP/xcG5jkPa1YSJ/9q1aG77QUTeC8Git
         mbKCwtGxUi/NeDFWvmpN++Z7Fl/Cr959nnvDPvZKpEXKOLyS3dSka5hmdTxHjZ6Hbmxy
         n7qVodTLgY+HxZ3Q7/dvmN1oERxiexG2wY2TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awe/FZlFt6W5mRsQyenuEisLmRJCTiud4/jehSXxi7c=;
        b=RW91P7ZfPJOYUKQEiT9YTFv3S/UlfjOHUxDsk1M9HwvB8jC9kgRMZwlukRfJFl+4ST
         4wc/k6u6LpDIQZLRwv8l/CCBXaJo+zBSJ+eK2e8uS0aygHI3BG4YZcD2szFH4zrp7DbT
         ovQtrB0wD9KjI3zxcI0us8F03QHEgjqTOI9C/hcODrPW2rNV0tZrxI8wCU4eE2C1mmis
         7LF6reLEzkY/KQ6DS7ZW8no5Ro3dS/xWbdNi9Rv4AxBs2daKhtmsW9FNfhONZqG8eGHk
         gw2rrCzdpACgJWsa+TE3BKhWnRo2mnFILkKPLlmqCRpmOPsqgz2Pc7av1ew/7zVb5x/9
         /Sng==
X-Gm-Message-State: APjAAAU8Sj9NP1vF6I1RYYD/6cXtAbcBKFlicshWSmOFTHv5MiM3Thnl
        V0JzdK6zDHhmBa+gmZN6aYO7TwRAcJQ=
X-Google-Smtp-Source: APXvYqzGozfUHb31L4GRuAoOZbw5U6Q7xIQdOo2UA+FiBRWtnfnZpZRgDCPRKwGPVhPB/fFHvWo99A==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr497016pfd.209.1567720816129;
        Thu, 05 Sep 2019 15:00:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id k95sm2121815pje.10.2019.09.05.15.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 15:00:14 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v2] drm/virtio: Use vmalloc for command buffer allocations.
Date:   Thu,  5 Sep 2019 15:00:08 -0700
Message-Id: <20190905220008.75488-1-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
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
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |   4 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 114 ++++++++++++++++++++-----
 2 files changed, 96 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index ac60be9b5c19..a8732a8af766 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -195,7 +195,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto out_free;
 
-	buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
+	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
 		goto out_unresv;
@@ -230,7 +230,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	return 0;
 
 out_memdup:
-	kfree(buf);
+	kvfree(buf);
 out_unresv:
 	ttm_eu_backoff_reservation(&ticket, &validate_list);
 out_free:
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 981ee16e3ee9..3ec89ae8478c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -154,7 +154,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 {
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
-	kfree(vbuf->data_buf);
+	kvfree(vbuf->data_buf);
 	kmem_cache_free(vgdev->vbufs, vbuf);
 }
 
@@ -251,13 +251,70 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
+/* How many bytes left in this page. */
+static unsigned int rest_of_page(void *data)
+{
+	return PAGE_SIZE - offset_in_page(data);
+}
+
+/* Create sg_table from a vmalloc'd buffer. */
+static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
+{
+	int nents, ret, s, i;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+	struct page *pg;
+
+	*sg_ents = 0;
+
+	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return NULL;
+
+	nents = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
+	ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
+	if (ret) {
+		kfree(sgt);
+		return NULL;
+	}
+
+	for_each_sg(sgt->sgl, sg, nents, i) {
+		pg = vmalloc_to_page(data);
+		if (!pg) {
+			sg_free_table(sgt);
+			kfree(sgt);
+			return NULL;
+		}
+
+		s = rest_of_page(data);
+		if (s > size)
+			s = size;
+
+		sg_set_page(sg, pg, s, offset_in_page(data));
+
+		size -= s;
+		data += s;
+		*sg_ents += 1;
+
+		if (size) {
+			sg_unmark_end(sg);
+		} else {
+			sg_mark_end(sg);
+			break;
+		}
+	}
+
+	return sgt;
+}
+
 static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
-					       struct virtio_gpu_vbuffer *vbuf)
+					       struct virtio_gpu_vbuffer *vbuf,
+					       struct scatterlist *vout)
 		__releases(&vgdev->ctrlq.qlock)
 		__acquires(&vgdev->ctrlq.qlock)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
-	struct scatterlist *sgs[3], vcmd, vout, vresp;
+	struct scatterlist *sgs[3], vcmd, vresp;
 	int outcnt = 0, incnt = 0;
 	int ret;
 
@@ -268,9 +325,8 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	sgs[outcnt + incnt] = &vcmd;
 	outcnt++;
 
-	if (vbuf->data_size) {
-		sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
-		sgs[outcnt + incnt] = &vout;
+	if (vout) {
+		sgs[outcnt + incnt] = vout;
 		outcnt++;
 	}
 
@@ -299,24 +355,30 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	return ret;
 }
 
-static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					struct virtio_gpu_vbuffer *vbuf)
-{
-	int rc;
-
-	spin_lock(&vgdev->ctrlq.qlock);
-	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
-	spin_unlock(&vgdev->ctrlq.qlock);
-	return rc;
-}
-
 static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf,
 					       struct virtio_gpu_ctrl_hdr *hdr,
 					       struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
+	struct scatterlist *vout = NULL, sg;
+	struct sg_table *sgt = NULL;
 	int rc;
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
@@ -329,19 +391,31 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	 * to wait for free space, which can result in fence ids being
 	 * submitted out-of-order.
 	 */
-	if (vq->num_free < 3) {
+	if (vq->num_free < 2 + outcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= 3);
 		goto again;
 	}
 
-	if (fence)
+	if (hdr && fence)
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
-	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf, vout);
 	spin_unlock(&vgdev->ctrlq.qlock);
+
+	if (sgt) {
+		sg_free_table(sgt);
+		kfree(sgt);
+	}
+
 	return rc;
 }
 
+static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					struct virtio_gpu_vbuffer *vbuf)
+{
+	return virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
+}
+
 static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 				   struct virtio_gpu_vbuffer *vbuf)
 {
-- 
2.23.0.187.g17f5b7556c-goog

