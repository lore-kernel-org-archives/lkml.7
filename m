Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EAFC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8782184E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEYFsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:48:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfEYFsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:51 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:48 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/15] iommu/vt-d: Implement apply_resv_region iommu ops entry
Date:   Sat, 25 May 2019 13:41:23 +0800
Message-Id: <20190525054136.27810-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Sewart <jamessewart@arista.com>

Used by iommu.c before creating identity mappings for reserved
ranges to ensure dma-ops won't ever remap these ranges.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5809185750b4..4d0fa3097f5d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5588,6 +5588,19 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	return ret;
 }
 
+static void intel_iommu_apply_resv_region(struct device *dev,
+					  struct iommu_domain *domain,
+					  struct iommu_resv_region *region)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long start, end;
+
+	start = IOVA_PFN(region->start);
+	end   = IOVA_PFN(region->start + region->length - 1);
+
+	WARN_ON_ONCE(!reserve_iova(&dmar_domain->iovad, start, end));
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 {
@@ -5753,6 +5766,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
-- 
2.17.1

