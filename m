Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C57C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01A22231A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKSRwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:52:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:14025 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfKSRwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:52:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 09:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="209488272"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 19 Nov 2019 09:51:58 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 2/8] iommu/vt-d: Match CPU and IOMMU paging mode
Date:   Tue, 19 Nov 2019 09:56:26 -0800
Message-Id: <1574186193-30457-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting up first level page tables for sharing with CPU, we need
to ensure IOMMU can support no less than the levels supported by the
CPU.

It is not adequate, as in the current code, to set up 5-level paging
in PASID entry First Level Paging Mode(FLPM) solely based on CPU.

Currently, intel_pasid_setup_first_level() is only used by native SVM
code which already checks paging mode matches. However, future use of
this helper function may not be limited to native SVM.
https://lkml.org/lkml/2019/11/18/1037

Fixes: 437f35e1cd4c8 ("iommu/vt-d: Add first level page table
interface")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 040a445be300..e7cb0b8a7332 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -499,8 +499,16 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	}
 
 #ifdef CONFIG_X86
-	if (cpu_feature_enabled(X86_FEATURE_LA57))
-		pasid_set_flpm(pte, 1);
+	/* Both CPU and IOMMU paging mode need to match */
+	if (cpu_feature_enabled(X86_FEATURE_LA57)) {
+		if (cap_5lp_support(iommu->cap)) {
+			pasid_set_flpm(pte, 1);
+		} else {
+			pr_err("VT-d has no 5-level paging support for CPU\n");
+			pasid_clear_entry(pte);
+			return -EINVAL;
+		}
+	}
 #endif /* CONFIG_X86 */
 
 	pasid_set_domain_id(pte, did);
-- 
2.7.4

