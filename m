Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E20C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AA20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDCSWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:22:19 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:59778 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfDCSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:21:53 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id vuMq1z00n3XaVaC01uMqja; Wed, 03 Apr 2019 20:21:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBkWE-00057t-Hs; Wed, 03 Apr 2019 20:21:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBkWE-0004iN-GU; Wed, 03 Apr 2019 20:21:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/6] iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
Date:   Wed,  3 Apr 2019 20:21:44 +0200
Message-Id: <20190403182148.18058-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403182148.18058-1-geert+renesas@glider.be>
References: <20190403182148.18058-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On R-Car Gen3, the faulting virtual address is a 40-bit address, and
comprised of two registers.  Read the upper address part, and combine
both parts, when running on a 64-bit system.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Apart from this, the driver doesn't support 40-bit IOVA addresses yet.

v2:
  - Merge IMEAR/IMELAR.
---
 drivers/iommu/ipmmu-vmsa.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f2b781e20a0eba6..f2061bd1dc7b8852 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -186,7 +186,8 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 #define IMMAIR_ATTR_IDX_WBRWA		1
 #define IMMAIR_ATTR_IDX_DEV		2
 
-#define IMEAR				0x0030
+#define IMELAR				0x0030	/* IMEAR on R-Car Gen2 */
+#define IMEUAR				0x0034	/* R-Car Gen3 only */
 
 #define IMPCTR				0x0200
 #define IMPSTR				0x0208
@@ -522,14 +523,16 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 {
 	const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
+	unsigned long iova;
 	u32 status;
-	u32 iova;
 
 	status = ipmmu_ctx_read_root(domain, IMSTR);
 	if (!(status & err_mask))
 		return IRQ_NONE;
 
-	iova = ipmmu_ctx_read_root(domain, IMEAR);
+	iova = ipmmu_ctx_read_root(domain, IMELAR);
+	if (IS_ENABLED(CONFIG_64BIT))
+		iova |= (u64)ipmmu_ctx_read_root(domain, IMEUAR) << 32;
 
 	/*
 	 * Clear the error status flags. Unlike traditional interrupt flag
@@ -541,10 +544,10 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 
 	/* Log fatal errors. */
 	if (status & IMSTR_MHIT)
-		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%08x\n",
+		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%lx\n",
 				    iova);
 	if (status & IMSTR_ABORT)
-		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%08x\n",
+		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%lx\n",
 				    iova);
 
 	if (!(status & (IMSTR_PF | IMSTR_TF)))
@@ -560,7 +563,7 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 		return IRQ_HANDLED;
 
 	dev_err_ratelimited(mmu->dev,
-			    "Unhandled fault: status 0x%08x iova 0x%08x\n",
+			    "Unhandled fault: status 0x%08x iova 0x%lx\n",
 			    status, iova);
 
 	return IRQ_HANDLED;
-- 
2.17.1

