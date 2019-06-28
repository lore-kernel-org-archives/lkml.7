Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D9EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6E02133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfF1JES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF1JDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56078128B5;
        Fri, 28 Jun 2019 09:03:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2D011001B16;
        Fri, 28 Jun 2019 09:03:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4939B9D71; Fri, 28 Jun 2019 11:03:07 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 09/18] drm/vram: drop drm_gem_vram_driver_gem_prime_mmap
Date:   Fri, 28 Jun 2019 11:02:54 +0200
Message-Id: <20190628090303.29467-10-kraxel@redhat.com>
In-Reply-To: <20190628090303.29467-1-kraxel@redhat.com>
References: <20190628090303.29467-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 28 Jun 2019 09:03:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrapper doesn't do anything any more, drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_gem_vram_helper.h     |  4 +---
 drivers/gpu/drm/drm_gem_vram_helper.c | 17 -----------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 2627bb618979..7dec1bcfd6f7 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -137,14 +137,12 @@ void drm_gem_vram_driver_gem_prime_unpin(struct drm_gem_object *obj);
 void *drm_gem_vram_driver_gem_prime_vmap(struct drm_gem_object *obj);
 void drm_gem_vram_driver_gem_prime_vunmap(struct drm_gem_object *obj,
 					  void *vaddr);
-int drm_gem_vram_driver_gem_prime_mmap(struct drm_gem_object *obj,
-				       struct vm_area_struct *vma);
 
 #define DRM_GEM_VRAM_DRIVER_PRIME \
 	.gem_prime_pin	  = drm_gem_vram_driver_gem_prime_pin, \
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

