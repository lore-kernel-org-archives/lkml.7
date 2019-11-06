Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB96C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98E5217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfKFFOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:14:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:5882 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfKFFOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:14:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 21:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="227371766"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2019 21:14:44 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Add Kconfig option to enable/disable scalable mode
Date:   Wed,  6 Nov 2019 13:11:30 +0800
Message-Id: <20191106051130.485-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a Kconfig option INTEL_IOMMU_SCALABLE_MODE_ON to make
it easier for distributions to enable or disable the Intel IOMMU
scalable mode during kernel build.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Kconfig       | 10 ++++++++++
 drivers/iommu/intel-iommu.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..32f30e27791c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -242,6 +242,16 @@ config INTEL_IOMMU_FLOPPY_WA
 	  workaround will setup a 1:1 mapping for the first
 	  16MiB to make floppy (an ISA device) work.
 
+config INTEL_IOMMU_SCALABLE_MODE_ON
+	def_bool n
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
index 0f2f7124c1ca..545eb3b5c083 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -357,7 +357,12 @@ int dmar_disabled = 0;
 int dmar_disabled = 1;
 #endif /*CONFIG_INTEL_IOMMU_DEFAULT_ON*/
 
+#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_ON
+int intel_iommu_sm = 1;
+#else
 int intel_iommu_sm;
+#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_ON */
+
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
-- 
2.17.1

