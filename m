Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6AEC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2606421530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfFUL7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:59:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfFUL6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF56283F3B;
        Fri, 21 Jun 2019 11:58:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CA8561101;
        Fri, 21 Jun 2019 11:58:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EA55117536; Fri, 21 Jun 2019 13:57:56 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/18] drm/amdgpu: use embedded gem object
Date:   Fri, 21 Jun 2019 13:57:42 +0200
Message-Id: <20190621115755.8481-6-kraxel@redhat.com>
In-Reply-To: <20190621115755.8481-1-kraxel@redhat.com>
References: <20190621115755.8481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 21 Jun 2019 11:58:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop drm_gem_object from amdgpu_bo, use the
ttm_buffer_object.base instead.

Build tested only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 2 +-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b8ba6e27c61f..2f17150e26e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -31,7 +31,7 @@
  */
 
 #define AMDGPU_GEM_DOMAIN_MAX		0x3
-#define gem_to_amdgpu_bo(gobj) container_of((gobj), struct amdgpu_bo, gem_base)
+#define gem_to_amdgpu_bo(gobj) container_of((gobj), struct amdgpu_bo, tbo.base)
 
 void amdgpu_gem_object_free(struct drm_gem_object *obj);
 int amdgpu_gem_object_open(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index c430e8259038..a80a9972ad16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -94,7 +94,6 @@ struct amdgpu_bo {
 	/* per VM structure for page tables and with virtual addresses */
 	struct amdgpu_vm_bo_base	*vm_bo;
 	/* Constant after initialization */
-	struct drm_gem_object		gem_base;
 	struct amdgpu_bo		*parent;
 	struct amdgpu_bo		*shadow;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 489041df1f45..c56819bcad8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -409,7 +409,7 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
 		bo->prime_shared_count = 1;
 
 	ww_mutex_unlock(&resv->lock);
-	return &bo->gem_base;
+	return &bo->tbo.base;
 
 error:
 	ww_mutex_unlock(&resv->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 37b526c6f494..6d991e8df357 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -85,7 +85,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 		}
 		return r;
 	}
-	*obj = &bo->gem_base;
+	*obj = &bo->tbo.base;
 
 	return 0;
 }
@@ -690,7 +690,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		struct drm_amdgpu_gem_create_in info;
 		void __user *out = u64_to_user_ptr(args->value);
 
-		info.bo_size = robj->gem_base.size;
+		info.bo_size = robj->tbo.base.size;
 		info.alignment = robj->tbo.mem.page_alignment << PAGE_SHIFT;
 		info.domains = robj->preferred_domains;
 		info.domain_flags = robj->flags;
@@ -820,8 +820,8 @@ static int amdgpu_debugfs_gem_bo_info(int id, void *ptr, void *data)
 	if (pin_count)
 		seq_printf(m, " pin count %d", pin_count);
 
-	dma_buf = READ_ONCE(bo->gem_base.dma_buf);
-	attachment = READ_ONCE(bo->gem_base.import_attach);
+	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
+	attachment = READ_ONCE(bo->tbo.base.import_attach);
 
 	if (attachment)
 		seq_printf(m, " imported from %p", dma_buf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 16f96f2e3671..00b283f914a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -85,9 +85,9 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 
 	amdgpu_bo_kunmap(bo);
 
-	if (bo->gem_base.import_attach)
-		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
-	drm_gem_object_release(&bo->gem_base);
+	if (bo->tbo.base.import_attach)
+		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
+	drm_gem_object_release(&bo->tbo.base);
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
 	if (!list_empty(&bo->shadow_list)) {
 		mutex_lock(&adev->shadow_list_lock);
@@ -454,7 +454,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	drm_gem_private_object_init(adev->ddev, &bo->gem_base, size);
+	drm_gem_private_object_init(adev->ddev, &bo->tbo.base, size);
 	INIT_LIST_HEAD(&bo->shadow_list);
 	bo->vm_bo = NULL;
 	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d81bebf76310..b8ae9a838b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -227,7 +227,7 @@ static int amdgpu_verify_access(struct ttm_buffer_object *bo, struct file *filp)
 
 	if (amdgpu_ttm_tt_get_usermm(bo->ttm))
 		return -EPERM;
-	return drm_vma_node_verify_access(&abo->gem_base.vma_node,
+	return drm_vma_node_verify_access(&abo->tbo.base.vma_node,
 					  filp->private_data);
 }
 
-- 
2.18.1

