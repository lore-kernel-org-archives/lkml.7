Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2206C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9277D20675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfESR52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:57:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727620AbfESR50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:57:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2FE1C505548047439AB4;
        Sun, 19 May 2019 18:07:38 +0800 (CST)
Received: from HGHY1z004218071.china.huawei.com (10.177.29.32) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sun, 19 May 2019 18:07:29 +0800
From:   Xiang Zheng <zhengxiang9@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <wanghaibin.wang@huawei.com>,
        <shannon.zhaosl@gmail.com>, Xiang Zheng <zhengxiang9@huawei.com>
Subject: [PATCH] KVM: ARM64: Update perf event when setting PMU count value
Date:   Sun, 19 May 2019 18:05:59 +0800
Message-ID: <20190519100559.7188-1-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest will adjust the sample period and set PMU counter value when
it takes a long time to handle the PMU interrupts.

However, we don't have a corresponding change on the virtual PMU
which is emulated via a perf event. It could cause a large number
of PMU interrupts injected to guest. Then guest will get hang for
handling these interrupts.

So update the sample_period of perf event if the counter value is
changed to avoid this case.

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 virt/kvm/arm/pmu.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 1c5b76c..cbad3ec 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -24,6 +24,11 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_vgic.h>
 
+static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
+static struct perf_event *kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu,
+						    struct kvm_pmc *pmc,
+						    struct perf_event_attr *attr);
+
 /**
  * kvm_pmu_get_counter_value - get PMU counter value
  * @vcpu: The vcpu pointer
@@ -57,11 +62,29 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
  */
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
 {
-	u64 reg;
+	u64 reg, counter, old_sample_period;
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
+	struct perf_event *event;
+	struct perf_event_attr attr;
 
 	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
 	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
 	__vcpu_sys_reg(vcpu, reg) += (s64)val - kvm_pmu_get_counter_value(vcpu, select_idx);
+
+	if (pmc->perf_event) {
+		attr = pmc->perf_event->attr;
+		old_sample_period = attr.sample_period;
+		counter = kvm_pmu_get_counter_value(vcpu, select_idx);
+		attr.sample_period = (-counter) & pmc->bitmask;
+		if (attr.sample_period == old_sample_period)
+			return;
+
+		kvm_pmu_stop_counter(vcpu, pmc);
+		event = kvm_pmu_create_perf_event(vcpu, pmc, &attr);
+		if (event)
+			pmc->perf_event = event;
+	}
 }
 
 /**
@@ -303,6 +326,24 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 	}
 }
 
+static struct perf_event *kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu,
+						    struct kvm_pmc *pmc,
+						    struct perf_event_attr *attr)
+{
+	struct perf_event *event;
+
+	event = perf_event_create_kernel_counter(attr, -1, current,
+						 kvm_pmu_perf_overflow, pmc);
+
+	if (IS_ERR(event)) {
+		pr_err_once("kvm: pmu event creation failed %ld\n",
+			    PTR_ERR(event));
+		return NULL;
+	}
+
+	return event;
+}
+
 /**
  * kvm_pmu_software_increment - do software increment
  * @vcpu: The vcpu pointer
@@ -416,15 +457,10 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 	/* The initial sample period (overflow count) of an event. */
 	attr.sample_period = (-counter) & pmc->bitmask;
 
-	event = perf_event_create_kernel_counter(&attr, -1, current,
-						 kvm_pmu_perf_overflow, pmc);
-	if (IS_ERR(event)) {
-		pr_err_once("kvm: pmu event creation failed %ld\n",
-			    PTR_ERR(event));
-		return;
-	}
+	event = kvm_pmu_create_perf_event(vcpu, pmc, &attr);
 
-	pmc->perf_event = event;
+	if (event)
+		pmc->perf_event = event;
 }
 
 bool kvm_arm_support_pmu_v3(void)
-- 
1.8.3.1


