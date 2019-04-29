Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AC4C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3D320843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfD2CQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 22:16:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:46364 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfD2CQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:16:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 19:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146537881"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 19:16:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 8/8] iommu/vt-d: Implement is_attach_deferred iommu ops entry
Date:   Mon, 29 Apr 2019 10:09:25 +0800
Message-Id: <20190429020925.18136-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a domain is now attached to a device earlier, we should
implement the is_attach_deferred call-back and use it to
defer the domain attach from iommu driver init to device
driver init when iommu is pre-enabled in kdump kernel.

Suggested-by: Tom Murphy <tmurphy@arista.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index dd6abd554804..7e24f025f7a9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -358,6 +358,8 @@ static void domain_context_clear(struct intel_iommu *iommu,
 				 struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
+static int intel_iommu_attach_device(struct iommu_domain *domain,
+				     struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
 int dmar_disabled = 0;
@@ -387,6 +389,7 @@ int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
 #define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
+#define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
@@ -2404,8 +2407,18 @@ static struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
+	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO)) {
+		struct iommu_domain *domain;
+
+		dev->archdata.iommu = NULL;
+		domain = iommu_get_domain_for_dev(dev);
+		if (domain)
+			intel_iommu_attach_device(domain, dev);
+	}
+
 	/* No lock here, assumes no domain exit in normal case */
 	info = dev->archdata.iommu;
+
 	if (likely(info))
 		return info->domain;
 	return NULL;
@@ -5154,6 +5167,9 @@ static int intel_iommu_add_device(struct device *dev)
 
 	iommu_device_link(&iommu->iommu, dev);
 
+	if (translation_pre_enabled(iommu))
+		dev->archdata.iommu = DEFER_DEVICE_DOMAIN_INFO;
+
 	group = iommu_group_get_for_dev(dev);
 
 	if (IS_ERR(group))
@@ -5440,6 +5456,12 @@ intel_iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 			dmar_domain->default_pasid : -EINVAL;
 }
 
+static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
+					   struct device *dev)
+{
+	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5463,6 +5485,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.def_domain_type	= intel_iommu_def_domain_type,
+	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1

