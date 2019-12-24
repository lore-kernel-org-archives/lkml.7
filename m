Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD9C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfLXHqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:46:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:49687 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfLXHq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:46:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 23:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; 
   d="scan'208";a="223177094"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 23:46:24 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, yi.y.sun@intel.com,
        Peter Xu <peterx@redhat.com>, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 7/9] iommu/vt-d: Update first level super page capability
Date:   Tue, 24 Dec 2019 15:45:00 +0800
Message-Id: <20191224074502.5545-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224074502.5545-1-baolu.lu@linux.intel.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First-level translation may map input addresses to 4-KByte pages,
2-MByte pages, or 1-GByte pages. Support for 4-KByte pages and
2-Mbyte pages are mandatory for first-level translation. Hardware
support for 1-GByte page is reported through the FL1GP field in
the Capability Register.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1ebf5ed460cf..34e619318f64 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -685,11 +685,12 @@ static int domain_update_iommu_snooping(struct intel_iommu *skip)
 	return ret;
 }
 
-static int domain_update_iommu_superpage(struct intel_iommu *skip)
+static int domain_update_iommu_superpage(struct dmar_domain *domain,
+					 struct intel_iommu *skip)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	int mask = 0xf;
+	int mask = 0x3;
 
 	if (!intel_iommu_superpage) {
 		return 0;
@@ -699,7 +700,13 @@ static int domain_update_iommu_superpage(struct intel_iommu *skip)
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
 		if (iommu != skip) {
-			mask &= cap_super_page_val(iommu->cap);
+			if (domain && domain_use_first_level(domain)) {
+				if (!cap_fl1gp_support(iommu->cap))
+					mask = 0x1;
+			} else {
+				mask &= cap_super_page_val(iommu->cap);
+			}
+
 			if (!mask)
 				break;
 		}
@@ -714,7 +721,7 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
 	domain->iommu_snooping = domain_update_iommu_snooping(NULL);
-	domain->iommu_superpage = domain_update_iommu_superpage(NULL);
+	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -4604,7 +4611,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 			iommu->name);
 		return -ENXIO;
 	}
-	sp = domain_update_iommu_superpage(iommu) - 1;
+	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
 	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
 		pr_warn("%s: Doesn't support large page.\n",
 			iommu->name);
-- 
2.17.1

