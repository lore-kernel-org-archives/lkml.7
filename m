Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C0C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfFSJFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:05:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbfFSJE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 471DB6EF;
        Wed, 19 Jun 2019 09:04:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-86.ams2.redhat.com [10.36.116.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 461245C207;
        Wed, 19 Jun 2019 09:04:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DE74D9D89; Wed, 19 Jun 2019 11:04:22 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 12/12] drm/virtio: remove virtio_gpu_alloc_object
Date:   Wed, 19 Jun 2019 11:04:20 +0200
Message-Id: <20190619090420.6667-13-kraxel@redhat.com>
In-Reply-To: <20190619090420.6667-1-kraxel@redhat.com>
References: <20190619090420.6667-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 19 Jun 2019 09:04:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thin wrapper around virtio_gpu_object_create(),
but calling that directly works equally well.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ----
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 23 ++++-------------------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 +++---
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 0087a0fc7020..ae4a9c21d9c1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -224,10 +224,6 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 			       struct drm_file *file);
 void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 				 struct drm_file *file);
-struct virtio_gpu_object*
-virtio_gpu_alloc_object(struct drm_device *dev,
-			struct virtio_gpu_object_params *params,
-			struct virtio_gpu_fence *fence);
 int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_device *dev,
 				struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 762d98587d3a..cebc2e10b286 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -26,35 +26,20 @@
 #include <drm/drmP.h>
 #include "virtgpu_drv.h"
 
-struct virtio_gpu_object*
-virtio_gpu_alloc_object(struct drm_device *dev,
-			struct virtio_gpu_object_params *params,
-			struct virtio_gpu_fence *fence)
-{
-	struct virtio_gpu_device *vgdev = dev->dev_private;
-	struct virtio_gpu_object *obj;
-	int ret;
-
-	ret = virtio_gpu_object_create(vgdev, params, &obj, fence);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return obj;
-}
-
 int virtio_gpu_gem_create(struct drm_file *file,
 			  struct drm_device *dev,
 			  struct virtio_gpu_object_params *params,
 			  struct drm_gem_object **obj_p,
 			  uint32_t *handle_p)
 {
+	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_object *obj;
 	int ret;
 	u32 handle;
 
-	obj = virtio_gpu_alloc_object(dev, params, NULL);
-	if (IS_ERR(obj))
-		return PTR_ERR(obj);
+	ret = virtio_gpu_object_create(vgdev, params, &obj, NULL);
+	if (ret < 0)
+		return ret;
 
 	ret = drm_gem_handle_create(file, &obj->base.base, &handle);
 	if (ret) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 98fb9955097e..da2a5b486774 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -264,10 +264,10 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	fence = virtio_gpu_fence_alloc(vgdev);
 	if (!fence)
 		return -ENOMEM;
-	qobj = virtio_gpu_alloc_object(dev, &params, fence);
+	ret = virtio_gpu_object_create(vgdev, &params, &qobj, fence);
 	dma_fence_put(&fence->f);
-	if (IS_ERR(qobj))
-		return PTR_ERR(qobj);
+	if (ret < 0)
+		return ret;
 	obj = &qobj->base.base;
 
 	ret = drm_gem_handle_create(file_priv, obj, &handle);
-- 
2.18.1

