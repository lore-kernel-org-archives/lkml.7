Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6D2C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F39C21479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfFRN6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbfFRN6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EEECB0AA6;
        Tue, 18 Jun 2019 13:58:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 246F81001DFF;
        Tue, 18 Jun 2019 13:58:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A6CFB1753A; Tue, 18 Jun 2019 15:58:22 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 11/12] drm/virtio: rework virtio_gpu_object_create fencing even more.
Date:   Tue, 18 Jun 2019 15:58:19 +0200
Message-Id: <20190618135821.8644-12-kraxel@redhat.com>
In-Reply-To: <20190618135821.8644-1-kraxel@redhat.com>
References: <20190618135821.8644-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 18 Jun 2019 13:58:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with ttm initialization being out of the way we can simplify
virtio_gpu_object_create fencing even more.  No need to check whenever
the command is still running after ttm_bo_init() returned.  We have a
fully initialized gem bo before we kick off the resource creation
command, so we can simply add the fence to the bo's reservation object
beforehand.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 27 +++++++++----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index d0e328db0a55..4301456f087f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -120,30 +120,21 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	}
 	bo->dumb = params->dumb;
 
-	if (params->virgl) {
-		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params, fence);
-	} else {
-		virtio_gpu_cmd_create_resource(vgdev, bo, params, fence);
-	}
-
 	if (fence) {
-		struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
 		struct drm_gem_object *obj = &bo->base.base;
 		struct ww_acquire_ctx ticket;
-		unsigned long irq_flags;
 
-		drm_gem_object_get(obj);
 		ret = drm_gem_lock_reservations(&obj, 1, &ticket);
-		if (ret == 0) {
-			spin_lock_irqsave(&drv->lock, irq_flags);
-			if (!virtio_fence_signaled(&fence->f))
-				/* virtio create command still in flight */
-				reservation_object_add_excl_fence(obj->resv,
-								  &fence->f);
-			spin_unlock_irqrestore(&drv->lock, irq_flags);
-		}
+		if (ret == 0)
+			reservation_object_add_excl_fence(obj->resv,
+							  &fence->f);
 		drm_gem_unlock_reservations(&obj, 1, &ticket);
-		drm_gem_object_put_unlocked(obj);
+	}
+
+	if (params->virgl) {
+		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params, fence);
+	} else {
+		virtio_gpu_cmd_create_resource(vgdev, bo, params, fence);
 	}
 
 	ret = virtio_gpu_object_attach(vgdev, bo, NULL);
-- 
2.18.1

