Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF1C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCDC21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R61eEifg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfIJUMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 16:12:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47037 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfIJUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:12:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id t1so9088381plq.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15hWnr6f2tJrfEoilZ1helN5HSi4DmE9rTuHqUhMmkU=;
        b=R61eEifgYMh7PnNayuYxhvP5bhbfW2mOmVNcjBrX0u4fCMa2T6Ler3WWj5Apg/ZTMQ
         f1/ye3xAfOzASybxWrea9GsS6SoROey6PHwxCSthuxwXK0qDfT/cYfz/fb9ycyHnRX2e
         EbV46qG2jGs23H1GpBftp0RKBI0c8rFuNQb3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15hWnr6f2tJrfEoilZ1helN5HSi4DmE9rTuHqUhMmkU=;
        b=kZpQ2aaPLvWdfvSGqvPXMAGXkWN0hnpeD/pPtPlik4AtGmcPT6sxNUxzGJyvt8+MHv
         GW5FYUQgYCEnMc1x9bDZ57VzFPi2KDCPlKVdu2E+4aOAgwC1UOdB7G9oPzyV3iqnEnml
         JcpNQPzfpBLg/h8iSEfx7+P3dMNrhL7nXCKFh8LsP39k0taW26emcP5gH4M6JN7HXHTB
         h/KRMx3QKp/n7SO4t3rvVT3v+xhwGlG0MEpG2dtXAMd0N4tpAH48GEGrdFe7AHGrEEon
         B+gxhUs+TBJM9noPAGu6NBj/kcPb0w7og1bhRlACb/F92vQkQyaGiU3AztXIuaLxJuqI
         pIPA==
X-Gm-Message-State: APjAAAV14SNvoOyY5chVimYw3+WNgbedFh6p+gPyoiaTxcPkokstYZid
        C07QtUR8HwieJ9hF3Iozzb3Rqg==
X-Google-Smtp-Source: APXvYqxe5wirZcu9g1h+r/nLCfi6tx506Er0HD6EdTcai5ASMPCpU4DNsON/yG0qYLuEnO9zkBPWPw==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr33009585plr.201.1568146344505;
        Tue, 10 Sep 2019 13:12:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id c8sm1581955pgw.37.2019.09.10.13.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 13:12:23 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v3 2/2] drm/virtio: Use vmalloc for command buffer allocations.
Date:   Tue, 10 Sep 2019 13:06:51 -0700
Message-Id: <20190910200651.118628-2-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
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
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 79 +++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 10 deletions(-)

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
index bf5a4a50b002..76cf2b9d5d1d 100644
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
 
@@ -251,13 +251,54 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
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
 
@@ -268,9 +309,8 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	sgs[outcnt + incnt] = &vcmd;
 	outcnt++;
 
-	if (vbuf->data_size) {
-		sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
-		sgs[outcnt + incnt] = &vout;
+	if (vout) {
+		sgs[outcnt + incnt] = vout;
 		outcnt++;
 	}
 
@@ -305,7 +345,24 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
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
@@ -318,7 +375,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	 * to wait for free space, which can result in fence ids being
 	 * submitted out-of-order.
 	 */
-	if (vq->num_free < 3) {
+	if (vq->num_free < 2 + outcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= 3);
 		goto again;
@@ -326,8 +383,14 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 
 	if (hdr && fence)
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
 
-- 
2.23.0.162.g0b9fbb3734-goog

