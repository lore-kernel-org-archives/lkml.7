Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C2C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A109207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbfFJSwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:52:15 -0400
Received: from foss.arm.com ([217.140.110.172]:47606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388882AbfFJSv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:51:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D804ADA7;
        Mon, 10 Jun 2019 11:51:58 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 68A3C3F246;
        Mon, 10 Jun 2019 11:51:57 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com
Subject: [PATCH 6/8] iommu/arm-smmu-v3: Support auxiliary domains
Date:   Mon, 10 Jun 2019 19:47:12 +0100
Message-Id: <20190610184714.6786-7-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit a3a195929d40 ("iommu: Add APIs for multiple domains per
device"), the IOMMU API gained the concept of auxiliary domains (AUXD),
which allows to control the PASID-tagged address spaces of a device. With
AUXD the PASID address space are not shared with the CPU, but are instead
modified with iommu_map() and iommu_unmap() calls on auxiliary domains.

Add auxiliary domain support to the SMMUv3 driver. Device drivers allocate
an unmanaged IOMMU domain with iommu_domain_alloc(), and attach it to the
device with iommu_aux_attach_domain().

The AUXD API is fairly permissive, and allows to attach an IOMMU domain in
both normal and auxiliary mode at the same time - one device can be
attached to the domain normally, and another device can be attached
through one of its PASIDs. To avoid excessive complexity in the SMMU
implementation we pose some restrictions on supported AUXD usage:

* A domain is either in auxiliary mode or normal mode. And that state is
  sticky. Once detached the domain has to be re-attached in the same mode.

* An auxiliary domain can have a single parent domain. Two devices can be
  attached to the same auxiliary domain only if they are attached to the
  same parent domain.

In practice these shouldn't be problematic, since we have the same kind of
restriction on normal domains and users have been able to cope so far: at
the moment a domain cannot be attached to two devices behind different
SMMUs. When VFIO puts two such devices in the same container, it simply
falls back to allocating two separate IOMMU domains.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/arm-smmu-v3.c | 276 +++++++++++++++++++++++++++++++++---
 2 files changed, 260 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 9b45f70549a7..d326fef3d3a6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -393,6 +393,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
+	select IOASID
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ_DOMAIN
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 326b71793336..633d829f246f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
+#include <linux/ioasid.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/init.h>
@@ -641,6 +642,7 @@ struct arm_smmu_master {
 	unsigned int			num_sids;
 	unsigned int			ssid_bits;
 	bool				ats_enabled		:1;
+	bool				auxd_enabled		:1;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -666,8 +668,14 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
+	/* Unused in aux domains */
 	struct list_head		devices;
 	spinlock_t			devices_lock;
+
+	/* Auxiliary domain stuff */
+	struct arm_smmu_domain		*parent;
+	ioasid_t			ssid;
+	unsigned long			aux_nr_devs;
 };
 
 struct arm_smmu_option_prop {
@@ -675,6 +683,8 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
+static DECLARE_IOASID_SET(private_ioasid);
+
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -696,6 +706,15 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct arm_smmu_master *dev_to_master(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return NULL;
+	return fwspec->iommu_priv;
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1776,13 +1795,19 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 }
 
 static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-				   int ssid, unsigned long iova, size_t size)
+				   unsigned long iova, size_t size)
 {
 	int ret = 0;
+	unsigned int ssid = 0;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
 
+	if (smmu_domain->parent) {
+		ssid = smmu_domain->ssid;
+		smmu_domain = smmu_domain->parent;
+	}
+
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
 
@@ -1935,10 +1960,12 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-		if (cfg->tables) {
+		if (cfg->tables)
 			arm_smmu_free_cd_tables(smmu_domain);
+		if (cfg->cd.asid)
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
-		}
+		if (smmu_domain->ssid)
+			ioasid_free(smmu_domain->ssid);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -1948,11 +1975,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
-static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
-	int ret;
 	int asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
@@ -1961,16 +1987,30 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
-	if (ret)
-		goto out_free_asid;
-
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
+	return 0;
+}
+
+static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master *master,
+				       struct io_pgtable_cfg *pgtbl_cfg)
+{
+	int ret;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	ret = arm_smmu_domain_finalise_cd(smmu_domain, master, pgtbl_cfg);
+	if (ret)
+		return ret;
+
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
+	if (ret)
+		goto out_free_asid;
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &smmu_domain->s1_cfg.cd);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, &cfg->cd);
 	if (ret)
 		goto out_free_table;
 	return 0;
@@ -1978,7 +2018,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 out_free_table:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
-	arm_smmu_bitmap_free(smmu->asid_map, asid);
+	arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 	return ret;
 }
 
@@ -2031,7 +2071,10 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		ias = min_t(unsigned long, ias, VA_BITS);
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
-		finalise_stage_fn = arm_smmu_domain_finalise_s1;
+		if (smmu_domain->parent)
+			finalise_stage_fn = arm_smmu_domain_finalise_cd;
+		else
+			finalise_stage_fn = arm_smmu_domain_finalise_s1;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
@@ -2177,15 +2220,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	unsigned long flags;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_master *master = dev_to_master(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_master *master;
 
-	if (!fwspec)
+	if (!master)
 		return -ENOENT;
 
-	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 
 	arm_smmu_detach_dev(master);
@@ -2213,6 +2254,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
+	} else if (smmu_domain->parent) {
+		dev_err(dev, "cannot attach auxiliary domain\n");
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
@@ -2252,7 +2297,7 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		return 0;
 
 	ret = ops->unmap(ops, iova, size);
-	if (ret && arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size))
+	if (ret && arm_smmu_atc_inv_domain(smmu_domain, iova, size))
 		return 0;
 
 	return ret;
@@ -2521,6 +2566,194 @@ static void arm_smmu_put_resv_regions(struct device *dev,
 		kfree(entry);
 }
 
+static bool arm_smmu_dev_has_feature(struct device *dev,
+				     enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_to_master(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_AUX:
+		return master->ssid_bits != 0;
+	default:
+		return false;
+	}
+}
+
+static bool arm_smmu_dev_feature_enabled(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_to_master(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_AUX:
+		return master->auxd_enabled;
+	default:
+		return false;
+	}
+}
+
+static int arm_smmu_dev_enable_feature(struct device *dev,
+				       enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_to_master(dev);
+
+	if (!arm_smmu_dev_has_feature(dev, feat))
+		return -ENODEV;
+
+	if (arm_smmu_dev_feature_enabled(dev, feat))
+		return -EBUSY;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_AUX:
+		master->auxd_enabled = true;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int arm_smmu_dev_disable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_to_master(dev);
+
+	if (!arm_smmu_dev_feature_enabled(dev, feat))
+		return -EINVAL;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_AUX:
+		/* TODO: check if aux domains are still attached? */
+		master->auxd_enabled = false;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int arm_smmu_aux_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	int ret;
+	struct iommu_domain *parent_domain;
+	struct arm_smmu_domain *parent_smmu_domain;
+	struct arm_smmu_master *master = dev_to_master(dev);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (!arm_smmu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
+		return -EINVAL;
+
+	parent_domain = iommu_get_domain_for_dev(dev);
+	if (!parent_domain)
+		return -EINVAL;
+	parent_smmu_domain = to_smmu_domain(parent_domain);
+
+	mutex_lock(&smmu_domain->init_mutex);
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1 ||
+	    parent_smmu_domain->stage != ARM_SMMU_DOMAIN_S1) {
+		ret = -EINVAL;
+		goto out_unlock;
+	} else if (smmu_domain->s1_cfg.tables) {
+		/* Already attached as a normal domain */
+		dev_err(dev, "cannot attach domain in auxiliary mode\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	} else if (!smmu_domain->smmu) {
+		ioasid_t ssid = ioasid_alloc(&private_ioasid, 1,
+					     (1UL << master->ssid_bits) - 1,
+					     NULL);
+		if (ssid == INVALID_IOASID) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		smmu_domain->smmu = master->smmu;
+		smmu_domain->parent = parent_smmu_domain;
+		smmu_domain->ssid = ssid;
+
+		ret = arm_smmu_domain_finalise(domain, master);
+		if (ret) {
+			smmu_domain->smmu = NULL;
+			smmu_domain->ssid = 0;
+			smmu_domain->parent = NULL;
+			ioasid_free(ssid);
+			goto out_unlock;
+		}
+	} else if (smmu_domain->parent != parent_smmu_domain) {
+		/* Additional restriction: an aux domain has a single parent */
+		dev_err(dev, "cannot attach aux domain with different parent\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (!smmu_domain->aux_nr_devs++)
+		arm_smmu_write_ctx_desc(parent_smmu_domain, smmu_domain->ssid,
+					&smmu_domain->s1_cfg.cd);
+	/*
+	 * Note that all other devices attached to the parent domain can now
+	 * access this context as well.
+	 */
+
+out_unlock:
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
+static void arm_smmu_aux_detach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_domain *parent_domain;
+	struct arm_smmu_domain *parent_smmu_domain;
+	struct arm_smmu_master *master = dev_to_master(dev);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (!arm_smmu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
+		return;
+
+	parent_domain = iommu_get_domain_for_dev(dev);
+	if (!parent_domain)
+		return;
+	parent_smmu_domain = to_smmu_domain(parent_domain);
+
+	mutex_lock(&smmu_domain->init_mutex);
+	if (!smmu_domain->aux_nr_devs)
+		goto out_unlock;
+
+	if (!--smmu_domain->aux_nr_devs) {
+		arm_smmu_write_ctx_desc(parent_smmu_domain, smmu_domain->ssid,
+					NULL);
+		/*
+		 * TLB doesn't need invalidation since accesses from the device
+		 * can't use this domain's ASID once the CD is clear.
+		 *
+		 * Sadly that doesn't apply to ATCs, which are PASID tagged.
+		 * Invalidate all other devices as well, because even though
+		 * they weren't 'officially' attached to the auxiliary domain,
+		 * they could have formed ATC entries.
+		 */
+		arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
+	} else {
+		struct arm_smmu_cmdq_ent cmd;
+
+		/* Invalidate only this device's ATC */
+		if (master->ats_enabled) {
+			arm_smmu_atc_inv_to_cmd(smmu_domain->ssid, 0, 0, &cmd);
+			arm_smmu_atc_inv_master(master, &cmd);
+		}
+	}
+out_unlock:
+	mutex_unlock(&smmu_domain->init_mutex);
+}
+
+static int arm_smmu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	return smmu_domain->ssid ?: -EINVAL;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2539,6 +2772,13 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
+	.dev_has_feat		= arm_smmu_dev_has_feature,
+	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
+	.dev_enable_feat	= arm_smmu_dev_enable_feature,
+	.dev_disable_feat	= arm_smmu_dev_disable_feature,
+	.aux_attach_dev		= arm_smmu_aux_attach_dev,
+	.aux_detach_dev		= arm_smmu_aux_detach_dev,
+	.aux_get_pasid		= arm_smmu_aux_get_pasid,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -3332,6 +3572,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	smmu->dev = dev;
+	/* Reserve ASID 0 for validity check */
+	set_bit(0, smmu->asid_map);
 
 	if (dev->of_node) {
 		ret = arm_smmu_device_dt_probe(pdev, smmu);
-- 
2.21.0

