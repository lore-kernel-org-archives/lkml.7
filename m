Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50788CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15738222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TvR3U3rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbfJRXbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 19:31:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10996 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387715AbfJRXbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:31:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5daa4b4e0001>; Fri, 18 Oct 2019 16:31:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 18 Oct 2019 16:31:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 18 Oct 2019 16:31:23 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 23:31:22 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 18 Oct 2019 23:31:22 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5daa4b4a0008>; Fri, 18 Oct 2019 16:31:22 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <thomasz@nvidia.com>,
        <olof@lixom.net>, <jtukkinen@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v3 4/7] iommu/arm-smmu: Add global/context fault implementation hooks
Date:   Fri, 18 Oct 2019 16:31:29 -0700
Message-ID: <1571441492-21919-5-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571441486; bh=HkaZhvgyRQDt71jo4v5NVXRxSHdoSf+1oYL6Hz/lejc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TvR3U3rWT9Uv8dxK5QdexNVSncUAKyvfjUjhDS65ps6ArSKm2w+aERd0PXCRtZGJG
         TVLNupepaShhqK0hLh1CV0QLwwqFfBbA8HSVGVOhL7GWALNsamQKIUst/vCt2gArtZ
         LhFkcaKHzycO5Myi0odkMKXgEF2tXKUZdFz5WFW0QBJciwME+iJeJLX8rydgcm8FFD
         7Sk0EAeKM7VMTAI2UsO1s0Oi2/rgJMAudyHneRCF4u18UhqE1RUOXt9dYT7MAnA1Gf
         zR8SOVLGIGZZTuLEXvUmlVDnBpnqP6NHKa/jJMndMQMDKIfTamDjIPi7ayjCAWhAxX
         LdSVKkPVqJSDg==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add global/context fault hooks to allow NVIDIA SMMU implementation
handle faults across multiple SMMUs.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu-nvidia.c | 100 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c        |  11 ++++-
 drivers/iommu/arm-smmu.h        |   3 ++
 3 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
index ca871dc..2a19d41 100644
--- a/drivers/iommu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm-smmu-nvidia.c
@@ -143,6 +143,104 @@ static int nsmmu_init_context(struct arm_smmu_domain *smmu_domain)
 	return 0;
 }
 
+static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
+static irqreturn_t nsmmu_global_fault_inst(int irq,
+					       struct arm_smmu_device *smmu,
+					       int inst)
+{
+	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
+
+	gfsr = readl_relaxed(nsmmu_page(smmu, inst, 0) + ARM_SMMU_GR0_sGFSR);
+	gfsynr0 = readl_relaxed(nsmmu_page(smmu, inst, 0) +
+				ARM_SMMU_GR0_sGFSYNR0);
+	gfsynr1 = readl_relaxed(nsmmu_page(smmu, inst, 0) +
+				ARM_SMMU_GR0_sGFSYNR1);
+	gfsynr2 = readl_relaxed(nsmmu_page(smmu, inst, 0) +
+				ARM_SMMU_GR0_sGFSYNR2);
+
+	if (!gfsr)
+		return IRQ_NONE;
+
+	dev_err_ratelimited(smmu->dev,
+		"Unexpected global fault, this could be serious\n");
+	dev_err_ratelimited(smmu->dev,
+		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
+		gfsr, gfsynr0, gfsynr1, gfsynr2);
+
+	writel_relaxed(gfsr, nsmmu_page(smmu, inst, 0) + ARM_SMMU_GR0_sGFSR);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nsmmu_global_fault(int irq, void *dev)
+{
+	int inst;
+	irqreturn_t irq_ret = IRQ_NONE;
+	struct arm_smmu_device *smmu = dev;
+
+	for (inst = 0; inst < to_nvidia_smmu(smmu)->num_inst; inst++) {
+		irq_ret = nsmmu_global_fault_inst(irq, smmu, inst);
+		if (irq_ret == IRQ_HANDLED)
+			return irq_ret;
+	}
+
+	return irq_ret;
+}
+
+static irqreturn_t nsmmu_context_fault_bank(int irq,
+					    struct arm_smmu_device *smmu,
+					    int idx, int inst)
+{
+	u32 fsr, fsynr, cbfrsynra;
+	unsigned long iova;
+
+	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+	if (!(fsr & FSR_FAULT))
+		return IRQ_NONE;
+
+	fsynr = readl_relaxed(nsmmu_page(smmu, inst, smmu->numpage + idx) +
+			      ARM_SMMU_CB_FSYNR0);
+	iova = readq_relaxed(nsmmu_page(smmu, inst, smmu->numpage + idx) +
+			     ARM_SMMU_CB_FAR);
+	cbfrsynra = readl_relaxed(nsmmu_page(smmu, inst, 1) +
+				  ARM_SMMU_GR1_CBFRSYNRA(idx));
+
+	dev_err_ratelimited(smmu->dev,
+	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
+			    fsr, iova, fsynr, cbfrsynra, idx);
+
+	writel_relaxed(fsr, nsmmu_page(smmu, inst, smmu->numpage + idx) +
+			    ARM_SMMU_CB_FSR);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nsmmu_context_fault(int irq, void *dev)
+{
+	int inst, idx;
+	irqreturn_t irq_ret = IRQ_NONE;
+	struct iommu_domain *domain = dev;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	for (inst = 0; inst < to_nvidia_smmu(smmu)->num_inst; inst++) {
+		/* Interrupt line shared between all context faults.
+		 * Check for faults across all contexts.
+		 */
+		for (idx = 0; idx < smmu->num_context_banks; idx++) {
+			irq_ret = nsmmu_context_fault_bank(irq, smmu,
+							   idx, inst);
+
+			if (irq_ret == IRQ_HANDLED)
+				return irq_ret;
+		}
+	}
+
+	return irq_ret;
+}
+
 static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.read_reg = nsmmu_read_reg,
 	.write_reg = nsmmu_write_reg,
@@ -150,6 +248,8 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.write_reg64 = nsmmu_write_reg64,
 	.reset = nsmmu_reset,
 	.init_context = nsmmu_init_context,
+	.global_fault = nsmmu_global_fault,
+	.context_fault = nsmmu_context_fault,
 };
 
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc0b27d..2fd8848 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -635,6 +635,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	enum io_pgtable_fmt fmt;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	irqreturn_t (*context_fault)(int irq, void *dev);
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -797,7 +798,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 * handler seeing a half-initialised domain state.
 	 */
 	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
-	ret = devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
+	context_fault = (smmu->impl && smmu->impl->context_fault) ?
+			 smmu->impl->context_fault : arm_smmu_context_fault;
+	ret = devm_request_irq(smmu->dev, irq, context_fault,
 			       IRQF_SHARED, "arm-smmu-context-fault", domain);
 	if (ret < 0) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
@@ -2008,6 +2011,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	int num_irqs, i, err;
+	irqreturn_t (*global_fault)(int irq, void *dev);
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2096,9 +2100,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->num_context_irqs = smmu->num_context_banks;
 	}
 
+	global_fault = (smmu->impl && smmu->impl->global_fault) ?
+			smmu->impl->global_fault : arm_smmu_global_fault;
+
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
 		err = devm_request_irq(smmu->dev, smmu->irqs[i],
-				       arm_smmu_global_fault,
+				       global_fault,
 				       IRQF_SHARED,
 				       "arm-smmu global fault",
 				       smmu);
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 4520ef7..cfd5f22 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -17,6 +17,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/irqreturn.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -337,6 +338,8 @@ struct arm_smmu_impl {
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
 	int (*init_context)(struct arm_smmu_domain *smmu_domain);
+	irqreturn_t (*global_fault)(int irq, void *dev);
+	irqreturn_t (*context_fault)(int irq, void *dev);
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
2.7.4

