Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DEDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BE82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfF1XEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:04:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:51667 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfF1XEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:04:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 16:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="164797063"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2019 16:04:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 811E03015ED; Fri, 28 Jun 2019 16:04:09 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH v1] perf/x86: Consider pinned events for group validation
Date:   Fri, 28 Jun 2019 16:03:57 -0700
Message-Id: <20190628230357.10042-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

perf stat -M metrics relies on weak groups to reject unschedulable groups
and run them as non-groups.

This uses the group validation code in the kernel. Unfortunately
that code doesn't take pinned events, such as the NMI watchdog, into
account. So some groups can pass validation, but then later still
never schedule.

This patch is an attempt to track pinned events in the group
validation too. We track a pinned mask, and use the mask from
either the CPU the event is pinned or, or the current CPU
if floating.

Then use this mask as a starting point for the scheduler.

I *think* it is mostly conservative, as in rejecting nothing
that would schedule, except locking is a bit weaker than a real
schedule, so it might be slightly behind

It won't catch all possible cases that cannot schedule, such
as events pinned differently on different CPUs, or complicated
constraints. For the case of the NMI watchdog interacting
with the current perf metrics it is strong enough.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/core.c         | 44 +++++++++++++++++++++++++++-------
 arch/x86/events/intel/p4.c     |  3 ++-
 arch/x86/events/intel/uncore.c |  2 +-
 arch/x86/events/perf_event.h   | 10 +++++---
 4 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f0e4804515d8..9459b1f83aa4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -713,7 +713,7 @@ struct perf_sched {
  * Initialize interator that runs through all events and counters.
  */
 static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
-			    int num, int wmin, int wmax, int gpmax)
+			    int num, int wmin, int wmax, int gpmax, unsigned long *pinned)
 {
 	int idx;
 
@@ -731,6 +731,8 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
 	sched->state.event	= idx;		/* start with min weight */
 	sched->state.weight	= wmin;
 	sched->state.unassigned	= num;
+	if (pinned)
+		bitmap_copy(sched->state.used, pinned, X86_PMC_IDX_MAX);
 }
 
 static void perf_sched_save_state(struct perf_sched *sched)
@@ -846,11 +848,12 @@ static bool perf_sched_next_event(struct perf_sched *sched)
  * Assign a counter for each event.
  */
 int perf_assign_events(struct event_constraint **constraints, int n,
-			int wmin, int wmax, int gpmax, int *assign)
+		       int wmin, int wmax, int gpmax, int *assign,
+		       unsigned long *pinned)
 {
 	struct perf_sched sched;
 
-	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax);
+	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax, pinned);
 
 	do {
 		if (!perf_sched_find_counter(&sched))
@@ -863,7 +866,8 @@ int perf_assign_events(struct event_constraint **constraints, int n,
 }
 EXPORT_SYMBOL_GPL(perf_assign_events);
 
-int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
+int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign,
+			unsigned long *pinned)
 {
 	struct event_constraint *c;
 	unsigned long used_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
@@ -871,7 +875,10 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	int n0, i, wmin, wmax, unsched = 0;
 	struct hw_perf_event *hwc;
 
-	bitmap_zero(used_mask, X86_PMC_IDX_MAX);
+	if (pinned)
+		bitmap_copy(used_mask, pinned, X86_PMC_IDX_MAX);
+	else
+		bitmap_zero(used_mask, X86_PMC_IDX_MAX);
 
 	/*
 	 * Compute the number of events already present; see x86_pmu_add(),
@@ -953,7 +960,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			gpmax /= 2;
 
 		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
-					     wmax, gpmax, assign);
+					     wmax, gpmax, assign, pinned);
 	}
 
 	/*
@@ -1267,7 +1274,7 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = x86_pmu.schedule_events(cpuc, n, assign, NULL);
 	if (ret)
 		goto out;
 	/*
@@ -1321,6 +1328,8 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 	__set_bit(idx, cpuc->running);
 	x86_pmu.enable(event);
 	perf_event_update_userpage(event);
+	if (event->attr.pinned)
+		__set_bit(idx, cpuc->pinned);
 }
 
 void perf_event_print_debug(void)
@@ -1388,12 +1397,16 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
+
+
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		x86_pmu.disable(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] = NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
+		if (event->attr.pinned)
+			__clear_bit(event->hw.idx, cpuc->pinned);
 	}
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
@@ -1925,7 +1938,7 @@ static int x86_pmu_commit_txn(struct pmu *pmu)
 	if (!x86_pmu_initialized())
 		return -EAGAIN;
 
-	ret = x86_pmu.schedule_events(cpuc, n, assign);
+	ret = x86_pmu.schedule_events(cpuc, n, assign, NULL);
 	if (ret)
 		return ret;
 
@@ -2013,6 +2026,7 @@ static int validate_group(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
 	struct cpu_hw_events *fake_cpuc;
+	unsigned long pinned[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int ret = -EINVAL, n;
 
 	fake_cpuc = allocate_fake_cpuc();
@@ -2033,8 +2047,20 @@ static int validate_group(struct perf_event *event)
 	if (n < 0)
 		goto out;
 
+	/*
+	 * Get the pinned mask from the real CPU so that we don't
+	 * allow anything that conflicts with pinned events.
+	 *
+	 * This is not fully accurate with complicated constraints,
+	 * but good enough to handle common cases like the global NMI watchdog.
+	 */
+	bitmap_copy(pinned,
+		    per_cpu_ptr(&cpu_hw_events,
+				event->cpu >= 0 ? event->cpu : raw_smp_processor_id())->pinned,
+		    X86_PMC_IDX_MAX);
+
 	fake_cpuc->n_events = 0;
-	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
+	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL, pinned);
 
 out:
 	free_fake_cpuc(fake_cpuc);
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index dee579efb2b2..c6eef326b23f 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1203,7 +1203,8 @@ static int p4_next_cntr(int thread, unsigned long *used_mask,
 	return -1;
 }
 
-static int p4_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
+static int p4_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign,
+				  unsigned long *pinned)
 {
 	unsigned long used_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	unsigned long escr_mask[BITS_TO_LONGS(P4_ESCR_MSR_TABLE_SIZE)];
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3694a5d0703d..d44518a6c0e2 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -459,7 +459,7 @@ static int uncore_assign_events(struct intel_uncore_box *box, int assign[], int
 	/* slow path */
 	if (i != n)
 		ret = perf_assign_events(box->event_constraint, n,
-					 wmin, wmax, n, assign);
+					 wmin, wmax, n, assign, NULL);
 
 	if (!assign || ret) {
 		for (i = 0; i < n; i++)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9bcec3f99e4a..34f264633e9f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -202,6 +202,7 @@ struct cpu_hw_events {
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	unsigned long		running[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	unsigned long		pinned[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
@@ -585,7 +586,8 @@ struct x86_pmu {
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
 	int		(*hw_config)(struct perf_event *event);
-	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
+	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign,
+					   unsigned long *pinned);
 	unsigned	eventsel;
 	unsigned	perfctr;
 	int		(*addr_offset)(int index, bool eventsel);
@@ -850,8 +852,10 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 void x86_pmu_enable_all(int added);
 
 int perf_assign_events(struct event_constraint **constraints, int n,
-			int wmin, int wmax, int gpmax, int *assign);
-int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign);
+		       int wmin, int wmax, int gpmax, int *assign,
+		       unsigned long *pinned);
+int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign,
+			unsigned long *pinned);
 
 void x86_pmu_stop(struct perf_event *event, int flags);
 
-- 
2.20.1

