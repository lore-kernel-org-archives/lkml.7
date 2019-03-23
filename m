Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE067C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E08218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfCWOSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:18:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:28331 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfCWOSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:18:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 07:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129543546"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2019 07:18:51 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] [PATCH v2 1/5] perf/x86: avoid host changing counter state for kvm_intel events holder
Date:   Sat, 23 Mar 2019 22:18:04 +0800
Message-Id: <1553350688-39627-2-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an perf_event is used by intel vPMU, the vPMU would be responsible
for updating its event_base and config_base. Just checking the writes not
including reading helps perf_events run as usual.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/events/core.c       | 37 +++++++++++++++++++++++++++++++++----
 arch/x86/events/intel/core.c |  5 +++--
 arch/x86/events/perf_event.h | 13 +++++++++----
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447..d4b5fc0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1120,6 +1120,35 @@ static void x86_pmu_enable(struct pmu *pmu)
 static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
 
 /*
+ * If this is an event used by intel vPMU,
+ * intel_kvm_pmu would be responsible for updating the HW.
+ */
+void x86_perf_event_set_event_base(struct perf_event *event,
+	unsigned long val)
+{
+	if (event->attr.exclude_host &&
+			boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return;
+
+	wrmsrl(event->hw.event_base, val);
+}
+
+void x86_perf_event_set_config_base(struct perf_event *event,
+	unsigned long val, bool set_extra_config)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.exclude_host &&
+			boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return;
+
+	if (set_extra_config)
+		wrmsrl(hwc->extra_reg.reg, hwc->extra_reg.config);
+
+	wrmsrl(event->hw.config_base, val);
+}
+
+/*
  * Set the next IRQ period, based on the hwc->period_left value.
  * To be called with the event disabled in hw:
  */
@@ -1169,17 +1198,17 @@ int x86_perf_event_set_period(struct perf_event *event)
 	 */
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
+	x86_perf_event_set_event_base(event,
+		(u64)(-left) & x86_pmu.cntval_mask);
 
 	/*
 	 * Due to erratum on certan cpu we need
 	 * a second write to be sure the register
 	 * is updated properly
 	 */
-	if (x86_pmu.perfctr_second_write) {
-		wrmsrl(hwc->event_base,
+	if (x86_pmu.perfctr_second_write)
+		x86_perf_event_set_event_base(event,
 			(u64)(-left) & x86_pmu.cntval_mask);
-	}
 
 	perf_event_update_userpage(event);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8baa441..817257c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2061,6 +2061,7 @@ static inline void intel_pmu_ack_status(u64 ack)
 
 static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
 {
+	struct perf_event *event = container_of(hwc, struct perf_event, hw);
 	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask;
 
@@ -2068,7 +2069,7 @@ static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
 
 	rdmsrl(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
-	wrmsrl(hwc->config_base, ctrl_val);
+	x86_perf_event_set_config_base(event, ctrl_val, false);
 }
 
 static inline bool event_is_checkpointed(struct perf_event *event)
@@ -2148,7 +2149,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	rdmsrl(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	ctrl_val |= bits;
-	wrmsrl(hwc->config_base, ctrl_val);
+	x86_perf_event_set_config_base(event, ctrl_val, false);
 }
 
 static void intel_pmu_enable_event(struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a759557..3029960 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -726,6 +726,11 @@ static inline bool x86_pmu_has_lbr_callstack(void)
 
 int x86_perf_event_set_period(struct perf_event *event);
 
+void x86_perf_event_set_config_base(struct perf_event *event,
+	unsigned long val, bool set_extra_config);
+void x86_perf_event_set_event_base(struct perf_event *event,
+	unsigned long val);
+
 /*
  * Generalized hw caching related hw_event table, filled
  * in on a per model basis. A value of 0 means
@@ -785,11 +790,11 @@ static inline int x86_pmu_rdpmc_index(int index)
 static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 					  u64 enable_mask)
 {
+	struct perf_event *event = container_of(hwc, struct perf_event, hw);
 	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 
-	if (hwc->extra_reg.reg)
-		wrmsrl(hwc->extra_reg.reg, hwc->extra_reg.config);
-	wrmsrl(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
+	x86_perf_event_set_config_base(event,
+		(hwc->config | enable_mask) & ~disable_mask, true);
 }
 
 void x86_pmu_enable_all(int added);
@@ -804,7 +809,7 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config);
+	x86_perf_event_set_config_base(event, hwc->config, false);
 }
 
 void x86_pmu_enable_event(struct perf_event *event);
-- 
1.8.3.1

