Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED8C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CDD21019
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfKIDni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:43:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:46233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfKIDni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:43:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 19:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="228378624"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2019 19:43:36 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable scalable mode
Date:   Sat,  9 Nov 2019 11:40:39 +0800
Message-Id: <20191109034039.27964-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Kconfig option INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
to make it easier for distributions to enable or disable the
Intel IOMMU scalable mode by default during kernel build.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Kconfig       | 9 +++++++++
 drivers/iommu/intel-iommu.c | 7 ++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..fbdf3fd291d9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -242,6 +242,15 @@ config INTEL_IOMMU_FLOPPY_WA
 	  workaround will setup a 1:1 mapping for the first
 	  16MiB to make floppy (an ISA device) work.
 
+config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
+	prompt "Enable Intel IOMMU scalable mode by default"
+	depends on INTEL_IOMMU
+	help
+	  Selecting this option will enable the scalable mode if
+	  hardware presents the capability. If this option is not
+	  selected, scalable mode support could also be enabled
+	  by passing intel_iommu=sm_on to the kernel.
+
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6db6d969e31c..6051fe790c61 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -355,9 +355,14 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 int dmar_disabled = 0;
 #else
 int dmar_disabled = 1;
-#endif /*CONFIG_INTEL_IOMMU_DEFAULT_ON*/
+#endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
 
+#ifdef INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
+int intel_iommu_sm = 1;
+#else
 int intel_iommu_sm;
+#endif /* INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
+
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
-- 
2.17.1

