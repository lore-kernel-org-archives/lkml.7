Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0713CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E1E227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLSFT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:19:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:30641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfLSFTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:19:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 21:19:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="213131740"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 18 Dec 2019 21:19:52 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Loose requirement for flush queue initializaton
Date:   Thu, 19 Dec 2019 13:18:51 +0800
Message-Id: <20191219051851.25159-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219051851.25159-1-baolu.lu@linux.intel.com>
References: <20191219051851.25159-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if flush queue initialization fails, we return error
or enforce the system-wide strict mode. These are unnecessary
because we always check the existence of a flush queue before
queuing any iova's for lazy flushing. Printing a informational
message is enough.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 93e1d7c3ac7c..65eee8cf6d59 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1854,15 +1854,15 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 {
 	int adjust_width, agaw;
 	unsigned long sagaw;
-	int err;
+	int ret;
 
 	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 
 	if (!intel_iommu_strict) {
-		err = init_iova_flush_queue(&domain->iovad,
+		ret = init_iova_flush_queue(&domain->iovad,
 					    iommu_flush_iova, iova_entry_free);
-		if (err)
-			return err;
+		if (ret)
+			pr_info("iova flush queue initialization failed\n");
 	}
 
 	domain_reserve_special_ranges(domain);
@@ -5222,10 +5222,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			ret = init_iova_flush_queue(&dmar_domain->iovad,
 						    iommu_flush_iova,
 						    iova_entry_free);
-			if (ret) {
-				pr_warn("iova flush queue initialization failed\n");
-				intel_iommu_strict = 1;
-			}
+			if (ret)
+				pr_info("iova flush queue initialization failed\n");
 		}
 
 		domain_update_iommu_cap(dmar_domain);
-- 
2.17.1

