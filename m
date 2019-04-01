Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E71C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061F4206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfDASgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:36:04 -0400
Received: from anholt.net ([50.246.234.109]:47342 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfDASgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:36:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5ABA510A280C;
        Mon,  1 Apr 2019 11:36:03 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id SBAnzN0y6ZLP; Mon,  1 Apr 2019 11:35:59 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B246510A278C;
        Mon,  1 Apr 2019 11:35:59 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 43AD32FE338C; Mon,  1 Apr 2019 11:35:59 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 2/2] drm/vc4: Disable V3D interactions if the v3d component didn't probe.
Date:   Mon,  1 Apr 2019 11:35:59 -0700
Message-Id: <20190401183559.3823-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401183559.3823-1-eric@anholt.net>
References: <20190401183559.3823-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One might want to use the VC4 display stack without using Mesa.
Similar to the debugfs fixes for not having all of the possible
display bits enabled, make sure you can't oops in vc4 if v3d isn't
enabled.

v2: Fix matching against other v3d variants (review by Paul), don't
    forget to set irq_enabled so that the vblank uapi works

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_drv.c     | 10 ++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h     |  1 +
 drivers/gpu/drm/vc4/vc4_gem.c     | 10 ++++++++++
 drivers/gpu/drm/vc4/vc4_irq.c     |  9 +++++++++
 drivers/gpu/drm/vc4/vc4_kms.c     |  1 +
 drivers/gpu/drm/vc4/vc4_perfmon.c | 18 ++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_v3d.c     |  2 +-
 7 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 3d6fccea5080..d840b52b9805 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -72,6 +72,9 @@ static int vc4_get_param_ioctl(struct drm_device *dev, void *data,
 	if (args->pad != 0)
 		return -EINVAL;
 
+	if (!vc4->v3d)
+		return -EINVAL;
+
 	switch (args->param) {
 	case DRM_VC4_PARAM_V3D_IDENT0:
 		ret = vc4_v3d_pm_get(vc4);
@@ -248,6 +251,7 @@ static int vc4_drm_bind(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm;
 	struct vc4_dev *vc4;
+	struct device_node *node;
 	int ret = 0;
 
 	dev->coherent_dma_mask = DMA_BIT_MASK(32);
@@ -256,6 +260,12 @@ static int vc4_drm_bind(struct device *dev)
 	if (!vc4)
 		return -ENOMEM;
 
+	/* If VC4 V3D is missing, don't advertise render nodes. */
+	node = of_find_matching_node_and_match(NULL, vc4_v3d_dt_match, NULL);
+	if (!node || !of_device_is_available(node))
+		vc4_drm_driver.driver_features &= ~DRIVER_RENDER;
+	of_node_put(node);
+
 	drm = drm_dev_alloc(&vc4_drm_driver, dev);
 	if (IS_ERR(drm))
 		return PTR_ERR(drm);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index be85656024fa..e61734af059b 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -831,6 +831,7 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
 
 /* vc4_v3d.c */
 extern struct platform_driver vc4_v3d_driver;
+extern const struct of_device_id vc4_v3d_dt_match[];
 int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
 int vc4_v3d_pm_get(struct vc4_dev *vc4);
 void vc4_v3d_pm_put(struct vc4_dev *vc4);
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 5e9496d477bf..4544a478f106 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -74,6 +74,11 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *data,
 	u32 i;
 	int ret = 0;
 
+	if (!vc4->v3d) {
+		DRM_DEBUG("VC4_GET_HANG_STATE with no VC4 V3D probed\n");
+		return -EINVAL;
+	}
+
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	kernel_state = vc4->hang_state;
 	if (!kernel_state) {
@@ -1119,6 +1124,11 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 	struct dma_fence *in_fence;
 	int ret = 0;
 
+	if (!vc4->v3d) {
+		DRM_DEBUG("VC4_SUBMIT_CL with no VC4 V3D probed\n");
+		return -EINVAL;
+	}
+
 	if ((args->flags & ~(VC4_SUBMIT_CL_USE_CLEAR_COLOR |
 			     VC4_SUBMIT_CL_FIXED_RCL_ORDER |
 			     VC4_SUBMIT_CL_RCL_ORDER_INCREASING_X |
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 4cd2ccfe15f4..ffd0a4388752 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -229,6 +229,9 @@ vc4_irq_preinstall(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
+	if (!vc4->v3d)
+		return;
+
 	init_waitqueue_head(&vc4->job_wait_queue);
 	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
 
@@ -243,6 +246,9 @@ vc4_irq_postinstall(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
+	if (!vc4->v3d)
+		return 0;
+
 	/* Enable both the render done and out of memory interrupts. */
 	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
 
@@ -254,6 +260,9 @@ vc4_irq_uninstall(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
+	if (!vc4->v3d)
+		return;
+
 	/* Disable sending interrupts for our driver's IRQs. */
 	V3D_WRITE(V3D_INTDIS, V3D_DRIVER_IRQS);
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 5160cad25fce..295dacc8bcb9 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -525,6 +525,7 @@ int vc4_kms_load(struct drm_device *dev)
 	/* Set support for vblank irq fast disable, before drm_vblank_init() */
 	dev->vblank_disable_immediate = true;
 
+	dev->irq_enabled = true;
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index 495150415020..6562d3d30b20 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -100,12 +100,18 @@ void vc4_perfmon_close_file(struct vc4_file *vc4file)
 int vc4_perfmon_create_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file_priv)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_file *vc4file = file_priv->driver_priv;
 	struct drm_vc4_perfmon_create *req = data;
 	struct vc4_perfmon *perfmon;
 	unsigned int i;
 	int ret;
 
+	if (!vc4->v3d) {
+		DRM_DEBUG("Creating perfmon no VC4 V3D probed\n");
+		return -EINVAL;
+	}
+
 	/* Number of monitored counters cannot exceed HW limits. */
 	if (req->ncounters > DRM_VC4_MAX_PERF_COUNTERS ||
 	    !req->ncounters)
@@ -146,10 +152,16 @@ int vc4_perfmon_create_ioctl(struct drm_device *dev, void *data,
 int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *file_priv)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_file *vc4file = file_priv->driver_priv;
 	struct drm_vc4_perfmon_destroy *req = data;
 	struct vc4_perfmon *perfmon;
 
+	if (!vc4->v3d) {
+		DRM_DEBUG("Destroying perfmon no VC4 V3D probed\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&vc4file->perfmon.lock);
 	perfmon = idr_remove(&vc4file->perfmon.idr, req->id);
 	mutex_unlock(&vc4file->perfmon.lock);
@@ -164,11 +176,17 @@ int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_file *vc4file = file_priv->driver_priv;
 	struct drm_vc4_perfmon_get_values *req = data;
 	struct vc4_perfmon *perfmon;
 	int ret;
 
+	if (!vc4->v3d) {
+		DRM_DEBUG("Getting perfmon no VC4 V3D probed\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&vc4file->perfmon.lock);
 	perfmon = idr_find(&vc4file->perfmon.idr, req->id);
 	vc4_perfmon_get(perfmon);
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 36e6c7086ecf..a4b6859e3af6 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -474,7 +474,7 @@ static int vc4_v3d_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id vc4_v3d_dt_match[] = {
+const struct of_device_id vc4_v3d_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-v3d" },
 	{ .compatible = "brcm,cygnus-v3d" },
 	{ .compatible = "brcm,vc4-v3d" },
-- 
2.20.1

