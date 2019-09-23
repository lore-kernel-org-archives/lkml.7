Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232C1217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfIWM1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:27:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:4334 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfIWM1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:27:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 05:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="203116661"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2019 05:27:19 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Yi Sun <yi.y.sun@linux.intel.com>
Subject: [RFC PATCH 1/4] iommu/vt-d: Move domain_flush_cache helper into header
Date:   Mon, 23 Sep 2019 20:24:51 +0800
Message-Id: <20190923122454.9888-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923122454.9888-1-baolu.lu@linux.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that it could be used in other source files as well.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 7 -------
 include/linux/intel-iommu.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5aa68a094efd..9cfe8098d993 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -828,13 +828,6 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 	return iommu;
 }
 
-static void domain_flush_cache(struct dmar_domain *domain,
-			       void *addr, int size)
-{
-	if (!domain->iommu_coherency)
-		clflush_cache_range(addr, size);
-}
-
 static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	struct context_entry *context;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ed11ef594378..3ee694d4f361 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -629,6 +629,13 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
+static inline void
+domain_flush_cache(struct dmar_domain *domain, void *addr, int size)
+{
+	if (!domain->iommu_coherency)
+		clflush_cache_range(addr, size);
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
-- 
2.17.1

