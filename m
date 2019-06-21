Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06782C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E2B208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfFUL6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfFUL6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:58:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C87B33082A8F;
        Fri, 21 Jun 2019 11:57:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B01BB60CA3;
        Fri, 21 Jun 2019 11:57:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EEA7817473; Fri, 21 Jun 2019 13:57:55 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/18] drm/vram: use embedded gem object
Date:   Fri, 21 Jun 2019 13:57:39 +0200
Message-Id: <20190621115755.8481-3-kraxel@redhat.com>
In-Reply-To: <20190621115755.8481-1-kraxel@redhat.com>
References: <20190621115755.8481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 21 Jun 2019 11:58:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop drm_gem_object from drm_gem_vram_object, use the
ttm_buffer_object.base instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h           |  3 +--
 drivers/gpu/drm/ast/ast_main.c              |  2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c       | 16 ++++++++--------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c |  2 +-
 drivers/gpu/drm/mgag200/mgag200_main.c      |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_main.c       |  2 +-
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 9581ea0a4f7e..7b9f50ba3fce 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -36,7 +36,6 @@ struct vm_area_struct;
  * video memory becomes scarce.
  */
 struct drm_gem_vram_object {
-	struct drm_gem_object gem;
 	struct ttm_buffer_object bo;
 	struct ttm_bo_kmap_obj kmap;
 
@@ -68,7 +67,7 @@ static inline struct drm_gem_vram_object *drm_gem_vram_of_bo(
 static inline struct drm_gem_vram_object *drm_gem_vram_of_gem(
 	struct drm_gem_object *gem)
 {
-	return container_of(gem, struct drm_gem_vram_object, gem);
+	return container_of(gem, struct drm_gem_vram_object, bo.base);
 }
 
 struct drm_gem_vram_object *drm_gem_vram_create(struct drm_device *dev,
diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 4c7e31cb45ff..74e6e471d283 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -609,6 +609,6 @@ int ast_gem_create(struct drm_device *dev,
 			DRM_ERROR("failed to allocate GEM object\n");
 		return ret;
 	}
-	*obj = &gbo->gem;
+	*obj = &gbo->bo.base;
 	return 0;
 }
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 4de782ca26b2..61d9520cc15f 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -24,7 +24,7 @@ static void drm_gem_vram_cleanup(struct drm_gem_vram_object *gbo)
 	 * TTM buffer object in 'bo' has already been cleaned
 	 * up; only release the GEM object.
 	 */
-	drm_gem_object_release(&gbo->gem);
+	drm_gem_object_release(&gbo->bo.base);
 }
 
 static void drm_gem_vram_destroy(struct drm_gem_vram_object *gbo)
@@ -80,7 +80,7 @@ static int drm_gem_vram_init(struct drm_device *dev,
 	int ret;
 	size_t acc_size;
 
-	ret = drm_gem_object_init(dev, &gbo->gem, size);
+	ret = drm_gem_object_init(dev, &gbo->bo.base, size);
 	if (ret)
 		return ret;
 
@@ -98,7 +98,7 @@ static int drm_gem_vram_init(struct drm_device *dev,
 	return 0;
 
 err_drm_gem_object_release:
-	drm_gem_object_release(&gbo->gem);
+	drm_gem_object_release(&gbo->bo.base);
 	return ret;
 }
 
@@ -378,11 +378,11 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 	if (IS_ERR(gbo))
 		return PTR_ERR(gbo);
 
-	ret = drm_gem_handle_create(file, &gbo->gem, &handle);
+	ret = drm_gem_handle_create(file, &gbo->bo.base, &handle);
 	if (ret)
 		goto err_drm_gem_object_put_unlocked;
 
-	drm_gem_object_put_unlocked(&gbo->gem);
+	drm_gem_object_put_unlocked(&gbo->bo.base);
 
 	args->pitch = pitch;
 	args->size = size;
@@ -391,7 +391,7 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 	return 0;
 
 err_drm_gem_object_put_unlocked:
-	drm_gem_object_put_unlocked(&gbo->gem);
+	drm_gem_object_put_unlocked(&gbo->bo.base);
 	return ret;
 }
 EXPORT_SYMBOL(drm_gem_vram_fill_create_dumb);
@@ -441,7 +441,7 @@ int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
 {
 	struct drm_gem_vram_object *gbo = drm_gem_vram_of_bo(bo);
 
-	return drm_vma_node_verify_access(&gbo->gem.vma_node,
+	return drm_vma_node_verify_access(&gbo->bo.base.vma_node,
 					  filp->private_data);
 }
 EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
@@ -635,7 +635,7 @@ int drm_gem_vram_driver_gem_prime_mmap(struct drm_gem_object *gem,
 {
 	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(gem);
 
-	gbo->gem.vma_node.vm_node.start = gbo->bo.vma_node.vm_node.start;
+	gbo->bo.base.vma_node.vm_node.start = gbo->bo.vma_node.vm_node.start;
 	return drm_gem_prime_mmap(gem, vma);
 }
 EXPORT_SYMBOL(drm_gem_vram_driver_gem_prime_mmap);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
index 52fba8cb8ddd..f2a63b5f0425 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
@@ -65,7 +65,7 @@ int hibmc_gem_create(struct drm_device *dev, u32 size, bool iskernel,
 			DRM_ERROR("failed to allocate GEM object: %d\n", ret);
 		return ret;
 	}
-	*obj = &gbo->gem;
+	*obj = &gbo->bo.base;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_main.c b/drivers/gpu/drm/mgag200/mgag200_main.c
index 0d7fc00e5d8a..c17440d3e6bc 100644
--- a/drivers/gpu/drm/mgag200/mgag200_main.c
+++ b/drivers/gpu/drm/mgag200/mgag200_main.c
@@ -288,6 +288,6 @@ int mgag200_gem_create(struct drm_device *dev,
 			DRM_ERROR("failed to allocate GEM object\n");
 		return ret;
 	}
-	*obj = &gbo->gem;
+	*obj = &gbo->bo.base;
 	return 0;
 }
diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index 18693e2bf72a..02fa8277ff1e 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -292,7 +292,7 @@ int vbox_gem_create(struct vbox_private *vbox,
 		return ret;
 	}
 
-	*obj = &gbo->gem;
+	*obj = &gbo->bo.base;
 
 	return 0;
 }
-- 
2.18.1

