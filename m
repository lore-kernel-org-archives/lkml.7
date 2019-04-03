Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB7C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE9420700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDCSWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:22:21 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:59774 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDCSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:21:53 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id vuMq1z00u3XaVaC01uMqje; Wed, 03 Apr 2019 20:21:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBkWE-000584-MS; Wed, 03 Apr 2019 20:21:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBkWE-0004iX-Ka; Wed, 03 Apr 2019 20:21:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 5/6] iommu/ipmmu-vmsa: Extract hardware context initialization
Date:   Wed,  3 Apr 2019 20:21:47 +0200
Message-Id: <20190403182148.18058-6-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403182148.18058-1-geert+renesas@glider.be>
References: <20190403182148.18058-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipmmu_domain_init_context() takes care of (1) initializing the software
domain, and (2) initializing the hardware context for the domain.

Extract the code to initialize the hardware context into a new subroutine
ipmmu_domain_setup_context(), to prepare for later reuse.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - s/ipmmu_context_init/ipmmu_domain_setup_context/.
---
 drivers/iommu/ipmmu-vmsa.c | 91 ++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 3fa57627b1e35562..56e84bcc9532e1ce 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -404,52 +404,10 @@ static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
 	spin_unlock_irqrestore(&mmu->lock, flags);
 }
 
-static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+static void ipmmu_domain_setup_context(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
 	u32 tmp;
-	int ret;
-
-	/*
-	 * Allocate the page table operations.
-	 *
-	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
-	 * access, Long-descriptor format" that the NStable bit being set in a
-	 * table descriptor will result in the NStable and NS bits of all child
-	 * entries being ignored and considered as being set. The IPMMU seems
-	 * not to comply with this, as it generates a secure access page fault
-	 * if any of the NStable and NS bits isn't set when running in
-	 * non-secure mode.
-	 */
-	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
-	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
-	domain->cfg.ias = 32;
-	domain->cfg.oas = 40;
-	domain->cfg.tlb = &ipmmu_gather_ops;
-	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
-	domain->io_domain.geometry.force_aperture = true;
-	/*
-	 * TODO: Add support for coherent walk through CCI with DVM and remove
-	 * cache handling. For now, delegate it to the io-pgtable code.
-	 */
-	domain->cfg.iommu_dev = domain->mmu->root->dev;
-
-	/*
-	 * Find an unused context.
-	 */
-	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
-	if (ret < 0)
-		return ret;
-
-	domain->context_id = ret;
-
-	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
-					   domain);
-	if (!domain->iop) {
-		ipmmu_domain_free_context(domain->mmu->root,
-					  domain->context_id);
-		return -EINVAL;
-	}
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
@@ -495,7 +453,54 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	 */
 	ipmmu_ctx_write_all(domain, IMCTR,
 			    IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+}
+
+static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+{
+	int ret;
+
+	/*
+	 * Allocate the page table operations.
+	 *
+	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
+	 * access, Long-descriptor format" that the NStable bit being set in a
+	 * table descriptor will result in the NStable and NS bits of all child
+	 * entries being ignored and considered as being set. The IPMMU seems
+	 * not to comply with this, as it generates a secure access page fault
+	 * if any of the NStable and NS bits isn't set when running in
+	 * non-secure mode.
+	 */
+	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
+	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
+	domain->cfg.ias = 32;
+	domain->cfg.oas = 40;
+	domain->cfg.tlb = &ipmmu_gather_ops;
+	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	domain->io_domain.geometry.force_aperture = true;
+	/*
+	 * TODO: Add support for coherent walk through CCI with DVM and remove
+	 * cache handling. For now, delegate it to the io-pgtable code.
+	 */
+	domain->cfg.iommu_dev = domain->mmu->root->dev;
+
+	/*
+	 * Find an unused context.
+	 */
+	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
+	if (ret < 0)
+		return ret;
+
+	domain->context_id = ret;
+
+	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
+					   domain);
+	if (!domain->iop) {
+		ipmmu_domain_free_context(domain->mmu->root,
+					  domain->context_id);
+		return -EINVAL;
+	}
 
+	ipmmu_domain_setup_context(domain);
 	return 0;
 }
 
-- 
2.17.1

