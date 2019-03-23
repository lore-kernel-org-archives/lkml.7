Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCCDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E2B20870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfCWOTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:19:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:28331 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbfCWOTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:19:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 07:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129543566"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2019 07:18:57 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] [PATCH v2 4/5] KVM/x86/vPMU: add vCPU scheduling support for hw-assigned vPMC
Date:   Sat, 23 Mar 2019 22:18:07 +0800
Message-Id: <1553350688-39627-5-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch would dispatch the generic vPMU request to intel ones.
In the vCPU scheduling context, this patch would save and restore
those in-use assigned counter states without interference.

The intel_pmu_sched_in() would release the event if its hw_life_count
has been counted down to zero OR if vPMC is disabled, it is considered
to be no longer used and its hw_life_count is decreased by one.

Signed-off-by: Wang Wei <wei.w.wang@intel.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kvm/pmu.c           | 15 ++++++++
 arch/x86/kvm/pmu.h           | 22 ++++++++++++
 arch/x86/kvm/vmx/pmu_intel.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c           |  6 ++++
 4 files changed, 124 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 58ead7d..672e268 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -284,6 +284,9 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 	struct kvm_pmc *pmc;
 	u64 ctr_val;
 
+	if (kvm_x86_ops->pmu_ops->pmc_read_counter)
+		return kvm_x86_ops->pmu_ops->pmc_read_counter(vcpu, idx, data);
+
 	if (is_vmware_backdoor_pmc(idx))
 		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
 
@@ -337,6 +340,18 @@ void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	kvm_x86_ops->pmu_ops->reset(vcpu);
 }
 
+void kvm_pmu_sched_out(struct kvm_vcpu *vcpu)
+{
+	if (kvm_x86_ops->pmu_ops->sched_out)
+		kvm_x86_ops->pmu_ops->sched_out(vcpu);
+}
+
+void kvm_pmu_sched_in(struct kvm_vcpu *vcpu)
+{
+	if (kvm_x86_ops->pmu_ops->sched_in)
+		kvm_x86_ops->pmu_ops->sched_in(vcpu);
+}
+
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ba8898e..de68ff0 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -33,6 +33,12 @@ struct kvm_pmu_ops {
 	void (*refresh)(struct kvm_vcpu *vcpu);
 	void (*init)(struct kvm_vcpu *vcpu);
 	void (*reset)(struct kvm_vcpu *vcpu);
+	bool (*pmc_is_assigned)(struct kvm_pmc *pmc);
+	void (*pmc_stop_counter)(struct kvm_pmc *pmc);
+	int (*pmc_read_counter)(struct kvm_vcpu *vcpu,
+		unsigned int idx, u64 *data);
+	void (*sched_out)(struct kvm_vcpu *vcpu);
+	void (*sched_in)(struct kvm_vcpu *vcpu);
 };
 
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
@@ -54,8 +60,22 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 	return counter & pmc_bitmask(pmc);
 }
 
+static inline bool pmc_is_assigned(struct kvm_pmc *pmc)
+{
+	if (kvm_x86_ops->pmu_ops->pmc_is_assigned)
+		return kvm_x86_ops->pmu_ops->pmc_is_assigned(pmc);
+
+	return false;
+}
+
 static inline void pmc_stop_counter(struct kvm_pmc *pmc)
 {
+	if (kvm_x86_ops->pmu_ops->pmc_stop_counter) {
+		if (pmc_is_assigned(pmc))
+			rdmsrl(pmc->perf_event->hw.event_base, pmc->counter);
+		return;
+	}
+
 	if (pmc->perf_event) {
 		pmc->counter = pmc_read_counter(pmc);
 		perf_event_release_kernel(pmc->perf_event);
@@ -117,6 +137,8 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 void kvm_pmu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_init(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
+void kvm_pmu_sched_out(struct kvm_vcpu *vcpu);
+void kvm_pmu_sched_in(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 0b69acc..63e00ea 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -522,6 +522,82 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 		pmu->global_ovf_ctrl = 0;
 }
 
+static void intel_pmu_sched_out(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int i;
+
+	for (i = 0; i < INTEL_PMC_MAX_GENERIC; i++) {
+		pmc = &pmu->gp_counters[i];
+		intel_pmu_disable_host_counter(pmc);
+		intel_pmu_save_guest_pmc(pmu, pmc->idx);
+	}
+
+	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
+		pmc = &pmu->fixed_counters[i];
+		intel_pmu_disable_host_counter(pmc);
+		intel_pmu_save_guest_pmc(pmu, pmc->idx);
+	}
+}
+
+static void intel_pmu_sched_in(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	struct hw_perf_event *hwc;
+	u64 host_ctrl, test, disabled_ctrl_val = 0;
+	int i;
+
+	for (i = 0; i < INTEL_PMC_MAX_GENERIC; i++) {
+		pmc = &pmu->gp_counters[i];
+
+		if (pmc->perf_event && pmc->hw_life_count == 0)
+			intel_pmc_stop_counter(pmc);
+
+		if (!intel_pmc_is_assigned(pmc))
+			continue;
+
+		intel_pmu_restore_guest_pmc(pmu, pmc->idx);
+
+		hwc = &pmc->perf_event->hw;
+		if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
+			u64 mask = 0xfULL <<
+				((hwc->idx - INTEL_PMC_IDX_FIXED) * 4);
+			disabled_ctrl_val &= ~mask;
+			rdmsrl(hwc->config_base, host_ctrl);
+			if (disabled_ctrl_val == host_ctrl)
+				pmc->hw_life_count--;
+		} else if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)) {
+			pmc->hw_life_count--;
+		}
+	}
+
+	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
+		pmc = &pmu->fixed_counters[i];
+
+		if (pmc->perf_event && pmc->hw_life_count == 0)
+			intel_pmc_stop_counter(pmc);
+
+		if (!intel_pmc_is_assigned(pmc))
+			continue;
+
+		intel_pmu_restore_guest_pmc(pmu, pmc->idx);
+
+		hwc = &pmc->perf_event->hw;
+		if (hwc->idx < INTEL_PMC_IDX_FIXED) {
+			rdmsrl(hwc->config_base, test);
+			if (!(test & ARCH_PERFMON_EVENTSEL_ENABLE))
+				pmc->hw_life_count--;
+		} else {
+			u8 ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl,
+				pmc->idx - INTEL_PMC_IDX_FIXED);
+			if (ctrl == 0)
+				pmc->hw_life_count--;
+		}
+	}
+}
+
 struct kvm_pmu_ops intel_pmu_ops = {
 	.find_arch_event = intel_find_arch_event,
 	.find_fixed_event = intel_find_fixed_event,
@@ -535,4 +611,9 @@ struct kvm_pmu_ops intel_pmu_ops = {
 	.refresh = intel_pmu_refresh,
 	.init = intel_pmu_init,
 	.reset = intel_pmu_reset,
+	.pmc_is_assigned = intel_pmc_is_assigned,
+	.pmc_stop_counter = intel_pmc_stop_counter,
+	.pmc_read_counter = intel_pmc_read_counter,
+	.sched_out = intel_pmu_sched_out,
+	.sched_in = intel_pmu_sched_in,
 };
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 65e4559..f9c715b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9100,9 +9100,15 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 		static_key_slow_dec(&kvm_no_apic_vcpu);
 }
 
+void kvm_arch_sched_out(struct kvm_vcpu *vcpu)
+{
+	kvm_pmu_sched_out(vcpu);
+}
+
 void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
 {
 	vcpu->arch.l1tf_flush_l1d = true;
+	kvm_pmu_sched_in(vcpu);
 	kvm_x86_ops->sched_in(vcpu, cpu);
 }
 
-- 
1.8.3.1

