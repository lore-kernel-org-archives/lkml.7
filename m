Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7316C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63CA2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfCZPU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:20:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731905AbfCZPUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:20:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE50E64A8430CE43DEDA;
        Tue, 26 Mar 2019 23:20:22 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Mar 2019 23:20:12 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
CC:     <andrew.murray@arm.com>, <jean-philippe.brucker@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <pabba@codeaurora.org>, <vkilari@codeaurora.org>,
        <rruigrok@codeaurora.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
Subject: [PATCH v7 4/4] perf/smmuv3: Enable HiSilicon Erratum 162001800 quirk
Date:   Tue, 26 Mar 2019 15:17:53 +0000
Message-ID: <20190326151753.19384-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSilicon erratum 162001800 describes the limitation of
SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.

On these platforms, the PMCG event counter registers
(SMMU_PMCG_EVCNTRn) are read only and as a result it
is not possible to set the initial counter period value
on event monitor start.

To work around this, the current value of the counter
is read and used for delta calculations. OEM information
from ACPI header is used to identify the affected hardware
platforms.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
 drivers/perf/arm_smmuv3_pmu.c | 48 ++++++++++++++++++++++++++++++++++++-------
 include/linux/acpi_iort.h     |  1 +
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e2c9b26..4dc68de 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1366,9 +1366,23 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 				       ACPI_EDGE_SENSITIVE, &res[2]);
 }
 
+static struct acpi_platform_list pmcg_plat_info[] __initdata = {
+	/* HiSilicon Hip08 Platform */
+	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal, 0,
+	 IORT_SMMU_V3_PMCG_HISI_HIP08},
+	{ }
+};
+
 static int __init arm_smmu_v3_pmcg_add_platdata(struct platform_device *pdev)
 {
-	u32 model = IORT_SMMU_V3_PMCG_GENERIC;
+	u32 model;
+	int idx;
+
+	idx = acpi_match_platform_list(pmcg_plat_info);
+	if (idx >= 0)
+		model = pmcg_plat_info[idx].data;
+	else
+		model = IORT_SMMU_V3_PMCG_GENERIC;
 
 	return platform_device_add_data(pdev, &model, sizeof(model));
 }
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 7803e9e..6b3c0ed 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -35,6 +35,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cpuhotplug.h>
@@ -93,6 +94,8 @@
 
 #define SMMU_PMCG_PA_SHIFT              12
 
+#define SMMU_PMCG_EVCNTR_RDONLY         BIT(0)
+
 static int cpuhp_state_num;
 
 struct smmu_pmu {
@@ -108,6 +111,7 @@ struct smmu_pmu {
 	void __iomem *reg_base;
 	void __iomem *reloc_base;
 	u64 counter_mask;
+	u32 options;
 	bool global_filter;
 	u32 global_filter_span;
 	u32 global_filter_sid;
@@ -222,15 +226,27 @@ static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
 	u32 idx = hwc->idx;
 	u64 new;
 
-	/*
-	 * We limit the max period to half the max counter value of the counter
-	 * size, so that even in the case of extreme interrupt latency the
-	 * counter will (hopefully) not wrap past its initial value.
-	 */
-	new = smmu_pmu->counter_mask >> 1;
+	if (smmu_pmu->options & SMMU_PMCG_EVCNTR_RDONLY) {
+		/*
+		 * On platforms that require this quirk, if the counter starts
+		 * at < half_counter value and wraps, the current logic of
+		 * handling the overflow may not work. It is expected that,
+		 * those platforms will have full 64 counter bits implemented
+		 * so that such a possibility is remote(eg: HiSilicon HIP08).
+		 */
+		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
+	} else {
+		/*
+		 * We limit the max period to half the max counter value
+		 * of the counter size, so that even in the case of extreme
+		 * interrupt latency the counter will (hopefully) not wrap
+		 * past its initial value.
+		 */
+		new = smmu_pmu->counter_mask >> 1;
+		smmu_pmu_counter_set_value(smmu_pmu, idx, new);
+	}
 
 	local64_set(&hwc->prev_count, new);
-	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
 }
 
 static void smmu_pmu_set_event_filter(struct perf_event *event,
@@ -669,6 +685,22 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
 		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
 }
 
+static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
+{
+	u32 model;
+
+	model = *(u32 *)dev_get_platdata(smmu_pmu->dev);
+
+	switch (model) {
+	case IORT_SMMU_V3_PMCG_HISI_HIP08:
+		/* HiSilicon Erratum 162001800 */
+		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
+		break;
+	}
+
+	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
+}
+
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
@@ -748,6 +780,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	smmu_pmu_get_acpi_options(smmu_pmu);
+
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
 	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 052ef7b..723e4df 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -32,6 +32,7 @@
  * do with hardware or with IORT specification.
  */
 #define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic SMMUv3 PMCG */
+#define IORT_SMMU_V3_PMCG_HISI_HIP08     0x00000001 /* HiSilicon HIP08 PMCG */
 
 int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
-- 
2.7.4


