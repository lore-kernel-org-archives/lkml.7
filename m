Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2447C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933E521851
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfEYFtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfEYFsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:55 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:52 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 04/15] iommu/vt-d: Enable DMA remapping after rmrr mapped
Date:   Sat, 25 May 2019 13:41:25 +0800
Message-Id: <20190525054136.27810-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rmrr devices require identity map of the rmrr regions before
enabling DMA remapping. Otherwise, there will be a window during
which DMA from/to the rmrr regions will be blocked. In order to
alleviate this, we move enabling DMA remapping after all rmrr
regions get mapped.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c42317e27b0c..bac226dc8360 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3538,11 +3538,6 @@ static int __init init_dmars(void)
 		ret = dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
-
-		if (!translation_pre_enabled(iommu))
-			iommu_enable_translation(iommu);
-
-		iommu_disable_protect_mem_regions(iommu);
 	}
 
 	return 0;
@@ -4922,7 +4917,6 @@ int __init intel_iommu_init(void)
 		goto out_free_reserved_range;
 	}
 	up_write(&dmar_global_lock);
-	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	swiotlb = 0;
@@ -4945,6 +4939,16 @@ int __init intel_iommu_init(void)
 		register_memory_notifier(&intel_iommu_memory_nb);
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
+
+	/* Finally, we enable the DMA remapping hardware. */
+	for_each_iommu(iommu, drhd) {
+		if (!translation_pre_enabled(iommu))
+			iommu_enable_translation(iommu);
+
+		iommu_disable_protect_mem_regions(iommu);
+	}
+	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
+
 	intel_iommu_enabled = 1;
 	intel_iommu_debugfs_init();
 
-- 
2.17.1

