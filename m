Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E84C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEFA2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfHOUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:10:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:43474 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733284AbfHOUJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:09:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 13:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="188596230"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 13:09:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 11/19] iommu/vt-d: Add custom allocator for IOASID
Date:   Thu, 15 Aug 2019 13:13:17 -0700
Message-Id: <1565900005-62508-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VT-d driver runs in the guest, PASID allocation must be
performed via virtual command interface. This patch registers a
custom IOASID allocator which takes precedence over the default
XArray based allocator. The resulting IOASID allocation will always
come from the host. This ensures that PASID namespace is system-
wide.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-iommu.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 70 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0ade8a0..d5ca821 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -210,6 +210,7 @@ config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
 	select PCI_PASID
+	select IOASID
 	select MMU_NOTIFIER
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bdaed2d..b15ec58 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1693,6 +1693,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
+	ioasid_unregister_allocator(&iommu->pasid_allocator);
+
 #endif
 }
 
@@ -4619,6 +4621,46 @@ static int __init probe_acpi_namespace_devices(void)
 	return 0;
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
+{
+	struct intel_iommu *iommu = data;
+	ioasid_t ioasid;
+
+	/*
+	 * VT-d virtual command interface always uses the full 20 bit
+	 * PASID range. Host can partition guest PASID range based on
+	 * policies but it is out of guest's control.
+	 */
+	if (min < PASID_MIN || max > PASID_MAX)
+		return INVALID_IOASID;
+
+	if (vcmd_alloc_pasid(iommu, &ioasid))
+		return INVALID_IOASID;
+
+	return ioasid;
+}
+
+static void intel_ioasid_free(ioasid_t ioasid, void *data)
+{
+	struct iommu_pasid_alloc_info *svm;
+	struct intel_iommu *iommu = data;
+
+	if (!iommu)
+		return;
+	/*
+	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
+	 * We can only free the PASID when all the devices are unbond.
+	 */
+	svm = ioasid_find(NULL, ioasid, NULL);
+	if (!svm) {
+		pr_warn("Freeing unbond IOASID %d\n", ioasid);
+		return;
+	}
+	vcmd_free_pasid(iommu, ioasid);
+}
+#endif
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
@@ -4722,6 +4764,31 @@ int __init intel_iommu_init(void)
 				       "%s", iommu->name);
 		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
 		iommu_device_register(&iommu->iommu);
+#ifdef CONFIG_INTEL_IOMMU_SVM
+		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
+			/*
+			 * Register a custom ASID allocator if we are running
+			 * in a guest, the purpose is to have a system wide PASID
+			 * namespace among all PASID users.
+			 * There can be multiple vIOMMUs in each guest but only
+			 * one allocator is active. All vIOMMU allocators will
+			 * eventually be calling the same host allocator.
+			 */
+			iommu->pasid_allocator.alloc = intel_ioasid_alloc;
+			iommu->pasid_allocator.free = intel_ioasid_free;
+			iommu->pasid_allocator.pdata = (void *)iommu;
+			ret = ioasid_register_allocator(&iommu->pasid_allocator);
+			if (ret) {
+				pr_warn("Custom PASID allocator registeration failed\n");
+				/*
+				 * Disable scalable mode on this IOMMU if there
+				 * is no custom allocator. Mixing SM capable vIOMMU
+				 * and non-SM vIOMMU are not supported.
+				 */
+				intel_iommu_sm = 0;
+			}
+		}
+#endif
 	}
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 37fb0c9..80318c5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
+#include <linux/ioasid.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -543,6 +544,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
-- 
2.7.4

