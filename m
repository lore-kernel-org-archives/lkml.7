Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E43C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BE621927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbfISKCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389192AbfISKCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:02:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2297A811DE;
        Thu, 19 Sep 2019 10:02:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 382D960C80;
        Thu, 19 Sep 2019 10:02:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 02E549CAB; Thu, 19 Sep 2019 12:02:25 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 10/11] drm/vram: drop verify_access
Date:   Thu, 19 Sep 2019 12:02:22 +0200
Message-Id: <20190919100223.13309-11-kraxel@redhat.com>
In-Reply-To: <20190919100223.13309-1-kraxel@redhat.com>
References: <20190919100223.13309-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 19 Sep 2019 10:02:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index bc37c4651766..be8b09ac5280 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -540,13 +540,6 @@ static void drm_gem_vram_bo_driver_evict_flags(struct drm_gem_vram_object *gbo,
 	*pl = gbo->placement;
 }
 
-static int drm_gem_vram_bo_driver_verify_access(struct drm_gem_vram_object *gbo,
-						struct file *filp)
-{
-	return drm_vma_node_verify_access(&gbo->bo.base.vma_node,
-					  filp->private_data);
-}
-
 static void drm_gem_vram_bo_driver_move_notify(struct drm_gem_vram_object *gbo,
 					       bool evict,
 					       struct ttm_mem_reg *new_mem)
@@ -811,20 +804,6 @@ static void bo_driver_evict_flags(struct ttm_buffer_object *bo,
 	drm_gem_vram_bo_driver_evict_flags(gbo, placement);
 }
 
-static int bo_driver_verify_access(struct ttm_buffer_object *bo,
-				   struct file *filp)
-{
-	struct drm_gem_vram_object *gbo;
-
-	/* TTM may pass BOs that are not GEM VRAM BOs. */
-	if (!drm_is_gem_vram(bo))
-		return -EINVAL;
-
-	gbo = drm_gem_vram_of_bo(bo);
-
-	return drm_gem_vram_bo_driver_verify_access(gbo, filp);
-}
-
 static void bo_driver_move_notify(struct ttm_buffer_object *bo,
 				  bool evict,
 				  struct ttm_mem_reg *new_mem)
@@ -881,7 +860,6 @@ static struct ttm_bo_driver bo_driver = {
 	.init_mem_type = bo_driver_init_mem_type,
 	.eviction_valuable = ttm_bo_eviction_valuable,
 	.evict_flags = bo_driver_evict_flags,
-	.verify_access = bo_driver_verify_access,
 	.move_notify = bo_driver_move_notify,
 	.io_mem_reserve = bo_driver_io_mem_reserve,
 	.io_mem_free = bo_driver_io_mem_free,
-- 
2.18.1

