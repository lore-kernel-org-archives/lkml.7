Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2DBC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1970820665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393011AbfHBNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392946AbfHBNMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:12:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 169F43090FC7;
        Fri,  2 Aug 2019 13:12:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10EF75D71C;
        Fri,  2 Aug 2019 13:12:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5E0089D77; Fri,  2 Aug 2019 15:12:26 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 04/18] drm/virtio: remove virtio_gpu_object_wait
Date:   Fri,  2 Aug 2019 15:12:11 +0200
Message-Id: <20190802131225.17760-5-kraxel@redhat.com>
In-Reply-To: <20190802131225.17760-1-kraxel@redhat.com>
References: <20190802131225.17760-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 02 Aug 2019 13:12:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users left.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  1 -
 drivers/gpu/drm/virtio/virtgpu_object.c | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f4ecea6054ba..1496e3fc1c47 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -364,7 +364,6 @@ int virtio_gpu_object_kmap(struct virtio_gpu_object *bo);
 int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
 				   struct virtio_gpu_object *bo);
 void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
-int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
 
 /* virtgpu_prime.c */
 struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 242766d644a7..82bfbf983fd2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -233,16 +233,3 @@ void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo)
 	kfree(bo->pages);
 	bo->pages = NULL;
 }
-
-int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait)
-{
-	int r;
-
-	r = ttm_bo_reserve(&bo->tbo, true, no_wait, NULL);
-	if (unlikely(r != 0))
-		return r;
-	r = ttm_bo_wait(&bo->tbo, true, no_wait);
-	ttm_bo_unreserve(&bo->tbo);
-	return r;
-}
-
-- 
2.18.1

