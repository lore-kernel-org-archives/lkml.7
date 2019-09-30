Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8EC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1A2218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfI3OhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:37:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731803AbfI3OhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:37:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 324169B4856EE48EF227;
        Mon, 30 Sep 2019 22:36:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 22:36:49 +0800
From:   John Garry <john.garry@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <nleeder@codeaurora.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 5/6] perf/smmuv3: Match implementation options based on parent SMMU IIDR
Date:   Mon, 30 Sep 2019 22:33:50 +0800
Message-ID: <1569854031-237636-6-git-send-email-john.garry@huawei.com>
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

Currently we match the implementation options based on the ACPI PLATFORM
OEM ID.

Since we can now match based on the parent SMMUv3 IIDR, switch to this
method.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 11f28ba5fae0..33d1379ae525 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -739,14 +739,10 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
 		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
 }
 
-static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
+static void smmu_pmu_get_implementation_options(struct smmu_pmu *smmu_pmu)
 {
-	u32 model;
-
-	model = *(u32 *)dev_get_platdata(smmu_pmu->dev);
-
-	switch (model) {
-	case IORT_SMMU_V3_PMCG_HISI_HIP08:
+	switch (smmu_pmu->parent_iidr) {
+	case PARENT_SMMU_IIDR_HISI_HIP08:
 		/* HiSilicon Erratum 162001800 */
 		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
 		break;
@@ -844,7 +840,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	smmu_pmu_get_acpi_options(smmu_pmu);
+	smmu_pmu_get_implementation_options(smmu_pmu);
 
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
-- 
2.17.1

