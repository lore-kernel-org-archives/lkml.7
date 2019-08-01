Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C0C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0485C216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfHAMVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:21:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728791AbfHAMVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:21:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5C0348E4323954FF7DE6;
        Thu,  1 Aug 2019 20:21:41 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 20:21:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] iommu/arm-smmu-v3: add nr_ats_masters to avoid unnecessary operations
Date:   Thu, 1 Aug 2019 20:20:40 +0800
Message-ID: <20190801122040.26024-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When (smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS) is true, even if a
smmu domain does not contain any ats master, the operations of
arm_smmu_atc_inv_to_cmd() and lock protection in arm_smmu_atc_inv_domain()
are always executed. This will impact performance, especially in
multi-core and stress scenarios. For my FIO test scenario, about 8%
performance reduced.

In fact, we can use a atomic member to record how many ats masters the
smmu contains. And check that without traverse the list and check all
masters one by one in the lock protection.

Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a9a9fabd396804a..1b370d9aca95f94 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -631,6 +631,7 @@ struct arm_smmu_domain {
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	bool				non_strict;
+	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
 	union {
@@ -1531,7 +1532,7 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
+	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
@@ -1869,6 +1870,7 @@ static int arm_smmu_enable_ats(struct arm_smmu_master *master)
 	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_domain *smmu_domain = master->domain;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
@@ -1887,12 +1889,15 @@ static int arm_smmu_enable_ats(struct arm_smmu_master *master)
 		return ret;
 
 	master->ats_enabled = true;
+	atomic_inc(&smmu_domain->nr_ats_masters);
+
 	return 0;
 }
 
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
 	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!master->ats_enabled || !dev_is_pci(master->dev))
 		return;
@@ -1901,6 +1906,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	arm_smmu_atc_inv_master(master, &cmd);
 	pci_disable_ats(to_pci_dev(master->dev));
 	master->ats_enabled = false;
+	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
@@ -1915,10 +1921,10 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	master->domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
 
 	arm_smmu_disable_ats(master);
+	master->domain = NULL;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
-- 
1.8.3


