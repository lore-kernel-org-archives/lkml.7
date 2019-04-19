Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D3C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED7521736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfDSAKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:10:22 -0400
Received: from anholt.net ([50.246.234.109]:41340 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfDSAKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:10:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A921610A339D;
        Thu, 18 Apr 2019 17:10:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Iz5nf8Xl3WUu; Thu, 18 Apr 2019 17:10:15 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C022A10A3045;
        Thu, 18 Apr 2019 17:10:15 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id EB43F2FE3AAE; Thu, 18 Apr 2019 17:10:14 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4/4] drm/v3d: Fix and extend MMU error handling.
Date:   Thu, 18 Apr 2019 17:10:14 -0700
Message-Id: <20190419001014.23579-4-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419001014.23579-1-eric@anholt.net>
References: <20190419001014.23579-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were setting the wrong flags to enable PTI errors, so we were
seeing reads to invalid PTEs show up as write errors.  Also, we
weren't turning on the interrupts.  The AXI IDs we were dumping
included the outstanding write number and so they looked basically
random.  And the VIO_ADDR decoding was based on the MMU VA_WIDTH for
the first platform I worked on and was wrong on others.  In short,
this was a thorough mess from early HW enabling.

Tested on V3D 4.1 and 4.2 with intentional L2T, CLE, PTB, and TLB
faults.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.c  |  1 +
 drivers/gpu/drm/v3d/v3d_drv.h  |  2 ++
 drivers/gpu/drm/v3d/v3d_irq.c  | 31 +++++++++++++++++++++++++++----
 drivers/gpu/drm/v3d/v3d_mmu.c  |  7 +++++--
 drivers/gpu/drm/v3d/v3d_regs.h |  3 ++-
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 7ab36192e6bc..9ce2e4ef6c2a 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -494,6 +494,7 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	mmu_debug = V3D_READ(V3D_MMU_DEBUG_INFO);
 	dev->coherent_dma_mask =
 		DMA_BIT_MASK(30 + V3D_GET_FIELD(mmu_debug, V3D_MMU_PA_WIDTH));
+	v3d->va_width = 30 + V3D_GET_FIELD(mmu_debug, V3D_MMU_VA_WIDTH);
 
 	ident1 = V3D_READ(V3D_HUB_IDENT1);
 	v3d->ver = (V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_TVER) * 10 +
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 6d31a6a5a08e..64682923018d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -63,6 +63,8 @@ struct v3d_dev {
 	 */
 	void *mmu_scratch;
 	dma_addr_t mmu_scratch_paddr;
+	/* virtual address bits from V3D to the MMU. */
+	int va_width;
 
 	/* Number of V3D cores. */
 	u32 cores;
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index fac3c542860b..268d8a889ac5 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -162,10 +162,33 @@ v3d_hub_irq(int irq, void *arg)
 		      V3D_HUB_INT_MMU_PTI |
 		      V3D_HUB_INT_MMU_CAP)) {
 		u32 axi_id = V3D_READ(V3D_MMU_VIO_ID);
-		u64 vio_addr = (u64)V3D_READ(V3D_MMU_VIO_ADDR) << 8;
-
-		dev_err(v3d->dev, "MMU error from client %d at 0x%08llx%s%s%s\n",
-			axi_id, (long long)vio_addr,
+		u64 vio_addr = ((u64)V3D_READ(V3D_MMU_VIO_ADDR) <<
+				(v3d->va_width - 32));
+		static const char *const v3d41_axi_ids[] = {
+			"L2T",
+			"PTB",
+			"PSE",
+			"TLB",
+			"CLE",
+			"TFU",
+			"MMU",
+			"GMP",
+		};
+		const char *client = "?";
+
+		V3D_WRITE(V3D_MMU_CTL,
+			  V3D_READ(V3D_MMU_CTL) & (V3D_MMU_CTL_CAP_EXCEEDED |
+						   V3D_MMU_CTL_PT_INVALID |
+						   V3D_MMU_CTL_WRITE_VIOLATION));
+
+		if (v3d->ver >= 41) {
+			axi_id = axi_id >> 5;
+			if (axi_id < ARRAY_SIZE(v3d41_axi_ids))
+				client = v3d41_axi_ids[axi_id];
+		}
+
+		dev_err(v3d->dev, "MMU error from client %s (%d) at 0x%llx%s%s%s\n",
+			client, axi_id, (long long)vio_addr,
 			((intsts & V3D_HUB_INT_MMU_WRV) ?
 			 ", write violation" : ""),
 			((intsts & V3D_HUB_INT_MMU_PTI) ?
diff --git a/drivers/gpu/drm/v3d/v3d_mmu.c b/drivers/gpu/drm/v3d/v3d_mmu.c
index 7a21f1787ab1..395e81d97163 100644
--- a/drivers/gpu/drm/v3d/v3d_mmu.c
+++ b/drivers/gpu/drm/v3d/v3d_mmu.c
@@ -69,10 +69,13 @@ int v3d_mmu_set_page_table(struct v3d_dev *v3d)
 	V3D_WRITE(V3D_MMU_PT_PA_BASE, v3d->pt_paddr >> V3D_MMU_PAGE_SHIFT);
 	V3D_WRITE(V3D_MMU_CTL,
 		  V3D_MMU_CTL_ENABLE |
-		  V3D_MMU_CTL_PT_INVALID |
+		  V3D_MMU_CTL_PT_INVALID_ENABLE |
 		  V3D_MMU_CTL_PT_INVALID_ABORT |
+		  V3D_MMU_CTL_PT_INVALID_INT |
 		  V3D_MMU_CTL_WRITE_VIOLATION_ABORT |
-		  V3D_MMU_CTL_CAP_EXCEEDED_ABORT);
+		  V3D_MMU_CTL_WRITE_VIOLATION_INT |
+		  V3D_MMU_CTL_CAP_EXCEEDED_ABORT |
+		  V3D_MMU_CTL_CAP_EXCEEDED_INT);
 	V3D_WRITE(V3D_MMU_ILLEGAL_ADDR,
 		  (v3d->mmu_scratch_paddr >> V3D_MMU_PAGE_SHIFT) |
 		  V3D_MMU_ILLEGAL_ADDR_ENABLE);
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index eda1e289976f..9bcb57781d31 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -152,7 +152,8 @@
 # define V3D_MMU_CTL_PT_INVALID_ABORT                  BIT(19)
 # define V3D_MMU_CTL_PT_INVALID_INT                    BIT(18)
 # define V3D_MMU_CTL_PT_INVALID_EXCEPTION              BIT(17)
-# define V3D_MMU_CTL_WRITE_VIOLATION                   BIT(16)
+# define V3D_MMU_CTL_PT_INVALID_ENABLE                 BIT(16)
+# define V3D_MMU_CTL_WRITE_VIOLATION                   BIT(12)
 # define V3D_MMU_CTL_WRITE_VIOLATION_ABORT             BIT(11)
 # define V3D_MMU_CTL_WRITE_VIOLATION_INT               BIT(10)
 # define V3D_MMU_CTL_WRITE_VIOLATION_EXCEPTION         BIT(9)
-- 
2.20.1

