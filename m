Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CAFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D1E20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555074410;
	bh=ZYnwcJDMvVpJ3oy9GhqXfrbGjHhW+07tKPtLBUs+rGk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=LlKXazVtUuXV9qyCFZAZvFWfm8fCb+9QpcEN5Zlf9yQjRDlXbAotI6DkrnmS6uVEg
	 y1RQdL/jyBos2EuIrK7r3rvjaLz87YUKeP/SjDma7q2wuL8bfg5O8fRCB3GxyfKVue
	 q2tNfLODo9kRpR4fh/u+/wOugY7v/deXRoGhrtCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfDLNGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:06:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50524 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLNGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:06:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so11223075wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NUYsJNJCtdTmThlpAvJloLw8EnmqIWl3fW1RWHftPrc=;
        b=jDpX+uy9haXp9NYz1H1Bd9jerG2PymNU3AMH5jOCc43a+wG7UwJ2rNauWMnVWITW43
         gSuB/XX5/fOLkh8YEllvKE+Lhxxcii/CRZ0cmZaW5RhqOalzqIwUVanr/XrK5tg/dmwk
         /2yNiLXm/TwiTT0rgKe/HYaLYWgoJkOqrPuj0mnN/bMTETEhbW/wRpqr0xYV9t0OOG5r
         GG4dTRwae05CQ/1kLKKeol7mzZeuG157FtXmAV9Lq4Kx9l/6KDClr9U5jrx7rnXpTpbk
         eiP0yyYZFDIy3yTUSC/wcX/zAT81ZO/H8Tj9jzgAX4YQa2g3If+aEYkjUOgd1m3N1vy2
         +ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=NUYsJNJCtdTmThlpAvJloLw8EnmqIWl3fW1RWHftPrc=;
        b=KFba3zZHM5vFy+xQ++l9zukM1mzM5Y3SBL08PKqlLeZl/0CbWFUQifdOI51jwXIqbb
         dW/rdMSiBw+/bItoSmlmKlo7NFxsSuD3SVnKOnszTYxuVG6CW7RsWCVEvkJycHktQmXq
         Y3e7M/vYxK/qXq4KfxyjTiay4maLgO2jXXAnxUmE0j2LO3pBr3ujbGYpSBYJXcGZ1NlR
         ys0wsbZeO/l87HxP6LnCgckwf91My3sCAV9YhNn3yNboGlf/HQXIgH4J+KCNZcOcVDyc
         wTHc4q3xmVzAdaXIW6WaOdAaxZ1PBhKa/aMbG47NewX1qnqELRWq5pF387455RurpzyG
         iOWg==
X-Gm-Message-State: APjAAAXPeLKWphWIpSzpOfoZTU0SGD3cVL7FNGUZk3AVVQ8ujGixYWg1
        A/biuETEDZPbd3diaDZ4it4=
X-Google-Smtp-Source: APXvYqyIBE7WsCNOxjOLjS9MjtrbgFFcQC/bLQ7sL1b7aLLhaMtOHfP8PRCGwF5m0kDwsbTe3BD64w==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr11514609wma.129.1555074405116;
        Fri, 12 Apr 2019 06:06:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w130sm10992117wma.36.2019.04.12.06.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 06:06:44 -0700 (PDT)
Date:   Fri, 12 Apr 2019 15:06:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] perf fixes
Message-ID: <20190412130642.GA29980@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 1d54ad944074010609562da5c89e4f5df2f4e5db perf/core: Fix perf_event_disable_inatomic() race

Six kernel side fixes: three related to NMI handling on AMD systems, a 
race fix, a kexec initialization fix and a PEBS sampling fix.

 Thanks,

	Ingo

------------------>
Lendacky, Thomas (3):
      x86/perf/amd: Resolve race condition when disabling PMC
      x86/perf/amd: Resolve NMI latency issues for active PMCs
      x86/perf/amd: Remove need to check "running" bit in NMI handler

Peter Zijlstra (2):
      perf/x86/intel: Initialize TFA MSR
      perf/core: Fix perf_event_disable_inatomic() race

Stephane Eranian (1):
      perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS


 arch/x86/events/amd/core.c   | 140 +++++++++++++++++++++++++++++++++++++++++--
 arch/x86/events/core.c       |  13 +---
 arch/x86/events/intel/core.c |   8 ++-
 kernel/events/core.c         |  52 +++++++++++++---
 kernel/events/ring_buffer.c  |   4 +-
 5 files changed, 190 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 7d2d7c801dba..0ecfac84ba91 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -3,10 +3,14 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <asm/apicdef.h>
+#include <asm/nmi.h>
 
 #include "../perf_event.h"
 
+static DEFINE_PER_CPU(unsigned int, perf_nmi_counter);
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -429,6 +433,132 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
+/*
+ * When a PMC counter overflows, an NMI is used to process the event and
+ * reset the counter. NMI latency can result in the counter being updated
+ * before the NMI can run, which can result in what appear to be spurious
+ * NMIs. This function is intended to wait for the NMI to run and reset
+ * the counter to avoid possible unhandled NMI messages.
+ */
+#define OVERFLOW_WAIT_COUNT	50
+
+static void amd_pmu_wait_on_overflow(int idx)
+{
+	unsigned int i;
+	u64 counter;
+
+	/*
+	 * Wait for the counter to be reset if it has overflowed. This loop
+	 * should exit very, very quickly, but just in case, don't wait
+	 * forever...
+	 */
+	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
+		rdmsrl(x86_pmu_event_addr(idx), counter);
+		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
+			break;
+
+		/* Might be in IRQ context, so can't sleep */
+		udelay(1);
+	}
+}
+
+static void amd_pmu_disable_all(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int idx;
+
+	x86_pmu_disable_all();
+
+	/*
+	 * This shouldn't be called from NMI context, but add a safeguard here
+	 * to return, since if we're in NMI context we can't wait for an NMI
+	 * to reset an overflowed counter value.
+	 */
+	if (in_nmi())
+		return;
+
+	/*
+	 * Check each counter for overflow and wait for it to be reset by the
+	 * NMI if it has overflowed. This relies on the fact that all active
+	 * counters are always enabled when this function is caled and
+	 * ARCH_PERFMON_EVENTSEL_INT is always set.
+	 */
+	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
+		amd_pmu_wait_on_overflow(idx);
+	}
+}
+
+static void amd_pmu_disable_event(struct perf_event *event)
+{
+	x86_pmu_disable_event(event);
+
+	/*
+	 * This can be called from NMI context (via x86_pmu_stop). The counter
+	 * may have overflowed, but either way, we'll never see it get reset
+	 * by the NMI if we're already in the NMI. And the NMI latency support
+	 * below will take care of any pending NMI that might have been
+	 * generated by the overflow.
+	 */
+	if (in_nmi())
+		return;
+
+	amd_pmu_wait_on_overflow(event->hw.idx);
+}
+
+/*
+ * Because of NMI latency, if multiple PMC counters are active or other sources
+ * of NMIs are received, the perf NMI handler can handle one or more overflowed
+ * PMC counters outside of the NMI associated with the PMC overflow. If the NMI
+ * doesn't arrive at the LAPIC in time to become a pending NMI, then the kernel
+ * back-to-back NMI support won't be active. This PMC handler needs to take into
+ * account that this can occur, otherwise this could result in unknown NMI
+ * messages being issued. Examples of this is PMC overflow while in the NMI
+ * handler when multiple PMCs are active or PMC overflow while handling some
+ * other source of an NMI.
+ *
+ * Attempt to mitigate this by using the number of active PMCs to determine
+ * whether to return NMI_HANDLED if the perf NMI handler did not handle/reset
+ * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of the
+ * number of active PMCs or 2. The value of 2 is used in case an NMI does not
+ * arrive at the LAPIC in time to be collapsed into an already pending NMI.
+ */
+static int amd_pmu_handle_irq(struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int active, handled;
+
+	/*
+	 * Obtain the active count before calling x86_pmu_handle_irq() since
+	 * it is possible that x86_pmu_handle_irq() may make a counter
+	 * inactive (through x86_pmu_stop).
+	 */
+	active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
+
+	/* Process any counter overflows */
+	handled = x86_pmu_handle_irq(regs);
+
+	/*
+	 * If a counter was handled, record the number of possible remaining
+	 * NMIs that can occur.
+	 */
+	if (handled) {
+		this_cpu_write(perf_nmi_counter,
+			       min_t(unsigned int, 2, active));
+
+		return handled;
+	}
+
+	if (!this_cpu_read(perf_nmi_counter))
+		return NMI_DONE;
+
+	this_cpu_dec(perf_nmi_counter);
+
+	return NMI_HANDLED;
+}
+
 static struct event_constraint *
 amd_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -621,11 +751,11 @@ static ssize_t amd_event_sysfs_show(char *page, u64 config)
 
 static __initconst const struct x86_pmu amd_pmu = {
 	.name			= "AMD",
-	.handle_irq		= x86_pmu_handle_irq,
-	.disable_all		= x86_pmu_disable_all,
+	.handle_irq		= amd_pmu_handle_irq,
+	.disable_all		= amd_pmu_disable_all,
 	.enable_all		= x86_pmu_enable_all,
 	.enable			= x86_pmu_enable_event,
-	.disable		= x86_pmu_disable_event,
+	.disable		= amd_pmu_disable_event,
 	.hw_config		= amd_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_K7_EVNTSEL0,
@@ -732,7 +862,7 @@ void amd_pmu_enable_virt(void)
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
@@ -750,7 +880,7 @@ void amd_pmu_disable_virt(void)
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
 
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..81911e11a15d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1349,8 +1349,9 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (__test_and_clear_bit(hwc->idx, cpuc->active_mask)) {
+	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		x86_pmu.disable(event);
+		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
@@ -1447,16 +1448,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
-		if (!test_bit(idx, cpuc->active_mask)) {
-			/*
-			 * Though we deactivated the counter some cpus
-			 * might still deliver spurious interrupts still
-			 * in flight. Catch them:
-			 */
-			if (__test_and_clear_bit(idx, cpuc->running))
-				handled++;
+		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		}
 
 		event = cpuc->events[idx];
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8baa441d8000..f61dcbef20ff 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3185,7 +3185,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!event->attr.freq) {
+		if (!(event->attr.freq || event->attr.wakeup_events)) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event)))
@@ -3575,6 +3575,12 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	cpuc->lbr_sel = NULL;
 
+	if (x86_pmu.flags & PMU_FL_TFA) {
+		WARN_ON_ONCE(cpuc->tfa_shadow);
+		cpuc->tfa_shadow = ~0ULL;
+		intel_set_tfa(cpuc, false);
+	}
+
 	if (x86_pmu.version > 1)
 		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 72d06e302e99..534e01e7bc36 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2009,8 +2009,8 @@ event_sched_out(struct perf_event *event,
 	event->pmu->del(event, 0);
 	event->oncpu = -1;
 
-	if (event->pending_disable) {
-		event->pending_disable = 0;
+	if (READ_ONCE(event->pending_disable) >= 0) {
+		WRITE_ONCE(event->pending_disable, -1);
 		state = PERF_EVENT_STATE_OFF;
 	}
 	perf_event_set_state(event, state);
@@ -2198,7 +2198,8 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 
 void perf_event_disable_inatomic(struct perf_event *event)
 {
-	event->pending_disable = 1;
+	WRITE_ONCE(event->pending_disable, smp_processor_id());
+	/* can fail, see perf_pending_event_disable() */
 	irq_work_queue(&event->pending);
 }
 
@@ -5810,10 +5811,45 @@ void perf_event_wakeup(struct perf_event *event)
 	}
 }
 
+static void perf_pending_event_disable(struct perf_event *event)
+{
+	int cpu = READ_ONCE(event->pending_disable);
+
+	if (cpu < 0)
+		return;
+
+	if (cpu == smp_processor_id()) {
+		WRITE_ONCE(event->pending_disable, -1);
+		perf_event_disable_local(event);
+		return;
+	}
+
+	/*
+	 *  CPU-A			CPU-B
+	 *
+	 *  perf_event_disable_inatomic()
+	 *    @pending_disable = CPU-A;
+	 *    irq_work_queue();
+	 *
+	 *  sched-out
+	 *    @pending_disable = -1;
+	 *
+	 *				sched-in
+	 *				perf_event_disable_inatomic()
+	 *				  @pending_disable = CPU-B;
+	 *				  irq_work_queue(); // FAILS
+	 *
+	 *  irq_work_run()
+	 *    perf_pending_event()
+	 *
+	 * But the event runs on CPU-B and wants disabling there.
+	 */
+	irq_work_queue_on(&event->pending, cpu);
+}
+
 static void perf_pending_event(struct irq_work *entry)
 {
-	struct perf_event *event = container_of(entry,
-			struct perf_event, pending);
+	struct perf_event *event = container_of(entry, struct perf_event, pending);
 	int rctx;
 
 	rctx = perf_swevent_get_recursion_context();
@@ -5822,10 +5858,7 @@ static void perf_pending_event(struct irq_work *entry)
 	 * and we won't recurse 'further'.
 	 */
 
-	if (event->pending_disable) {
-		event->pending_disable = 0;
-		perf_event_disable_local(event);
-	}
+	perf_pending_event_disable(event);
 
 	if (event->pending_wakeup) {
 		event->pending_wakeup = 0;
@@ -10236,6 +10269,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 
 	init_waitqueue_head(&event->waitq);
+	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
 
 	mutex_init(&event->mmap_mutex);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index a4047321d7d8..2545ac08cc77 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -392,7 +392,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 		 * store that will be enabled on successful return
 		 */
 		if (!handle->size) { /* A, matches D */
-			event->pending_disable = 1;
+			event->pending_disable = smp_processor_id();
 			perf_output_wakeup(handle);
 			local_set(&rb->aux_nest, 0);
 			goto err_put;
@@ -480,7 +480,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 
 	if (wakeup) {
 		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
-			handle->event->pending_disable = 1;
+			handle->event->pending_disable = smp_processor_id();
 		perf_output_wakeup(handle);
 	}
 
