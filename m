Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1089C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1CA208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfD0PYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727487AbfD0PP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2y-0000z6-LZ; Sat, 27 Apr 2019 16:15:24 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004aM-CZ; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Vince Weaver" <vincent.weaver@maine.edu>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Ravi Bangoria" <ravi.bangoria@linux.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.810277723@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 145/202] perf/x86: Add check_period PMU callback
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@redhat.com>

commit 81ec3f3c4c4d78f2d3b6689c9816bfbdf7417dbb upstream.

Vince (and later on Ravi) reported crashes in the BTS code during
fuzzing with the following backtrace:

  general protection fault: 0000 [#1] SMP PTI
  ...
  RIP: 0010:perf_prepare_sample+0x8f/0x510
  ...
  Call Trace:
   <IRQ>
   ? intel_pmu_drain_bts_buffer+0x194/0x230
   intel_pmu_drain_bts_buffer+0x160/0x230
   ? tick_nohz_irq_exit+0x31/0x40
   ? smp_call_function_single_interrupt+0x48/0xe0
   ? call_function_single_interrupt+0xf/0x20
   ? call_function_single_interrupt+0xa/0x20
   ? x86_schedule_events+0x1a0/0x2f0
   ? x86_pmu_commit_txn+0xb4/0x100
   ? find_busiest_group+0x47/0x5d0
   ? perf_event_set_state.part.42+0x12/0x50
   ? perf_mux_hrtimer_restart+0x40/0xb0
   intel_pmu_disable_event+0xae/0x100
   ? intel_pmu_disable_event+0xae/0x100
   x86_pmu_stop+0x7a/0xb0
   x86_pmu_del+0x57/0x120
   event_sched_out.isra.101+0x83/0x180
   group_sched_out.part.103+0x57/0xe0
   ctx_sched_out+0x188/0x240
   ctx_resched+0xa8/0xd0
   __perf_event_enable+0x193/0x1e0
   event_function+0x8e/0xc0
   remote_function+0x41/0x50
   flush_smp_call_function_queue+0x68/0x100
   generic_smp_call_function_single_interrupt+0x13/0x30
   smp_call_function_single_interrupt+0x3e/0xe0
   call_function_single_interrupt+0xf/0x20
   </IRQ>

The reason is that while event init code does several checks
for BTS events and prevents several unwanted config bits for
BTS event (like precise_ip), the PERF_EVENT_IOC_PERIOD allows
to create BTS event without those checks being done.

Following sequence will cause the crash:

If we create an 'almost' BTS event with precise_ip and callchains,
and it into a BTS event it will crash the perf_prepare_sample()
function because precise_ip events are expected to come
in with callchain data initialized, but that's not the
case for intel_pmu_drain_bts_buffer() caller.

Adding a check_period callback to be called before the period
is changed via PERF_EVENT_IOC_PERIOD. It will deny the change
if the event would become BTS. Plus adding also the limit_period
check as well.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190204123532.GA4794@krava
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - Don't call limit_period operation, which doesn't exist and isn't needed here
 - Add the intel_pmu_has_bts() function, which didn't previously exist here
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1920,6 +1920,14 @@ void perf_check_microcode(void)
 }
 EXPORT_SYMBOL_GPL(perf_check_microcode);
 
+static int x86_pmu_check_period(struct perf_event *event, u64 value)
+{
+	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -1940,6 +1948,7 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.flush_branch_stack	= x86_pmu_flush_branch_stack,
+	.check_period		= x86_pmu_check_period,
 };
 
 void arch_perf_update_userpage(struct perf_event_mmap_page *userpg, u64 now)
--- a/arch/x86/kernel/cpu/perf_event.h
+++ b/arch/x86/kernel/cpu/perf_event.h
@@ -473,6 +473,11 @@ struct x86_pmu {
 	 * Intel host/guest support (KVM)
 	 */
 	struct perf_guest_switch_msr *(*guest_get_msrs)(int *nr);
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period) (struct perf_event *event, u64 period);
 };
 
 #define x86_add_quirk(func_)						\
@@ -634,6 +639,22 @@ static inline int amd_pmu_init(void)
 
 #ifdef CONFIG_CPU_SUP_INTEL
 
+static inline bool intel_pmu_has_bts_period(struct perf_event *event, u64 period)
+{
+	if (event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
+	    !event->attr.freq && period == 1)
+		return true;
+
+	return false;
+}
+
+static inline bool intel_pmu_has_bts(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	return intel_pmu_has_bts_period(event, hwc->sample_period);
+}
+
 int intel_pmu_save_and_restart(struct perf_event *event);
 
 struct event_constraint *
--- a/arch/x86/kernel/cpu/perf_event_intel.c
+++ b/arch/x86/kernel/cpu/perf_event_intel.c
@@ -1969,6 +1969,11 @@ ssize_t intel_event_sysfs_show(char *pag
 	return x86_event_sysfs_show(page, config, event);
 }
 
+static int intel_pmu_check_period(struct perf_event *event, u64 value)
+{
+	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
+}
+
 static __initconst const struct x86_pmu core_pmu = {
 	.name			= "core",
 	.handle_irq		= x86_pmu_handle_irq,
@@ -1995,6 +2000,8 @@ static __initconst const struct x86_pmu
 	.guest_get_msrs		= core_guest_get_msrs,
 	.format_attrs		= intel_arch_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 struct intel_shared_regs *allocate_shared_regs(int cpu)
@@ -2145,6 +2152,8 @@ static __initconst const struct x86_pmu
 	.cpu_dying		= intel_pmu_cpu_dying,
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.flush_branch_stack	= intel_pmu_flush_branch_stack,
+
+	.check_period		= intel_pmu_check_period,
 };
 
 static __init void intel_clovertown_quirk(void)
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -262,6 +262,11 @@ struct pmu {
 	 * flush branch stack on context-switches (needed in cpu-wide mode)
 	 */
 	void (*flush_branch_stack)	(void);
+
+	/*
+	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 */
+	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
 };
 
 /**
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3805,6 +3805,11 @@ static int __perf_event_period(void *inf
 	return 0;
 }
 
+static int perf_event_check_period(struct perf_event *event, u64 value)
+{
+	return event->pmu->check_period(event, value);
+}
+
 static int perf_event_period(struct perf_event *event, u64 __user *arg)
 {
 	struct period_event pe = { .event = event, };
@@ -3824,6 +3829,9 @@ static int perf_event_period(struct perf
 	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
 		return -EINVAL;
 
+	if (perf_event_check_period(event, value))
+		return -EINVAL;
+
 	task = ctx->task;
 	pe.value = value;
 
@@ -6649,6 +6657,11 @@ static int perf_pmu_nop_int(struct pmu *
 	return 0;
 }
 
+static int perf_event_nop_int(struct perf_event *event, u64 value)
+{
+	return 0;
+}
+
 static void perf_pmu_start_txn(struct pmu *pmu)
 {
 	perf_pmu_disable(pmu);
@@ -6903,6 +6916,9 @@ got_cpu_context:
 		pmu->pmu_disable = perf_pmu_nop_void;
 	}
 
+	if (!pmu->check_period)
+		pmu->check_period = perf_event_nop_int;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 

