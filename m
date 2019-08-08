Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651ACC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4251621882
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbfHHNpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:45:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733258AbfHHNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F08930A7BBD;
        Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01BB61000343;
        Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 375179D3C; Thu,  8 Aug 2019 15:44:20 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 11/17] drm/vram: drop verify_access
Date:   Thu,  8 Aug 2019 15:44:11 +0200
Message-Id: <20190808134417.10610-12-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 08 Aug 2019 13:44:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h     |  3 ---
 include/drm/drm_vram_mm_helper.h      |  3 ---
 drivers/gpu/drm/drm_gem_vram_helper.c |  1 -
 drivers/gpu/drm/drm_vram_mm_helper.c  | 11 -----------
 4 files changed, 18 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 701d2c46a4f4..7723ad59a0c5 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -98,9 +98,6 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
 					struct ttm_placement *pl);
 
-int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
-					 struct file *filp);
-
 extern const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs;
 
 /*
diff --git a/include/drm/drm_vram_mm_helper.h b/include/drm/drm_vram_mm_helper.h
index ff328bdaa638..f272adc8ad37 100644
--- a/include/drm/drm_vram_mm_helper.h
+++ b/include/drm/drm_vram_mm_helper.h
@@ -13,8 +13,6 @@ struct drm_device;
  * struct drm_vram_mm_funcs - Callback functions for &struct drm_vram_mm
  * @evict_flags:	Provides an implementation for struct \
 	&ttm_bo_driver.evict_flags
- * @verify_access:	Provides an implementation for \
-	struct &ttm_bo_driver.verify_access
  *
  * These callback function integrate VRAM MM with TTM buffer objects. New
  * functions can be added if necessary.
@@ -22,7 +20,6 @@ struct drm_device;
 struct drm_vram_mm_funcs {
 	void (*evict_flags)(struct ttm_buffer_object *bo,
 			    struct ttm_placement *placement);
-	int (*verify_access)(struct ttm_buffer_object *bo, struct file *filp);
 };
 
 /**
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index ed1625f6a296..41bb969079d8 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -445,7 +445,6 @@ EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
  */
 const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs = {
 	.evict_flags = drm_gem_vram_bo_driver_evict_flags,
-	.verify_access = drm_gem_vram_bo_driver_verify_access
 };
 EXPORT_SYMBOL(drm_gem_vram_mm_funcs);
 
diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm_vram_mm_helper.c
index 8f6e26b3da69..059a216d6e78 100644
--- a/drivers/gpu/drm/drm_vram_mm_helper.c
+++ b/drivers/gpu/drm/drm_vram_mm_helper.c
@@ -89,16 +89,6 @@ static void bo_driver_evict_flags(struct ttm_buffer_object *bo,
 		vmm->funcs->evict_flags(bo, placement);
 }
 
-static int bo_driver_verify_access(struct ttm_buffer_object *bo,
-				   struct file *filp)
-{
-	struct drm_vram_mm *vmm = drm_vram_mm_of_bdev(bo->bdev);
-
-	if (!vmm->funcs || !vmm->funcs->verify_access)
-		return 0;
-	return vmm->funcs->verify_access(bo, filp);
-}
-
 static int bo_driver_io_mem_reserve(struct ttm_bo_device *bdev,
 				    struct ttm_mem_reg *mem)
 {
@@ -140,7 +130,6 @@ static struct ttm_bo_driver bo_driver = {
 	.init_mem_type = bo_driver_init_mem_type,
 	.eviction_valuable = ttm_bo_eviction_valuable,
 	.evict_flags = bo_driver_evict_flags,
-	.verify_access = bo_driver_verify_access,
 	.io_mem_reserve = bo_driver_io_mem_reserve,
 	.io_mem_free = bo_driver_io_mem_free,
 };
-- 
2.18.1

