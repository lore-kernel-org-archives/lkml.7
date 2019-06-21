Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA5C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0690208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfFUL6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfFUL57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:57:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A49985A03;
        Fri, 21 Jun 2019 11:57:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFFFB5D772;
        Fri, 21 Jun 2019 11:57:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AB5DA17472; Fri, 21 Jun 2019 13:57:55 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/18] drm/ttm: add gem base object
Date:   Fri, 21 Jun 2019 13:57:38 +0200
Message-Id: <20190621115755.8481-2-kraxel@redhat.com>
In-Reply-To: <20190621115755.8481-1-kraxel@redhat.com>
References: <20190621115755.8481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 21 Jun 2019 11:57:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drm_gem_object struct to ttm_buffer_object, so ttm objects are a gdm
object superclass.  Add a function to check whenever a given bo actually
uses the embedded drm_gem_object, for the transition period.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_api.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 49d9cdfc58f2..72f6aeda619c 100644
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
@@ -768,4 +772,18 @@ int ttm_bo_swapout(struct ttm_bo_global *glob,
 			struct ttm_operation_ctx *ctx);
 void ttm_bo_swapout_all(struct ttm_bo_device *bdev);
 int ttm_bo_wait_unreserved(struct ttm_buffer_object *bo);
+
+/**
+ * ttm_bo_uses_embedded_gem_object - check if the given bo uses the
+ * embedded drm_gem_object.
+ *
+ * Helper for the transition period, once all drivers are switched to
+ * use the embedded drm_gem_object this can go away.
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

