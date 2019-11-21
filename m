Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7591DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6862068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKUVWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:22:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:19234 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfKUVV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:21:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 13:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="210224382"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2019 13:21:55 -0800
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
Subject: [PATCH v4 5/8] iommu/vt-d: Fix off-by-one in PASID allocation
Date:   Thu, 21 Nov 2019 13:26:25 -0800
Message-Id: <1574371588-65634-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574371588-65634-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1574371588-65634-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PASID allocator uses IDR which is exclusive for the end of the
allocation range. There is no need to decrement pasid_max.

Fixes: af39507305fb ("iommu/vt-d: Apply global PASID in SVA")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 74df10a39dfc..e90d0b914afe 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -338,7 +338,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
 		ret = intel_pasid_alloc_id(svm,
 					   !!cap_caching_mode(iommu->cap),
-					   pasid_max - 1, GFP_KERNEL);
+					   pasid_max, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
 			kfree(sdev);
-- 
2.7.4

