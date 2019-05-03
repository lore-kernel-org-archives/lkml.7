Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C0C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8992087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfECINT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:13:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46095 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfECINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:13:17 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost.localdomain (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A6B5820006;
        Fri,  3 May 2019 08:13:12 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v8 4/4] drm/vc4: Allocate binner bo when starting to use the V3D
Date:   Fri,  3 May 2019 10:12:42 +0200
Message-Id: <20190503081242.29039-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503081242.29039-1-paul.kocialkowski@bootlin.com>
References: <20190503081242.29039-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binner BO is not required until the V3D is in use, so avoid
allocating it at probe and do it on the first non-dumb BO allocation.

Keep track of which clients are using the V3D and liberate the buffer
when there is none left, using a kref. Protect the logic with a
mutex to avoid race conditions.

The binner BO is created at the time of the first render ioctl and is
destroyed when there is no client and no exec job using it left.

The Out-Of-Memory (OOM) interrupt also gets some tweaking, to avoid
enabling it before having allocated a binner bo.

We also want to keep the BO alive during runtime suspend/resume to avoid
failing to allocate it at resume. This happens when the CMA pool is
full at that point and results in a hard crash.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c  | 31 ++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_drv.c |  6 ++++
 drivers/gpu/drm/vc4/vc4_drv.h | 14 ++++++++
 drivers/gpu/drm/vc4/vc4_gem.c | 11 ++++++
 drivers/gpu/drm/vc4/vc4_irq.c | 21 ++++++++----
 drivers/gpu/drm/vc4/vc4_v3d.c | 64 ++++++++++++++++++++++++++++-------
 6 files changed, 127 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 88ebd681d7eb..1434bb829267 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -799,13 +799,36 @@ vc4_prime_import_sg_table(struct drm_device *dev,
 	return obj;
 }
 
+static int vc4_grab_bin_bo(struct vc4_dev *vc4, struct vc4_file *vc4file)
+{
+	int ret;
+
+	if (!vc4->v3d)
+		return -ENODEV;
+
+	if (vc4file->bin_bo_used)
+		return 0;
+
+	ret = vc4_v3d_bin_bo_get(vc4, &vc4file->bin_bo_used);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_priv)
 {
 	struct drm_vc4_create_bo *args = data;
+	struct vc4_file *vc4file = file_priv->driver_priv;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_bo *bo = NULL;
 	int ret;
 
+	ret = vc4_grab_bin_bo(vc4, vc4file);
+	if (ret)
+		return ret;
+
 	/*
 	 * We can't allocate from the BO cache, because the BOs don't
 	 * get zeroed, and that might leak data between users.
@@ -846,6 +869,8 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv)
 {
 	struct drm_vc4_create_shader_bo *args = data;
+	struct vc4_file *vc4file = file_priv->driver_priv;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_bo *bo = NULL;
 	int ret;
 
@@ -865,6 +890,10 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	ret = vc4_grab_bin_bo(vc4, vc4file);
+	if (ret)
+		return ret;
+
 	bo = vc4_bo_create(dev, args->size, true, VC4_BO_TYPE_V3D_SHADER);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
@@ -894,7 +923,7 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 	 */
 	ret = drm_gem_handle_create(file_priv, &bo->base.base, &args->handle);
 
- fail:
+fail:
 	drm_gem_object_put_unlocked(&bo->base.base);
 
 	return ret;
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 6d9be20a32be..0f99ad03614e 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -128,8 +128,12 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 
 static void vc4_close(struct drm_device *dev, struct drm_file *file)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_file *vc4file = file->driver_priv;
 
+	if (vc4file->bin_bo_used)
+		vc4_v3d_bin_bo_put(vc4);
+
 	vc4_perfmon_close_file(vc4file);
 	kfree(vc4file);
 }
@@ -274,6 +278,8 @@ static int vc4_drm_bind(struct device *dev)
 	drm->dev_private = vc4;
 	INIT_LIST_HEAD(&vc4->debugfs_list);
 
+	mutex_init(&vc4->bin_bo_lock);
+
 	ret = vc4_bo_cache_init(drm);
 	if (ret)
 		goto dev_put;
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 4f13f6262491..9170a24ec5f5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -216,6 +216,11 @@ struct vc4_dev {
 	 * the minor is available (after drm_dev_register()).
 	 */
 	struct list_head debugfs_list;
+
+	/* Mutex for binner bo allocation. */
+	struct mutex bin_bo_lock;
+	/* Reference count for our binner bo. */
+	struct kref bin_bo_kref;
 };
 
 static inline struct vc4_dev *
@@ -584,6 +589,11 @@ struct vc4_exec_info {
 	 * NULL otherwise.
 	 */
 	struct vc4_perfmon *perfmon;
+
+	/* Whether the exec has taken a reference to the binner BO, which should
+	 * happen with a VC4_PACKET_TILE_BINNING_MODE_CONFIG packet.
+	 */
+	bool bin_bo_used;
 };
 
 /* Per-open file private data. Any driver-specific resource that has to be
@@ -594,6 +604,8 @@ struct vc4_file {
 		struct idr idr;
 		struct mutex lock;
 	} perfmon;
+
+	bool bin_bo_used;
 };
 
 static inline struct vc4_exec_info *
@@ -833,6 +845,8 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
 extern struct platform_driver vc4_v3d_driver;
 extern const struct of_device_id vc4_v3d_dt_match[];
 int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
+int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used);
+void vc4_v3d_bin_bo_put(struct vc4_dev *vc4);
 int vc4_v3d_pm_get(struct vc4_dev *vc4);
 void vc4_v3d_pm_put(struct vc4_dev *vc4);
 
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index d9311be32a4f..84795d928f20 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -820,6 +820,7 @@ static int
 vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
 {
 	struct drm_vc4_submit_cl *args = exec->args;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	void *temp = NULL;
 	void *bin;
 	int ret = 0;
@@ -918,6 +919,12 @@ vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
 	if (ret)
 		goto fail;
 
+	if (exec->found_tile_binning_mode_config_packet) {
+		ret = vc4_v3d_bin_bo_get(vc4, &exec->bin_bo_used);
+		if (ret)
+			goto fail;
+	}
+
 	/* Block waiting on any previous rendering into the CS's VBO,
 	 * IB, or textures, so that pixels are actually written by the
 	 * time we try to read them.
@@ -966,6 +973,10 @@ vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
 	vc4->bin_alloc_used &= ~exec->bin_slots;
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
+	/* Release the reference on the binner BO if needed. */
+	if (exec->bin_bo_used)
+		vc4_v3d_bin_bo_put(vc4);
+
 	/* Release the reference we had on the perf monitor. */
 	vc4_perfmon_put(exec->perfmon);
 
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 723dc86b4511..e226c24e543f 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -59,18 +59,22 @@ vc4_overflow_mem_work(struct work_struct *work)
 {
 	struct vc4_dev *vc4 =
 		container_of(work, struct vc4_dev, overflow_mem_work);
-	struct vc4_bo *bo = vc4->bin_bo;
+	struct vc4_bo *bo;
 	int bin_bo_slot;
 	struct vc4_exec_info *exec;
 	unsigned long irqflags;
 
-	if (!bo)
-		return;
+	mutex_lock(&vc4->bin_bo_lock);
+
+	if (!vc4->bin_bo)
+		goto complete;
+
+	bo = vc4->bin_bo;
 
 	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
 	if (bin_bo_slot < 0) {
 		DRM_ERROR("Couldn't allocate binner overflow mem\n");
-		return;
+		goto complete;
 	}
 
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
@@ -101,6 +105,9 @@ vc4_overflow_mem_work(struct work_struct *work)
 	V3D_WRITE(V3D_INTCTL, V3D_INT_OUTOMEM);
 	V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+
+complete:
+	mutex_unlock(&vc4->bin_bo_lock);
 }
 
 static void
@@ -252,8 +259,10 @@ vc4_irq_postinstall(struct drm_device *dev)
 	if (!vc4->v3d)
 		return 0;
 
-	/* Enable both the render done and out of memory interrupts. */
-	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
+	/* Enable the render done interrupts. The out-of-memory interrupt is
+	 * enabled as soon as we have a binner BO allocated.
+	 */
+	V3D_WRITE(V3D_INTENA, V3D_INT_FLDONE | V3D_INT_FRDONE);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index c16db4665af6..7df717241a10 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -294,6 +294,14 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
 			WARN_ON_ONCE(sizeof(vc4->bin_alloc_used) * 8 !=
 				     bo->base.base.size / vc4->bin_alloc_size);
 
+			kref_init(&vc4->bin_bo_kref);
+
+			/* Enable the out-of-memory interrupt to set our
+			 * newly-allocated binner BO, potentially from an
+			 * already-pending-but-masked interupt.
+			 */
+			V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
+
 			break;
 		}
 
@@ -313,6 +321,49 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
 	return ret;
 }
 
+int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
+{
+	int ret = 0;
+
+	mutex_lock(&vc4->bin_bo_lock);
+
+	if (used && *used)
+		goto complete;
+
+	if (used)
+		*used = true;
+
+	if (vc4->bin_bo) {
+		kref_get(&vc4->bin_bo_kref);
+		goto complete;
+	}
+
+	ret = bin_bo_alloc(vc4);
+
+complete:
+	mutex_unlock(&vc4->bin_bo_lock);
+
+	return ret;
+}
+
+static void bin_bo_release(struct kref *ref)
+{
+	struct vc4_dev *vc4 = container_of(ref, struct vc4_dev, bin_bo_kref);
+
+	if (WARN_ON_ONCE(!vc4->bin_bo))
+		return;
+
+	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
+	vc4->bin_bo = NULL;
+}
+
+void vc4_v3d_bin_bo_put(struct vc4_dev *vc4)
+{
+	mutex_lock(&vc4->bin_bo_lock);
+	kref_put(&vc4->bin_bo_kref, bin_bo_release);
+	mutex_unlock(&vc4->bin_bo_lock);
+}
+
 #ifdef CONFIG_PM
 static int vc4_v3d_runtime_suspend(struct device *dev)
 {
@@ -321,9 +372,6 @@ static int vc4_v3d_runtime_suspend(struct device *dev)
 
 	vc4_irq_uninstall(vc4->dev);
 
-	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
-	vc4->bin_bo = NULL;
-
 	clk_disable_unprepare(v3d->clk);
 
 	return 0;
@@ -335,10 +383,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	struct vc4_dev *vc4 = v3d->vc4;
 	int ret;
 
-	ret = bin_bo_alloc(vc4);
-	if (ret)
-		return ret;
-
 	ret = clk_prepare_enable(v3d->clk);
 	if (ret != 0)
 		return ret;
@@ -405,12 +449,6 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (ret != 0)
 		return ret;
 
-	ret = bin_bo_alloc(vc4);
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

