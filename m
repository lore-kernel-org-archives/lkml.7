Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1594AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D789C218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCWOS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:18:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:28331 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfCWOSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:18:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 07:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129543551"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2019 07:18:53 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] [PATCH v2 2/5] KVM/x86/vPMU: add pmc operations for vmx and count to track release
Date:   Sat, 23 Mar 2019 22:18:05 +0800
Message-Id: <1553350688-39627-3-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduced hw_life_count is initialized with HW_LIFE_COUNT_MAX
when the vPMC holds a hw-assigned perf_event and the kvm_pmu_sched ctx
would start counting down (0 means to be released) if not be charged.

If vPMC is assigned, the intel_pmc_read_counter() would use rdpmcl
directly not perf_event_read_value() and charge hw_life_count to max.

To clear out responsibility for potential operating space in kvm,
this patch is not going to invoke similar functions from host perf.

Signed-off-by: Wang Wei <wei.w.wang@intel.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/vmx/pmu_intel.c    | 98 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a5db447..2a2c78f2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -449,6 +449,7 @@ enum pmc_type {
 	KVM_PMC_FIXED,
 };
 
+#define	HW_LIFE_COUNT_MAX	2
 struct kvm_pmc {
 	enum pmc_type type;
 	u8 idx;
@@ -456,6 +457,7 @@ struct kvm_pmc {
 	u64 eventsel;
 	struct perf_event *perf_event;
 	struct kvm_vcpu *vcpu;
+	int hw_life_count;
 };
 
 struct kvm_pmu {
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 5ab4a36..bb16031 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -35,6 +35,104 @@
 /* mapping between fixed pmc index and intel_arch_events array */
 static int fixed_pmc_events[] = {1, 0, 7};
 
+static bool intel_pmc_is_assigned(struct kvm_pmc *pmc)
+{
+	return pmc->perf_event != NULL &&
+		   pmc->perf_event->hw.idx != -1 &&
+		   pmc->perf_event->oncpu != -1;
+}
+
+static int intel_pmc_read_counter(struct kvm_vcpu *vcpu,
+	unsigned int idx, u64 *data)
+{
+	struct kvm_pmc *pmc = kvm_x86_ops->pmu_ops->msr_idx_to_pmc(vcpu, idx);
+
+	if (intel_pmc_is_assigned(pmc)) {
+		rdpmcl(pmc->perf_event->hw.event_base_rdpmc, *data);
+		pmc->counter = *data;
+		pmc->hw_life_count = HW_LIFE_COUNT_MAX;
+	} else {
+		*data = pmc->counter;
+	}
+	return 0;
+}
+
+static void intel_pmu_enable_host_gp_counter(struct kvm_pmc *pmc)
+{
+	u64 config;
+
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	config = (pmc->type == KVM_PMC_GP) ? pmc->eventsel :
+		pmc->perf_event->hw.config | ARCH_PERFMON_EVENTSEL_ENABLE;
+	wrmsrl(pmc->perf_event->hw.config_base, config);
+}
+
+static void intel_pmu_disable_host_gp_counter(struct kvm_pmc *pmc)
+{
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	wrmsrl(pmc->perf_event->hw.config_base, 0);
+}
+
+static void intel_pmu_enable_host_fixed_counter(struct kvm_pmc *pmc)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(pmc->vcpu);
+	int host_idx = pmc->perf_event->hw.idx - INTEL_PMC_IDX_FIXED;
+	u64 ctrl_val, mask, bits = 0;
+
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	if (!pmc->perf_event->attr.precise_ip)
+		bits |= 0x8;
+	if (pmc->perf_event->hw.config & ARCH_PERFMON_EVENTSEL_USR)
+		bits |= 0x2;
+	if (pmc->perf_event->hw.config & ARCH_PERFMON_EVENTSEL_OS)
+		bits |= 0x1;
+
+	if (pmu->version > 2
+		&& (pmc->perf_event->hw.config & ARCH_PERFMON_EVENTSEL_ANY))
+		bits |= 0x4;
+
+	bits <<= (host_idx * 4);
+	mask = 0xfULL << (host_idx * 4);
+
+	rdmsrl(pmc->perf_event->hw.config_base, ctrl_val);
+	ctrl_val &= ~mask;
+	ctrl_val |= bits;
+	wrmsrl(pmc->perf_event->hw.config_base, ctrl_val);
+}
+
+static void intel_pmu_disable_host_fixed_counter(struct kvm_pmc *pmc)
+{
+	u64 ctrl_val, mask = 0;
+	u8 host_idx;
+
+	if (!intel_pmc_is_assigned(pmc))
+		return;
+
+	host_idx = pmc->perf_event->hw.idx - INTEL_PMC_IDX_FIXED;
+	mask = 0xfULL << (host_idx * 4);
+	rdmsrl(pmc->perf_event->hw.config_base, ctrl_val);
+	ctrl_val &= ~mask;
+	wrmsrl(pmc->perf_event->hw.config_base, ctrl_val);
+}
+
+static void intel_pmu_update_host_fixed_ctrl(u64 new_ctrl, u8 host_idx)
+{
+	u64 host_ctrl, mask;
+
+	rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, host_ctrl);
+	mask = 0xfULL << (host_idx * 4);
+	host_ctrl &= ~mask;
+	new_ctrl <<= (host_idx * 4);
+	host_ctrl |= new_ctrl;
+	wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, host_ctrl);
+}
+
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
 	int i;
-- 
1.8.3.1

