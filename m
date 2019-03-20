Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7811FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE972146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfCTIgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:36:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfCTIgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7453D309264B;
        Wed, 20 Mar 2019 08:36:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08D5717F8D;
        Wed, 20 Mar 2019 08:36:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2A1951750C; Wed, 20 Mar 2019 09:36:12 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: add virtio-gpu-features debugfs file.
Date:   Wed, 20 Mar 2019 09:36:12 +0100
Message-Id: <20190320083612.32067-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 20 Mar 2019 08:36:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file prints which features the virtio-gpu device has.

Also add "virtio-gpu-" prefix to the existing fence file,
to make clear this is a driver-specific debugfs file.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index 73dc99046c43..ed0fcda713c3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -28,6 +28,30 @@
 
 #include "virtgpu_drv.h"
 
+static void virtio_add_bool(struct seq_file *m, const char *name,
+				    bool value)
+{
+	seq_printf(m, "%-16s : %s\n", name, value ? "yes" : "no");
+}
+
+static void virtio_add_int(struct seq_file *m, const char *name,
+				   int value)
+{
+	seq_printf(m, "%-16s : %d\n", name, value);
+}
+
+static int virtio_gpu_features(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
+
+	virtio_add_bool(m, "virgl", vgdev->has_virgl_3d);
+	virtio_add_bool(m, "edid", vgdev->has_edid);
+	virtio_add_int(m, "cap sets", vgdev->num_capsets);
+	virtio_add_int(m, "scanouts", vgdev->num_scanouts);
+	return 0;
+}
+
 static int
 virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 {
@@ -41,7 +65,8 @@ virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 }
 
 static struct drm_info_list virtio_gpu_debugfs_list[] = {
-	{ "irq_fence", virtio_gpu_debugfs_irq_info, 0, NULL },
+	{ "virtio-gpu-features", virtio_gpu_features },
+	{ "virtio-gpu-irq-fence", virtio_gpu_debugfs_irq_info, 0, NULL },
 };
 
 #define VIRTIO_GPU_DEBUGFS_ENTRIES ARRAY_SIZE(virtio_gpu_debugfs_list)
-- 
2.18.1

