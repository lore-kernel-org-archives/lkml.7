Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B18C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238EE206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDCPuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:11 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33047 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfDCPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:50:07 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost.localdomain (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C63521BF218;
        Wed,  3 Apr 2019 15:50:03 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 4/4] drm/vc4: Allocate binner bo when starting to use the V3D
Date:   Wed,  3 Apr 2019 17:48:56 +0200
Message-Id: <20190403154856.9470-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403154856.9470-1-paul.kocialkowski@bootlin.com>
References: <20190403154856.9470-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binner bo is not required until the V3D is in use, so avoid
allocating it at probe and do it on the first non-dumb BO allocation.
Keep track of which clients are using the V3D and liberate the buffer
when there is none left.

We also want to keep it alive during runtime suspend/resume to avoid
failing to allocate it at resume. This happens when the CMA pool is
full at that point and results in a hard crash.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c  | 32 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c |  9 +++++++++
 drivers/gpu/drm/vc4/vc4_drv.h |  4 ++++
 drivers/gpu/drm/vc4/vc4_v3d.c | 13 -------------
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 88ebd681d7eb..b941f09b9378 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -799,6 +799,30 @@ vc4_prime_import_sg_table(struct drm_device *dev,
 	return obj;
 }
 
+static int vc4_prepare_bin_bo(struct drm_device *dev,
+			      struct drm_file *file_priv)
+{
+	struct vc4_file *vc4file = file_priv->driver_priv;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	int ret;
+
+	if (!vc4->v3d)
+		return -ENODEV;
+
+	if (!vc4file->needs_bin_bo) {
+		atomic_inc(&vc4->bin_bo_usecnt);
+		vc4file->needs_bin_bo = true;
+	}
+
+	if (!vc4->bin_bo) {
+		ret = vc4_v3d_allocate_bin_bo(vc4);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_priv)
 {
@@ -806,6 +830,10 @@ int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
 	struct vc4_bo *bo = NULL;
 	int ret;
 
+	ret = vc4_prepare_bin_bo(dev, file_priv);
+	if (ret)
+		return ret;
+
 	/*
 	 * We can't allocate from the BO cache, because the BOs don't
 	 * get zeroed, and that might leak data between users.
@@ -865,6 +893,10 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
+	ret = vc4_prepare_bin_bo(dev, file_priv);
+	if (ret)
+		return ret;
+
 	bo = vc4_bo_create(dev, args->size, true, VC4_BO_TYPE_V3D_SHADER);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index d840b52b9805..4db937601638 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -128,8 +128,15 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
 
 static void vc4_close(struct drm_device *dev, struct drm_file *file)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_file *vc4file = file->driver_priv;
 
+	if (vc4file->needs_bin_bo && atomic_dec_and_test(&vc4->bin_bo_usecnt) &&
+	    vc4->bin_bo) {
+		drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
+		vc4->bin_bo = NULL;
+	}
+
 	vc4_perfmon_close_file(vc4file);
 	kfree(vc4file);
 }
@@ -274,6 +281,8 @@ static int vc4_drm_bind(struct device *dev)
 	drm->dev_private = vc4;
 	INIT_LIST_HEAD(&vc4->debugfs_list);
 
+	atomic_set(&vc4->bin_bo_usecnt, 0);
+
 	ret = vc4_bo_cache_init(drm);
 	if (ret)
 		goto dev_put;
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 37941f0e212a..7d49452f04fe 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -216,6 +216,8 @@ struct vc4_dev {
 	 * the minor is available (after drm_dev_register()).
 	 */
 	struct list_head debugfs_list;
+
+	atomic_t bin_bo_usecnt;
 };
 
 static inline struct vc4_dev *
@@ -594,6 +596,8 @@ struct vc4_file {
 		struct idr idr;
 		struct mutex lock;
 	} perfmon;
+
+	bool needs_bin_bo;
 };
 
 static inline struct vc4_exec_info *
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 70204c38074a..1cc366d76f2a 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -321,9 +321,6 @@ static int vc4_v3d_runtime_suspend(struct device *dev)
 
 	vc4_irq_uninstall(vc4->dev);
 
-	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
-	vc4->bin_bo = NULL;
-
 	clk_disable_unprepare(v3d->clk);
 
 	return 0;
@@ -335,10 +332,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	struct vc4_dev *vc4 = v3d->vc4;
 	int ret;
 
-	ret = vc4_v3d_allocate_bin_bo(vc4);
-	if (ret)
-		return ret;
-
 	ret = clk_prepare_enable(v3d->clk);
 	if (ret != 0)
 		return ret;
@@ -405,12 +398,6 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (ret != 0)
 		return ret;
 
-	ret = vc4_v3d_allocate_bin_bo(vc4);
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

