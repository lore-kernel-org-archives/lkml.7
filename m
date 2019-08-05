Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59023214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfHEOCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbfHEOBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:01:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EB533081CFF;
        Mon,  5 Aug 2019 14:01:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D15936B8F4;
        Mon,  5 Aug 2019 14:01:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E4F5217472; Mon,  5 Aug 2019 16:01:19 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        thomas@shipmail.org, bskeggs@redhat.com, tzimmermann@suse.de,
        ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 02/17] drm/vram: use embedded gem object
Date:   Mon,  5 Aug 2019 16:01:04 +0200
Message-Id: <20190805140119.7337-3-kraxel@redhat.com>
In-Reply-To: <20190805140119.7337-1-kraxel@redhat.com>
References: <20190805140119.7337-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 05 Aug 2019 14:01:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop drm_gem_object from drm_gem_vram_object, use the
ttm_buffer_object.base instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_gem_vram_helper.h           |  3 +--
 drivers/gpu/drm/ast/ast_main.c              |  2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c       | 18 +++++++++---------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_main.c       |  2 +-
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index b41d932eb53a..ac217d768456 100644
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
index 0a1bb9c05195..dab77b2bc8ac 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -554,6 +554,6 @@ int ast_gem_create(struct drm_device *dev,
 			DRM_ERROR("failed to allocate GEM object\n");
 		return ret;
 	}
-	*obj = &gbo->gem;
+	*obj = &gbo->bo.base;
 	return 0;
 }
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index e0fbfb6570cf..fc13920b3cb4 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -26,7 +26,7 @@ static void drm_gem_vram_cleanup(struct drm_gem_vram_object *gbo)
 	 * TTM buffer object in 'bo' has already been cleaned
 	 * up; only release the GEM object.
 	 */
-	drm_gem_object_release(&gbo->gem);
+	drm_gem_object_release(&gbo->bo.base);
 }
 
 static void drm_gem_vram_destroy(struct drm_gem_vram_object *gbo)
@@ -82,10 +82,10 @@ static int drm_gem_vram_init(struct drm_device *dev,
 	int ret;
 	size_t acc_size;
 
-	if (!gbo->gem.funcs)
-		gbo->gem.funcs = &drm_gem_vram_object_funcs;
+	if (!gbo->bo.base.funcs)
+		gbo->bo.base.funcs = &drm_gem_vram_object_funcs;
 
-	ret = drm_gem_object_init(dev, &gbo->gem, size);
+	ret = drm_gem_object_init(dev, &gbo->bo.base, size);
 	if (ret)
 		return ret;
 
@@ -103,7 +103,7 @@ static int drm_gem_vram_init(struct drm_device *dev,
 	return 0;
 
 err_drm_gem_object_release:
-	drm_gem_object_release(&gbo->gem);
+	drm_gem_object_release(&gbo->bo.base);
 	return ret;
 }
 
@@ -383,11 +383,11 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
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
@@ -396,7 +396,7 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 	return 0;
 
 err_drm_gem_object_put_unlocked:
-	drm_gem_object_put_unlocked(&gbo->gem);
+	drm_gem_object_put_unlocked(&gbo->bo.base);
 	return ret;
 }
 EXPORT_SYMBOL(drm_gem_vram_fill_create_dumb);
@@ -446,7 +446,7 @@ int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
 {
 	struct drm_gem_vram_object *gbo = drm_gem_vram_of_bo(bo);
 
-	return drm_vma_node_verify_access(&gbo->gem.vma_node,
+	return drm_vma_node_verify_access(&gbo->bo.base.vma_node,
 					  filp->private_data);
 }
 EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
index cfc2faabda14..9f6e473e6295 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
@@ -66,7 +66,7 @@ int hibmc_gem_create(struct drm_device *dev, u32 size, bool iskernel,
 			DRM_ERROR("failed to allocate GEM object: %d\n", ret);
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

