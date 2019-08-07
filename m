Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C064C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717BB21E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfHGKiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:38:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfHGKix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:38:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BA0830A9231;
        Wed,  7 Aug 2019 10:38:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2275DA60;
        Wed,  7 Aug 2019 10:38:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A8A2A9D11; Wed,  7 Aug 2019 12:38:49 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/vram: switch vram helpers to use the new ttm helpers.
Date:   Wed,  7 Aug 2019 12:38:48 +0200
Message-Id: <20190807103849.7289-3-kraxel@redhat.com>
In-Reply-To: <20190807103849.7289-1-kraxel@redhat.com>
References: <20190807103849.7289-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 07 Aug 2019 10:38:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h             |  7 +--
 drivers/gpu/drm/drm_gem_vram_helper.c         | 48 -------------------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  2 +-
 drivers/gpu/drm/Kconfig                       |  1 +
 4 files changed, 4 insertions(+), 54 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index ac217d768456..fe4a1d5a35de 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -4,6 +4,7 @@
 #define DRM_GEM_VRAM_HELPER_H
 
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_placement.h>
 #include <linux/kernel.h> /* for container_of() */
@@ -76,7 +77,6 @@ struct drm_gem_vram_object *drm_gem_vram_create(struct drm_device *dev,
 						unsigned long pg_align,
 						bool interruptible);
 void drm_gem_vram_put(struct drm_gem_vram_object *gbo);
-u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo);
 s64 drm_gem_vram_offset(struct drm_gem_vram_object *gbo);
 int drm_gem_vram_pin(struct drm_gem_vram_object *gbo, unsigned long pl_flag);
 int drm_gem_vram_unpin(struct drm_gem_vram_object *gbo);
@@ -110,9 +110,6 @@ extern const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs;
 int drm_gem_vram_driver_dumb_create(struct drm_file *file,
 				    struct drm_device *dev,
 				    struct drm_mode_create_dumb *args);
-int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
-					 struct drm_device *dev,
-					 uint32_t handle, uint64_t *offset);
 
 /**
  * define DRM_GEM_VRAM_DRIVER - default callback functions for \
@@ -123,7 +120,7 @@ int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
  */
 #define DRM_GEM_VRAM_DRIVER \
 	.dumb_create		  = drm_gem_vram_driver_dumb_create, \
-	.dumb_map_offset	  = drm_gem_vram_driver_dumb_mmap_offset, \
+	.dumb_map_offset	  = drm_gem_ttm_driver_dumb_mmap_offset, \
 	.gem_prime_mmap		  = drm_gem_prime_mmap
 
 #endif
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index fd751078bae1..b78865055990 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -156,22 +156,6 @@ void drm_gem_vram_put(struct drm_gem_vram_object *gbo)
 }
 EXPORT_SYMBOL(drm_gem_vram_put);
 
-/**
- * drm_gem_vram_mmap_offset() - Returns a GEM VRAM object's mmap offset
- * @gbo:	the GEM VRAM object
- *
- * See drm_vma_node_offset_addr() for more information.
- *
- * Returns:
- * The buffer object's offset for userspace mappings on success, or
- * 0 if no offset is allocated.
- */
-u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo)
-{
-	return drm_vma_node_offset_addr(&gbo->bo.base.vma_node);
-}
-EXPORT_SYMBOL(drm_gem_vram_mmap_offset);
-
 /**
  * drm_gem_vram_offset() - \
 	Returns a GEM VRAM object's offset in video memory
@@ -511,38 +495,6 @@ int drm_gem_vram_driver_dumb_create(struct drm_file *file,
 }
 EXPORT_SYMBOL(drm_gem_vram_driver_dumb_create);
 
-/**
- * drm_gem_vram_driver_dumb_mmap_offset() - \
-	Implements &struct drm_driver.dumb_mmap_offset
- * @file:	DRM file pointer.
- * @dev:	DRM device.
- * @handle:	GEM handle
- * @offset:	Returns the mapping's memory offset on success
- *
- * Returns:
- * 0 on success, or
- * a negative errno code otherwise.
- */
-int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
-					 struct drm_device *dev,
-					 uint32_t handle, uint64_t *offset)
-{
-	struct drm_gem_object *gem;
-	struct drm_gem_vram_object *gbo;
-
-	gem = drm_gem_object_lookup(file, handle);
-	if (!gem)
-		return -ENOENT;
-
-	gbo = drm_gem_vram_of_gem(gem);
-	*offset = drm_gem_vram_mmap_offset(gbo);
-
-	drm_gem_object_put_unlocked(gem);
-
-	return 0;
-}
-EXPORT_SYMBOL(drm_gem_vram_driver_dumb_mmap_offset);
-
 /*
  * PRIME helpers
  */
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 2ae538835781..16fb10be4251 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -59,7 +59,7 @@ static struct drm_driver hibmc_driver = {
 	.major			= 1,
 	.minor			= 0,
 	.dumb_create            = hibmc_dumb_create,
-	.dumb_map_offset        = drm_gem_vram_driver_dumb_mmap_offset,
+	.dumb_map_offset        = drm_gem_ttm_driver_dumb_mmap_offset,
 	.gem_prime_mmap		= drm_gem_prime_mmap,
 	.irq_handler		= hibmc_drm_interrupt,
 };
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f7b25519f95c..1be8ad30d8fe 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -169,6 +169,7 @@ config DRM_VRAM_HELPER
 	tristate
 	depends on DRM
 	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	  Helpers for VRAM memory management
 
-- 
2.18.1

