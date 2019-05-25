Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F53CC28CBF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DDE2184E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfEYFsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:48:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfEYFsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:53 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:50 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 03/15] iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions
Date:   Sat, 25 May 2019 13:41:24 +0800
Message-Id: <20190525054136.27810-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support mapping ISA region via iommu_group_create_direct_mappings,
make sure its exposed by iommu_get_resv_regions.

Signed-off-by: James Sewart <jamessewart@arista.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4d0fa3097f5d..c42317e27b0c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5520,6 +5520,20 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	}
 	rcu_read_unlock();
 
+#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
+	if (dev_is_pci(device)) {
+		struct pci_dev *pdev = to_pci_dev(device);
+
+		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
+			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
+						      IOMMU_RESV_DIRECT,
+						      GFP_KERNEL);
+			if (reg)
+				list_add_tail(&reg->list, head);
+		}
+	}
+#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
+
 	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
 				      0, IOMMU_RESV_MSI, GFP_KERNEL);
-- 
2.17.1

