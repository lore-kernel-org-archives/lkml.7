Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A82C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF00320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfHEOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfHEOBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6983CEB9CC;
        Mon,  5 Aug 2019 14:01:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA7B764024;
        Mon,  5 Aug 2019 14:01:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AB34617444; Mon,  5 Aug 2019 16:01:19 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        thomas@shipmail.org, bskeggs@redhat.com, tzimmermann@suse.de,
        ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 01/17] drm/ttm: add gem base object
Date:   Mon,  5 Aug 2019 16:01:03 +0200
Message-Id: <20190805140119.7337-2-kraxel@redhat.com>
In-Reply-To: <20190805140119.7337-1-kraxel@redhat.com>
References: <20190805140119.7337-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 05 Aug 2019 14:01:22 +0000 (UTC)
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

