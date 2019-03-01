Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98472C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A51218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfCAD2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:28:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:46930 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731068AbfCAD2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:28:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 19:28:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="137175155"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2019 19:28:42 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 4/4] iommu/vt-d: Get domain ID before clear pasid entry
Date:   Fri,  1 Mar 2019 11:23:13 +0800
Message-Id: <20190301032313.9311-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After tearing down a pasid entry, the domain id is used to
invalidate the translation caches. Retrieve the domain id
from the pasid entry value before clearing the pasid entry.
Otherwise, we will always use domain id 0.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Fixes: 6f7db75e1c469 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 53fe5248d8f1..03b12d2ee213 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -466,8 +466,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 	if (WARN_ON(!pte))
 		return;
 
-	intel_pasid_clear_entry(dev, pasid);
 	did = pasid_get_domain_id(pte);
+	intel_pasid_clear_entry(dev, pasid);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
-- 
2.17.1

