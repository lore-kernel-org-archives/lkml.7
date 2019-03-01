Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466FB20838
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VTQhq/RB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lEuGW7wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCATjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:39:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfCATiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:38:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 171C261701; Fri,  1 Mar 2019 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469134;
        bh=vtUz/70hS+YlPCP+DnDk5nDj0CmNlWrNaq3raVA+i8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTQhq/RBvz95bMpD9j8KIKNbwghgefa49yK/dngpsLKYjmw3QG0DdqmgqwGhvXq/m
         tJF+1C3/zlCVd/1ytVOlKBGTHhNnZqUYHiQ52VTJKGc6dr+cuQHCBARx3eTMmGryuA
         dVS5JYux/d8zkLlxUSBLM4p4Jg7UBMd1NmhcseBM=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A573B61340;
        Fri,  1 Mar 2019 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469129;
        bh=vtUz/70hS+YlPCP+DnDk5nDj0CmNlWrNaq3raVA+i8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEuGW7wu7BqP8FrW5iTzDW4Alv3uOFxfNDgQCT7ilgx+mmdBDx0434MoRUYYjtzNN
         2HvaFNt5z9WcRtGuBUTAzhZbVIFU90kJIgkP7bV0m/Wnx+DhXUIdTRVmAYFNgkMAN0
         b/sdzrl8XMXsW4p4Ytu2JRhONhp/DKAsoqAP4xDA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A573B61340
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v1 05/15] iommu/arm-smmu: Add auxiliary domain support for arm-smmuv2
Date:   Fri,  1 Mar 2019 12:38:27 -0700
Message-Id: <1551469117-3404-6-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the new auxiliary domain API for arm-smmuv2 to initialize and
support multiple pagetables for a SMMU device. Since the smmu-v2 hardware
doesn't have any built in support for switching the pagetable base it is
left as an exercise to the caller to actually use the pagetable; aux
domains in the IOMMU driver are only preoccupied with creating and managing
the pagetable memory.

Following is a pseudo code example of how a domain can be created

 /* Check to see if aux domains are supported */
 if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
	 iommu = iommu_domain_alloc(...);

	 if (iommu_aux_attach_device(domain, dev))
		 return FAIL;

	/* Save the base address of the pagetable for use by the driver
	iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
 }

After this 'domain' can be used like any other iommu domain to map and
unmap iova addresses in the pagetable. The driver/hardware can be used
to switch the pagetable according to its own specific implementation.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 135 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 111 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 05eb126..b7b508e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -263,6 +263,8 @@ struct arm_smmu_domain {
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	u32 attributes;
 	struct iommu_domain		domain;
+	bool				is_aux;
+	u64				ttbr0;
 };
 
 struct arm_smmu_option_prop {
@@ -874,6 +876,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
+	/* Aux domains can only be created for stage-1 tables */
+	if (smmu_domain->is_aux && smmu_domain->stage != ARM_SMMU_DOMAIN_S1) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/*
 	 * Choosing a suitable context format is even more fiddly. Until we
 	 * grow some way for the caller to express a preference, and/or move
@@ -920,7 +928,10 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 32UL);
 			oas = min(oas, 32UL);
 		}
-		smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
+
+		/* aux domains shouldn't touch hardware so no TLB ops */
+		if (!smmu_domain->is_aux)
+			smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
@@ -939,32 +950,42 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 40UL);
 			oas = min(oas, 40UL);
 		}
-		if (smmu->version == ARM_SMMU_V2)
-			smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v2;
-		else
-			smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v1;
+
+		if (!smmu_domain->is_aux) {
+			if (smmu->version == ARM_SMMU_V2)
+				smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v2;
+			else
+				smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v1;
+		}
 		break;
 	default:
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
-				      smmu->num_context_banks);
-	if (ret < 0)
-		goto out_unlock;
 
-	cfg->cbndx = ret;
-	if (smmu->version < ARM_SMMU_V2) {
-		cfg->irptndx = atomic_inc_return(&smmu->irptndx);
-		cfg->irptndx %= smmu->num_context_irqs;
-	} else {
-		cfg->irptndx = cfg->cbndx;
-	}
+	/*
+	 * Aux domains will use the same context bank assigned to the master
+	 * domain for the device
+	 */
+	if (!smmu_domain->is_aux) {
+		ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
+					      smmu->num_context_banks);
+		if (ret < 0)
+			goto out_unlock;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
-		cfg->vmid = cfg->cbndx + 1 + smmu->cavium_id_base;
-	else
-		cfg->asid = cfg->cbndx + smmu->cavium_id_base;
+		cfg->cbndx = ret;
+		if (smmu->version < ARM_SMMU_V2) {
+			cfg->irptndx = atomic_inc_return(&smmu->irptndx);
+			cfg->irptndx %= smmu->num_context_irqs;
+		} else {
+			cfg->irptndx = cfg->cbndx;
+		}
+
+		if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
+			cfg->vmid = cfg->cbndx + 1 + smmu->cavium_id_base;
+		else
+			cfg->asid = cfg->cbndx + smmu->cavium_id_base;
+	}
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
@@ -987,16 +1008,26 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		goto out_clear_smmu;
 	}
 
+	/* Cache the TTBR0 for the aux domain */
+	smmu_domain->ttbr0 = pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0];
+
 	/* Update the domain's page sizes to reflect the page table format */
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	domain->geometry.aperture_end = (1UL << ias) - 1;
 	domain->geometry.force_aperture = true;
 
+	pgtbl_ops[1] = NULL;
+
+	/*
+	 * aux domains don't use split tables or program the hardware so we're
+	 * done setting it up
+	 */
+	if (smmu_domain->is_aux)
+		goto end;
+
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
 
-	pgtbl_ops[1] = NULL;
-
 	if (split_tables) {
 		/* FIXME: I think it is safe to reuse pgtbl_cfg here */
 		pgtbl_ops[1] = alloc_io_pgtable_ops(fmt, &pgtbl_cfg,
@@ -1018,13 +1049,15 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	 */
 	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
 	ret = devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
-			       IRQF_SHARED, "arm-smmu-context-fault", domain);
+			       IRQF_SHARED, "arm-smmu-context-fault",
+			       domain);
 	if (ret < 0) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
 			cfg->irptndx, irq);
 		cfg->irptndx = INVALID_IRPTNDX;
 	}
 
+end:
 	mutex_unlock(&smmu_domain->init_mutex);
 
 	/* Publish page table ops for map/unmap */
@@ -1050,6 +1083,12 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
+	/* All we need to do for aux devices is destroy the pagetable */
+	if (smmu_domain->is_aux) {
+		free_io_pgtable_ops(smmu_domain->pgtbl_ops[0]);
+		return;
+	}
+
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
 		return;
@@ -1330,6 +1369,39 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+static bool arm_smmu_dev_has_feat(struct device *dev,
+		enum iommu_dev_features feat)
+{
+	/*
+	 * FIXME: Should we do some hardware checking here, like to be sure this
+	 * is a stage 1 and such?
+	 */
+
+	/* Always allow aux domains */
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return true;
+
+	return false;
+}
+
+/* FIXME: Add stubs for dev_enable_feat and dev_disable_feat? */
+
+/* Set up a new aux domain and create a new pagetable with the same
+ * characteristics as the master
+ */
+static int arm_smmu_aux_attach_dev(struct iommu_domain *domain,
+		struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	smmu_domain->is_aux = true;
+
+	/* No power is needed because aux domain doesn't touch the hardware */
+	return arm_smmu_init_domain_context(domain, smmu);
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
@@ -1342,6 +1414,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENXIO;
 	}
 
+	/* FIXME: Reject unmanged domains since those should be aux? */
+
 	/*
 	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
 	 * domains between of_xlate() and add_device() - we have no way to cope
@@ -1388,7 +1462,13 @@ arm_smmu_get_pgtbl_ops(struct iommu_domain *domain, unsigned long iova)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+	struct arm_smmu_cb *cb;
+
+	/* quick escape for domains that don't have split pagetables enabled */
+	if (!smmu_domain->pgtbl_ops[1])
+		return smmu_domain->pgtbl_ops[0];
+
+	cb = &smmu_domain->smmu->cbs[cfg->cbndx];
 
 	if (iova & cb->split_table_mask)
 		return smmu_domain->pgtbl_ops[1];
@@ -1700,6 +1780,11 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 				!!(smmu_domain->attributes &
 				   (1 << DOMAIN_ATTR_SPLIT_TABLES));
 			return 0;
+		case DOMAIN_ATTR_PTBASE:
+			if (!smmu_domain->is_aux)
+				return -ENODEV;
+			*((u64 *)data) = smmu_domain->ttbr0;
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1810,7 +1895,9 @@ static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
+	.dev_has_feat		= arm_smmu_dev_has_feat,
 	.attach_dev		= arm_smmu_attach_dev,
+	.aux_attach_dev		= arm_smmu_aux_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
-- 
2.7.4

