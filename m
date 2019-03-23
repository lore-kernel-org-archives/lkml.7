Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3362C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8056520823
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCWOS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:18:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:28331 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbfCWOS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:18:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 07:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129543558"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2019 07:18:55 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] [PATCH v2 3/5] KVM/x86/vPMU: add Intel vPMC enable/disable and save/restore support
Date:   Sat, 23 Mar 2019 22:18:06 +0800
Message-Id: <1553350688-39627-4-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may not assume the guest fixed vPMC would be assigned by
an host fixed counter and vice versa. This issue (the host hw->idx
has a different type of guest hw->idx) is named as the cross-mapping
and it needs to keep semantics for mask select and enable ctrl.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 92 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index bb16031..0b69acc 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -133,6 +133,34 @@ static void intel_pmu_update_host_fixed_ctrl(u64 new_ctrl, u8 host_idx)
 	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, host_ctrl);
 }
 
+static void intel_pmu_enable_host_counter(struct kvm_pmc *pmc)
+{
+	u8 host_idx;
+
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	host_idx = pmc->perf_event->hw.idx;
+	if (host_idx >= INTEL_PMC_IDX_FIXED)
+		intel_pmu_enable_host_fixed_counter(pmc);
+	else
+		intel_pmu_enable_host_gp_counter(pmc);
+}
+
+static void intel_pmu_disable_host_counter(struct kvm_pmc *pmc)
+{
+	u8 host_idx;
+
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	host_idx = pmc->perf_event->hw.idx;
+	if (host_idx >= INTEL_PMC_IDX_FIXED)
+		intel_pmu_disable_host_fixed_counter(pmc);
+	else
+		intel_pmu_disable_host_gp_counter(pmc);
+}
+
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	int i;
@@ -262,6 +290,57 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	return ret;
 }
 
+static void intel_pmu_save_guest_pmc(struct kvm_pmu *pmu, u32 idx)
+{
+	struct kvm_pmc *pmc = intel_pmc_idx_to_pmc(pmu, idx);
+
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	rdmsrl(pmc->perf_event->hw.event_base, pmc->counter);
+	wrmsrl(pmc->perf_event->hw.event_base, 0);
+}
+
+static void intel_pmu_restore_guest_pmc(struct kvm_pmu *pmu, u32 idx)
+{
+	struct kvm_pmc *pmc = intel_pmc_idx_to_pmc(pmu, idx);
+	u8 ctrl;
+
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	if (pmc->idx >= INTEL_PMC_IDX_FIXED) {
+		ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl,
+			pmc->idx - INTEL_PMC_IDX_FIXED);
+		if (ctrl)
+			intel_pmu_enable_host_counter(pmc);
+		else
+			intel_pmu_disable_host_counter(pmc);
+	} else {
+		if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
+			intel_pmu_disable_host_counter(pmc);
+		else
+			intel_pmu_enable_host_counter(pmc);
+	}
+
+	wrmsrl(pmc->perf_event->hw.event_base, pmc->counter);
+}
+
+static void intel_pmc_stop_counter(struct kvm_pmc *pmc)
+{
+	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
+
+	if (!pmc->perf_event)
+		return;
+
+	intel_pmu_disable_host_counter(pmc);
+	intel_pmu_save_guest_pmc(pmu, pmc->idx);
+	pmc_read_counter(pmc);
+	perf_event_release_kernel(pmc->perf_event);
+	pmc->perf_event = NULL;
+	pmc->hw_life_count = 0;
+}
+
 static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *data)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -424,17 +503,20 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
 	int i;
 
 	for (i = 0; i < INTEL_PMC_MAX_GENERIC; i++) {
-		struct kvm_pmc *pmc = &pmu->gp_counters[i];
-
-		pmc_stop_counter(pmc);
+		pmc = &pmu->gp_counters[i];
+		intel_pmc_stop_counter(pmc);
 		pmc->counter = pmc->eventsel = 0;
 	}
 
-	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++)
-		pmc_stop_counter(&pmu->fixed_counters[i]);
+	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
+		pmc = &pmu->fixed_counters[i];
+		intel_pmc_stop_counter(pmc);
+		pmc->counter = 0;
+	}
 
 	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status =
 		pmu->global_ovf_ctrl = 0;
-- 
1.8.3.1

