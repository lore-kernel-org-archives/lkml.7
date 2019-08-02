Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9F2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B35206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfHBFWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfHBFWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79FF619CF26;
        Fri,  2 Aug 2019 05:22:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A22C85D9CD;
        Fri,  2 Aug 2019 05:22:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D31C017474; Fri,  2 Aug 2019 07:22:47 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/17] drm/ttm: add gem base object
Date:   Fri,  2 Aug 2019 07:22:31 +0200
Message-Id: <20190802052247.18427-2-kraxel@redhat.com>
In-Reply-To: <20190802052247.18427-1-kraxel@redhat.com>
References: <20190802052247.18427-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 02 Aug 2019 05:22:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drm_gem_object struct to ttm_buffer_object, so ttm objects are a gdm
object superclass.  Add a function to check whenever a given bo actually
uses the embedded drm_gem_object.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/drm/ttm/ttm_bo_api.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 49d9cdfc58f2..082550cac92c 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -31,6 +31,7 @@
 #ifndef _TTM_BO_API_H_
 #define _TTM_BO_API_H_
 
+#include <drm/drm_gem.h>
 #include <drm/drm_hashtab.h>
 #include <drm/drm_vma_manager.h>
 #include <linux/kref.h>
@@ -127,6 +128,7 @@ struct ttm_tt;
 /**
  * struct ttm_buffer_object
  *
+ * @base: drm_gem_object superclass data.
  * @bdev: Pointer to the buffer object device structure.
  * @type: The bo type.
  * @destroy: Destruction function. If NULL, kfree is used.
@@ -169,6 +171,8 @@ struct ttm_tt;
  */
 
 struct ttm_buffer_object {
+	struct drm_gem_object base;
+
 	/**
 	 * Members constant at init.
 	 */
@@ -768,4 +772,23 @@ int ttm_bo_swapout(struct ttm_bo_global *glob,
 			struct ttm_operation_ctx *ctx);
 void ttm_bo_swapout_all(struct ttm_bo_device *bdev);
 int ttm_bo_wait_unreserved(struct ttm_buffer_object *bo);
+
+/**
+ * ttm_bo_uses_embedded_gem_object - check if the given bo uses the
+ * embedded drm_gem_object.
+ *
+ * Most ttm drivers are using gem too, so the embedded
+ * ttm_buffer_object.base will be initialized by the driver (before
+ * calling ttm_bo_init).  It is also possible to use ttm without gem
+ * though (vmwgfx does that).
+ *
+ * This helper will figure whenever a given ttm bo is a gem object too
+ * or not.
+ *
+ * @bo: The bo to check.
+ */
+static inline bool ttm_bo_uses_embedded_gem_object(struct ttm_buffer_object *bo)
+{
+	return bo->base.dev != NULL;
+}
 #endif
-- 
2.18.1

