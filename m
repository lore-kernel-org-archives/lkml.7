Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EB0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E927720870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfCWOTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:19:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:28327 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfCWOTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:19:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 07:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129543575"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2019 07:18:59 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] [PATCH v2 5/5] KVM/x86/vPMU: not do reprogram_counter for Intel hw-assigned vPMC
Date:   Sat, 23 Mar 2019 22:18:08 +0800
Message-Id: <1553350688-39627-6-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the cross-mapping issue, this patch directly passes
the intel_pmu_set_msr request value to the hw-assigned vPMC.

This patch would reprogram a counter from host perf scheduler
just one time when it's first requested and keep to reuse it
during a certain period of time until it's lazy-released, which
is associated with HW_LIFE_COUNT_MAX and scheduling time slice.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kvm/pmu.c           | 19 +++++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c | 58 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 672e268..d7e7fb6 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -137,6 +137,11 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
 	}
 
 	pmc->perf_event = event;
+	if (pmc_is_assigned(pmc)) {
+		pmc->hw_life_count = HW_LIFE_COUNT_MAX;
+		wrmsrl(pmc->perf_event->hw.event_base, pmc->counter);
+	}
+
 	clear_bit(pmc->idx, (unsigned long*)&pmc_to_pmu(pmc)->reprogram_pmi);
 }
 
@@ -155,6 +160,13 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
 	if (!(eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) || !pmc_is_enabled(pmc))
 		return;
 
+	if (pmc_is_assigned(pmc)) {
+		pmc->hw_life_count = HW_LIFE_COUNT_MAX;
+		clear_bit(pmc->idx,
+			(unsigned long *)&pmc_to_pmu(pmc)->reprogram_pmi);
+		return;
+	}
+
 	event_select = eventsel & ARCH_PERFMON_EVENTSEL_EVENT;
 	unit_mask = (eventsel & ARCH_PERFMON_EVENTSEL_UMASK) >> 8;
 
@@ -192,6 +204,13 @@ void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ctrl, int idx)
 	if (!en_field || !pmc_is_enabled(pmc))
 		return;
 
+	if (pmc_is_assigned(pmc)) {
+		pmc->hw_life_count = HW_LIFE_COUNT_MAX;
+		clear_bit(pmc->idx,
+			(unsigned long *)&pmc_to_pmu(pmc)->reprogram_pmi);
+		return;
+	}
+
 	pmc_reprogram_counter(pmc, PERF_TYPE_HARDWARE,
 			      kvm_x86_ops->pmu_ops->find_fixed_event(idx),
 			      !(en_field & 0x2), /* exclude user */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 63e00ea..2dfdf54 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -163,12 +163,13 @@ static void intel_pmu_disable_host_counter(struct kvm_pmc *pmc)
 
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
+	struct hw_perf_event *hwc;
+	struct kvm_pmc *pmc;
 	int i;
 
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		u8 new_ctrl = fixed_ctrl_field(data, i);
 		u8 old_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
-		struct kvm_pmc *pmc;
 
 		pmc = get_fixed_pmc(pmu, MSR_CORE_PERF_FIXED_CTR0 + i);
 
@@ -176,6 +177,19 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 			continue;
 
 		reprogram_fixed_counter(pmc, new_ctrl, i);
+
+		if (!intel_pmc_is_assigned(pmc))
+			continue;
+
+		hwc = &pmc->perf_event->hw;
+		if (hwc->idx < INTEL_PMC_IDX_FIXED) {
+			u64 config = (new_ctrl == 0) ? 0 :
+				(hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE);
+			wrmsrl(hwc->config_base, config);
+		} else {
+			intel_pmu_update_host_fixed_ctrl(new_ctrl,
+				hwc->idx - INTEL_PMC_IDX_FIXED);
+		}
 	}
 
 	pmu->fixed_ctr_ctrl = data;
@@ -345,6 +359,7 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
+	struct hw_perf_event *hwc;
 
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
@@ -362,7 +377,13 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 	default:
 		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
 		    (pmc = get_fixed_pmc(pmu, msr))) {
-			*data = pmc_read_counter(pmc);
+			if (intel_pmc_is_assigned(pmc)) {
+				hwc = &pmc->perf_event->hw;
+				rdmsrl_safe(hwc->event_base, data);
+				pmc->counter = *data;
+			} else {
+				*data = pmc->counter;
+			}
 			return 0;
 		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
 			*data = pmc->eventsel;
@@ -377,6 +398,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
+	struct hw_perf_event *hwc;
 	u32 msr = msr_info->index;
 	u64 data = msr_info->data;
 
@@ -414,18 +436,30 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	default:
 		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
 		    (pmc = get_fixed_pmc(pmu, msr))) {
-			if (!msr_info->host_initiated)
-				data = (s64)(s32)data;
-			pmc->counter += data - pmc_read_counter(pmc);
-			return 0;
-		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
-			if (data == pmc->eventsel)
-				return 0;
-			if (!(data & pmu->reserved_bits)) {
-				reprogram_gp_counter(pmc, data);
-				return 0;
+			pmc->counter = data;
+			if (intel_pmc_is_assigned(pmc)) {
+				hwc = &pmc->perf_event->hw;
+				wrmsrl(hwc->event_base, pmc->counter);
 			}
+			return 0;
 		}
+
+		pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0);
+		if (!pmc)
+			return 1;
+
+		if (data == pmc->eventsel
+				|| (data & pmu->reserved_bits))
+			return 0;
+
+		reprogram_gp_counter(pmc, data);
+
+		if (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)
+			intel_pmu_enable_host_counter(pmc);
+		else
+			intel_pmu_disable_host_counter(pmc);
+
+		return 0;
 	}
 
 	return 1;
-- 
1.8.3.1

