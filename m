Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA79AC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEBF233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbfHVK0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730918AbfHVK0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:26:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B9607F75C;
        Thu, 22 Aug 2019 10:26:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A15426012C;
        Thu, 22 Aug 2019 10:26:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C817516E32; Thu, 22 Aug 2019 12:26:14 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/virtio: make resource id workaround runtime switchable.
Date:   Thu, 22 Aug 2019 12:26:14 +0200
Message-Id: <20190822102614.18164-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 22 Aug 2019 10:26:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also update the comment with a reference to the virglrenderer fix.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 44 ++++++++++++++-----------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index b2da31310d24..e98aaa00578d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -27,34 +27,38 @@
 
 #include "virtgpu_drv.h"
 
+static int virtio_gpu_virglrenderer_workaround = 1;
+module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
+
 static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
-#if 0
-	int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
-
-	if (handle < 0)
-		return handle;
-#else
-	static int handle;
-
-	/*
-	 * FIXME: dirty hack to avoid re-using IDs, virglrenderer
-	 * can't deal with that.  Needs fixing in virglrenderer, also
-	 * should figure a better way to handle that in the guest.
-	 */
-	handle++;
-#endif
-
-	*resid = handle + 1;
+	if (virtio_gpu_virglrenderer_workaround) {
+		/*
+		 * Hack to avoid re-using resource IDs.
+		 *
+		 * virglrenderer versions up to (and including) 0.7.0
+		 * can't deal with that.  virglrenderer commit
+		 * "f91a9dd35715 Fix unlinking resources from hash
+		 * table." (Feb 2019) fixes the bug.
+		 */
+		static int handle;
+		handle++;
+		*resid = handle + 1;
+	} else {
+		int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
+		if (handle < 0)
+			return handle;
+		*resid = handle + 1;
+	}
 	return 0;
 }
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-#if 0
-	ida_free(&vgdev->resource_ida, id - 1);
-#endif
+	if (!virtio_gpu_virglrenderer_workaround) {
+		ida_free(&vgdev->resource_ida, id - 1);
+	}
 }
 
 static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
-- 
2.18.1

