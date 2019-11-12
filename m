Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F119BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DC9214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfKLGmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:42:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:61253 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfKLGmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:42:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 22:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="229240247"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2019 22:42:53 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/1] iommu/vt-d: Add Kconfig option to enable/disable scalable mode
Date:   Tue, 12 Nov 2019 14:39:54 +0800
Message-Id: <20191112063954.19371-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/Kconfig       | 12 ++++++++++++
 drivers/iommu/intel-iommu.c |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..7dd445d7ba93 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -242,6 +242,18 @@ config INTEL_IOMMU_FLOPPY_WA
 	  workaround will setup a 1:1 mapping for the first
 	  16MiB to make floppy (an ISA device) work.
 
+config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
+	prompt "Enable Intel IOMMU scalable mode by default"
+	depends on INTEL_IOMMU
+	help
+	  Selecting this option will enable by default the scalable mode if
+	  hardware presents the capability. The scalable mode is defined in
+	  VT-d 3.0. The scalable mode capability could be checked by reading
+	  /sys/devices/virtual/iommu/dmar*/intel-iommu/ecap. If this option
+	  is not selected, scalable mode support could also be enabled by
+	  passing intel_iommu=sm_on to the kernel. If not sure, please use
+	  the default value.
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

