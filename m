Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C362C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2554F20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfCYBhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:37:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:35778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfCYBhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:37:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 18:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="128326891"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 24 Mar 2019 18:37:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 4/9] iommu/vt-d: Move common code out of iommu_attch_device()
Date:   Mon, 25 Mar 2019 09:30:31 +0800
Message-Id: <20190325013036.18400-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325013036.18400-1-baolu.lu@linux.intel.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part of code could be used by both normal and aux
domain specific attach entries. Hence move them into a
common function to avoid duplication.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 60 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ba5f2e5b3a03..a0f9c748ca9f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5066,35 +5066,14 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 	domain_exit(to_dmar_domain(domain));
 }
 
-static int intel_iommu_attach_device(struct iommu_domain *domain,
-				     struct device *dev)
+static int prepare_domain_attach_device(struct iommu_domain *domain,
+					struct device *dev)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
 	int addr_width;
 	u8 bus, devfn;
 
-	if (device_is_rmrr_locked(dev)) {
-		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
-		return -EPERM;
-	}
-
-	/* normally dev is not mapped */
-	if (unlikely(domain_context_mapped(dev))) {
-		struct dmar_domain *old_domain;
-
-		old_domain = find_domain(dev);
-		if (old_domain) {
-			rcu_read_lock();
-			dmar_remove_one_dev_info(dev);
-			rcu_read_unlock();
-
-			if (!domain_type_is_vm_or_si(old_domain) &&
-			     list_empty(&old_domain->devices))
-				domain_exit(old_domain);
-		}
-	}
-
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
@@ -5127,7 +5106,40 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
 
-	return domain_add_dev_info(dmar_domain, dev);
+	return 0;
+}
+
+static int intel_iommu_attach_device(struct iommu_domain *domain,
+				     struct device *dev)
+{
+	int ret;
+
+	if (device_is_rmrr_locked(dev)) {
+		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
+		return -EPERM;
+	}
+
+	/* normally dev is not mapped */
+	if (unlikely(domain_context_mapped(dev))) {
+		struct dmar_domain *old_domain;
+
+		old_domain = find_domain(dev);
+		if (old_domain) {
+			rcu_read_lock();
+			dmar_remove_one_dev_info(dev);
+			rcu_read_unlock();
+
+			if (!domain_type_is_vm_or_si(old_domain) &&
+			    list_empty(&old_domain->devices))
+				domain_exit(old_domain);
+		}
+	}
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
 static void intel_iommu_detach_device(struct iommu_domain *domain,
-- 
2.17.1

