Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD478C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF0E21906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfI3OhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:37:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730780AbfI3OhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:37:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63F89242D57370195736;
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
Subject: [RFC PATCH 3/6] perf/smmuv3: Retrieve parent SMMUv3 IIDR
Date:   Mon, 30 Sep 2019 22:33:48 +0800
Message-ID: <1569854031-237636-4-git-send-email-john.garry@huawei.com>
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

To support IMP DEF events per PMCG, retrieve the parent SMMUv3 IIDR. This
will be used as a lookup for the IMP DEF events supported, under the
assumption that a PMCG implementation has the same uniqueness as the
parent SMMUv3. In this, we assume that any PMCG associated with the same
SMMUv3 will have the same IMP DEF events - otherwise, some other
secondary matching would need to be done.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index da71c741cb46..f702898c695d 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -115,6 +115,7 @@ struct smmu_pmu {
 	bool global_filter;
 	u32 global_filter_span;
 	u32 global_filter_sid;
+	u32 parent_iidr;
 };
 
 #define to_smmu_pmu(p) (container_of(p, struct smmu_pmu, pmu))
@@ -551,6 +552,11 @@ static const struct attribute_group *smmu_pmu_attr_grps[] = {
 	NULL
 };
 
+static const struct attribute_group **smmu_pmu_lookup_attr_groups(u32 parent_smmu_iidr)
+{
+	return smmu_pmu_attr_grps;
+}
+
 /*
  * Generic device handlers
  */
@@ -706,11 +712,21 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	int irq, err;
 	char *name;
 	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
 
 	smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu), GFP_KERNEL);
 	if (!smmu_pmu)
 		return -ENOMEM;
 
+	if (parent) {
+		void *parent_drvdata;
+
+		parent_drvdata = platform_get_drvdata(to_platform_device(parent));
+		if (!parent_drvdata)
+			return -EPROBE_DEFER;
+		smmu_pmu->parent_iidr = *(u32 *)parent_drvdata;
+	}
+
 	smmu_pmu->dev = dev;
 	platform_set_drvdata(pdev, smmu_pmu);
 
@@ -724,7 +740,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.start		= smmu_pmu_event_start,
 		.stop		= smmu_pmu_event_stop,
 		.read		= smmu_pmu_event_read,
-		.attr_groups	= smmu_pmu_attr_grps,
+		.attr_groups	= smmu_pmu_lookup_attr_groups(smmu_pmu->parent_iidr),
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-- 
2.17.1

