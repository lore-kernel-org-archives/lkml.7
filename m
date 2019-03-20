Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47552175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCTIvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:51:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfCTIvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E82F281104;
        Wed, 20 Mar 2019 08:51:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C95635D9C4;
        Wed, 20 Mar 2019 08:51:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E182C1750C; Wed, 20 Mar 2019 09:51:33 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: make resource id workaround runtime switchable.
Date:   Wed, 20 Mar 2019 09:51:33 +0100
Message-Id: <20190320085133.26632-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 20 Mar 2019 08:51:39 +0000 (UTC)
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
index e7e946035027..a73dae4e5029 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,34 +25,38 @@
 
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

