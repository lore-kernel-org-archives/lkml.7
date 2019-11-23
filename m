Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B230C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D76D20719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 09:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKWJYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 04:24:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfKWJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 04:24:40 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6AF948F924E54E9A4201;
        Sat, 23 Nov 2019 17:24:35 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 23 Nov 2019
 17:24:29 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>, <James.Clark@arm.com>,
        <jeremy.linton@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [RFC v3 4/5] drivers: perf: add some arm spe events
Date:   Sat, 23 Nov 2019 18:11:17 +0800
Message-ID: <20191123101118.12635-5-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123101118.12635-1-tanxiaojun@huawei.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some definitions of arm spe events, these are precise ip events.
Displayed in the perf list as follows:

---------------------------------------------------------------------
...
arm_spe_0//                                        [Kernel PMU event]
arm_spe_0/branch_miss/                             [Kernel PMU event]
arm_spe_0/llc_miss/                                [Kernel PMU event]
arm_spe_0/remote_access/                           [Kernel PMU event]
arm_spe_0/tlb_miss/                                [Kernel PMU event]
...
---------------------------------------------------------------------

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 drivers/perf/arm_spe_pmu.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 4e4984a55cd1..4df9abdb2255 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -161,6 +161,9 @@ static struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_pct_enable_CFG		config	/* PMSCR_EL1.PCT */
 #define ATTR_CFG_FLD_pct_enable_LO		2
 #define ATTR_CFG_FLD_pct_enable_HI		2
+#define ATTR_CFG_FLD_event_CFG			config	/* ARM SPE EVENTS */
+#define ATTR_CFG_FLD_event_LO			3
+#define ATTR_CFG_FLD_event_HI			6
 #define ATTR_CFG_FLD_jitter_CFG			config	/* PMSIRR_EL1.RND */
 #define ATTR_CFG_FLD_jitter_LO			16
 #define ATTR_CFG_FLD_jitter_HI			16
@@ -174,6 +177,11 @@ static struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
 
+#define ARM_SPE_EVENT_LLC_MISS			BIT(0)
+#define ARM_SPE_EVENT_BRANCH_MISS		BIT(1)
+#define ARM_SPE_EVENT_TLB_MISS			BIT(2)
+#define ARM_SPE_EVENT_REMOTE_ACCESS		BIT(3)
+
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
 #define ATTR_CFG_FLD_event_filter_HI		63
@@ -213,8 +221,43 @@ GEN_PMU_FORMAT_ATTR(load_filter);
 GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(event);
+
+static ssize_t
+arm_spe_events_sysfs_show(struct device *dev,
+		struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);
+}
+
+#define ARM_SPE_EVENT_ATTR(name, config) \
+	PMU_EVENT_ATTR(name, arm_spe_event_attr_##name, \
+		       config, arm_spe_events_sysfs_show)
+
+ARM_SPE_EVENT_ATTR(llc_miss, ARM_SPE_EVENT_LLC_MISS);
+ARM_SPE_EVENT_ATTR(branch_miss, ARM_SPE_EVENT_BRANCH_MISS);
+ARM_SPE_EVENT_ATTR(tlb_miss, ARM_SPE_EVENT_TLB_MISS);
+ARM_SPE_EVENT_ATTR(remote_access, ARM_SPE_EVENT_REMOTE_ACCESS);
+
+static struct attribute *arm_spe_pmu_event_attrs[] = {
+	&arm_spe_event_attr_llc_miss.attr.attr,
+	&arm_spe_event_attr_branch_miss.attr.attr,
+	&arm_spe_event_attr_tlb_miss.attr.attr,
+	&arm_spe_event_attr_remote_access.attr.attr,
+	NULL,
+};
+
+static struct attribute_group arm_spe_pmu_event_group = {
+	.name = "events",
+	.attrs	= arm_spe_pmu_event_attrs,
+};
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
+	&format_attr_event.attr,
 	&format_attr_ts_enable.attr,
 	&format_attr_pa_enable.attr,
 	&format_attr_pct_enable.attr,
@@ -252,6 +295,7 @@ static struct attribute_group arm_spe_pmu_group = {
 };
 
 static const struct attribute_group *arm_spe_pmu_attr_groups[] = {
+	&arm_spe_pmu_event_group,
 	&arm_spe_pmu_group,
 	&arm_spe_pmu_cap_group,
 	&arm_spe_pmu_format_group,
-- 
2.17.1

