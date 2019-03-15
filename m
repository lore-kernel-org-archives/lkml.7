Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AB9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE0B218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfCOQ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:26:05 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59261 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfCOQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:26:05 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost.localdomain (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4AF4AC0014;
        Fri, 15 Mar 2019 16:26:01 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 2/3] drm/vc4: Allocate/liberate the binner BO at firstopen/lastclose
Date:   Fri, 15 Mar 2019 17:25:37 +0100
Message-Id: <20190315162538.4120-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190315162538.4120-1-paul.kocialkowski@bootlin.com>
References: <20190315162538.4120-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the binner buffer is only required for GPU rendering, it's a waste
to allocate it when the driver probes since internal users of the driver
(such as fbcon) won't try to use the GPU.

Move the allocation/liberation to the firstopen/lastclose to only
allocate it when userspace has opened the device.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h |  1 +
 drivers/gpu/drm/vc4/vc4_irq.c |  3 +++
 drivers/gpu/drm/vc4/vc4_v3d.c |  8 +-------
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 3227706700f9..605dc50613e3 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -134,6 +134,30 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
 	kfree(vc4file);
 }
 
+static int vc4_firstopen(struct drm_device *drm)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
+	int ret;
+
+	if (!vc4->bin_bo) {
+		ret = vc4_allocate_bin_bo(drm);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void vc4_lastclose(struct drm_device *drm)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
+
+	if (vc4->bin_bo) {
+		drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
+		vc4->bin_bo = NULL;
+	}
+}
+
 static const struct vm_operations_struct vc4_vm_ops = {
 	.fault = vc4_fault,
 	.open = drm_gem_vm_open,
@@ -180,6 +204,8 @@ static struct drm_driver vc4_drm_driver = {
 			    DRIVER_SYNCOBJ),
 	.open = vc4_open,
 	.postclose = vc4_close,
+	.firstopen = vc4_firstopen,
+	.lastclose = vc4_lastclose,
 	.irq_handler = vc4_irq,
 	.irq_preinstall = vc4_irq_preinstall,
 	.irq_postinstall = vc4_irq_postinstall,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 7a3c093e7443..f52bb21e9885 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -808,6 +808,7 @@ extern struct platform_driver vc4_v3d_driver;
 int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused);
 int vc4_v3d_debugfs_regs(struct seq_file *m, void *unused);
 int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
+int vc4_allocate_bin_bo(struct drm_device *drm);
 
 /* vc4_validate.c */
 int
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 4cd2ccfe15f4..efaba2b02f6c 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
 	struct vc4_exec_info *exec;
 	unsigned long irqflags;
 
+	if (!bo)
+		return;
+
 	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
 	if (bin_bo_slot < 0) {
 		DRM_ERROR("Couldn't allocate binner overflow mem\n");
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index e47e29426078..ab15e71df001 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -218,7 +218,7 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
  * overall CMA pool before they make scenes complicated enough to run
  * out of bin space.
  */
-static int vc4_allocate_bin_bo(struct drm_device *drm)
+int vc4_allocate_bin_bo(struct drm_device *drm)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct vc4_v3d *v3d = vc4->v3d;
@@ -384,12 +384,6 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (ret != 0)
 		return ret;
 
-	ret = vc4_allocate_bin_bo(drm);
-	if (ret) {
-		clk_disable_unprepare(v3d->clk);
-		return ret;
-	}
-
 	/* Reset the binner overflow address/size at setup, to be sure
 	 * we don't reuse an old one.
 	 */
-- 
2.21.0

