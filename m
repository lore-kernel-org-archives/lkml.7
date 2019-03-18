Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32922C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BDF2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfCRLdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbfCRLdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EF2788AAB;
        Mon, 18 Mar 2019 11:33:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 241605D9D3;
        Mon, 18 Mar 2019 11:33:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7187C17536; Mon, 18 Mar 2019 12:33:33 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/5] drm/virtio: params struct for virtio_gpu_cmd_create_resource()
Date:   Mon, 18 Mar 2019 12:33:30 +0100
Message-Id: <20190318113332.10900-4-kraxel@redhat.com>
In-Reply-To: <20190318113332.10900-1-kraxel@redhat.com>
References: <20190318113332.10900-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 18 Mar 2019 11:33:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add format, width and height fields to the virtio_gpu_object_params
struct.  With that in place we can use the parameter struct for
virtio_gpu_cmd_create_resource() calls too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 ++++---
 drivers/gpu/drm/virtio/virtgpu_gem.c   |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 10 ++++------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 16746c0fc0cf..5b38c397afbc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -51,6 +51,9 @@
 #define DRIVER_PATCHLEVEL 0
 
 struct virtio_gpu_object_params {
+	uint32_t format;
+	uint32_t width;
+	uint32_t height;
 	unsigned long size;
 };
 
@@ -247,9 +250,7 @@ int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t format,
-				    uint32_t width,
-				    uint32_t height);
+				    struct virtio_gpu_object_params *params);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index ffeb734003e4..ac15863643e7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -88,7 +88,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	struct virtio_gpu_object_params params = { 0 };
 	int ret;
 	uint32_t pitch;
-	uint32_t format;
 
 	if (args->bpp != 32)
 		return -EINVAL;
@@ -97,16 +96,17 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
+	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
+	params.width = args->width;
+	params.height = args->height;
 	params.size = args->size;
 	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
 				    &args->handle);
 	if (ret)
 		goto fail;
 
-	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_cmd_create_resource(vgdev, obj, format,
-				       args->width, args->height);
+	virtio_gpu_cmd_create_resource(vgdev, obj, &params);
 
 	/* attach the object to the resource */
 	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3b05320bcf73..d1751ee488e5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -302,6 +302,9 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	INIT_LIST_HEAD(&validate_list);
 	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
 
+	params.format = rc->format;
+	params.width = rc->width;
+	params.height = rc->height;
 	params.size = rc->size;
 
 	/* allocate a single page size object */
@@ -314,8 +317,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	obj = &qobj->gem_base;
 
 	if (!vgdev->has_virgl_3d) {
-		virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
-					       rc->width, rc->height);
+		virtio_gpu_cmd_create_resource(vgdev, qobj, &params);
 
 		ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
 	} else {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6bc2008b0d0d..363b8b85775e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -376,9 +376,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 /* create a basic resource */
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
-				    uint32_t format,
-				    uint32_t width,
-				    uint32_t height)
+				    struct virtio_gpu_object_params *params)
 {
 	struct virtio_gpu_resource_create_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
@@ -388,9 +386,9 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-	cmd_p->format = cpu_to_le32(format);
-	cmd_p->width = cpu_to_le32(width);
-	cmd_p->height = cpu_to_le32(height);
+	cmd_p->format = cpu_to_le32(params->format);
+	cmd_p->width = cpu_to_le32(params->width);
+	cmd_p->height = cpu_to_le32(params->height);
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
-- 
2.18.1

