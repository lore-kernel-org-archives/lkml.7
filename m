Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5E0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626022073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH2Kd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:33:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19693 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfH2KdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:33:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 855D07FDE9;
        Thu, 29 Aug 2019 10:33:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E58415D9E2;
        Thu, 29 Aug 2019 10:33:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2B3F631EFC; Thu, 29 Aug 2019 12:33:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 09/18] drm/virtio: rework virtio_gpu_object_create fencing
Date:   Thu, 29 Aug 2019 12:32:52 +0200
Message-Id: <20190829103301.3539-10-kraxel@redhat.com>
In-Reply-To: <20190829103301.3539-1-kraxel@redhat.com>
References: <20190829103301.3539-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 29 Aug 2019 10:33:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework fencing workflow.  Stop using ttm helpers, use the
virtio_gpu_array_* helpers instead.

Due to using the gem reservation object it is initialized and ready for
use before calling ttm_bo_init.  So we can simply use the standard
fencing workflow and drop the tricky logic which checks whenever the
command is in flight still.

v6: rewrite most of the patch.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 +
 drivers/gpu/drm/virtio/virtgpu_object.c | 74 +++++++++++--------------
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  4 ++
 3 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f4f843aec18a..c6ea65f6507e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -274,6 +274,7 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    struct virtio_gpu_object_params *params,
+				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
@@ -336,6 +337,7 @@ void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_object_params *params,
+				  struct virtio_gpu_object_array *objs,
 				  struct virtio_gpu_fence *fence);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index ad216d062507..6af2862c9a73 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -103,6 +103,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object **bo_ptr,
 			     struct virtio_gpu_fence *fence)
 {
+	struct virtio_gpu_object_array *objs = NULL;
 	struct virtio_gpu_object *bo;
 	size_t acc_size;
 	int ret;
@@ -116,23 +117,34 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	if (bo == NULL)
 		return -ENOMEM;
 	ret = virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
-	if (ret < 0) {
-		kfree(bo);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_free_gem;
+
 	params->size = roundup(params->size, PAGE_SIZE);
 	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, params->size);
-	if (ret != 0) {
-		virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
-		kfree(bo);
-		return ret;
-	}
+	if (ret != 0)
+		goto err_put_id;
+
 	bo->dumb = params->dumb;
 
+	if (fence) {
+		ret = -ENOMEM;
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs)
+			goto err_put_id;
+		virtio_gpu_array_add_obj(objs, &bo->gem_base);
+
+		ret = virtio_gpu_array_lock_resv(objs);
+		if (ret != 0)
+			goto err_put_objs;
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
 
 	virtio_gpu_init_ttm_placement(bo);
@@ -145,40 +157,16 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
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
+
+err_put_objs:
+	virtio_gpu_array_put_free(objs);
+err_put_id:
+	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
+err_free_gem:
+	kfree(bo);
+	return ret;
 }
 
 void virtio_gpu_object_kunmap(struct virtio_gpu_object *bo)
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5137dcf11d31..7509424a7b92 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -396,6 +396,7 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    struct virtio_gpu_object_params *params,
+				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_2d *cmd_p;
@@ -403,6 +404,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
+	vbuf->objs = objs;
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
@@ -869,6 +871,7 @@ void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
 				  struct virtio_gpu_object_params *params,
+				  struct virtio_gpu_object_array *objs,
 				  struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
@@ -876,6 +879,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
+	vbuf->objs = objs;
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-- 
2.18.1

