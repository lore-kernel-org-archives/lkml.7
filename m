Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE53C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40A820850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCRNOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:14:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfCRNO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:14:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C67FACB25BD9615062DA;
        Mon, 18 Mar 2019 21:14:27 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Mar 2019 21:14:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
Date:   Mon, 18 Mar 2019 21:12:42 +0800
Message-ID: <20190318131243.20716-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190318131243.20716-1-thunder.leizhen@huawei.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the content of L1STD(Level 1 Stream Table Descriptor) in DDR has been
modified, should make sure the cached copies be invalidated.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cfc8c..9b6afa8e69f70f6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1071,13 +1071,14 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	*dst = cpu_to_le64(val);
 }
 
-static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
+static void __arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu,
+					 u32 sid, bool leaf)
 {
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_STE,
 		.cfgi	= {
 			.sid	= sid,
-			.leaf	= true,
+			.leaf	= leaf,
 		},
 	};
 
@@ -1085,6 +1086,16 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
+static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__arm_smmu_sync_ste_for_sid(smmu, sid, true);
+}
+
+static void arm_smmu_sync_std_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__arm_smmu_sync_ste_for_sid(smmu, sid, false);
+}
+
 static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 				      __le64 *dst, struct arm_smmu_strtab_ent *ste)
 {
@@ -1232,6 +1243,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
+	arm_smmu_sync_std_for_sid(smmu, sid);
 	return 0;
 }
 
-- 
1.8.3


