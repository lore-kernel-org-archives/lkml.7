Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58086C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398AF21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfISKCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:02:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389147AbfISKC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:02:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AE6D18CB8EA;
        Thu, 19 Sep 2019 10:02:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B63A60872;
        Thu, 19 Sep 2019 10:02:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9A45C9D3C; Thu, 19 Sep 2019 12:02:24 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/11] drm/ttm: rename ttm_fbdev_mmap
Date:   Thu, 19 Sep 2019 12:02:19 +0200
Message-Id: <20190919100223.13309-8-kraxel@redhat.com>
In-Reply-To: <20190919100223.13309-1-kraxel@redhat.com>
References: <20190919100223.13309-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 19 Sep 2019 10:02:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename ttm_fbdev_mmap to ttm_bo_mmap_obj.  Move the vm_pgoff sanity
check to amdgpu_bo_fbdev_mmap (only ttm_fbdev_mmap user in tree).

The ttm_bo_mmap_obj function can now be used to map any buffer object.
This allows to implement &drm_gem_object_funcs.mmap in gem ttm helpers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_api.h               | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  5 ++++-
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  8 ++------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 43c4929a2171..d2277e06316d 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -710,16 +710,14 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo, unsigned long start_page,
 void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map);
 
 /**
- * ttm_fbdev_mmap - mmap fbdev memory backed by a ttm buffer object.
+ * ttm_bo_mmap_obj - mmap memory backed by a ttm buffer object.
  *
  * @vma:       vma as input from the fbdev mmap method.
- * @bo:        The bo backing the address space. The address space will
- * have the same size as the bo, and start at offset 0.
+ * @bo:        The bo backing the address space.
  *
- * This function is intended to be called by the fbdev mmap method
- * if the fbdev address space is to be backed by a bo.
+ * Maps a buffer object.
  */
-int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_object *bo);
+int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo);
 
 /**
  * ttm_bo_mmap - mmap out of the ttm device address space.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2f11ebd95528..e5447e0d8b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1051,7 +1051,10 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
 int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
 			     struct vm_area_struct *vma)
 {
-	return ttm_fbdev_mmap(vma, &bo->tbo);
+	if (vma->vm_pgoff != 0)
+		return -EACCES;
+
+	return ttm_bo_mmap_obj(vma, &bo->tbo);
 }
 
 /**
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index b5314ef85a3d..6688d7893161 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -479,14 +479,10 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(ttm_bo_mmap);
 
-int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
+int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
 {
-	if (vma->vm_pgoff != 0)
-		return -EACCES;
-
 	ttm_bo_get(bo);
-
 	ttm_bo_mmap_vma_setup(bo, vma);
 	return 0;
 }
-EXPORT_SYMBOL(ttm_fbdev_mmap);
+EXPORT_SYMBOL(ttm_bo_mmap_obj);
-- 
2.18.1

