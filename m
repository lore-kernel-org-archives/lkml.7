Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F154C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77A2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393021AbfHBNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392996AbfHBNMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:12:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3ACAF300BC74;
        Fri,  2 Aug 2019 13:12:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D42E25C22B;
        Fri,  2 Aug 2019 13:12:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C21CE9D1D; Fri,  2 Aug 2019 15:12:27 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 13/18] drm/virtio: drop virtio_gpu_object_list_validate/virtio_gpu_unref_list
Date:   Fri,  2 Aug 2019 15:12:20 +0200
Message-Id: <20190802131225.17760-14-kraxel@redhat.com>
In-Reply-To: <20190802131225.17760-1-kraxel@redhat.com>
References: <20190802131225.17760-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 02 Aug 2019 13:12:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users left.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 --
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 39 --------------------------
 2 files changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 2fbb3d766560..e5f1b20b6f14 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -223,9 +223,6 @@ struct virtio_gpu_fpriv {
 /* virtio_ioctl.c */
 #define DRM_VIRTIO_NUM_IOCTLS 10
 extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
-int virtio_gpu_object_list_validate(struct ww_acquire_ctx *ticket,
-				    struct list_head *head);
-void virtio_gpu_unref_list(struct list_head *head);
 
 /* virtio_kms.c */
 int virtio_gpu_init(struct drm_device *dev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c85019e29e96..123ac28f498a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -56,45 +56,6 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 					 &virtio_gpu_map->offset);
 }
 
-int virtio_gpu_object_list_validate(struct ww_acquire_ctx *ticket,
-				    struct list_head *head)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	struct ttm_validate_buffer *buf;
-	struct ttm_buffer_object *bo;
-	struct virtio_gpu_object *qobj;
-	int ret;
-
-	ret = ttm_eu_reserve_buffers(ticket, head, true, NULL, true);
-	if (ret != 0)
-		return ret;
-
-	list_for_each_entry(buf, head, head) {
-		bo = buf->bo;
-		qobj = container_of(bo, struct virtio_gpu_object, tbo);
-		ret = ttm_bo_validate(bo, &qobj->placement, &ctx);
-		if (ret) {
-			ttm_eu_backoff_reservation(ticket, head);
-			return ret;
-		}
-	}
-	return 0;
-}
-
-void virtio_gpu_unref_list(struct list_head *head)
-{
-	struct ttm_validate_buffer *buf;
-	struct ttm_buffer_object *bo;
-	struct virtio_gpu_object *qobj;
-
-	list_for_each_entry(buf, head, head) {
-		bo = buf->bo;
-		qobj = container_of(bo, struct virtio_gpu_object, tbo);
-
-		drm_gem_object_put_unlocked(&qobj->gem_base);
-	}
-}
-
 /*
  * Usage of execbuffer:
  * Relocations need to take into account the full VIRTIO_GPUDrawable size.
-- 
2.18.1

