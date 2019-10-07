Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF320C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D272173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lu2RrdL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfJGLZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IHiM4AEHxgTk89Fw+ckwRW7i/VFrPo7XG35BGVhzyIU=; b=Lu2RrdL/LjLFdFU/9mM2hnlriG
        OJDZSlQqGs+BN9VWG7R3M6RcKuu/o+3FiJTWVR4Ka7WIC87kBWQkRAcAXLZmRfS4v6v+88Mm+uyVh
        maihY3PEJnbFfcPEmRFHnaXyzuJEzF2jGDpnlfpHiE7jMKJwzaQ1yyAV7Rk6+SpvDozqiBYC4kACw
        pqu2dmVt5u1dUe+0SuDlGvNmIr2nLJbPz4Vtt6RFujPNthcbb6mHpy0eMPZkU5K+CVQ6aarz1yqoz
        yeTu9ZdlZM9b7e3EUW9qcZ7bfryMgMYmVW7tn+yqbSlv3f8+fATI/HdBjRgp9uYBfReURMQB7V6gC
        vYTfjRDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003H1-9U; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F1633072B4;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E41EF20244E3E; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083831.26880701.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RFC][PATCH v2 13/13] x86/perf, static_call: Optimize x86_pmu methods
References: <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace many of the indirect calls with static_call().

XXX run performance numbers

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |  136 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 98 insertions(+), 38 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/nospec.h>
+#include <linux/static_call.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -51,6 +52,45 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu
 
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
+static void _x86_pmu_add(struct perf_event *event) { }
+static void _x86_pmu_del(struct perf_event *event) { }
+static void _x86_pmu_read(struct perf_event *event) { x86_perf_event_update(event); }
+static void _x86_pmu_put_event_constraints(struct cpu_hw_events *cpuc, struct perf_event *event) { }
+static void _x86_pmu_drain_pebs(struct pt_regs *regs) { }
+static void _x86_pmu_pebs_aliases(struct perf_event *event) { }
+static void _x86_pmu_start_scheduling(struct cpu_hw_events *cpuc) { }
+static void _x86_pmu_commit_scheduling(struct cpu_hw_events *cpuc, int idx, int cntr) { }
+static void _x86_pmu_stop_scheduling(struct cpu_hw_events *cpuc) { }
+static void _x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) { }
+
+DEFINE_STATIC_CALL(x86_pmu_handle_irq, x86_pmu_handle_irq);
+DEFINE_STATIC_CALL(x86_pmu_disable_all, x86_pmu_disable_all);
+DEFINE_STATIC_CALL(x86_pmu_enable_all, x86_pmu_enable_all);
+DEFINE_STATIC_CALL(x86_pmu_enable, x86_pmu_enable_event);
+DEFINE_STATIC_CALL(x86_pmu_disable, x86_pmu_disable_event);
+
+DEFINE_STATIC_CALL(x86_pmu_add, _x86_pmu_add);
+DEFINE_STATIC_CALL(x86_pmu_del, _x86_pmu_del);
+DEFINE_STATIC_CALL(x86_pmu_read, _x86_pmu_read);
+
+DEFINE_STATIC_CALL(x86_pmu_schedule_events, x86_schedule_events);
+
+// addr_offset
+// rdpmc_index
+// event_map
+
+DEFINE_STATIC_CALL(x86_pmu_get_event_constraints, x86_get_event_constraints);
+DEFINE_STATIC_CALL(x86_pmu_put_event_constraints, _x86_pmu_put_event_constraints);
+
+DEFINE_STATIC_CALL(x86_pmu_drain_pebs, _x86_pmu_drain_pebs);
+DEFINE_STATIC_CALL(x86_pmu_pebs_aliases, _x86_pmu_pebs_aliases);
+
+DEFINE_STATIC_CALL(x86_pmu_start_scheduling, _x86_pmu_start_scheduling);
+DEFINE_STATIC_CALL(x86_pmu_commit_scheduling, _x86_pmu_commit_scheduling);
+DEFINE_STATIC_CALL(x86_pmu_stop_scheduling, _x86_pmu_stop_scheduling);
+
+DEFINE_STATIC_CALL(x86_pmu_sched_task, _x86_pmu_sched_task);
+
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -651,7 +691,7 @@ static void x86_pmu_disable(struct pmu *
 	cpuc->enabled = 0;
 	barrier();
 
-	x86_pmu.disable_all();
+	static_call(x86_pmu_disable_all)();
 }
 
 void x86_pmu_enable_all(int added)
@@ -884,8 +924,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	if (x86_pmu.start_scheduling)
-		x86_pmu.start_scheduling(cpuc);
+	static_cond_call(x86_pmu_start_scheduling)(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -902,7 +941,7 @@ int x86_schedule_events(struct cpu_hw_ev
 		 * change due to external factors (sibling state, allow_tfa).
 		 */
 		if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
-			c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
+			c = static_call(x86_pmu_get_event_constraints)(cpuc, i, cpuc->event_list[i]);
 			cpuc->event_constraint[i] = c;
 		}
 
@@ -969,8 +1008,7 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++) {
 			e = cpuc->event_list[i];
-			if (x86_pmu.commit_scheduling)
-				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
+			static_cond_call(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 		}
 	} else {
 		for (i = n0; i < n; i++) {
@@ -979,15 +1017,13 @@ int x86_schedule_events(struct cpu_hw_ev
 			/*
 			 * release events that failed scheduling
 			 */
-			if (x86_pmu.put_event_constraints)
-				x86_pmu.put_event_constraints(cpuc, e);
+			static_cond_call(x86_pmu_put_event_constraints)(cpuc, e);
 
 			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
-	if (x86_pmu.stop_scheduling)
-		x86_pmu.stop_scheduling(cpuc);
+	static_cond_call(x86_pmu_stop_scheduling)(cpuc);
 
 	return unsched ? -EINVAL : 0;
 }
@@ -1174,7 +1210,7 @@ static void x86_pmu_enable(struct pmu *p
 	cpuc->enabled = 1;
 	barrier();
 
-	x86_pmu.enable_all(added);
+	static_call(x86_pmu_enable_all)(added);
 }
 
 static DEFINE_PER_CPU(u64 [X86_PMC_IDX_MAX], pmc_prev_left);
@@ -1288,7 +1324,7 @@ static int x86_pmu_add(struct perf_event
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		goto out;
 	/*
@@ -1306,13 +1342,11 @@ static int x86_pmu_add(struct perf_event
 	cpuc->n_added += n - n0;
 	cpuc->n_txn += n - n0;
 
-	if (x86_pmu.add) {
-		/*
-		 * This is before x86_pmu_enable() will call x86_pmu_start(),
-		 * so we enable LBRs before an event needs them etc..
-		 */
-		x86_pmu.add(event);
-	}
+	/*
+	 * This is before x86_pmu_enable() will call x86_pmu_start(),
+	 * so we enable LBRs before an event needs them etc..
+	 */
+	static_cond_call(x86_pmu_add)(event);
 
 	ret = 0;
 out:
@@ -1340,7 +1374,7 @@ static void x86_pmu_start(struct perf_ev
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
 	__set_bit(idx, cpuc->running);
-	x86_pmu.enable(event);
+	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
 }
 
@@ -1410,7 +1444,7 @@ void x86_pmu_stop(struct perf_event *eve
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
-		x86_pmu.disable(event);
+		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
@@ -1460,8 +1494,7 @@ static void x86_pmu_del(struct perf_even
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	if (x86_pmu.put_event_constraints)
-		x86_pmu.put_event_constraints(cpuc, event);
+	static_cond_call(x86_pmu_put_event_constraints)(cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1474,13 +1507,12 @@ static void x86_pmu_del(struct perf_even
 	perf_event_update_userpage(event);
 
 do_del:
-	if (x86_pmu.del) {
-		/*
-		 * This is after x86_pmu_stop(); so we disable LBRs after any
-		 * event can need them etc..
-		 */
-		x86_pmu.del(event);
-	}
+
+	/*
+	 * This is after x86_pmu_stop(); so we disable LBRs after any
+	 * event can need them etc..
+	 */
+	static_cond_call(x86_pmu_del)(event);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
@@ -1558,7 +1590,7 @@ perf_event_nmi_handler(unsigned int cmd,
 		return NMI_DONE;
 
 	start_clock = sched_clock();
-	ret = x86_pmu.handle_irq(regs);
+	ret = static_call(x86_pmu_handle_irq)(regs);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
@@ -1765,6 +1797,32 @@ ssize_t x86_event_sysfs_show(char *page,
 static struct attribute_group x86_pmu_attr_group;
 static struct attribute_group x86_pmu_caps_group;
 
+static void x86_pmu_static_call_update(void)
+{
+	static_call_update(x86_pmu_handle_irq, x86_pmu.handle_irq);
+	static_call_update(x86_pmu_disable_all, x86_pmu.disable_all);
+	static_call_update(x86_pmu_enable_all, x86_pmu.enable_all);
+	static_call_update(x86_pmu_enable, x86_pmu.enable);
+	static_call_update(x86_pmu_disable, x86_pmu.disable);
+
+	static_call_update(x86_pmu_add, x86_pmu.add);
+	static_call_update(x86_pmu_del, x86_pmu.del);
+	static_call_update(x86_pmu_read, x86_pmu.read);
+
+	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
+	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);
+	static_call_update(x86_pmu_put_event_constraints, x86_pmu.put_event_constraints);
+
+	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
+	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
+
+	static_call_update(x86_pmu_start_scheduling, x86_pmu.start_scheduling);
+	static_call_update(x86_pmu_commit_scheduling, x86_pmu.commit_scheduling);
+	static_call_update(x86_pmu_stop_scheduling, x86_pmu.stop_scheduling);
+
+	static_call_update(x86_pmu_sched_task, x86_pmu.sched_task);
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -1829,6 +1887,11 @@ static int __init init_hw_perf_events(vo
 	pr_info("... fixed-purpose events:   %d\n",     x86_pmu.num_counters_fixed);
 	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
 
+	if (!x86_pmu.read)
+		x86_pmu.read = _x86_pmu_read;
+
+	x86_pmu_static_call_update();
+
 	/*
 	 * Install callbacks. Core will call them for each online
 	 * cpu.
@@ -1865,11 +1928,9 @@ static int __init init_hw_perf_events(vo
 }
 early_initcall(init_hw_perf_events);
 
-static inline void x86_pmu_read(struct perf_event *event)
+static void x86_pmu_read(struct perf_event *event)
 {
-	if (x86_pmu.read)
-		return x86_pmu.read(event);
-	x86_perf_event_update(event);
+	static_call(x86_pmu_read)(event);
 }
 
 /*
@@ -1946,7 +2007,7 @@ static int x86_pmu_commit_txn(struct pmu
 	if (!x86_pmu_initialized())
 		return -EAGAIN;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = static_call(x86_pmu_schedule_events)(cpuc, n, assign);
 	if (ret)
 		return ret;
 
@@ -2239,8 +2300,7 @@ static const struct attribute_group *x86
 
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
-	if (x86_pmu.sched_task)
-		x86_pmu.sched_task(ctx, sched_in);
+	static_cond_call(x86_pmu_sched_task)(ctx, sched_in);
 }
 
 void perf_check_microcode(void)


