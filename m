Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D31ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390B32084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfJUUEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:04:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:57214 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730271AbfJUUEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:04:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="201467401"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2019 13:04:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 08/13] perf tools: Stitch LBR call stack
Date:   Mon, 21 Oct 2019 13:03:09 -0700
Message-Id: <20191021200314.1613-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021200314.1613-1-kan.liang@linux.intel.com>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
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

In struct lbr_stitch, add 'prev_sample' to save the previous sample.
Add 'prev_lbr_cursor' to save all LBR cursor nodes from previous sample.
Once perf determines to stitch the previous LBRs, the corresponding LBR
cursor nodes will be copied to 'lists'.
The 'lists' is to track the LBR cursor nodes which are going to be
stitched.
When the stitching is over, the nodes will not be freed immediately.
They will be moved to 'free_lists'. Next stitching may reuse the space.
Both 'lists' and 'free_lists' will be freed when all samples are
processed.

The 'lbr_stitch_enable' is used to indicate whether enable LBR stitch
approach, which is disabled by default. The following patch will
introduce a new option to enable the LBR stitch approach.
This is because,
- The stitching approach base on LBR call stack technology. The known
limitations of LBR call stack technology still apply to the approach,
e.g. Exception handing such as setjmp/longjmp will have calls/returns
not match.
- This approach is not full proof. There can be cases where it creates
incorrect call stacks from incorrect matches. There is no attempt
to validate any matches in another way.

However in many common cases with call stack overflows it can recreate
better call stacks than the default lbr call stack output. So if there
are problems with LBR overflows, this is a possible workaround.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/branch.h    |   5 +-
 tools/perf/util/callchain.h |  12 +-
 tools/perf/util/machine.c   | 232 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/thread.c    |   2 +
 tools/perf/util/thread.h    |  34 ++++++
 5 files changed, 280 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 88e00d268f6f..749fce3675b6 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -34,7 +34,10 @@ struct branch_info {
 struct branch_entry {
 	u64			from;
 	u64			to;
-	struct branch_flags	flags;
+	union {
+		struct branch_flags	flags;
+		u64			flags_value;
+	};
 };
 
 struct branch_stack {
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 83398e5bbe4b..9708b8640946 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -149,7 +149,17 @@ struct callchain_cursor_node {
 	u64				branch_from;
 	int				nr_loop_iter;
 	u64				iter_cycles;
-	struct callchain_cursor_node	*next;
+	union {
+		struct callchain_cursor_node	*next;
+
+		/* Indicate valid cursor node for LBR stitch */
+		bool				valid;
+	};
+};
+
+struct stitch_list {
+	struct list_head		node;
+	struct callchain_cursor_node	cursor;
 };
 
 struct callchain_cursor {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e3e516e30093..dd8c764bc9ae 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2216,6 +2216,31 @@ static int lbr_callchain_add_kernel_ip(struct thread *thread,
 	return 0;
 }
 
+static void save_lbr_cursor_node(struct thread *thread,
+				 struct callchain_cursor *cursor,
+				 int idx)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+
+	if (!lbr_stitch)
+		return;
+
+	if (cursor->pos == cursor->nr) {
+		lbr_stitch->prev_lbr_cursor[idx].valid = false;
+		return;
+	}
+
+	if (!cursor->curr)
+		cursor->curr = cursor->first;
+	else
+		cursor->curr = cursor->curr->next;
+	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
+	       sizeof(struct callchain_cursor_node));
+
+	lbr_stitch->prev_lbr_cursor[idx].valid = true;
+	cursor->pos++;
+}
+
 static int lbr_callchain_add_lbr_ip(struct thread *thread,
 				    struct callchain_cursor *cursor,
 				    struct perf_sample *sample,
@@ -2230,6 +2255,21 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	u64 ip, branch_from = 0;
 	int err, i;
 
+	/*
+	 * The curr and pos are not used in writing session. They are cleared
+	 * in callchain_cursor_commit() when the writing session is closed.
+	 * Using curr and pos to track the current cursor node.
+	 */
+	if (thread->lbr_stitch) {
+		cursor->curr = NULL;
+		cursor->pos = cursor->nr;
+		if (cursor->nr) {
+			cursor->curr = cursor->first;
+			for (i = 0; i < (int)(cursor->nr - 1); i++)
+				cursor->curr = cursor->curr->next;
+		}
+	}
+
 	if (callee) {
 		ip = lbr_stack->entries[0].to;
 		flags = &lbr_stack->entries[0].flags;
@@ -2240,6 +2280,20 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		if (err)
 			return err;
 
+		/*
+		 * The number of cursor node increases.
+		 * Move the current cursor node.
+		 * But does not need to save current cursor node for entry 0.
+		 * It's impossible to stitch the whole LBRs of previous sample.
+		 */
+		if (thread->lbr_stitch && (cursor->pos != cursor->nr)) {
+			if (!cursor->curr)
+				cursor->curr = cursor->first;
+			else
+				cursor->curr = cursor->curr->next;
+			cursor->pos++;
+		}
+
 		for (i = 0; i < lbr_nr; i++) {
 			ip = lbr_stack->entries[i].from;
 			flags = &lbr_stack->entries[i].flags;
@@ -2248,6 +2302,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 					       true, flags, NULL, branch_from);
 			if (err)
 				return err;
+			save_lbr_cursor_node(thread, cursor, i);
 		}
 	} else {
 		for (i = lbr_nr - 1; i >= 0; i--) {
@@ -2258,6 +2313,7 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 					       true, flags, NULL, branch_from);
 			if (err)
 				return err;
+			save_lbr_cursor_node(thread, cursor, i);
 		}
 
 		ip = lbr_stack->entries[0].to;
@@ -2273,6 +2329,145 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	return 0;
 }
 
+static int lbr_callchain_add_stitched_lbr_ip(struct thread *thread,
+					     struct callchain_cursor *cursor)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	struct stitch_list *stitch_node;
+	int err;
+
+	struct callchain_cursor_node *cnode;
+
+	list_for_each_entry(stitch_node, &lbr_stitch->lists, node) {
+		cnode = &stitch_node->cursor;
+
+		err = callchain_cursor_append(cursor, cnode->ip, cnode->map,
+					      cnode->sym, cnode->branch,
+					      &cnode->branch_flags,
+					      cnode->nr_loop_iter,
+					      cnode->iter_cycles,
+					      cnode->branch_from,
+					      cnode->srcline);
+		if (err)
+			return err;
+
+	}
+	return 0;
+}
+
+static struct stitch_list *get_stitch_node(struct thread *thread)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	struct stitch_list *stitch_node;
+
+	if (!list_empty(&lbr_stitch->free_lists)) {
+		stitch_node = list_first_entry(&lbr_stitch->free_lists,
+					       struct stitch_list, node);
+		list_del(&stitch_node->node);
+
+		return stitch_node;
+	}
+
+	return malloc(sizeof(struct stitch_list));
+}
+
+static bool has_stitched_lbr(struct thread *thread,
+			     struct perf_sample *cur,
+			     struct perf_sample *prev,
+			     unsigned int max_lbr,
+			     bool callee)
+{
+	struct branch_stack *cur_stack = cur->branch_stack;
+	struct branch_stack *prev_stack = prev->branch_stack;
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	int i, j, nr_identical_branches = 0;
+	struct stitch_list *stitch_node;
+	u64 cur_base, distance;
+
+	if (!cur_stack || !prev_stack)
+		return false;
+
+	/* Find the physical index of the base-of-stack for current sample. */
+	cur_base = max_lbr - cur_stack->nr + cur->lbr_tos + 1;
+
+	distance = (prev->lbr_tos > cur_base) ? (prev->lbr_tos - cur_base) :
+					    (max_lbr + prev->lbr_tos - cur_base);
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
+	 * and the base-of-stack of current sample into lbr_stitch->lists.
+	 * These LBRs will be stitched later.
+	 */
+	for (i = prev_stack->nr - 1; i > (int)distance; i--) {
+
+		if (!lbr_stitch->prev_lbr_cursor[i].valid)
+			continue;
+
+		stitch_node = get_stitch_node(thread);
+		if (!stitch_node)
+			return false;
+
+		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
+		       sizeof(struct callchain_cursor_node));
+
+		if (callee)
+			list_add(&stitch_node->node, &lbr_stitch->lists);
+		else
+			list_add_tail(&stitch_node->node, &lbr_stitch->lists);
+	}
+
+	return true;
+}
+
+static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
+{
+	if (thread->lbr_stitch)
+		return true;
+
+	thread->lbr_stitch = calloc(1, sizeof(struct lbr_stitch));
+	if (!thread->lbr_stitch)
+		goto err;
+
+	thread->lbr_stitch->prev_lbr_cursor = calloc(max_lbr + 1, sizeof(struct callchain_cursor_node));
+	if (!thread->lbr_stitch->prev_lbr_cursor)
+		goto free_lbr_stitch;
+
+	INIT_LIST_HEAD(&thread->lbr_stitch->lists);
+	INIT_LIST_HEAD(&thread->lbr_stitch->free_lists);
+
+	return true;
+
+free_lbr_stitch:
+	free(thread->lbr_stitch);
+	thread->lbr_stitch = NULL;
+err:
+	pr_warning("Failed to allocate space for stitched LBRs. Disable LBR stitch\n");
+	thread->lbr_stitch_enable = false;
+	return false;
+}
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2285,10 +2480,14 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
+	struct lbr_stitch *lbr_stitch;
+	bool stitched_lbr = false;
 	int i, err;
 
 	for (i = 0; i < chain_nr; i++) {
@@ -2303,7 +2502,21 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	if (i == chain_nr)
 		return 0;
 
-	if (callchain_param.order == ORDER_CALLEE) {
+	if (thread->lbr_stitch_enable && sample->lbr_tos != (-1ULL) &&
+	    (max_lbr > 0) && alloc_lbr_stitch(thread, max_lbr)) {
+		lbr_stitch = thread->lbr_stitch;
+
+		stitched_lbr = has_stitched_lbr(thread, sample,
+						&lbr_stitch->prev_sample,
+						max_lbr, callee);
+		if (!stitched_lbr) {
+			list_replace_init(&lbr_stitch->lists,
+					  &lbr_stitch->free_lists);
+		}
+		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
+	}
+
+	if (callee) {
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
 						  parent, root_al, true, i);
 		if (err)
@@ -2312,7 +2525,17 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					       parent, root_al, true);
 		if (err)
 			goto error;
+		if (stitched_lbr) {
+			err = lbr_callchain_add_stitched_lbr_ip(thread, cursor);
+			if (err)
+				goto error;
+		}
 	} else {
+		if (stitched_lbr) {
+			err = lbr_callchain_add_stitched_lbr_ip(thread, cursor);
+			if (err)
+				goto error;
+		}
 		err = lbr_callchain_add_lbr_ip(thread, cursor, sample,
 					       parent, root_al, false);
 		if (err)
@@ -2369,8 +2592,11 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
index b64e9e049636..d3d8758e273e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -47,6 +47,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread->tid = tid;
 		thread->ppid = -1;
 		thread->cpu = -1;
+		thread->lbr_stitch_enable = false;
 		INIT_LIST_HEAD(&thread->namespaces_list);
 		INIT_LIST_HEAD(&thread->comm_list);
 		init_rwsem(&thread->namespaces_lock);
@@ -110,6 +111,7 @@ void thread__delete(struct thread *thread)
 
 	exit_rwsem(&thread->namespaces_lock);
 	exit_rwsem(&thread->comm_lock);
+	thread__free_stitch_list(thread);
 	free(thread);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 51bdb9a7af7f..e6740ca37091 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -13,6 +13,8 @@
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
+#include "event.h"
+#include "callchain.h"
 
 struct addr_location;
 struct map;
@@ -20,6 +22,13 @@ struct perf_record_namespaces;
 struct thread_stack;
 struct unwind_libunwind_ops;
 
+struct lbr_stitch {
+	struct list_head		lists;
+	struct list_head		free_lists;
+	struct perf_sample		prev_sample;
+	struct callchain_cursor_node	*prev_lbr_cursor;
+};
+
 struct thread {
 	union {
 		struct rb_node	 rb_node;
@@ -46,6 +55,10 @@ struct thread {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
+
+	/* LBR call stack stitch */
+	bool			lbr_stitch_enable;
+	struct lbr_stitch	*lbr_stitch;
 };
 
 struct machine;
@@ -142,4 +155,25 @@ static inline bool thread__is_filtered(struct thread *thread)
 	return false;
 }
 
+static inline void thread__free_stitch_list(struct thread *thread)
+{
+	struct lbr_stitch *lbr_stitch = thread->lbr_stitch;
+	struct stitch_list *pos, *tmp;
+
+	if (!lbr_stitch)
+		return;
+
+	list_for_each_entry_safe(pos, tmp, &lbr_stitch->lists, node) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
+
+	list_for_each_entry_safe(pos, tmp, &lbr_stitch->free_lists, node) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
+	free(lbr_stitch->prev_lbr_cursor);
+	free(thread->lbr_stitch);
+}
+
 #endif	/* __PERF_THREAD_H */
-- 
2.17.1

