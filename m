Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B944C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1473621736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDSAKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:10:23 -0400
Received: from anholt.net ([50.246.234.109]:41346 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfDSAKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:10:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EB0D010A3045;
        Thu, 18 Apr 2019 17:10:21 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 89Mn6pONfiju; Thu, 18 Apr 2019 17:10:19 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E7EC310A3378;
        Thu, 18 Apr 2019 17:10:15 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E23392FE2FC0; Thu, 18 Apr 2019 17:10:14 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/4] drm/v3d: Set the correct DMA mask according to the MMU's limits.
Date:   Thu, 18 Apr 2019 17:10:12 -0700
Message-Id: <20190419001014.23579-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419001014.23579-1-eric@anholt.net>
References: <20190419001014.23579-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7278, we've got 40 bits to work with.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 1 +
 drivers/gpu/drm/v3d/v3d_drv.c     | 6 +++++-
 drivers/gpu/drm/v3d/v3d_regs.h    | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 356a8acfa72d..ab652a034959 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -30,6 +30,7 @@ static const struct v3d_reg_def v3d_hub_reg_defs[] = {
 	REGDEF(V3D_MMU_CTL),
 	REGDEF(V3D_MMU_VIO_ADDR),
 	REGDEF(V3D_MMU_VIO_ID),
+	REGDEF(V3D_MMU_DEBUG_INFO),
 };
 
 static const struct v3d_reg_def v3d_gca_reg_defs[] = {
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index f8d1d2569c1f..7ab36192e6bc 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -472,9 +472,9 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	struct drm_device *drm;
 	struct v3d_dev *v3d;
 	int ret;
+	u32 mmu_debug;
 	u32 ident1;
 
-	dev->coherent_dma_mask = DMA_BIT_MASK(36);
 
 	v3d = kzalloc(sizeof(*v3d), GFP_KERNEL);
 	if (!v3d)
@@ -491,6 +491,10 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	if (ret)
 		goto dev_free;
 
+	mmu_debug = V3D_READ(V3D_MMU_DEBUG_INFO);
+	dev->coherent_dma_mask =
+		DMA_BIT_MASK(30 + V3D_GET_FIELD(mmu_debug, V3D_MMU_PA_WIDTH));
+
 	ident1 = V3D_READ(V3D_HUB_IDENT1);
 	v3d->ver = (V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_TVER) * 10 +
 		    V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_REV));
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index 9a8ff0ce648e..54c8c4320da0 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -191,6 +191,14 @@
 /* Address that faulted */
 #define V3D_MMU_VIO_ADDR                               0x01234
 
+#define V3D_MMU_DEBUG_INFO                             0x01238
+# define V3D_MMU_PA_WIDTH_MASK                         V3D_MASK(11, 8)
+# define V3D_MMU_PA_WIDTH_SHIFT                        8
+# define V3D_MMU_VA_WIDTH_MASK                         V3D_MASK(7, 4)
+# define V3D_MMU_VA_WIDTH_SHIFT                        4
+# define V3D_MMU_VERSION_MASK                          V3D_MASK(3, 0)
+# define V3D_MMU_VERSION_SHIFT                         0
+
 /* Per-V3D-core registers */
 
 #define V3D_CTL_IDENT0                                 0x00000
-- 
2.20.1

