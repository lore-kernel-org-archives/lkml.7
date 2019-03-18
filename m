Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45926C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6822087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCRLdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfCRLdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E6993082E6A;
        Mon, 18 Mar 2019 11:33:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B52A17B18;
        Mon, 18 Mar 2019 11:33:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 999F117538; Mon, 18 Mar 2019 12:33:33 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/5] drm/virtio: params struct for virtio_gpu_cmd_create_resource_3d()
Date:   Mon, 18 Mar 2019 12:33:31 +0100
Message-Id: <20190318113332.10900-5-kraxel@redhat.com>
In-Reply-To: <20190318113332.10900-1-kraxel@redhat.com>
References: <20190318113332.10900-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 18 Mar 2019 11:33:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 3d resource parameters to virtio_gpu_object_params struct.  With
that in place we can use it for virtio_gpu_cmd_resource_create_3d()
calls.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 10 +++++++++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 25 ++++++++++---------------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 16 +++++++++++++---
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 5b38c397afbc..9b01cb34a616 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -55,6 +55,14 @@ struct virtio_gpu_object_params {
 	uint32_t width;
 	uint32_t height;
 	unsigned long size;
+	/* 3d */
+	uint32_t target;
+	uint32_t bind;
+	uint32_t depth;
+	uint32_t array_size;
+	uint32_t last_level;
+	uint32_t nr_samples;
+	uint32_t flags;
 };
 
 struct virtio_gpu_object {
@@ -309,7 +317,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d);
+				  struct virtio_gpu_object_params *params);
 void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_fence_ack(struct virtqueue *vq);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d1751ee488e5..143898b0d628 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -283,7 +283,6 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct ttm_validate_buffer mainbuf;
 	struct virtio_gpu_fence *fence = NULL;
 	struct ww_acquire_ctx ticket;
-	struct virtio_gpu_resource_create_3d rc_3d;
 	struct virtio_gpu_object_params params = { 0 };
 
 	if (vgdev->has_virgl_3d == false) {
@@ -306,7 +305,15 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	params.width = rc->width;
 	params.height = rc->height;
 	params.size = rc->size;
-
+	if (vgdev->has_virgl_3d) {
+		params.target = rc->target;
+		params.bind = rc->bind;
+		params.depth = rc->depth;
+		params.array_size = rc->array_size;
+		params.last_level = rc->last_level;
+		params.nr_samples = rc->nr_samples;
+		params.flags = rc->flags;
+	}
 	/* allocate a single page size object */
 	if (params.size == 0)
 		params.size = PAGE_SIZE;
@@ -332,25 +339,13 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 			goto fail_unref;
 		}
 
-		rc_3d.resource_id = cpu_to_le32(qobj->hw_res_handle);
-		rc_3d.target = cpu_to_le32(rc->target);
-		rc_3d.format = cpu_to_le32(rc->format);
-		rc_3d.bind = cpu_to_le32(rc->bind);
-		rc_3d.width = cpu_to_le32(rc->width);
-		rc_3d.height = cpu_to_le32(rc->height);
-		rc_3d.depth = cpu_to_le32(rc->depth);
-		rc_3d.array_size = cpu_to_le32(rc->array_size);
-		rc_3d.last_level = cpu_to_le32(rc->last_level);
-		rc_3d.nr_samples = cpu_to_le32(rc->nr_samples);
-		rc_3d.flags = cpu_to_le32(rc->flags);
-
 		fence = virtio_gpu_fence_alloc(vgdev);
 		if (!fence) {
 			ret = -ENOMEM;
 			goto fail_backoff;
 		}
 
-		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d);
+		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &params);
 		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
 		if (ret) {
 			dma_fence_put(&fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 363b8b85775e..ca93ec6ca3c5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -826,7 +826,7 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
 void
 virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 				  struct virtio_gpu_object *bo,
-				  struct virtio_gpu_resource_create_3d *rc_3d)
+				  struct virtio_gpu_object_params *params)
 {
 	struct virtio_gpu_resource_create_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -834,9 +834,19 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
-	*cmd_p = *rc_3d;
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
-	cmd_p->hdr.flags = 0;
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
+	cmd_p->format = cpu_to_le32(params->format);
+	cmd_p->width = cpu_to_le32(params->width);
+	cmd_p->height = cpu_to_le32(params->height);
+
+	cmd_p->target = cpu_to_le32(params->target);
+	cmd_p->bind = cpu_to_le32(params->bind);
+	cmd_p->depth = cpu_to_le32(params->depth);
+	cmd_p->array_size = cpu_to_le32(params->array_size);
+	cmd_p->last_level = cpu_to_le32(params->last_level);
+	cmd_p->nr_samples = cpu_to_le32(params->nr_samples);
+	cmd_p->flags = cpu_to_le32(params->flags);
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
-- 
2.18.1

