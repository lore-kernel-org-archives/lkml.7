Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5AC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F29020693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfDOMj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:39:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38397 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfDOMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:39:23 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost.localdomain (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BD4451C0011;
        Mon, 15 Apr 2019 12:39:19 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v5 4/4] drm/vc4: Allocate binner bo when starting to use the V3D
Date:   Mon, 15 Apr 2019 14:39:08 +0200
Message-Id: <20190415123908.28986-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415123908.28986-1-paul.kocialkowski@bootlin.com>
References: <20190415123908.28986-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binner bo is not required until the V3D is in use, so avoid
allocating it at probe and do it on the first non-dumb BO allocation.
Keep track of which clients are using the V3D and liberate the buffer
when there is none left (through a kref) and protect it with a mutex to
avoid race conditions.

The Out-Of-Memory (OOM) interrupt also gets some tweaking, to avoid
enabling it before having allocated a binner bo.

We also want to keep the BO alive during runtime suspend/resume to avoid
failing to allocate it at resume. This happens when the CMA pool is
full at that point and results in a hard crash.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c  | 30 ++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c | 17 +++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h |  9 +++++++
 drivers/gpu/drm/vc4/vc4_irq.c |  6 +++--
 drivers/gpu/drm/vc4/vc4_v3d.c | 47 +++++++++++++++++++++++++----------
 5 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 88ebd681d7eb..5a5276cce9a2 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -799,6 +799,28 @@ vc4_prime_import_sg_table(struct drm_device *dev,
 	return obj;
 }
 
+static int vc4_grab_bin_bo(struct drm_device *dev,
+			   struct drm_file *file_priv)
+{
+	struct vc4_file *vc4file = file_priv->driver_priv;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	if (!vc4->v3d)
+		return -ENODEV;
+
+	if (vc4file->bin_bo_kref)
+		return 0;
+
+	mutex_lock(&vc4->bin_bo_lock);
+	vc4file->bin_bo_kref = vc4_v3d_bin_bo_get(vc4);
+	mutex_unlock(&vc4->bin_bo_lock);
+
+	if (!vc4file->bin_bo_kref)
+		return -ENOMEM;
+
+	return 0;
+}
+
 int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_priv)
 {
@@ -806,6 +828,10 @@ int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
 	struct vc4_bo *bo = NULL;
 	int ret;
 
+	ret = vc4_grab_bin_bo(dev, file_priv);
+	if (ret)
+		return ret;
+
 	/*
 	 * We can't allocate from the BO cache, because the BOs don't
 	 * get zeroed, and that might leak data between users.
@@ -865,6 +891,10 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	ret = vc4_grab_bin_bo(dev, file_priv);
+	if (ret)
+		return ret;
+
 	bo = vc4_bo_create(dev, args->size, true, VC4_BO_TYPE_V3D_SHADER);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index d840b52b9805..b09f771384be 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -126,10 +126,25 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 	return 0;
 }
 
+static void vc4_close_bin_bo_release(struct kref *ref)
+{
+	struct vc4_dev *vc4 = container_of(ref, struct vc4_dev, bin_bo_kref);
+
+	return vc4_v3d_bin_bo_free(vc4);
+}
+
 static void vc4_close(struct drm_device *dev, struct drm_file *file)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_file *vc4file = file->driver_priv;
 
+	mutex_lock(&vc4->bin_bo_lock);
+
+	if (vc4file->bin_bo_kref)
+		kref_put(vc4file->bin_bo_kref, vc4_close_bin_bo_release);
+
+	mutex_unlock(&vc4->bin_bo_lock);
+
 	vc4_perfmon_close_file(vc4file);
 	kfree(vc4file);
 }
@@ -274,6 +289,8 @@ static int vc4_drm_bind(struct device *dev)
 	drm->dev_private = vc4;
 	INIT_LIST_HEAD(&vc4->debugfs_list);
 
+	mutex_init(&vc4->bin_bo_lock);
+
 	ret = vc4_bo_cache_init(drm);
 	if (ret)
 		goto dev_put;
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 1f0f529169a1..69dbda8e89ba 100644
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
@@ -594,6 +599,8 @@ struct vc4_file {
 		struct idr idr;
 		struct mutex lock;
 	} perfmon;
+
+	struct kref *bin_bo_kref;
 };
 
 static inline struct vc4_exec_info *
@@ -833,7 +840,9 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
 extern struct platform_driver vc4_v3d_driver;
 extern const struct of_device_id vc4_v3d_dt_match[];
 int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
+struct kref *vc4_v3d_bin_bo_get(struct vc4_dev *vc4);
 int vc4_v3d_bin_bo_alloc(struct vc4_dev *vc4);
+void vc4_v3d_bin_bo_free(struct vc4_dev *vc4);
 int vc4_v3d_pm_get(struct vc4_dev *vc4);
 void vc4_v3d_pm_put(struct vc4_dev *vc4);
 
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 723dc86b4511..e20e46483346 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -252,8 +252,10 @@ vc4_irq_postinstall(struct drm_device *dev)
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
index a77c8d6c7d5b..3501a83a0e91 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -212,6 +212,23 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 	return -ENOMEM;
 }
 
+struct kref *vc4_v3d_bin_bo_get(struct vc4_dev *vc4)
+{
+	struct kref *bin_bo_kref = &vc4->bin_bo_kref;
+	int ret;
+
+	if (vc4->bin_bo) {
+		kref_get(bin_bo_kref);
+		return bin_bo_kref;
+	}
+
+	ret = vc4_v3d_bin_bo_alloc(vc4);
+	if (ret)
+		return NULL;
+
+	return bin_bo_kref;
+}
+
 /**
  * vc4_v3d_bin_bo_alloc() - allocates the memory that will be used for
  * tile binning.
@@ -294,6 +311,14 @@ int vc4_v3d_bin_bo_alloc(struct vc4_dev *vc4)
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
 
@@ -313,6 +338,15 @@ int vc4_v3d_bin_bo_alloc(struct vc4_dev *vc4)
 	return ret;
 }
 
+void vc4_v3d_bin_bo_free(struct vc4_dev *vc4)
+{
+	if (!vc4->bin_bo)
+		return;
+
+	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
+	vc4->bin_bo = NULL;
+}
+
 #ifdef CONFIG_PM
 static int vc4_v3d_runtime_suspend(struct device *dev)
 {
@@ -321,9 +355,6 @@ static int vc4_v3d_runtime_suspend(struct device *dev)
 
 	vc4_irq_uninstall(vc4->dev);
 
-	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
-	vc4->bin_bo = NULL;
-
 	clk_disable_unprepare(v3d->clk);
 
 	return 0;
@@ -335,10 +366,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	struct vc4_dev *vc4 = v3d->vc4;
 	int ret;
 
-	ret = vc4_v3d_bin_bo_alloc(vc4);
-	if (ret)
-		return ret;
-
 	ret = clk_prepare_enable(v3d->clk);
 	if (ret != 0)
 		return ret;
@@ -405,12 +432,6 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (ret != 0)
 		return ret;
 
-	ret = vc4_v3d_bin_bo_alloc(vc4);
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

