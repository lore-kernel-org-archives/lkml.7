Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D1BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C0421881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfIBMll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:41:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbfIBMlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:41:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E970A3084288;
        Mon,  2 Sep 2019 12:41:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C844860127;
        Mon,  2 Sep 2019 12:41:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0A1EB31EBC; Mon,  2 Sep 2019 14:41:27 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] drm/vram: use drm_gem_ttm_print_info
Date:   Mon,  2 Sep 2019 14:41:23 +0200
Message-Id: <20190902124126.7700-3-kraxel@redhat.com>
In-Reply-To: <20190902124126.7700-1-kraxel@redhat.com>
References: <20190902124126.7700-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 02 Sep 2019 12:41:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h     | 1 +
 drivers/gpu/drm/drm_gem_vram_helper.c | 3 ++-
 drivers/gpu/drm/Kconfig               | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index ac217d768456..17f160dd6e7d 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -4,6 +4,7 @@
 #define DRM_GEM_VRAM_HELPER_H
 
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_placement.h>
 #include <linux/kernel.h> /* for container_of() */
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index fd751078bae1..b4929e1fb190 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -633,5 +633,6 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
 	.pin	= drm_gem_vram_object_pin,
 	.unpin	= drm_gem_vram_object_unpin,
 	.vmap	= drm_gem_vram_object_vmap,
-	.vunmap	= drm_gem_vram_object_vunmap
+	.vunmap	= drm_gem_vram_object_vunmap,
+	.print_info = drm_gem_ttm_print_info,
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

