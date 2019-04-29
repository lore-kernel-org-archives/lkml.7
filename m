Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 01:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACE920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 01:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfD2BW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 21:22:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:8356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfD2BW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 21:22:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 18:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,407,1549958400"; 
   d="scan'208";a="146630198"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2019 18:22:25 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Cleanup: no spaces at the start of a line
Date:   Mon, 29 Apr 2019 09:16:02 +0800
Message-Id: <20190429011602.17625-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the whitespaces at the start of a line with tabs. No
functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 53 +++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c1f2f83e25d2..e0c0febc6fa5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2341,32 +2341,33 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 }
 
 static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-                         struct scatterlist *sg, unsigned long phys_pfn,
-                         unsigned long nr_pages, int prot)
-{
-       int ret;
-       struct intel_iommu *iommu;
-
-       /* Do the real mapping first */
-       ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
-       if (ret)
-               return ret;
-
-       /* Notify about the new mapping */
-       if (domain_type_is_vm(domain)) {
-	       /* VM typed domains can have more than one IOMMUs */
-	       int iommu_id;
-	       for_each_domain_iommu(iommu_id, domain) {
-		       iommu = g_iommus[iommu_id];
-		       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
-	       }
-       } else {
-	       /* General domains only have one IOMMU */
-	       iommu = domain_get_iommu(domain);
-	       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
-       }
+			  struct scatterlist *sg, unsigned long phys_pfn,
+			  unsigned long nr_pages, int prot)
+{
+	int ret;
+	struct intel_iommu *iommu;
+
+	/* Do the real mapping first */
+	ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
+	if (ret)
+		return ret;
 
-       return 0;
+	/* Notify about the new mapping */
+	if (domain_type_is_vm(domain)) {
+		/* VM typed domains can have more than one IOMMUs */
+		int iommu_id;
+
+		for_each_domain_iommu(iommu_id, domain) {
+			iommu = g_iommus[iommu_id];
+			__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+		}
+	} else {
+		/* General domains only have one IOMMU */
+		iommu = domain_get_iommu(domain);
+		__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+	}
+
+	return 0;
 }
 
 static inline int domain_sg_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
@@ -4098,7 +4099,7 @@ static int init_iommu_hw(void)
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
-	
+
 		iommu_flush_write_buffer(iommu);
 
 		iommu_set_root_entry(iommu);
-- 
2.17.1

