Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDADC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8A821479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfHHJhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:37:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732443AbfHHJhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D91930C75BF;
        Thu,  8 Aug 2019 09:37:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 143DD5C541;
        Thu,  8 Aug 2019 09:37:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CF0C39D22; Thu,  8 Aug 2019 11:37:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 7/8] gem/vram: use drm_gem_ttm_bo_driver_verify_access()
Date:   Thu,  8 Aug 2019 11:37:01 +0200
Message-Id: <20190808093702.29512-8-kraxel@redhat.com>
In-Reply-To: <20190808093702.29512-1-kraxel@redhat.com>
References: <20190808093702.29512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 08 Aug 2019 09:37:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h     |  3 ---
 drivers/gpu/drm/drm_gem_vram_helper.c | 22 +---------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

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
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index b78865055990..02d9cf0272bc 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -415,26 +415,6 @@ void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(drm_gem_vram_bo_driver_evict_flags);
 
-/**
- * drm_gem_vram_bo_driver_verify_access() - \
-	Implements &struct ttm_bo_driver.verify_access
- * @bo:		TTM buffer object. Refers to &struct drm_gem_vram_object.bo
- * @filp:	File pointer.
- *
- * Returns:
- * 0 on success, or
- * a negative errno code otherwise.
- */
-int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
-					 struct file *filp)
-{
-	struct drm_gem_vram_object *gbo = drm_gem_vram_of_bo(bo);
-
-	return drm_vma_node_verify_access(&gbo->bo.base.vma_node,
-					  filp->private_data);
-}
-EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
-
 /*
  * drm_gem_vram_mm_funcs - Functions for &struct drm_vram_mm
  *
@@ -444,7 +424,7 @@ EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
  */
 const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs = {
 	.evict_flags = drm_gem_vram_bo_driver_evict_flags,
-	.verify_access = drm_gem_vram_bo_driver_verify_access
+	.verify_access = drm_gem_ttm_bo_driver_verify_access
 };
 EXPORT_SYMBOL(drm_gem_vram_mm_funcs);
 
-- 
2.18.1

