Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF4BC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6AE21848
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfEYFtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfEYFs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:59 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 06/15] iommu/vt-d: Delegate the identity domain to upper layer
Date:   Sat, 25 May 2019 13:41:27 +0800
Message-Id: <20190525054136.27810-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the iommu generic layer to allocate an identity domain
and attach it to a device. Hence, the identity domain is delegated
to upper layer. As a side effect, iommu_identity_mapping can't be
used to check the existence of identity domains any more.

Signed-off-by: James Sewart <jamessewart@arista.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 90 ++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e1663af4e01b..907f9323921d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -349,6 +349,7 @@ static void domain_context_clear(struct intel_iommu *iommu,
 				 struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
+static bool device_is_rmrr_locked(struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
 int dmar_disabled = 0;
@@ -2835,7 +2836,9 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
 {
-	int nid, ret;
+	struct dmar_rmrr_unit *rmrr;
+	struct device *dev;
+	int i, nid, ret;
 
 	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
 	if (!si_domain)
@@ -2846,8 +2849,6 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 	}
 
-	pr_debug("Identity mapping domain allocated\n");
-
 	if (hw)
 		return 0;
 
@@ -2863,6 +2864,31 @@ static int __init si_domain_init(int hw)
 		}
 	}
 
+	/*
+	 * Normally we use DMA domains for devices which have RMRRs. But we
+	 * loose this requirement for graphic and usb devices. Identity map
+	 * the RMRRs for graphic and USB devices so that they could use the
+	 * si_domain.
+	 */
+	for_each_rmrr_units(rmrr) {
+		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
+					  i, dev) {
+			unsigned long long start = rmrr->base_address;
+			unsigned long long end = rmrr->end_address;
+
+			if (device_is_rmrr_locked(dev))
+				continue;
+
+			if (WARN_ON(end < start ||
+				    end >> agaw_to_width(si_domain->agaw)))
+				continue;
+
+			ret = iommu_domain_identity_map(si_domain, start, end);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -2870,9 +2896,6 @@ static int identity_mapping(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	if (likely(!iommu_identity_mapping))
-		return 0;
-
 	info = dev->archdata.iommu;
 	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
 		return (info->domain == si_domain);
@@ -3459,11 +3482,9 @@ static int __init init_dmars(void)
 
 	check_tylersburg_isoch();
 
-	if (iommu_identity_mapping) {
-		ret = si_domain_init(hw_pass_through);
-		if (ret)
-			goto free_iommu;
-	}
+	ret = si_domain_init(hw_pass_through);
+	if (ret)
+		goto free_iommu;
 
 
 	/*
@@ -3656,9 +3677,6 @@ static bool iommu_need_mapping(struct device *dev)
 	if (iommu_dummy(dev))
 		return false;
 
-	if (!iommu_identity_mapping)
-		return true;
-
 	found = identity_mapping(dev);
 	if (found) {
 		if (iommu_should_identity_map(dev, 0))
@@ -5071,32 +5089,40 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
 
-	dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
-	if (!dmar_domain) {
-		pr_err("Can't allocate dmar_domain\n");
-		return NULL;
-	}
-	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		pr_err("Domain initialization failed\n");
-		domain_exit(dmar_domain);
+		domain = &dmar_domain->domain;
+		domain->geometry.aperture_start = 0;
+		domain->geometry.aperture_end   =
+				__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+		domain->geometry.force_aperture = true;
+
+		return domain;
+	case IOMMU_DOMAIN_IDENTITY:
+		return &si_domain->domain;
+	default:
 		return NULL;
 	}
-	domain_update_iommu_cap(dmar_domain);
-
-	domain = &dmar_domain->domain;
-	domain->geometry.aperture_start = 0;
-	domain->geometry.aperture_end   = __DOMAIN_MAX_ADDR(dmar_domain->gaw);
-	domain->geometry.force_aperture = true;
 
-	return domain;
+	return NULL;
 }
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
-	domain_exit(to_dmar_domain(domain));
+	if (domain != &si_domain->domain)
+		domain_exit(to_dmar_domain(domain));
 }
 
 /*
-- 
2.17.1

