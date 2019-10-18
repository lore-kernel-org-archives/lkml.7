Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CACA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288F020854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407745AbfJRLih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:38:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfJRLig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:38:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7899F11A2F;
        Fri, 18 Oct 2019 11:38:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D25C5D9D5;
        Fri, 18 Oct 2019 11:38:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2E9C99DB6; Fri, 18 Oct 2019 13:38:32 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: print a single line with device features
Date:   Fri, 18 Oct 2019 13:38:32 +0200
Message-Id: <20191018113832.5460-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 18 Oct 2019 11:38:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 0b3cdb0d83b0..2f5773e43557 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
 #ifdef __LITTLE_ENDIAN
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
-	DRM_INFO("virgl 3d acceleration %s\n",
-		 vgdev->has_virgl_3d ? "enabled" : "not supported by host");
-#else
-	DRM_INFO("virgl 3d acceleration not supported by guest\n");
 #endif
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 		vgdev->has_edid = true;
-		DRM_INFO("EDID support available.\n");
 	}
 
+	DRM_INFO("features: %cvirgl %cedid\n",
+		 vgdev->has_virgl_3d ? '+' : '-',
+		 vgdev->has_edid     ? '+' : '-');
+
 	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 	if (ret) {
 		DRM_ERROR("failed to find virt queues\n");
-- 
2.18.1

