Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F120693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfDOMjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:39:19 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44545 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfDOMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:39:18 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost.localdomain (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 08C261C0011;
        Mon, 15 Apr 2019 12:39:14 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v5 1/4] drm/vc4: Reformat and export binner bo allocation helper
Date:   Mon, 15 Apr 2019 14:39:05 +0200
Message-Id: <20190415123908.28986-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415123908.28986-1-paul.kocialkowski@bootlin.com>
References: <20190415123908.28986-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we'll be using the binner bo allocation helper in other parts
of the driver, reformat it with a vc4_v3d prefix and pass the vc4 dev
directly to match other functions.

Make the function visible to the whole driver too.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  1 +
 drivers/gpu/drm/vc4/vc4_v3d.c | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index e61734af059b..1f0f529169a1 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -833,6 +833,7 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
 extern struct platform_driver vc4_v3d_driver;
 extern const struct of_device_id vc4_v3d_dt_match[];
 int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
+int vc4_v3d_bin_bo_alloc(struct vc4_dev *vc4);
 int vc4_v3d_pm_get(struct vc4_dev *vc4);
 void vc4_v3d_pm_put(struct vc4_dev *vc4);
 
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index a4b6859e3af6..9c73fad77449 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -213,7 +213,7 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 }
 
 /**
- * vc4_allocate_bin_bo() - allocates the memory that will be used for
+ * vc4_v3d_bin_bo_alloc() - allocates the memory that will be used for
  * tile binning.
  *
  * The binner has a limitation that the addresses in the tile state
@@ -234,9 +234,8 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
  * overall CMA pool before they make scenes complicated enough to run
  * out of bin space.
  */
-static int vc4_allocate_bin_bo(struct drm_device *drm)
+int vc4_v3d_bin_bo_alloc(struct vc4_dev *vc4)
 {
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct vc4_v3d *v3d = vc4->v3d;
 	uint32_t size = 16 * 1024 * 1024;
 	int ret = 0;
@@ -251,7 +250,7 @@ static int vc4_allocate_bin_bo(struct drm_device *drm)
 	INIT_LIST_HEAD(&list);
 
 	while (true) {
-		struct vc4_bo *bo = vc4_bo_create(drm, size, true,
+		struct vc4_bo *bo = vc4_bo_create(vc4->dev, size, true,
 						  VC4_BO_TYPE_BIN);
 
 		if (IS_ERR(bo)) {
@@ -333,7 +332,7 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	struct vc4_dev *vc4 = v3d->vc4;
 	int ret;
 
-	ret = vc4_allocate_bin_bo(vc4->dev);
+	ret = vc4_v3d_bin_bo_alloc(vc4);
 	if (ret)
 		return ret;
 
@@ -403,7 +402,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (ret != 0)
 		return ret;
 
-	ret = vc4_allocate_bin_bo(drm);
+	ret = vc4_v3d_bin_bo_alloc(vc4);
 	if (ret) {
 		clk_disable_unprepare(v3d->clk);
 		return ret;
-- 
2.21.0

