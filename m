Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4014E2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDLEc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:32:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:12394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDLEc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:32:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 21:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="142097063"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2019 21:32:26 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Flush IOTLB for untrusted device in time
Date:   Fri, 12 Apr 2019 12:26:13 +0800
Message-Id: <20190412042613.20257-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, for performance consideration, Intel IOMMU
driver won't flush IOTLB immediately after a buffer is
unmapped. It schedules a thread and flushes IOTLB in a
batched mode. This isn't suitable for untrusted device
since it still can access the memory even if it isn't
supposed to do so.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c137f0f2cf49..3d504b685dd8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3732,10 +3732,14 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	unsigned long iova_pfn;
 	struct intel_iommu *iommu;
 	struct page *freelist;
+	struct pci_dev *pdev = NULL;
 
 	if (iommu_no_mapping(dev))
 		return;
 
+	if (dev_is_pci(dev))
+		pdev = to_pci_dev(dev);
+
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
@@ -3751,7 +3755,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 
 	freelist = domain_unmap(domain, start_pfn, last_pfn);
 
-	if (intel_iommu_strict) {
+	if (intel_iommu_strict || (pdev && pdev->untrusted)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      nrpages, !freelist, 0);
 		/* free iova */
-- 
2.17.1

