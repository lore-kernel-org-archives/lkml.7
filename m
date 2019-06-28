Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5885C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A410208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfF1MNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbfF1MNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:13:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B518A3092647;
        Fri, 28 Jun 2019 12:13:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 391B85C893;
        Fri, 28 Jun 2019 12:13:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CF8159D71; Fri, 28 Jun 2019 14:13:39 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 09/12] drm/virtio: rework virtio_gpu_object_create fencing
Date:   Fri, 28 Jun 2019 14:13:35 +0200
Message-Id: <20190628121338.24398-10-kraxel@redhat.com>
In-Reply-To: <20190628121338.24398-1-kraxel@redhat.com>
References: <20190628121338.24398-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 28 Jun 2019 12:13:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use gem reservation helpers and direct reservation_object_* calls
instead of ttm.

v5: fix fencing (Chia-I Wu).
v3: Due to using the gem reservation object it is initialized and ready
for use before calling ttm_bo_init, so we can also drop the tricky fence
logic which checks whenever the command is in flight still.  We can
simply fence our object before submitting the virtio command and be done
with it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 +
 drivers/gpu/drm/virtio/virtgpu_object.c | 55 ++++++++++---------------
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  4 ++
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 356d27132388..c4b266b6f731 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -267,6 +267,7 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    struct virtio_gpu_object_params *params,
+				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
@@ -329,6 +330,7 @@ void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_object_params *params,
+				  struct virtio_gpu_object_array *objs,
 				  struct virtio_gpu_fence *fence);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 82bfbf983fd2..fa0ea22c68b0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -97,7 +97,9 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object **bo_ptr,
 			     struct virtio_gpu_fence *fence)
 {
+	struct virtio_gpu_object_array *objs = NULL;
 	struct virtio_gpu_object *bo;
+	struct ww_acquire_ctx ticket;
 	size_t acc_size;
 	int ret;
 
@@ -123,12 +125,29 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	}
 	bo->dumb = params->dumb;
 
+	if (fence) {
+		objs = virtio_gpu_array_alloc(1);
+		objs->objs[0] = &bo->gem_base;
+		drm_gem_object_get(objs->objs[0]);
+
+		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
+						&ticket);
+		if (ret == 0)
+			reservation_object_add_excl_fence(objs->objs[0]->resv,
+							  &fence->f);
+	}
+
 	if (params->virgl) {
-		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params, fence);
+		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
+						  objs, fence);
 	} else {
-		virtio_gpu_cmd_create_resource(vgdev, bo, params, fence);
+		virtio_gpu_cmd_create_resource(vgdev, bo, params,
+					       objs, fence);
 	}
 
+	if (fence)
+		drm_gem_unlock_reservations(objs->objs, objs->nents, &ticket);
+
 	virtio_gpu_init_ttm_placement(bo);
 	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
 			  ttm_bo_type_device, &bo->placement, 0,
@@ -139,38 +158,6 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	if (ret != 0)
 		return ret;
 
-	if (fence) {
-		struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
-		struct list_head validate_list;
-		struct ttm_validate_buffer mainbuf;
-		struct ww_acquire_ctx ticket;
-		unsigned long irq_flags;
-		bool signaled;
-
-		INIT_LIST_HEAD(&validate_list);
-		memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
-
-		/* use a gem reference since unref list undoes them */
-		drm_gem_object_get(&bo->gem_base);
-		mainbuf.bo = &bo->tbo;
-		list_add(&mainbuf.head, &validate_list);
-
-		ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
-		if (ret == 0) {
-			spin_lock_irqsave(&drv->lock, irq_flags);
-			signaled = virtio_fence_signaled(&fence->f);
-			if (!signaled)
-				/* virtio create command still in flight */
-				ttm_eu_fence_buffer_objects(&ticket, &validate_list,
-							    &fence->f);
-			spin_unlock_irqrestore(&drv->lock, irq_flags);
-			if (signaled)
-				/* virtio create command finished */
-				ttm_eu_backoff_reservation(&ticket, &validate_list);
-		}
-		virtio_gpu_unref_list(&validate_list);
-	}
-
 	*bo_ptr = bo;
 	return 0;
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 0c87c3e086f8..0a735e51a803 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -391,6 +391,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    struct virtio_gpu_object_params *params,
+				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_2d *cmd_p;
@@ -398,6 +399,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
+	vbuf->objs = objs;
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
@@ -864,6 +866,7 @@ void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_object_params *params,
+				  struct virtio_gpu_object_array *objs,
 				  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
@@ -871,6 +874,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
+	vbuf->objs = objs;
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-- 
2.18.1

