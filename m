Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61AAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A0B2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKRTiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:38:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:60276 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfKRTiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:38:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 11:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="380760859"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2019 11:37:59 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 05/10] iommu/vt-d: Avoid duplicated code for PASID setup
Date:   Mon, 18 Nov 2019 11:42:28 -0800
Message-Id: <1574106153-45867-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After each setup for PASID entry, related translation caches must be
flushed. We can combine duplicated code into one function which is less
error prone.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 48 +++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index e7cb0b8a7332..732bfee228df 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -465,6 +465,21 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
+static void pasid_flush_caches(struct intel_iommu *iommu,
+				struct pasid_entry *pte,
+				int pasid, u16 did)
+{
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	if (cap_caching_mode(iommu->cap)) {
+		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+		iotlb_invalidation_with_pasid(iommu, did, pasid);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+}
+
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -518,16 +533,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, 1);
 	pasid_set_present(pte);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(pte, sizeof(*pte));
-
-	if (cap_caching_mode(iommu->cap)) {
-		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
+	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
 }
@@ -591,16 +597,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	 */
 	pasid_set_sre(pte);
 	pasid_set_present(pte);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(pte, sizeof(*pte));
-
-	if (cap_caching_mode(iommu->cap)) {
-		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
+	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
 }
@@ -634,16 +631,7 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	 */
 	pasid_set_sre(pte);
 	pasid_set_present(pte);
-
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(pte, sizeof(*pte));
-
-	if (cap_caching_mode(iommu->cap)) {
-		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
+	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
 }
-- 
2.7.4

