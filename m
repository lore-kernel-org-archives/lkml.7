Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D54C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B576222B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgyfLEZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfLLMyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:54:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729289AbfLLMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576155236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=yfsqRxgDubeOFoB29hzjK9oDh1fi5tQsU42uuGO4JvA=;
        b=OgyfLEZrv1MrXD+Skkd5z0THJFnQmMeXzcF2/XOKH0vArXlksOvPjbwCA4KhnAIbvQHd9k
        ZOeOgJxvV+qBnT15Fy6pEH9riHPF5Q3AuN4BxNKCmSVv54LPuBrIhzI2UrC+lOMVAthY/J
        DIIlbi1YbIpo4+sXz18aBU0qPs3+w8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-jtrs1QBLO1mAcdbtrBxEDg-1; Thu, 12 Dec 2019 07:53:53 -0500
X-MC-Unique: jtrs1QBLO1mAcdbtrBxEDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A356E802B79;
        Thu, 12 Dec 2019 12:53:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.36.118.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C522A19C58;
        Thu, 12 Dec 2019 12:53:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1C99F9D62; Thu, 12 Dec 2019 13:53:47 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] virtio-gpu: batch display update commands.
Date:   Thu, 12 Dec 2019 13:53:45 +0100
Message-Id: <20191212125346.8334-3-kraxel@redhat.com>
In-Reply-To: <20191212125346.8334-1-kraxel@redhat.com>
References: <20191212125346.8334-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver submits multiple commands in a row it makes sense to
notify the host only after submitting the last one, so the host can
process them all at once, with a single vmexit.

Add functions to enable/disable notifications to allow that.  Use the
new functions for primary plane updates.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 ++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 23 +++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index eedae2a7b532..29cf005ed6b9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -183,6 +183,9 @@ struct virtio_gpu_device {
 	struct kmem_cache *vbufs;
 	bool vqs_ready;
 
+	bool disable_notify;
+	bool pending_notify;
+
 	struct ida	resource_ida;
 
 	wait_queue_head_t resp_wq;
@@ -335,6 +338,9 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work);
 void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
 void virtio_gpu_dequeue_fence_func(struct work_struct *work);
 
+void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev);
+void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev);
+
 /* virtio_gpu_display.c */
 int virtio_gpu_framebuffer_init(struct drm_device *dev,
 				struct virtio_gpu_framebuffer *vgfb,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 59bf76d4a333..2fb068cd680e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -146,6 +146,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
+	virtio_gpu_disable_notify(vgdev);
+
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 	if (bo->dumb)
@@ -177,6 +179,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 				      plane->state->src_y >> 16,
 				      plane->state->src_w >> 16,
 				      plane->state->src_h >> 16);
+
+	virtio_gpu_enable_notify(vgdev);
 }
 
 static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9274c4063c70..5914e79d3429 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -404,8 +404,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	}
 	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf, vout);
 	spin_unlock(&vgdev->ctrlq.qlock);
-	if (notify)
-		virtqueue_notify(vgdev->ctrlq.vq);
+	if (notify) {
+		if (vgdev->disable_notify)
+			vgdev->pending_notify = true;
+		else
+			virtqueue_notify(vgdev->ctrlq.vq);
+	}
 
 	if (sgt) {
 		sg_free_table(sgt);
@@ -413,6 +417,21 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	}
 }
 
+void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev)
+{
+	vgdev->disable_notify = true;
+}
+
+void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev)
+{
+	vgdev->disable_notify = false;
+
+	if (!vgdev->pending_notify)
+		return;
+	vgdev->pending_notify = false;
+	virtqueue_notify(vgdev->ctrlq.vq);
+}
+
 static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					 struct virtio_gpu_vbuffer *vbuf)
 {
-- 
2.18.1

