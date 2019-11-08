Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD478FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87086214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573226201;
	bh=pBm1YXFDvxPU3sKF0zgOf7PpNkkB3o04Q4UnqClU90o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlsqKvAJnEHmMRfQY4xuuGauqycHHtexmdAaGLMd5EX7BpCcO9yRbDKuTQiJQqbOD
	 YRemMWj6f6x1GZXV/5qeiAdYvjnZ5rB53JqoUjzRAtEhVdyUbww0zAPvJWHZ1Ft4qH
	 7rYGLalfbrmfgIfjOFQV5h7v1cOBfL6/OP9nkxG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKHPQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfKHPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:39 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 469CB222CB;
        Fri,  8 Nov 2019 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226198;
        bh=pBm1YXFDvxPU3sKF0zgOf7PpNkkB3o04Q4UnqClU90o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzEyX3q+r8kMKcyIWgYvu9SBnq8hWtBtESe0Vemq6qnzwk0VVAd2n8cAnt1kngDxo
         oj0RvZcyiLsq47IhYK+huVXuDqvLDrtLoS8XsionNnwRmrb1DzlAoRqssbT2ZcPRVI
         OadT+6ZLURANMDXnP6vpFPD0LqlHCMoQf0gVGsEA=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 9/9] iommu/arm-smmu: Allow building as a module
Date:   Fri,  8 Nov 2019 15:16:08 +0000
Message-Id: <20191108151608.20932-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108151608.20932-1-will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By conditionally dropping support for the legacy binding and exporting
the newly introduced 'arm_smmu_impl_init()' function we can allow the
ARM SMMU driver to be built as a module.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/Kconfig    | 14 +++++++++-
 drivers/iommu/Makefile   |  3 ++-
 drivers/iommu/arm-smmu.c | 55 ++++++++++++++++++++++++----------------
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 7583d47fc4d5..fc55f7ba0d18 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -350,7 +350,7 @@ config SPAPR_TCE_IOMMU
 
 # ARM IOMMU support
 config ARM_SMMU
-	bool "ARM Ltd. System MMU (SMMU) Support"
+	tristate "ARM Ltd. System MMU (SMMU) Support"
 	depends on (ARM64 || ARM) && MMU
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
@@ -362,6 +362,18 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_LEGACY_DT_BINDINGS
+	bool "Support the legacy \"mmu-masters\" devicetree bindings"
+	depends on ARM_SMMU=y && OF
+	help
+	  Support for the badly designed and deprecated "mmu-masters"
+	  devicetree bindings. This allows some DMA masters to attach
+	  to the SMMU but does not provide any support via the DMA API.
+	  If you're lucky, you might be able to get VFIO up and running.
+
+	  If you say Y here then you'll make me very sad. Instead, say N
+	  and move your firmware to the utopian future that was 2016.
+
 config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	bool "Default to disabling bypass on ARM SMMU v1 and v2"
 	depends on ARM_SMMU
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 4f405f926e73..b52a03d87fc3 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -13,7 +13,8 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o
+obj-$(CONFIG_ARM_SMMU) += arm-smmu-mod.o
+arm-smmu-mod-objs += arm-smmu.o arm-smmu-impl.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 53bbe0663b9e..9eb52410d016 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -125,6 +125,12 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct platform_driver arm_smmu_driver;
+static struct iommu_ops arm_smmu_ops;
+
+#ifdef CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS
+static void arm_smmu_bus_init(void);
+
 static struct device_node *dev_get_dev_node(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
@@ -160,9 +166,6 @@ static int __find_legacy_master_phandle(struct device *dev, void *data)
 	return err == -ENOENT ? 0 : err;
 }
 
-static struct platform_driver arm_smmu_driver;
-static struct iommu_ops arm_smmu_ops;
-
 static int arm_smmu_register_legacy_master(struct device *dev,
 					   struct arm_smmu_device **smmu)
 {
@@ -214,6 +217,27 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	return err;
 }
 
+/*
+ * With the legacy DT binding in play, we have no guarantees about
+ * probe order, but then we're also not doing default domains, so we can
+ * delay setting bus ops until we're sure every possible SMMU is ready,
+ * and that way ensure that no add_device() calls get missed.
+ */
+static int arm_smmu_legacy_bus_init(void)
+{
+	if (using_legacy_binding)
+		arm_smmu_bus_init();
+	return 0;
+}
+device_initcall_sync(arm_smmu_legacy_bus_init);
+#else
+static int arm_smmu_register_legacy_master(struct device *dev,
+					   struct arm_smmu_device **smmu)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS */
+
 static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
 	int idx;
@@ -1566,6 +1590,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.owner			= THIS_MODULE,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
@@ -1960,8 +1985,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 
 	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
 	if (legacy_binding && !using_generic_binding) {
-		if (!using_legacy_binding)
-			pr_notice("deprecated \"mmu-masters\" DT property in use; DMA API support unavailable\n");
+		if (!using_legacy_binding) {
+			pr_notice("deprecated \"mmu-masters\" DT property in use; %s support unavailable\n",
+				  IS_ENABLED(CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS) ? "DMA API" : "SMMU");
+		}
 		using_legacy_binding = true;
 	} else if (!legacy_binding && !using_legacy_binding) {
 		using_generic_binding = true;
@@ -1986,10 +2013,8 @@ static void arm_smmu_bus_init(void)
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 #endif
 #ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		pci_request_acs();
+	if (!iommu_present(&pci_bus_type))
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
-	}
 #endif
 #ifdef CONFIG_FSL_MC_BUS
 	if (!iommu_present(&fsl_mc_bus_type))
@@ -2147,20 +2172,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * With the legacy DT binding in play, though, we have no guarantees about
- * probe order, but then we're also not doing default domains, so we can
- * delay setting bus ops until we're sure every possible SMMU is ready,
- * and that way ensure that no add_device() calls get missed.
- */
-static int arm_smmu_legacy_bus_init(void)
-{
-	if (using_legacy_binding)
-		arm_smmu_bus_init();
-	return 0;
-}
-device_initcall_sync(arm_smmu_legacy_bus_init);
-
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

