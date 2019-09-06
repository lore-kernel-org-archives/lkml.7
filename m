Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7CCC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DC620842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 06:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391508AbfIFGQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:16:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:4005 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbfIFGQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:16:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 23:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="383159368"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2019 23:16:38 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v9 3/5] iommu/vt-d: Don't switch off swiotlb if bounce page is used
Date:   Fri,  6 Sep 2019 14:14:50 +0800
Message-Id: <20190906061452.30791-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906061452.30791-1-baolu.lu@linux.intel.com>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bounce page implementation depends on swiotlb. Hence, don't
switch off swiotlb if the system has untrusted devices or could
potentially be hot-added with any untrusted devices.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-iommu.c | 32 +++++++++++++++++---------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e15cdcd8cb3c..a4ddeade8ac4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -182,6 +182,7 @@ config INTEL_IOMMU
 	select IOMMU_IOVA
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
+	select SWIOTLB
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e12aa73008df..34e1265bb2ad 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4576,22 +4576,20 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static int __init platform_optin_force_iommu(void)
+static inline bool has_untrusted_dev(void)
 {
 	struct pci_dev *pdev = NULL;
-	bool has_untrusted_dev = false;
 
-	if (!dmar_platform_optin() || no_platform_optin)
-		return 0;
+	for_each_pci_dev(pdev)
+		if (pdev->untrusted)
+			return true;
 
-	for_each_pci_dev(pdev) {
-		if (pdev->untrusted) {
-			has_untrusted_dev = true;
-			break;
-		}
-	}
+	return false;
+}
 
-	if (!has_untrusted_dev)
+static int __init platform_optin_force_iommu(void)
+{
+	if (!dmar_platform_optin() || no_platform_optin || !has_untrusted_dev())
 		return 0;
 
 	if (no_iommu || dmar_disabled)
@@ -4605,9 +4603,6 @@ static int __init platform_optin_force_iommu(void)
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
 	dmar_disabled = 0;
-#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	swiotlb = 0;
-#endif
 	no_iommu = 0;
 
 	return 1;
@@ -4747,7 +4742,14 @@ int __init intel_iommu_init(void)
 	up_write(&dmar_global_lock);
 
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	swiotlb = 0;
+	/*
+	 * If the system has no untrusted device or the user has decided
+	 * to disable the bounce page mechanisms, we don't need swiotlb.
+	 * Mark this and the pre-allocated bounce pages will be released
+	 * later.
+	 */
+	if (!has_untrusted_dev() || intel_no_bounce)
+		swiotlb = 0;
 #endif
 	dma_ops = &intel_dma_ops;
 
-- 
2.17.1

