Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F2C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81DB21906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfI3OhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:37:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731715AbfI3OhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:37:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40F62D0A7B7A024C01A2;
        Mon, 30 Sep 2019 22:36:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 22:36:48 +0800
From:   John Garry <john.garry@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 2/6] iommu/arm-smmu-v3: Record IIDR in arm_smmu_device structure
Date:   Mon, 30 Sep 2019 22:33:47 +0800
Message-ID: <1569854031-237636-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
References: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow other devices know the SMMU HW IIDR, record the IIDR contents as
the first member of the arm_smmu_device structure.

In storing as the first member, it saves exposing SMMU APIs, which are
nicely self-contained today.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 40f4757096c3..1ed3ef0f1ec3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -70,6 +70,8 @@
 #define IDR1_SSIDSIZE			GENMASK(10, 6)
 #define IDR1_SIDSIZE			GENMASK(5, 0)
 
+#define ARM_SMMU_IIDR                  0x18
+
 #define ARM_SMMU_IDR5			0x14
 #define IDR5_STALL_MAX			GENMASK(31, 16)
 #define IDR5_GRAN64K			(1 << 6)
@@ -546,6 +548,7 @@ struct arm_smmu_strtab_cfg {
 
 /* An SMMUv3 instance */
 struct arm_smmu_device {
+	u32						iidr; /* must be first member */
 	struct device			*dev;
 	void __iomem			*base;
 
@@ -3153,6 +3156,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	iommu_device_set_ops(&smmu->iommu, &arm_smmu_ops);
 	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
 
+	smmu->iidr = readl(smmu->base + ARM_SMMU_IIDR);
+
 	ret = iommu_device_register(&smmu->iommu);
 	if (ret) {
 		dev_err(dev, "Failed to register iommu\n");
-- 
2.17.1

