Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C73C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65712085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfFTHog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:44:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfFTHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:44:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16CD83058F5B;
        Thu, 20 Jun 2019 07:44:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F25B5C21E;
        Thu, 20 Jun 2019 07:44:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8100A17538; Thu, 20 Jun 2019 09:44:25 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/6] drm/vram: drop drm_gem_vram_driver_gem_prime_mmap
Date:   Thu, 20 Jun 2019 09:44:24 +0200
Message-Id: <20190620074424.1677-7-kraxel@redhat.com>
In-Reply-To: <20190620074424.1677-1-kraxel@redhat.com>
References: <20190620074424.1677-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 20 Jun 2019 07:44:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrapper doesn't do anything any more, drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h     |  4 +---
 drivers/gpu/drm/drm_gem_vram_helper.c | 17 -----------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 7b9f50ba3fce..2ada671a2a6b 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -137,8 +137,6 @@ void drm_gem_vram_driver_gem_prime_unpin(struct drm_gem_object *obj);
 void *drm_gem_vram_driver_gem_prime_vmap(struct drm_gem_object *obj);
 void drm_gem_vram_driver_gem_prime_vunmap(struct drm_gem_object *obj,
 					  void *vaddr);
-int drm_gem_vram_driver_gem_prime_mmap(struct drm_gem_object *obj,
-				       struct vm_area_struct *vma);
 
 #define DRM_GEM_VRAM_DRIVER_PRIME \
 	.gem_prime_export = drm_gem_prime_export, \
@@ -147,6 +145,6 @@ int drm_gem_vram_driver_gem_prime_mmap(struct drm_gem_object *obj,
 	.gem_prime_unpin  = drm_gem_vram_driver_gem_prime_unpin, \
 	.gem_prime_vmap	  = drm_gem_vram_driver_gem_prime_vmap, \
 	.gem_prime_vunmap = drm_gem_vram_driver_gem_prime_vunmap, \
-	.gem_prime_mmap	  = drm_gem_vram_driver_gem_prime_mmap
+	.gem_prime_mmap	  = drm_gem_prime_mmap
 
 #endif
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 2e474dee30df..d78761802374 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -619,20 +619,3 @@ void drm_gem_vram_driver_gem_prime_vunmap(struct drm_gem_object *gem,
 	drm_gem_vram_unpin(gbo);
 }
 EXPORT_SYMBOL(drm_gem_vram_driver_gem_prime_vunmap);
-
-/**
- * drm_gem_vram_driver_gem_prime_mmap() - \
-	Implements &struct drm_driver.gem_prime_mmap
- * @gem:	The GEM object to map
- * @vma:	The VMA describing the mapping
- *
- * Returns:
- * 0 on success, or
- * a negative errno code otherwise.
- */
-int drm_gem_vram_driver_gem_prime_mmap(struct drm_gem_object *gem,
-				       struct vm_area_struct *vma)
-{
-	return drm_gem_prime_mmap(gem, vma);
-}
-EXPORT_SYMBOL(drm_gem_vram_driver_gem_prime_mmap);
-- 
2.18.1

