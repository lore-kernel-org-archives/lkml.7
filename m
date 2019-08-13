Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8E0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF6D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfHMIZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfHMIZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:25:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16CBE30832DC;
        Tue, 13 Aug 2019 08:25:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E067600C1;
        Tue, 13 Aug 2019 08:25:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7D05E9D00; Tue, 13 Aug 2019 10:25:09 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/virtio: notify virtqueues without holding spinlock
Date:   Tue, 13 Aug 2019 10:25:09 +0200
Message-Id: <20190813082509.29324-3-kraxel@redhat.com>
In-Reply-To: <20190813082509.29324-1-kraxel@redhat.com>
References: <20190813082509.29324-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 13 Aug 2019 08:25:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split virtqueue_kick() call into virtqueue_kick_prepare(), which
requires serialization, and virtqueue_notify(), which does not.  Move
the virtqueue_notify() call out of the critical section protected by the
queue lock.  This avoids triggering a vmexit while holding the lock and
thereby fixes a rather bad spinlock contention.

Suggested-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index ca91e83ffaef..e41c96143342 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -252,7 +252,7 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
-static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
+static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 						struct virtio_gpu_vbuffer *vbuf)
 		__releases(&vgdev->ctrlq.qlock)
 		__acquires(&vgdev->ctrlq.qlock)
@@ -260,10 +260,11 @@ static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	struct scatterlist *sgs[3], vcmd, vout, vresp;
 	int outcnt = 0, incnt = 0;
+	bool notify = false;
 	int ret;
 
 	if (!vgdev->vqs_ready)
-		return;
+		return notify;
 
 	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
 	sgs[outcnt + incnt] = &vcmd;
@@ -292,16 +293,21 @@ static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 		trace_virtio_gpu_cmd_queue(vq,
 			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
 
-		virtqueue_kick(vq);
+		notify = virtqueue_kick_prepare(vq);
 	}
+	return notify;
 }
 
 static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					 struct virtio_gpu_vbuffer *vbuf)
 {
+	bool notify;
+
 	spin_lock(&vgdev->ctrlq.qlock);
-	virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
+	if (notify)
+		virtqueue_notify(vgdev->ctrlq.vq);
 }
 
 static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
@@ -310,6 +316,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 						struct virtio_gpu_fence *fence)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
+	bool notify;
 
 again:
 	spin_lock(&vgdev->ctrlq.qlock);
@@ -330,8 +337,10 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 
 	if (fence)
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
-	virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
+	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
+	if (notify)
+		virtqueue_notify(vgdev->ctrlq.vq);
 }
 
 static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
@@ -339,6 +348,7 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 {
 	struct virtqueue *vq = vgdev->cursorq.vq;
 	struct scatterlist *sgs[1], ccmd;
+	bool notify;
 	int ret;
 	int outcnt;
 
@@ -361,10 +371,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 		trace_virtio_gpu_cmd_queue(vq,
 			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
 
-		virtqueue_kick(vq);
+		notify = virtqueue_kick_prepare(vq);
 	}
 
 	spin_unlock(&vgdev->cursorq.qlock);
+
+	if (notify)
+		virtqueue_notify(vq);
 }
 
 /* just create gem objects for userspace and long lived objects,
-- 
2.18.1

