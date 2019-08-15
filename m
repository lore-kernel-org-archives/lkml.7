Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A1DC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C592086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfHOFpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:45:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729759AbfHOFpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:45:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8352C04C9C9B653EB55;
        Thu, 15 Aug 2019 13:45:10 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 15 Aug 2019 13:45:04 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        John Garry <john.garry@huawei.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: add nr_ats_masters for quickly check
Date:   Thu, 15 Aug 2019 13:44:39 +0800
Message-ID: <20190815054439.30652-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190815054439.30652-1-thunder.leizhen@huawei.com>
References: <20190815054439.30652-1-thunder.leizhen@huawei.com>
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

In fact, we can use a struct member to record how many ats masters that
the smmu contains. And check that without traverse the list and check all
masters one by one in the lock protection.

Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 29056d9bb12aa01..154334d3310c9b8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -631,6 +631,7 @@ struct arm_smmu_domain {
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	bool				non_strict;
+	int				nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
 	union {
@@ -1531,7 +1532,16 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
+	/*
+	 * The protectiom of spinlock(&iommu_domain->devices_lock) is omitted.
+	 * Because for a given master, its map/unmap operations should only be
+	 * happened after it has been attached and before it has been detached.
+	 * So that, if at least one master need to be atc invalidated, the
+	 * value of smmu_domain->nr_ats_masters can not be zero.
+	 *
+	 * This can alleviate performance loss in multi-core scenarios.
+	 */
+	if (!smmu_domain->nr_ats_masters)
 		return 0;
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
@@ -1913,6 +1923,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
+	smmu_domain->nr_ats_masters--;
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	master->domain = NULL;
@@ -1968,6 +1979,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_add(&master->domain_head, &smmu_domain->devices);
+	smmu_domain->nr_ats_masters++;
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
-- 
1.8.3


