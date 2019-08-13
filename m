Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF3520663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfHMIZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53287 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfHMIZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:25:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C70430BA07B;
        Tue, 13 Aug 2019 08:25:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6387160C44;
        Tue, 13 Aug 2019 08:25:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 64A5C9D42; Tue, 13 Aug 2019 10:25:09 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/virtio: cleanup queue functions
Date:   Tue, 13 Aug 2019 10:25:08 +0200
Message-Id: <20190813082509.29324-2-kraxel@redhat.com>
In-Reply-To: <20190813082509.29324-1-kraxel@redhat.com>
References: <20190813082509.29324-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 13 Aug 2019 08:25:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the queue functions return void, none of
the call sites checks the return value.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 41 ++++++++++-------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 7ac20490e1b4..ca91e83ffaef 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -252,8 +252,8 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
-static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
-					       struct virtio_gpu_vbuffer *vbuf)
+static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
+						struct virtio_gpu_vbuffer *vbuf)
 		__releases(&vgdev->ctrlq.qlock)
 		__acquires(&vgdev->ctrlq.qlock)
 {
@@ -263,7 +263,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	int ret;
 
 	if (!vgdev->vqs_ready)
-		return -ENODEV;
+		return;
 
 	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
 	sgs[outcnt + incnt] = &vcmd;
@@ -294,30 +294,22 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 
 		virtqueue_kick(vq);
 	}
-
-	if (!ret)
-		ret = vq->num_free;
-	return ret;
 }
 
-static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					struct virtio_gpu_vbuffer *vbuf)
+static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					 struct virtio_gpu_vbuffer *vbuf)
 {
-	int rc;
-
 	spin_lock(&vgdev->ctrlq.qlock);
-	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
-	return rc;
 }
 
-static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					       struct virtio_gpu_vbuffer *vbuf,
-					       struct virtio_gpu_ctrl_hdr *hdr,
-					       struct virtio_gpu_fence *fence)
+static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
+						struct virtio_gpu_vbuffer *vbuf,
+						struct virtio_gpu_ctrl_hdr *hdr,
+						struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
-	int rc;
 
 again:
 	spin_lock(&vgdev->ctrlq.qlock);
@@ -338,13 +330,12 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 
 	if (fence)
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
-	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
-	return rc;
 }
 
-static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
-				   struct virtio_gpu_vbuffer *vbuf)
+static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
+				    struct virtio_gpu_vbuffer *vbuf)
 {
 	struct virtqueue *vq = vgdev->cursorq.vq;
 	struct scatterlist *sgs[1], ccmd;
@@ -352,7 +343,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	int outcnt;
 
 	if (!vgdev->vqs_ready)
-		return -ENODEV;
+		return;
 
 	sg_init_one(&ccmd, vbuf->buf, vbuf->size);
 	sgs[0] = &ccmd;
@@ -374,10 +365,6 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	}
 
 	spin_unlock(&vgdev->cursorq.qlock);
-
-	if (!ret)
-		ret = vq->num_free;
-	return ret;
 }
 
 /* just create gem objects for userspace and long lived objects,
-- 
2.18.1

