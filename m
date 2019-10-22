Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113BDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E670D20700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbfJVXtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:49:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:28707 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389849AbfJVXtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:49:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="191652637"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2019 16:49:03 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 04/10] iommu/vt-d: Move domain helper to header
Date:   Tue, 22 Oct 2019 16:53:17 -0700
Message-Id: <1571788403-42095-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move domain helper to header to be used by SVA code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 6 ------
 include/linux/intel-iommu.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 72febcf2c48f..89a976c21f55 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -428,12 +428,6 @@ static void init_translation_status(struct intel_iommu *iommu)
 		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
 }
 
-/* Convert generic 'struct iommu_domain to private struct dmar_domain */
-static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct dmar_domain, domain);
-}
-
 static int __init intel_iommu_setup(char *str)
 {
 	if (!str)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fb1973a761c1..4ed2ce3341a5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -590,6 +590,12 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+/* Convert generic struct iommu_domain to private struct dmar_domain */
+static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct dmar_domain, domain);
+}
+
 /*
  * 0: readable
  * 1: writable
-- 
2.7.4

