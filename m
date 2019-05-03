Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D391C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4FB2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfECINM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:13:12 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59301 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:13:11 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost.localdomain (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CA50E2000C;
        Fri,  3 May 2019 08:13:06 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v8 1/4] drm/vc4: Reformat and the binner bo allocation helper
Date:   Fri,  3 May 2019 10:12:39 +0200
Message-Id: <20190503081242.29039-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503081242.29039-1-paul.kocialkowski@bootlin.com>
References: <20190503081242.29039-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for wrapping the binner bo allocation helper with
put/get helpers, pass the vc4 dev directly and drop the vc4 prefix.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index a4b6859e3af6..7c490106e185 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -213,7 +213,7 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 }
 
 /**
- * vc4_allocate_bin_bo() - allocates the memory that will be used for
+ * bin_bo_alloc() - allocates the memory that will be used for
  * tile binning.
  *
  * The binner has a limitation that the addresses in the tile state
@@ -234,9 +234,8 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
  * overall CMA pool before they make scenes complicated enough to run
  * out of bin space.
  */
-static int vc4_allocate_bin_bo(struct drm_device *drm)
+static int bin_bo_alloc(struct vc4_dev *vc4)
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
+	ret = bin_bo_alloc(vc4);
 	if (ret)
 		return ret;
 
@@ -403,7 +402,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (ret != 0)
 		return ret;
 
-	ret = vc4_allocate_bin_bo(drm);
+	ret = bin_bo_alloc(vc4);
 	if (ret) {
 		clk_disable_unprepare(v3d->clk);
 		return ret;
-- 
2.21.0

