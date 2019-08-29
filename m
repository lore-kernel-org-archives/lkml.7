Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C017C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3158A2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0jTQN3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH2VY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:24:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfH2VY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:24:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so2978448pfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E2P9cOC9rhcxBzt6NHNxzx1T9WKYvIwrZWNTN0rkY+s=;
        b=h0jTQN3TrKHnWNcg4cy77XJ0Co8Zx9n1Djd8fwUQW0bwNR3x0a6yxAkmXQyKGJ0vuP
         2HpX11DY6L3hw3NBb+hAtyV/Ga22TIDS/NvuS5CEUbOTIw9b4QOdmT1FdD8gNz1QHFby
         OVTmlgN4RoKEVolCdsq3rEd/zNSOYd16GWfJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E2P9cOC9rhcxBzt6NHNxzx1T9WKYvIwrZWNTN0rkY+s=;
        b=TGPPbeAWcTVbz226Iu5vfFCOmNmq1r6fQbs6cfCO1gq4yQ9luu0mK4ue0U+oPlVPrX
         Tw3P84APigC0QXJ0CplnIZ8ZJg832MGbXIy/rQyWmt21k9MJCoi0W978jttMjUDdRh2X
         pwsX4+lSVl5tUh6Slf8QDMhE+/TgUmNTnNQ5rO9E/8Dezu+PtCM+XdtVXFw39+h9ZSgy
         qlLusjx3DRRj2N4IIz9jwJbNlQdo1b5snJ3QX1aWml9hbAtpTzr6GQFs/zbvGTm9M1Dx
         vlWIjpk8BKH1Xee78XRiUoeifR93ckKuQTuDNh075cVX8XQ6h31mCtT9YmXvCqbBbtrw
         KSdg==
X-Gm-Message-State: APjAAAWJz26pixTcBU3K9MZXYHrXm+mp89765g1NbMYYCl+Wa6SH08cy
        uJo3+JsCk6uO6g+RNouqkslcPA==
X-Google-Smtp-Source: APXvYqwrArfkjixaiROj/5i5BAEgcr0XtH1eJ8V9j+D6f55gAYz46DjrMy53tXXCLTJpgC2htTwUPA==
X-Received: by 2002:a63:f357:: with SMTP id t23mr10380346pgj.421.1567113866106;
        Thu, 29 Aug 2019 14:24:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id o9sm2972126pgv.19.2019.08.29.14.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 14:24:25 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Date:   Thu, 29 Aug 2019 14:24:17 -0700
Message-Id: <20190829212417.257397-1-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
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
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 74 ++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 5 deletions(-)

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
index 981ee16e3ee9..bcbc48b7284f 100644
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
 
@@ -251,6 +251,59 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
+/* How many bytes left in this page. */
+static unsigned int rest_of_page(void *data)
+{
+	return PAGE_SIZE - offset_in_page(data);
+}
+
+/* Create sg_table from a vmalloc'd buffer. */
+static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size)
+{
+	int nents, ret, s, i;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+	struct page *pg;
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
 					       struct virtio_gpu_vbuffer *vbuf)
 		__releases(&vgdev->ctrlq.qlock)
@@ -260,6 +313,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	struct scatterlist *sgs[3], vcmd, vout, vresp;
 	int outcnt = 0, incnt = 0;
 	int ret;
+	struct sg_table *sgt = NULL;
 
 	if (!vgdev->vqs_ready)
 		return -ENODEV;
@@ -269,8 +323,17 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	outcnt++;
 
 	if (vbuf->data_size) {
-		sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
-		sgs[outcnt + incnt] = &vout;
+		if (is_vmalloc_addr(vbuf->data_buf)) {
+			spin_unlock(&vgdev->ctrlq.qlock);
+			sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size);
+			spin_lock(&vgdev->ctrlq.qlock);
+			if (!sgt)
+				return -ENOMEM;
+			sgs[outcnt + incnt] = sgt->sgl;
+		} else {
+			sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
+			sgs[outcnt + incnt] = &vout;
+		}
 		outcnt++;
 	}
 
@@ -294,6 +357,11 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 		virtqueue_kick(vq);
 	}
 
+	if (sgt) {
+		sg_free_table(sgt);
+		kfree(sgt);
+	}
+
 	if (!ret)
 		ret = vq->num_free;
 	return ret;
-- 
2.23.0.187.g17f5b7556c-goog

