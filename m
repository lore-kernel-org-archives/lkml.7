Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59040C46478
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE78218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGBOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23095 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfGBOTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17EF6882FD;
        Tue,  2 Jul 2019 14:19:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F07CF5D6A9;
        Tue,  2 Jul 2019 14:19:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A458A1750B; Tue,  2 Jul 2019 16:19:04 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 08/18] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
Date:   Tue,  2 Jul 2019 16:18:53 +0200
Message-Id: <20190702141903.1131-9-kraxel@redhat.com>
In-Reply-To: <20190702141903.1131-1-kraxel@redhat.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 14:19:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework fencing workflow, starting with virtio_gpu_execbuffer_ioctl.
Stop using ttm helpers, use the virtio_gpu_array_* helpers (which work
on the reservation objects directly) instead.

New workflow:

 (1) All gem objects needed by a command are added to a
     virtio_gpu_object_array.
 (2) All reservation objects will be locked (virtio_gpu_array_lock_resv).
 (3) virtio_gpu_fence_emit() completes fence initialization.
 (4) fence gets added to the objects, reservation objects are unlocked
     (virtio_gpu_array_add_fence, virtio_gpu_array_unlock_resv).
 (5) virtio command is submitted to the host.
 (6) The completion callback (virtio_gpu_dequeue_ctrl_func)
     will drop object references and free virtio_gpu_object_array.

v6: rewrite most of the patch.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 ++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 56 +++++++++-----------------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 21 +++++++---
 3 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index abb078a5dedf..98511d1dfff2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -121,9 +121,9 @@ struct virtio_gpu_vbuffer {
 
 	char *resp_buf;
 	int resp_size;
-
 	virtio_gpu_resp_cb resp_cb;
 
+	struct virtio_gpu_object_array *objs;
 	struct list_head list;
 };
 
@@ -318,7 +318,9 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 					    uint32_t resource_id);
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
-			   uint32_t ctx_id, struct virtio_gpu_fence *fence);
+			   uint32_t ctx_id,
+			   struct virtio_gpu_object_array *objs,
+			   struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 					  uint32_t resource_id, uint32_t ctx_id,
 					  uint64_t offset, uint32_t level,
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 0caff3fa623e..9735d7e5899b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -105,16 +105,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct drm_virtgpu_execbuffer *exbuf = data;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
-	struct drm_gem_object *gobj;
 	struct virtio_gpu_fence *out_fence;
-	struct virtio_gpu_object *qobj;
 	int ret;
 	uint32_t *bo_handles = NULL;
 	void __user *user_bo_handles = NULL;
-	struct list_head validate_list;
-	struct ttm_validate_buffer *buflist = NULL;
-	int i;
-	struct ww_acquire_ctx ticket;
+	struct virtio_gpu_object_array *buflist = NULL;
 	struct sync_file *sync_file;
 	int in_fence_fd = exbuf->fence_fd;
 	int out_fence_fd = -1;
@@ -155,15 +150,10 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			return out_fence_fd;
 	}
 
-	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
-
 		bo_handles = kvmalloc_array(exbuf->num_bo_handles,
-					   sizeof(uint32_t), GFP_KERNEL);
-		buflist = kvmalloc_array(exbuf->num_bo_handles,
-					   sizeof(struct ttm_validate_buffer),
-					   GFP_KERNEL | __GFP_ZERO);
-		if (!bo_handles || !buflist) {
+					    sizeof(uint32_t), GFP_KERNEL);
+		if (!bo_handles) {
 			ret = -ENOMEM;
 			goto out_unused_fd;
 		}
@@ -175,25 +165,21 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			goto out_unused_fd;
 		}
 
-		for (i = 0; i < exbuf->num_bo_handles; i++) {
-			gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
-			if (!gobj) {
-				ret = -ENOENT;
-				goto out_unused_fd;
-			}
-
-			qobj = gem_to_virtio_gpu_obj(gobj);
-			buflist[i].bo = &qobj->tbo;
-
-			list_add(&buflist[i].head, &validate_list);
+		buflist = virtio_gpu_array_from_handles(drm_file, bo_handles,
+							exbuf->num_bo_handles);
+		if (!buflist) {
+			ret = -ENOENT;
+			goto out_unused_fd;
 		}
 		kvfree(bo_handles);
 		bo_handles = NULL;
 	}
 
-	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
-	if (ret)
-		goto out_free;
+	if (buflist) {
+		ret = virtio_gpu_array_lock_resv(buflist);
+		if (ret)
+			goto out_unused_fd;
+	}
 
 	buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
@@ -220,24 +206,18 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	}
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, out_fence);
-
-	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
-
-	/* fence the command bo */
-	virtio_gpu_unref_list(&validate_list);
-	kvfree(buflist);
+			      vfpriv->ctx_id, buflist, out_fence);
 	return 0;
 
 out_memdup:
 	kfree(buf);
 out_unresv:
-	ttm_eu_backoff_reservation(&ticket, &validate_list);
-out_free:
-	virtio_gpu_unref_list(&validate_list);
+	if (buflist)
+		virtio_gpu_array_unlock_resv(buflist);
 out_unused_fd:
 	kvfree(bo_handles);
-	kvfree(buflist);
+	if (buflist)
+		virtio_gpu_array_put_free(buflist);
 
 	if (out_fence_fd >= 0)
 		put_unused_fd(out_fence_fd);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6c1a90717535..dbe329801e84 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -191,7 +191,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 	} while (!virtqueue_enable_cb(vgdev->ctrlq.vq));
 	spin_unlock(&vgdev->ctrlq.qlock);
 
-	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
+	list_for_each_entry(entry, &reclaim_list, list) {
 		resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
 
 		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
@@ -218,14 +218,18 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 		}
 		if (entry->resp_cb)
 			entry->resp_cb(vgdev, entry);
-
-		list_del(&entry->list);
-		free_vbuf(vgdev, entry);
 	}
 	wake_up(&vgdev->ctrlq.ack_queue);
 
 	if (fence_id)
 		virtio_gpu_fence_event_process(vgdev, fence_id);
+
+	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
+		if (entry->objs)
+			virtio_gpu_array_put_free(entry->objs);
+		list_del(&entry->list);
+		free_vbuf(vgdev, entry);
+	}
 }
 
 void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
@@ -337,6 +341,10 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 
 	if (fence)
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
+	if (vbuf->objs) {
+		virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
+		virtio_gpu_array_unlock_resv(vbuf->objs);
+	}
 	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
 	return rc;
@@ -939,7 +947,9 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
-			   uint32_t ctx_id, struct virtio_gpu_fence *fence)
+			   uint32_t ctx_id,
+			   struct virtio_gpu_object_array *objs,
+			   struct virtio_gpu_fence *fence)
 {
 	struct virtio_gpu_cmd_submit *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -949,6 +959,7 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 
 	vbuf->data_buf = data;
 	vbuf->data_size = data_size;
+	vbuf->objs = objs;
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_SUBMIT_3D);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
-- 
2.18.1

