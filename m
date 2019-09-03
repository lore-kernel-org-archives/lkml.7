Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8389C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6EF22CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfICCnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:43:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfICCnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:43:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C994D77CF3F576A2A425;
        Tue,  3 Sep 2019 10:43:29 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 10:43:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iommu/arm-smmu-v3: Fix build error without CONFIG_PCI_ATS
Date:   Tue, 3 Sep 2019 10:42:12 +0800
Message-ID: <20190903024212.20300-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PCI_ATS is not set, building fails:

drivers/iommu/arm-smmu-v3.c: In function arm_smmu_ats_supported:
drivers/iommu/arm-smmu-v3.c:2325:35: error: struct pci_dev has no member named ats_cap; did you mean msi_cap?
  return !pdev->untrusted && pdev->ats_cap;
                                   ^~~~~~~

ats_cap should only used when CONFIG_PCI_ATS is defined,
so use #ifdef block to guard this.

Fixes: bfff88ec1afe ("iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 66bf641..44ac9ac 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2313,7 +2313,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
-	struct pci_dev *pdev;
+	struct pci_dev *pdev __maybe_unused;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
@@ -2321,8 +2321,10 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
 		return false;
 
+#ifdef CONFIG_PCI_ATS
 	pdev = to_pci_dev(master->dev);
 	return !pdev->untrusted && pdev->ats_cap;
+#endif
 }
 
 static void arm_smmu_enable_ats(struct arm_smmu_master *master)
-- 
2.7.4


