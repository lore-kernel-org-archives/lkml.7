Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC2021738
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfHEMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfHEMnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:43:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22CD8307CDFC;
        Mon,  5 Aug 2019 12:43:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCB005DA8C;
        Mon,  5 Aug 2019 12:43:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 25FAD9D21; Mon,  5 Aug 2019 14:43:15 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, thomas@shipmail.org,
        tzimmermann@suse.de, ckoenig.leichtzumerken@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 17/18] drm/virtio: switch driver from bo->resv to bo->base.resv
Date:   Mon,  5 Aug 2019 14:43:09 +0200
Message-Id: <20190805124310.3275-18-kraxel@redhat.com>
In-Reply-To: <20190805124310.3275-1-kraxel@redhat.com>
References: <20190805124310.3275-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 05 Aug 2019 12:43:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
 drivers/gpu/drm/virtio/virtgpu_plane.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d379d2e7e3ef..3c430dd65f67 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -396,7 +396,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 		(vgdev, qobj->hw_res_handle,
 		 vfpriv->ctx_id, offset, args->level,
 		 &box, fence);
-	reservation_object_add_excl_fence(qobj->tbo.resv,
+	reservation_object_add_excl_fence(qobj->tbo.base.resv,
 					  &fence->f);
 
 	dma_fence_put(&fence->f);
@@ -450,7 +450,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 			(vgdev, qobj,
 			 vfpriv ? vfpriv->ctx_id : 0, offset,
 			 args->level, &box, fence);
-		reservation_object_add_excl_fence(qobj->tbo.resv,
+		reservation_object_add_excl_fence(qobj->tbo.base.resv,
 						  &fence->f);
 		dma_fence_put(&fence->f);
 	}
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index f96c8296307e..3dc08f991a8d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -212,7 +212,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			 0, 0, vgfb->fence);
 		ret = virtio_gpu_object_reserve(bo, false);
 		if (!ret) {
-			reservation_object_add_excl_fence(bo->tbo.resv,
+			reservation_object_add_excl_fence(bo->tbo.base.resv,
 							  &vgfb->fence->f);
 			dma_fence_put(&vgfb->fence->f);
 			vgfb->fence = NULL;
-- 
2.18.1

