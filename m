Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A1C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E5E218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfI3OhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:37:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731698AbfI3OhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:37:00 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3920A100FDCBCDE5F8DC;
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
Subject: [RFC PATCH 4/6] perf/smmuv3: Support HiSilicon hip08 (hi1620) IMP DEF events
Date:   Mon, 30 Sep 2019 22:33:49 +0800
Message-ID: <1569854031-237636-5-git-send-email-john.garry@huawei.com>
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

Now that we can identify an PMCG implementation through the parent SMMUv3
implementation, add support for IMP DEF events.

For each new implementation supported, we add a new attr_grps structure
for a particular implementation and do lookup matching based on the
parent SMMUv3 IIDR. This could maybe be optimised in future to reduce
structures required.

For now, only the l1_tlb event is added for HiSilicon hip08 platform.

This platform supports many more IMP DEF events, but I need something
better than the electronically translated description of the event to
support.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 54 ++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index f702898c695d..11f28ba5fae0 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -132,6 +132,8 @@ SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_stream_id, config1, 0, 31);
 SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_span, config1, 32, 32);
 SMMU_PMU_EVENT_ATTR_EXTRACTOR(filter_enable, config1, 33, 33);
 
+#define PARENT_SMMU_IIDR_HISI_HIP08 (0x30736)
+
 static inline void smmu_pmu_enable(struct pmu *pmu)
 {
 	struct smmu_pmu *smmu_pmu = to_smmu_pmu(pmu);
@@ -505,6 +507,21 @@ static struct attribute *smmu_pmu_events[] = {
 	NULL
 };
 
+SMMU_EVENT_ATTR(l1_tlb, 0x8a);
+
+static struct attribute *smmu_pmu_events_hip08[] = {
+	&smmu_event_attr_cycles.attr.attr,
+	&smmu_event_attr_transaction.attr.attr,
+	&smmu_event_attr_tlb_miss.attr.attr,
+	&smmu_event_attr_config_cache_miss.attr.attr,
+	&smmu_event_attr_trans_table_walk_access.attr.attr,
+	&smmu_event_attr_config_struct_access.attr.attr,
+	&smmu_event_attr_pcie_ats_trans_rq.attr.attr,
+	&smmu_event_attr_pcie_ats_trans_passed.attr.attr,
+	&smmu_event_attr_l1_tlb.attr.attr,
+	NULL
+};
+
 static umode_t smmu_pmu_event_is_visible(struct kobject *kobj,
 					 struct attribute *attr, int unused)
 {
@@ -514,7 +531,10 @@ static umode_t smmu_pmu_event_is_visible(struct kobject *kobj,
 
 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
 
-	if (test_bit(pmu_attr->id, smmu_pmu->supported_events))
+	if (pmu_attr->id < SMMU_PMCG_ARCH_MAX_EVENTS &&
+	    test_bit(pmu_attr->id, smmu_pmu->supported_events))
+		return attr->mode;
+	else if (pmu_attr->id >= SMMU_PMCG_ARCH_MAX_EVENTS)
 		return attr->mode;
 
 	return 0;
@@ -526,6 +546,12 @@ static struct attribute_group smmu_pmu_events_group = {
 	.is_visible = smmu_pmu_event_is_visible,
 };
 
+static struct attribute_group smmu_pmu_events_group_hip08 = {
+	.name = "events",
+	.attrs = smmu_pmu_events_hip08,
+	.is_visible = smmu_pmu_event_is_visible,
+};
+
 /* Formats */
 PMU_FORMAT_ATTR(event,		   "config:0-15");
 PMU_FORMAT_ATTR(filter_stream_id,  "config1:0-31");
@@ -552,8 +578,34 @@ static const struct attribute_group *smmu_pmu_attr_grps[] = {
 	NULL
 };
 
+static const struct attribute_group *smmu_pmu_attr_grps_hip08[] = {
+	&smmu_pmu_cpumask_group,
+	&smmu_pmu_events_group_hip08,
+	&smmu_pmu_format_group,
+	NULL
+};
+
+struct smmu_pmu_attr_grps_custom {
+	u32 parent_smmu_iidr;
+	const struct attribute_group **attr_grps;
+} smmu_pmu_attr_custom_grps[] = {
+	{
+		.parent_smmu_iidr = PARENT_SMMU_IIDR_HISI_HIP08,
+		.attr_grps = smmu_pmu_attr_grps_hip08,
+	},
+};
+
 static const struct attribute_group **smmu_pmu_lookup_attr_groups(u32 parent_smmu_iidr)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(smmu_pmu_attr_custom_grps); i++) {
+		struct smmu_pmu_attr_grps_custom *c = &smmu_pmu_attr_custom_grps[i];
+
+		if (c->parent_smmu_iidr == parent_smmu_iidr)
+			return c->attr_grps;
+	}
+
 	return smmu_pmu_attr_grps;
 }
 
-- 
2.17.1

