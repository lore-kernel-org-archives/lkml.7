Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB083C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C15E21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfJGSAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:00:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:33637 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGSAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:00:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 11:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193161305"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 11:00:00 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 06/10] perf tools: Stitch LBR call stack
Date:   Mon,  7 Oct 2019 10:59:06 -0700
Message-Id: <20191007175910.2805-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007175910.2805-1-kan.liang@linux.intel.com>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In LBR call stack mode, the depth of reconstructed LBR call stack limits
to the number of LBR registers.

  For example, on skylake, the depth of reconstructed LBR call stack is
  always <= 32.

  # To display the perf.data header info, please use
  # --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6K of event 'cycles'
  # Event count (approx.): 6487119731
  #
  # Children      Self  Command          Shared Object       Symbol
  # ........  ........  ...............  ..................
  # ................................

    99.97%    99.97%  tchain_edit      tchain_edit        [.] f43
            |
             --99.64%--f11
                       f12
                       f13
                       f14
                       f15
                       f16
                       f17
                       f18
                       f19
                       f20
                       f21
                       f22
                       f23
                       f24
                       f25
                       f26
                       f27
                       f28
                       f29
                       f30
                       f31
                       f32
                       f33
                       f34
                       f35
                       f36
                       f37
                       f38
                       f39
                       f40
                       f41
                       f42
                       f43

For a call stack which is deeper than LBR limit, HW will overwrite the
LBR register with oldest branch. Only partial call stacks can be
reconstructed.

However, the overwritten LBRs may still be retrieved from previous
sample. At that moment, HW hasn't overwritten the LBR registers yet.
Perf tools can stitch those overwritten LBRs on current call stacks to
get a more complete call stack.

To determine if LBRs can be stitched, perf tools need to compare current
sample with previous sample.
- They should have identical LBR records (Same from, to and flags
  values, and the same physical index of LBR registers).
- The searching starts from the base-of-stack of current sample.

Add prev_sample in struct thread to save the previous sample.
Add lbr_stitch_lists to save the LBRs can be used to stitch.

lbr_stitch_enable is used to indicate whether enable LBR stitch
approach, which is disabled by default. The following patch will
introduce a new option to enable the LBR stitch approach.
This is because,
- The stitching approach base on LBR call stack technology. The known
limitations of LBR call stack technology still apply to the approach,
e.g. Exception handing such as setjmp/longjmp will have calls/returns
not match.
- This approach is not full proof. There can be cases where it creates
incorrect call stacks from incorrect matches. There is no attempt
to validate any matches in another way. So it is not enabled by default.
However in many common cases with call stack overflows it can recreate
better call stacks than the default lbr call stack output. So if there
are problems with LBR overflows this is a possible workaround.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/branch.h  |  10 ++-
 tools/perf/util/machine.c | 125 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/thread.c  |   3 +
 tools/perf/util/thread.h  |  18 ++++++
 4 files changed, 152 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 88e00d268f6f..a9c399703281 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -34,7 +34,15 @@ struct branch_info {
 struct branch_entry {
 	u64			from;
 	u64			to;
-	struct branch_flags	flags;
+	union {
+		struct branch_flags	flags;
+		u64			flags_value;
+	};
+};
+
+struct stitch_list {
+	struct list_head	node;
+	struct branch_entry	br_entry;
 };
 
 struct branch_stack {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e3e516e30093..02bd1740d547 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2273,6 +2273,98 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	return 0;
 }
 
+static int lbr_callchain_add_stitched_lbr_ip(struct thread *thread,
+					     struct callchain_cursor *cursor,
+					     struct symbol **parent,
+					     struct addr_location *root_al)
+{
+	u8 cpumode = PERF_RECORD_MISC_USER;
+	struct stitch_list *stitch_node;
+	struct branch_flags *flags;
+	int err;
+	u64 ip;
+
+	list_for_each_entry(stitch_node, &thread->lbr_stitch_lists, node) {
+		ip = stitch_node->br_entry.from;
+		flags = &stitch_node->br_entry.flags;
+
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       true, flags, NULL, 0);
+		if (err)
+			return err;
+
+	}
+	return 0;
+}
+
+
+static bool has_stitched_lbr(struct thread *thread,
+			     struct perf_sample *cur,
+			     struct perf_sample *prev,
+			     unsigned int max_lbr,
+			     bool callee)
+{
+	struct branch_stack *cur_stack = cur->branch_stack;
+	struct branch_stack *prev_stack = prev->branch_stack;
+	int i, j, nr_identical_branches = 0;
+	struct stitch_list *stitch_node;
+	u64 cur_base, distance;
+
+	if (!cur_stack || !prev_stack)
+		return false;
+
+	/* Find the physical index of the base-of-stack for current sample. */
+	cur_base = max_lbr - cur_stack->nr + cur->tos + 1;
+
+	distance = (prev->tos > cur_base) ? (prev->tos - cur_base) :
+					    (max_lbr + prev->tos - cur_base);
+	/* Previous sample has shorter stack. Nothing can be stitched. */
+	if (distance + 1 > prev_stack->nr)
+		return false;
+
+	/*
+	 * Check if there are identical LBRs between two samples.
+	 * Identicall LBRs must have same from, to and flags values. Also,
+	 * they have to be saved in the same LBR registers (same physical
+	 * index).
+	 *
+	 * Starts from the base-of-stack of current sample.
+	 */
+	for (i = distance, j = cur_stack->nr - 1; (i >= 0) && (j >= 0); i--, j--) {
+		if ((prev_stack->entries[i].from != cur_stack->entries[j].from) ||
+		    (prev_stack->entries[i].to != cur_stack->entries[j].to) ||
+		    (prev_stack->entries[i].flags_value != cur_stack->entries[j].flags_value))
+			break;
+
+		nr_identical_branches++;
+	}
+
+	if (!nr_identical_branches)
+		return false;
+
+	/*
+	 * Save the LBRs between the base-of-stack of previous sample
+	 * and the base-of-stack of current sample into lbr_stitch_lists.
+	 * These LBRs will be stitched later.
+	 */
+	for (i = prev_stack->nr - 1; i > (int)distance; i--) {
+		stitch_node = malloc(sizeof(*stitch_node));
+		if (!stitch_node)
+			return false;
+
+		memcpy(&stitch_node->br_entry, &prev_stack->entries[i],
+		       sizeof(struct branch_entry));
+
+		if (callee)
+			list_add(&stitch_node->node, &thread->lbr_stitch_lists);
+		else
+			list_add_tail(&stitch_node->node, &thread->lbr_stitch_lists);
+	}
+
+	return true;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2285,10 +2377,13 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					struct perf_sample *sample,
 					struct symbol **parent,
 					struct addr_location *root_al,
-					int max_stack)
+					int max_stack,
+					unsigned int max_lbr)
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr);
+	bool callee = (callchain_param.order == ORDER_CALLEE);
+	bool stitched_lbr = false;
 	int i, err;
 
 	for (i = 0; i < chain_nr; i++) {
@@ -2303,7 +2398,16 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	if (i == chain_nr)
 		return 0;
 
-	if (callchain_param.order == ORDER_CALLEE) {
+	if (thread->lbr_stitch_enable && sample->tos != (-1ULL) && (max_lbr > 0)) {
+		stitched_lbr = has_stitched_lbr(thread, sample,
+						&thread->prev_sample,
+						max_lbr, callee);
+		if (!stitched_lbr)
+			thread__free_stitch_list(thread);
+		memcpy(&thread->prev_sample, sample, sizeof(*sample));
+	}
+
+	if (callee) {
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
 						  parent, root_al, true, i);
 		if (err)
@@ -2312,7 +2416,19 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					       parent, root_al, true);
 		if (err)
 			goto error;
+		if (stitched_lbr) {
+			err = lbr_callchain_add_stitched_lbr_ip(thread, cursor,
+								parent, root_al);
+			if (err)
+				goto error;
+		}
 	} else {
+		if (stitched_lbr) {
+			err = lbr_callchain_add_stitched_lbr_ip(thread, cursor,
+								parent, root_al);
+			if (err)
+				goto error;
+		}
 		err = lbr_callchain_add_lbr_ip(thread, cursor, sample,
 					       parent, root_al, false);
 		if (err)
@@ -2369,8 +2485,11 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		chain_nr = chain->nr;
 
 	if (perf_evsel__has_branch_callstack(evsel)) {
+		struct perf_env *env = perf_evsel__env(evsel);
+
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
-						   root_al, max_stack);
+						   root_al, max_stack,
+						   !env ? 0 : env->max_branches);
 		if (err)
 			return (err < 0) ? err : 0;
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b64e9e049636..eca53b1c7de3 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -47,8 +47,10 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread->tid = tid;
 		thread->ppid = -1;
 		thread->cpu = -1;
+		thread->lbr_stitch_enable = false;
 		INIT_LIST_HEAD(&thread->namespaces_list);
 		INIT_LIST_HEAD(&thread->comm_list);
+		INIT_LIST_HEAD(&thread->lbr_stitch_lists);
 		init_rwsem(&thread->namespaces_lock);
 		init_rwsem(&thread->comm_lock);
 
@@ -110,6 +112,7 @@ void thread__delete(struct thread *thread)
 
 	exit_rwsem(&thread->namespaces_lock);
 	exit_rwsem(&thread->comm_lock);
+	thread__free_stitch_list(thread);
 	free(thread);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 51bdb9a7af7f..112eccc6979b 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -13,6 +13,9 @@
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
+#include "event.h"
+#include "map_symbol.h"
+#include "branch.h"
 
 struct addr_location;
 struct map;
@@ -46,6 +49,11 @@ struct thread {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
+
+	/* stitch LBR call stack */
+	bool			lbr_stitch_enable;
+	struct list_head	lbr_stitch_lists;
+	struct perf_sample	prev_sample;
 };
 
 struct machine;
@@ -142,4 +150,14 @@ static inline bool thread__is_filtered(struct thread *thread)
 	return false;
 }
 
+static inline void thread__free_stitch_list(struct thread *thread)
+{
+	struct stitch_list *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &thread->lbr_stitch_lists, node) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
+}
+
 #endif	/* __PERF_THREAD_H */
-- 
2.17.1

