Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B502CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A0F2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442773AbfJRMX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:23:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408123AbfJRMX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:23:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47EAA307C656;
        Fri, 18 Oct 2019 12:23:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6200060BF1;
        Fri, 18 Oct 2019 12:23:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5739616E08; Fri, 18 Oct 2019 14:23:52 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: move byteorder handling into virtio_gpu_cmd_transfer_to_host_2d function
Date:   Fri, 18 Oct 2019 14:23:52 +0200
Message-Id: <20191018122352.17019-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 18 Oct 2019 12:23:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be consistent with the rest of the code base.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_plane.c | 12 ++++++------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 314e02f94d9c..0b56ba005e25 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -267,8 +267,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
-					__le32 width, __le32 height,
-					__le32 x, __le32 y,
+					uint32_t width, uint32_t height,
+					uint32_t x, uint32_t y,
 					struct virtio_gpu_object_array *objs,
 					struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index f4b7360282ce..390524143139 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -132,10 +132,10 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 			virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
 			virtio_gpu_cmd_transfer_to_host_2d
 				(vgdev, 0,
-				 cpu_to_le32(plane->state->src_w >> 16),
-				 cpu_to_le32(plane->state->src_h >> 16),
-				 cpu_to_le32(plane->state->src_x >> 16),
-				 cpu_to_le32(plane->state->src_y >> 16),
+				 plane->state->src_w >> 16,
+				 plane->state->src_h >> 16,
+				 plane->state->src_x >> 16,
+				 plane->state->src_y >> 16,
 				 objs, NULL);
 		}
 	} else {
@@ -234,8 +234,8 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
-			 cpu_to_le32(plane->state->crtc_w),
-			 cpu_to_le32(plane->state->crtc_h),
+			 plane->state->crtc_w,
+			 plane->state->crtc_h,
 			 0, 0, objs, vgfb->fence);
 		dma_fence_wait(&vgfb->fence->f, true);
 		dma_fence_put(&vgfb->fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 80176f379ad5..74ad3bc3ebe8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -549,8 +549,8 @@ void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
-					__le32 width, __le32 height,
-					__le32 x, __le32 y,
+					uint32_t width, uint32_t height,
+					uint32_t x, uint32_t y,
 					struct virtio_gpu_object_array *objs,
 					struct virtio_gpu_fence *fence)
 {
@@ -571,10 +571,10 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 	cmd_p->offset = cpu_to_le64(offset);
-	cmd_p->r.width = width;
-	cmd_p->r.height = height;
-	cmd_p->r.x = x;
-	cmd_p->r.y = y;
+	cmd_p->r.width = cpu_to_le32(width);
+	cmd_p->r.height = cpu_to_le32(height);
+	cmd_p->r.x = cpu_to_le32(x);
+	cmd_p->r.y = cpu_to_le32(y);
 
 	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
 }
-- 
2.18.1

