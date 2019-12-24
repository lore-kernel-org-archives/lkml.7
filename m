Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76FCC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835112075B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLXHqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 02:46:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:49687 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfLXHq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:46:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 23:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; 
   d="scan'208";a="223177100"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 23:46:26 -0800
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
Subject: [PATCH v5 8/9] iommu/vt-d: Use iova over first level
Date:   Tue, 24 Dec 2019 15:45:01 +0800
Message-Id: <20191224074502.5545-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224074502.5545-1-baolu.lu@linux.intel.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we make all map/unmap paths support first level page table.
Let's turn it on if hardware supports scalable mode.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 34e619318f64..51d60bad0b1d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1770,15 +1770,13 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 
 /*
  * Check and return whether first level is used by default for
- * DMA translation. Currently, we make it off by setting
- * first_level_support = 0, and will change it to -1 after all
- * map/unmap paths support first level page table.
+ * DMA translation.
  */
 static bool first_level_by_default(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	static int first_level_support = 0;
+	static int first_level_support = -1;
 
 	if (likely(first_level_support != -1))
 		return first_level_support;
-- 
2.17.1

