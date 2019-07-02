Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E530C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5975B2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfGBOTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbfGBOTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA3587FDCA;
        Tue,  2 Jul 2019 14:19:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4665D9C6;
        Tue,  2 Jul 2019 14:19:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3E7D49D7D; Tue,  2 Jul 2019 16:19:06 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 16/18] drm/virtio: rework virtio_gpu_cmd_context_{attach,detach}_resource
Date:   Tue,  2 Jul 2019 16:19:01 +0200
Message-Id: <20190702141903.1131-17-kraxel@redhat.com>
In-Reply-To: <20190702141903.1131-1-kraxel@redhat.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 14:19:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the virtio_gpu_array_* helper workflow.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_gem.c | 24 +++++++++++-------------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 ++++++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index b1f63a21abb6..d99c54abd090 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -292,10 +292,10 @@ void virtio_gpu_cmd_context_destroy(struct virtio_gpu_device *vgdev,
 				    uint32_t id);
 void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device *vgdev,
 					    uint32_t ctx_id,
-					    uint32_t resource_id);
+					    struct virtio_gpu_object_array *objs);
 void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 					    uint32_t ctx_id,
-					    uint32_t resource_id);
+					    struct virtio_gpu_object_array *objs);
 void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 			   void *data, uint32_t data_size,
 			   uint32_t ctx_id,
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 6baf64141645..e75819dbba80 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -111,19 +111,18 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 {
 	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
-	struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
-	int r;
+	struct virtio_gpu_object_array *objs;
 
 	if (!vgdev->has_virgl_3d)
 		return 0;
 
-	r = virtio_gpu_object_reserve(qobj);
-	if (r)
-		return r;
+	objs = virtio_gpu_array_alloc(1);
+	if (!objs)
+		return -ENOMEM;
+	virtio_gpu_array_add_obj(objs, obj);
 
 	virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id,
-					       qobj->hw_res_handle);
-	virtio_gpu_object_unreserve(qobj);
+					       objs);
 	return 0;
 }
 
@@ -132,19 +131,18 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 {
 	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
-	struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
-	int r;
+	struct virtio_gpu_object_array *objs;
 
 	if (!vgdev->has_virgl_3d)
 		return;
 
-	r = virtio_gpu_object_reserve(qobj);
-	if (r)
+	objs = virtio_gpu_array_alloc(1);
+	if (!objs)
 		return;
+	virtio_gpu_array_add_obj(objs, obj);
 
 	virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
-						qobj->hw_res_handle);
-	virtio_gpu_object_unreserve(qobj);
+					       objs);
 }
 
 struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 1c0097de419a..799d1339ee0f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -835,8 +835,9 @@ void virtio_gpu_cmd_context_destroy(struct virtio_gpu_device *vgdev,
 
 void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device *vgdev,
 					    uint32_t ctx_id,
-					    uint32_t resource_id)
+					    struct virtio_gpu_object_array *objs)
 {
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
 	struct virtio_gpu_ctx_resource *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
 
@@ -845,15 +846,16 @@ void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 
 }
 
 void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 					    uint32_t ctx_id,
-					    uint32_t resource_id)
+					    struct virtio_gpu_object_array *objs)
 {
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
 	struct virtio_gpu_ctx_resource *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
 
@@ -862,7 +864,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
-- 
2.18.1

