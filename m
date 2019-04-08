Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B00F2148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfDHX51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:57:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:63288 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfDHX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169966"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:07 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org
Subject: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
Date:   Mon,  8 Apr 2019 16:59:25 -0700
Message-Id: <1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VT-d driver runs in the guest, PASID allocation must be
performed via virtual command interface. This patch register a
custom IOASID allocator which takes precedence over the default
IDR based allocator. The resulting IOASID allocation will always
come from the host. This ensures that PASID namespace is system-
wide.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  1 +
 2 files changed, 51 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28cb713..a38d774 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4820,6 +4820,42 @@ static int __init platform_optin_force_iommu(void)
 	return 1;
 }
 
+static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
+{
+	struct intel_iommu *iommu = data;
+	ioasid_t ioasid;
+
+	if (vcmd_alloc_pasid(iommu, &ioasid))
+		return INVALID_IOASID;
+	return ioasid;
+}
+
+static int intel_ioasid_free(ioasid_t ioasid, void *data)
+{
+	struct iommu_pasid_alloc_info *svm;
+	struct intel_iommu *iommu = data;
+
+	if (!iommu || !cap_caching_mode(iommu->cap))
+		return -EINVAL;
+	/*
+	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
+	 * We can only free the PASID when all the devices are unbond.
+	 */
+	svm = ioasid_find(NULL, ioasid, NULL);
+	if (!svm) {
+		pr_warn("Freeing unbond IOASID %d\n", ioasid);
+		return -EBUSY;
+	}
+	vcmd_free_pasid(iommu, ioasid);
+
+	return 0;
+}
+
+static struct ioasid_allocator intel_iommu_ioasid_allocator = {
+	.alloc = intel_ioasid_alloc,
+	.free = intel_ioasid_free,
+};
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
@@ -4921,6 +4957,20 @@ int __init intel_iommu_init(void)
 				       "%s", iommu->name);
 		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
 		iommu_device_register(&iommu->iommu);
+		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
+			/*
+			 * Register a custom ASID allocator if we are running
+			 * in a guest, the purpose is to have a system wide PASID
+			 * namespace among all PASID users.
+			 * Note that only one vIOMMU in each guest is supported.
+			 */
+			intel_iommu_ioasid_allocator.pdata = (void *)iommu;
+			ret = ioasid_set_allocator(&intel_iommu_ioasid_allocator);
+			if (ret == -EBUSY) {
+				pr_info("Custom IOASID allocator already registered\n");
+				break;
+			}
+		}
 	}
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b29c85c..bc09d80 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -31,6 +31,7 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
+#include <linux/ioasid.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
-- 
2.7.4

