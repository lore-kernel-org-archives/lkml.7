Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0589204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfDSTMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:12:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:20062 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDSTMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:12:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 23:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,368,1549958400"; 
   d="scan'208";a="162971214"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2019 23:49:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Don't request page request irq under dmar_global_lock
Date:   Fri, 19 Apr 2019 14:43:29 +0800
Message-Id: <20190419064329.17946-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting page reqest irq under dmar_global_lock could cause
potential lock race condition (caught by lockdep).

[    4.100055] ======================================================
[    4.100063] WARNING: possible circular locking dependency detected
[    4.100072] 5.1.0-rc4+ #2169 Not tainted
[    4.100078] ------------------------------------------------------
[    4.100086] swapper/0/1 is trying to acquire lock:
[    4.100094] 000000007dcbe3c3 (dmar_lock){+.+.}, at: dmar_alloc_hwirq+0x35/0x140
[    4.100112] but task is already holding lock:
[    4.100120] 0000000060bbe946 (dmar_global_lock){++++}, at: intel_iommu_init+0x191/0x1438
[    4.100136] which lock already depends on the new lock.
[    4.100146] the existing dependency chain (in reverse order) is:
[    4.100155]
               -> #2 (dmar_global_lock){++++}:
[    4.100169]        down_read+0x44/0xa0
[    4.100178]        intel_irq_remapping_alloc+0xb2/0x7b0
[    4.100186]        mp_irqdomain_alloc+0x9e/0x2e0
[    4.100195]        __irq_domain_alloc_irqs+0x131/0x330
[    4.100203]        alloc_isa_irq_from_domain.isra.4+0x9a/0xd0
[    4.100212]        mp_map_pin_to_irq+0x244/0x310
[    4.100221]        setup_IO_APIC+0x757/0x7ed
[    4.100229]        x86_late_time_init+0x17/0x1c
[    4.100238]        start_kernel+0x425/0x4e3
[    4.100247]        secondary_startup_64+0xa4/0xb0
[    4.100254]
               -> #1 (irq_domain_mutex){+.+.}:
[    4.100265]        __mutex_lock+0x7f/0x9d0
[    4.100273]        __irq_domain_add+0x195/0x2b0
[    4.100280]        irq_domain_create_hierarchy+0x3d/0x40
[    4.100289]        msi_create_irq_domain+0x32/0x110
[    4.100297]        dmar_alloc_hwirq+0x111/0x140
[    4.100305]        dmar_set_interrupt.part.14+0x1a/0x70
[    4.100314]        enable_drhd_fault_handling+0x2c/0x6c
[    4.100323]        apic_bsp_setup+0x75/0x7a
[    4.100330]        x86_late_time_init+0x17/0x1c
[    4.100338]        start_kernel+0x425/0x4e3
[    4.100346]        secondary_startup_64+0xa4/0xb0
[    4.100352]
               -> #0 (dmar_lock){+.+.}:
[    4.100364]        lock_acquire+0xb4/0x1c0
[    4.100372]        __mutex_lock+0x7f/0x9d0
[    4.100379]        dmar_alloc_hwirq+0x35/0x140
[    4.100389]        intel_svm_enable_prq+0x61/0x180
[    4.100397]        intel_iommu_init+0x1128/0x1438
[    4.100406]        pci_iommu_init+0x16/0x3f
[    4.100414]        do_one_initcall+0x5d/0x2be
[    4.100422]        kernel_init_freeable+0x1f0/0x27c
[    4.100431]        kernel_init+0xa/0x110
[    4.100438]        ret_from_fork+0x3a/0x50
[    4.100444]
               other info that might help us debug this:

[    4.100454] Chain exists of:
                 dmar_lock --> irq_domain_mutex --> dmar_global_lock
[    4.100469]  Possible unsafe locking scenario:

[    4.100476]        CPU0                    CPU1
[    4.100483]        ----                    ----
[    4.100488]   lock(dmar_global_lock);
[    4.100495]                                lock(irq_domain_mutex);
[    4.100503]                                lock(dmar_global_lock);
[    4.100512]   lock(dmar_lock);
[    4.100518]
                *** DEADLOCK ***

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Reported-by: Dave Jiang <dave.jiang@intel.com>
Fixes: a222a7f0bb6c9 ("iommu/vt-d: Implement page request handling")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3d504b685dd8..c1f2f83e25d2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3498,7 +3498,13 @@ static int __init init_dmars(void)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+			/*
+			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
+			 * could cause possible lock race condition.
+			 */
+			up_write(&dmar_global_lock);
 			ret = intel_svm_enable_prq(iommu);
+			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
 		}
-- 
2.17.1

