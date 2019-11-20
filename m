Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56053C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293A12240A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfKTGN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:13:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:13895 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKTGN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:13:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 22:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,220,1571727600"; 
   d="scan'208";a="218501484"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2019 22:13:27 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove incorrect PSI capability check
Date:   Wed, 20 Nov 2019 14:10:16 +0800
Message-Id: <20191120061016.31386-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSI (Page Selective Invalidation) bit in the capability register
is only valid for second-level translation. Intel IOMMU supporting
scalable mode must support page/address selective IOTLB invalidation
for first-level translation. Remove the PSI capability check in SVA
cache invalidation code.

Fixes: 8744daf4b0699 ("iommu/vt-d: Remove global page flush support")
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 9b159132405d..dca88f9fdf29 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -104,11 +104,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 {
 	struct qi_desc desc;
 
-	/*
-	 * Do PASID granu IOTLB invalidation if page selective capability is
-	 * not available.
-	 */
-	if (pages == -1 || !cap_pgsel_inv(svm->iommu->cap)) {
+	if (pages == -1) {
 		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
 			QI_EIOTLB_DID(sdev->did) |
 			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-- 
2.17.1

