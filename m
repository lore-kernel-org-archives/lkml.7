Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE212186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH3GBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfH3GBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A2D1308218D;
        Fri, 30 Aug 2019 06:01:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A464600F8;
        Fri, 30 Aug 2019 06:01:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 939B416E05; Fri, 30 Aug 2019 08:01:27 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: add worker for object release
Date:   Fri, 30 Aug 2019 08:01:16 +0200
Message-Id: <20190830060116.10476-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 30 Aug 2019 06:01:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move object release into a separate worker.  Releasing objects requires
sending commands to the host.  Doing that in the dequeue worker will
cause deadlocks in case the command queue gets filled up, because the
dequeue worker is also the one which will free up slots in the command
queue.

Reported-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  8 ++++++++
 drivers/gpu/drm/virtio/virtgpu_gem.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c |  6 ++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c  |  2 +-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index fb35831ed351..314e02f94d9c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -78,6 +78,7 @@ struct virtio_gpu_object {
 
 struct virtio_gpu_object_array {
 	struct ww_acquire_ctx ticket;
+	struct list_head next;
 	u32 nents, total;
 	struct drm_gem_object *objs[];
 };
@@ -197,6 +198,10 @@ struct virtio_gpu_device {
 
 	struct work_struct config_changed_work;
 
+	struct work_struct obj_free_work;
+	spinlock_t obj_free_lock;
+	struct list_head obj_free_list;
+
 	struct virtio_gpu_drv_capset *capsets;
 	uint32_t num_capsets;
 	struct list_head cap_cache;
@@ -246,6 +251,9 @@ void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
 void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
+				       struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_put_free_work(struct work_struct *work);
 
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index b812094ae916..4c1f579edfb3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -239,3 +239,30 @@ void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs)
 		drm_gem_object_put_unlocked(objs->objs[i]);
 	virtio_gpu_array_free(objs);
 }
+
+void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
+				       struct virtio_gpu_object_array *objs)
+{
+	spin_lock(&vgdev->obj_free_lock);
+	list_add_tail(&objs->next, &vgdev->obj_free_list);
+	spin_unlock(&vgdev->obj_free_lock);
+	schedule_work(&vgdev->obj_free_work);
+}
+
+void virtio_gpu_array_put_free_work(struct work_struct *work)
+{
+	struct virtio_gpu_device *vgdev =
+		container_of(work, struct virtio_gpu_device, obj_free_work);
+	struct virtio_gpu_object_array *objs;
+
+	spin_lock(&vgdev->obj_free_lock);
+	while (!list_empty(&vgdev->obj_free_list)) {
+		objs = list_first_entry(&vgdev->obj_free_list,
+					struct virtio_gpu_object_array, next);
+		list_del(&objs->next);
+		spin_unlock(&vgdev->obj_free_lock);
+		virtio_gpu_array_put_free(objs);
+		spin_lock(&vgdev->obj_free_lock);
+	}
+	spin_unlock(&vgdev->obj_free_lock);
+}
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 231c4e27b3b3..0b3cdb0d83b0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -147,6 +147,11 @@ int virtio_gpu_init(struct drm_device *dev)
 	INIT_WORK(&vgdev->config_changed_work,
 		  virtio_gpu_config_changed_work_func);
 
+	INIT_WORK(&vgdev->obj_free_work,
+		  virtio_gpu_array_put_free_work);
+	INIT_LIST_HEAD(&vgdev->obj_free_list);
+	spin_lock_init(&vgdev->obj_free_lock);
+
 #ifdef __LITTLE_ENDIAN
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
@@ -226,6 +231,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 
+	flush_work(&vgdev->obj_free_work);
 	vgdev->vqs_ready = false;
 	flush_work(&vgdev->ctrlq.dequeue_work);
 	flush_work(&vgdev->cursorq.dequeue_work);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index ecf57df965b0..595fa6ec2d58 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -227,7 +227,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
 		if (entry->objs)
-			virtio_gpu_array_put_free(entry->objs);
+			virtio_gpu_array_put_free_delayed(vgdev, entry->objs);
 		list_del(&entry->list);
 		free_vbuf(vgdev, entry);
 	}
-- 
2.18.1

