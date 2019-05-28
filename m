Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D17BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CC52075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfE1WJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:09:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:11133 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfE1WJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:09:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 15:09:10 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2019 15:09:10 -0700
From:   kan.liang@linux.intel.com
To:     mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        jolsa@redhat.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/5] perf: Disable extended registers for non-support PMUs
Date:   Tue, 28 May 2019 15:08:30 -0700
Message-Id: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf fuzzer caused skylake machine to crash.

[ 9680.085831] Call Trace:
[ 9680.088301]  <IRQ>
[ 9680.090363]  perf_output_sample_regs+0x43/0xa0
[ 9680.094928]  perf_output_sample+0x3aa/0x7a0
[ 9680.099181]  perf_event_output_forward+0x53/0x80
[ 9680.103917]  __perf_event_overflow+0x52/0xf0
[ 9680.108266]  ? perf_trace_run_bpf_submit+0xc0/0xc0
[ 9680.113108]  perf_swevent_hrtimer+0xe2/0x150
[ 9680.117475]  ? check_preempt_wakeup+0x181/0x230
[ 9680.122091]  ? check_preempt_curr+0x62/0x90
[ 9680.126361]  ? ttwu_do_wakeup+0x19/0x140
[ 9680.130355]  ? try_to_wake_up+0x54/0x460
[ 9680.134366]  ? reweight_entity+0x15b/0x1a0
[ 9680.138559]  ? __queue_work+0x103/0x3f0
[ 9680.142472]  ? update_dl_rq_load_avg+0x1cd/0x270
[ 9680.147194]  ? timerqueue_del+0x1e/0x40
[ 9680.151092]  ? __remove_hrtimer+0x35/0x70
[ 9680.155191]  __hrtimer_run_queues+0x100/0x280
[ 9680.159658]  hrtimer_interrupt+0x100/0x220
[ 9680.163835]  smp_apic_timer_interrupt+0x6a/0x140
[ 9680.168555]  apic_timer_interrupt+0xf/0x20
[ 9680.172756]  </IRQ>

The XMM registers can only be collected by PEBS hardware events on the
platforms with PEBS baseline support, e.g. Icelake, not software/probe
events.

Add capabilities flag PERF_PMU_CAP_EXTENDED_REGS to indicate the PMU
which support extended registers. For X86, the extended registers are
XMM registers.

Add has_extended_regs() to check if extended registers are applied.

The generic code define the mask of extended registers as 0 if arch
headers haven't overridden it.

Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Rename PERF_REG_NON_GENERIC_MASK to PERF_REG_EXTENDED_MASK
- Rename has_non_generic_regs() to has_extended_regs()
- Add capabilities flag PERF_PMU_CAP_EXTENDED_REGS
- Don't check separately. Check extended regs and flag in global
  perf_try_init_event()

 arch/x86/events/intel/ds.c            |  1 +
 arch/x86/include/uapi/asm/perf_regs.h |  3 +++
 include/linux/perf_event.h            |  1 +
 include/linux/perf_regs.h             |  8 ++++++++
 kernel/events/core.c                  | 18 ++++++++++++++----
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7a9f5da..f860cdd 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2020,6 +2020,7 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				pebs_qual = "-baseline";
+				x86_get_pmu()->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
 				x86_pmu.pebs_no_xmm_regs = 1;
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index ac67bbe..7c9d2bb 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -52,4 +52,7 @@ enum perf_event_x86_regs {
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
+
+#define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0ab99c7..2bca72f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -241,6 +241,7 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_INTERRUPT		0x01
 #define PERF_PMU_CAP_NO_NMI			0x02
 #define PERF_PMU_CAP_AUX_NO_SG			0x04
+#define PERF_PMU_CAP_EXTENDED_REGS		0x08
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 4767474..2d12e97 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -11,6 +11,11 @@ struct perf_regs {
 
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
+
+#ifndef PERF_REG_EXTENDED_MASK
+#define PERF_REG_EXTENDED_MASK	0
+#endif
+
 u64 perf_reg_value(struct pt_regs *regs, int idx);
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
@@ -18,6 +23,9 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs,
 			struct pt_regs *regs_user_copy);
 #else
+
+#define PERF_REG_EXTENDED_MASK	0
+
 static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	return 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3..62d8190 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10033,6 +10033,12 @@ void perf_pmu_unregister(struct pmu *pmu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
+static inline bool has_extended_regs(struct perf_event *event)
+{
+	return (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK) ||
+	       (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK);
+}
+
 static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 {
 	struct perf_event_context *ctx = NULL;
@@ -10064,12 +10070,16 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
 	if (!ret) {
+		if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
+		    has_extended_regs(event))
+			ret = -EOPNOTSUPP;
+
 		if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
-				event_has_any_exclude_flag(event)) {
-			if (event->destroy)
-				event->destroy(event);
+		    event_has_any_exclude_flag(event))
 			ret = -EINVAL;
-		}
+
+		if (ret && event->destroy)
+			event->destroy(event);
 	}
 
 	if (ret)
-- 
2.7.4

