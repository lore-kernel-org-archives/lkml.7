Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D1C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5DB208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfE0TJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:09:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:48012 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfE0TI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 12:08:59 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2019 12:08:56 -0700
From:   kan.liang@linux.intel.com
To:     mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        jolsa@redhat.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/3] perf/x86: Disable non generic regs for software/probe events
Date:   Mon, 27 May 2019 12:07:55 -0700
Message-Id: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com>
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

The XMM registers can only be collected by hardware events, not
software/probe events.

Add has_non_generic_regs() to check if non-generic registers, e.g. XMM
on X86, are applied for software/probe events. If yes, return
-EOPNOTSUPP.

The generic code define the mask of non-generic registers as 0 if arch
headers haven't overridden it.

Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Use macro PERF_REG_NON_GENERIC_MASK to replace function
- Avoid unnecessary abbreviations in comments
- Remove unnecessary bracket for return.

 arch/x86/include/uapi/asm/perf_regs.h |  3 +++
 include/linux/perf_regs.h             |  8 ++++++++
 kernel/events/core.c                  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index ac67bbe..3a96971 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -52,4 +52,7 @@ enum perf_event_x86_regs {
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
+
+#define PERF_REG_NON_GENERIC_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 4767474..1d794355 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -11,6 +11,11 @@ struct perf_regs {
 
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
+
+#ifndef PERF_REG_NON_GENERIC_MASK
+#define PERF_REG_NON_GENERIC_MASK	0
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
+#define PERF_REG_NON_GENERIC_MASK	0
+
 static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	return 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3..4865bdf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8457,6 +8457,12 @@ static void sw_perf_event_destroy(struct perf_event *event)
 	swevent_hlist_put();
 }
 
+static inline bool has_non_generic_regs(struct perf_event *event)
+{
+	return (event->attr.sample_regs_user & PERF_REG_NON_GENERIC_MASK) ||
+	       (event->attr.sample_regs_intr & PERF_REG_NON_GENERIC_MASK);
+}
+
 static int perf_swevent_init(struct perf_event *event)
 {
 	u64 event_id = event->attr.config;
@@ -8470,6 +8476,10 @@ static int perf_swevent_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* Only support generic registers */
+	if (has_non_generic_regs(event))
+		return -EOPNOTSUPP;
+
 	switch (event_id) {
 	case PERF_COUNT_SW_CPU_CLOCK:
 	case PERF_COUNT_SW_TASK_CLOCK:
@@ -8633,6 +8643,10 @@ static int perf_tp_event_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* Only support generic registers */
+	if (has_non_generic_regs(event))
+		return -EOPNOTSUPP;
+
 	err = perf_trace_init(event);
 	if (err)
 		return err;
@@ -8722,6 +8736,10 @@ static int perf_kprobe_event_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* Only support generic registers */
+	if (has_non_generic_regs(event))
+		return -EOPNOTSUPP;
+
 	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
 	err = perf_kprobe_init(event, is_retprobe);
 	if (err)
@@ -8782,6 +8800,10 @@ static int perf_uprobe_event_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* Only support generic registers */
+	if (has_non_generic_regs(event))
+		return -EOPNOTSUPP;
+
 	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
 	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
 	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
@@ -9562,6 +9584,10 @@ static int cpu_clock_event_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* Only support generic registers */
+	if (has_non_generic_regs(event))
+		return -EOPNOTSUPP;
+
 	perf_swevent_init_hrtimer(event);
 
 	return 0;
@@ -9643,6 +9669,10 @@ static int task_clock_event_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* Only support generic registers */
+	if (has_non_generic_regs(event))
+		return -EOPNOTSUPP;
+
 	perf_swevent_init_hrtimer(event);
 
 	return 0;
-- 
2.7.4

