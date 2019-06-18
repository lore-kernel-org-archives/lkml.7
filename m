Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A74C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF31820873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfFRN6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbfFRN6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77A2F8535C;
        Tue, 18 Jun 2019 13:58:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03E387D50E;
        Tue, 18 Jun 2019 13:58:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A208117446; Tue, 18 Jun 2019 15:58:21 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/12] drm/virtio: drop no_wait argument from virtio_gpu_object_reserve
Date:   Tue, 18 Jun 2019 15:58:13 +0200
Message-Id: <20190618135821.8644-6-kraxel@redhat.com>
In-Reply-To: <20190618135821.8644-1-kraxel@redhat.com>
References: <20190618135821.8644-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 18 Jun 2019 13:58:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers pass no_wait = false.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 5 ++---
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 4 ++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 2cd96256ba37..06cc0e961df6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -398,12 +398,11 @@ static inline u64 virtio_gpu_object_mmap_offset(struct virtio_gpu_object *bo)
 	return drm_vma_node_offset_addr(&bo->tbo.vma_node);
 }
 
-static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo,
-					 bool no_wait)
+static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
 {
 	int r;
 
-	r = ttm_bo_reserve(&bo->tbo, true, no_wait, NULL);
+	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS) {
 			struct virtio_gpu_device *qdev =
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 1e49e08dd545..9c9ad3b14080 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -140,7 +140,7 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 	if (!vgdev->has_virgl_3d)
 		return 0;
 
-	r = virtio_gpu_object_reserve(qobj, false);
+	r = virtio_gpu_object_reserve(qobj);
 	if (r)
 		return r;
 
@@ -161,7 +161,7 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 	if (!vgdev->has_virgl_3d)
 		return;
 
-	r = virtio_gpu_object_reserve(qobj, false);
+	r = virtio_gpu_object_reserve(qobj);
 	if (r)
 		return;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 313c770ea2c5..5cffd2e54c04 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -375,7 +375,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 
 	qobj = gem_to_virtio_gpu_obj(gobj);
 
-	ret = virtio_gpu_object_reserve(qobj, false);
+	ret = virtio_gpu_object_reserve(qobj);
 	if (ret)
 		goto out;
 
@@ -425,7 +425,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 
 	qobj = gem_to_virtio_gpu_obj(gobj);
 
-	ret = virtio_gpu_object_reserve(qobj, false);
+	ret = virtio_gpu_object_reserve(qobj);
 	if (ret)
 		goto out;
 
-- 
2.18.1

