Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893CAC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664D62173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEUHhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:37:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:4506 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfEUHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:37:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 00:37:11 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2019 00:37:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     joro@8bytes.org, dwmw2@infradead.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Kevin Tian <kevin.tian@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Fix lock inversion between iommu->lock and device_domain_lock
Date:   Tue, 21 May 2019 15:30:15 +0800
Message-Id: <20190521073016.27525-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Lockdep debug reported lock inversion related with the iommu code
caused by dmar_insert_one_dev_info() grabbing the iommu->lock and
the device_domain_lock out of order versus the code path in
iommu_flush_dev_iotlb(). Expanding the scope of the iommu->lock and
reversing the order of lock acquisition fixes the issue.

[   76.238180] dsa_bus wq0.0: dsa wq wq0.0 disabled
[   76.248706]
[   76.250486] ========================================================
[   76.257113] WARNING: possible irq lock inversion dependency detected
[   76.263736] 5.1.0-rc5+ #162 Not tainted
[   76.267854] --------------------------------------------------------
[   76.274485] systemd-journal/521 just changed the state of lock:
[   76.280685] 0000000055b330f5 (device_domain_lock){..-.}, at: iommu_flush_dev_iotlb.part.63+0x29/0x90
[   76.290099] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   76.297093]  (&(&iommu->lock)->rlock){+.+.}
[   76.297094]
[   76.297094]
[   76.297094] and interrupts could create inverse lock ordering between them.
[   76.297094]
[   76.314257]
[   76.314257] other info that might help us debug this:
[   76.321448]  Possible interrupt unsafe locking scenario:
[   76.321448]
[   76.328907]        CPU0                    CPU1
[   76.333777]        ----                    ----
[   76.338642]   lock(&(&iommu->lock)->rlock);
[   76.343165]                                local_irq_disable();
[   76.349422]                                lock(device_domain_lock);
[   76.356116]                                lock(&(&iommu->lock)->rlock);
[   76.363154]   <Interrupt>
[   76.366134]     lock(device_domain_lock);
[   76.370548]
[   76.370548]  *** DEADLOCK ***

Fixes: 745f2586e78e ("iommu/vt-d: Simplify function get_domain_for_dev()")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..91f4912c09c6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2512,6 +2512,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		}
 	}
 
+	spin_lock(&iommu->lock);
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (dev)
 		found = find_domain(dev);
@@ -2527,17 +2528,16 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (found) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
+		spin_unlock(&iommu->lock);
 		free_devinfo_mem(info);
 		/* Caller must free the original domain */
 		return found;
 	}
 
-	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
-
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
+		spin_unlock(&iommu->lock);
 		free_devinfo_mem(info);
 		return NULL;
 	}
@@ -2547,6 +2547,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev)
 		dev->archdata.iommu = info;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
+	spin_unlock(&iommu->lock);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
-- 
2.17.1

