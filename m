Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D050BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916B022BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="4eFJuXcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfGYQK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:10:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGYQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:10:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGA9I41074105
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:10:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGA9I41074105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071010;
        bh=QRc3CBcYUS8JfA8wx3Cx3zR5/hj83dToqK0IWh/o5/Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=4eFJuXcxrb0evH/3kmGfgVnuDZ/kwP8iiDxWMS93NDTK6q0fAebTE6WmrCRmLJac4
         GuKh9TNYrCB9fVsXq77qCFyDOBlqsIj/Q6AFdzlL0OOdScylux3K+Ca+jdUWBAzqy6
         7dR3QSb9zZQXQK1HkrX95OlwQ6O+GSxdaIwrNUedUUz+w7DIJ2GbuDTuyjeAv/Lj36
         zxidhbbM5IwqS1jeo7ZoxnoJTeKhZ+7aCw/VWXdlrsG7o/oHBdBdnf+EszsnosBw3V
         Z2HlrqPg0L6X4fOH+o6DNZJKHRbQVNFXAMuoAVwp6/iB+jhodA0lOhiZfUir6FOlhx
         XAU8Uo9Adv6JA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGA9rA1074101;
        Thu, 25 Jul 2019 09:10:09 -0700
Date:   Thu, 25 Jul 2019 09:10:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-12593b7467f9130b64a6d4b6a26ed4ec217b6784@git.kernel.org>
Cc:     torvalds@linux-foundation.org, duyuyang@gmail.com,
        ebiggers@kernel.org, bvanassche@acm.org, will.deacon@arm.com,
        longman@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: longman@redhat.com, will.deacon@arm.com, bvanassche@acm.org,
          hpa@zytor.com, ebiggers@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, duyuyang@gmail.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190722182443.216015-4-bvanassche@acm.org>
References: <20190722182443.216015-4-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Reduce space occupied by stack
 traces
Git-Commit-ID: 12593b7467f9130b64a6d4b6a26ed4ec217b6784
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  12593b7467f9130b64a6d4b6a26ed4ec217b6784
Gitweb:     https://git.kernel.org/tip/12593b7467f9130b64a6d4b6a26ed4ec217b6784
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Mon, 22 Jul 2019 11:24:42 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:43:27 +0200

locking/lockdep: Reduce space occupied by stack traces

Although commit 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys
for workqueues") unregisters dynamic lockdep keys when a workqueue is
destroyed, a side effect of that commit is that all stack traces
associated with the lockdep key are leaked when a workqueue is destroyed.
Fix this by storing each unique stack trace once. Other changes in this
patch are:

- Use NULL instead of { .nr_entries = 0 } to represent 'no trace'.
- Store a pointer to a stack trace in struct lock_class and struct
  lock_list instead of storing 'nr_entries' and 'offset'.

This patch avoids that the following program triggers the "BUG:
MAX_STACK_TRACE_ENTRIES too low!" complaint:

	#include <fcntl.h>
	#include <unistd.h>

	int main()
	{
		for (;;) {
			int fd = open("/dev/infiniband/rdma_cm", O_RDWR);
			close(fd);
		}
	}

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yuyang Du <duyuyang@gmail.com>
Link: https://lkml.kernel.org/r/20190722182443.216015-4-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h            |   9 +--
 kernel/locking/lockdep.c           | 128 ++++++++++++++++++++++++++-----------
 kernel/locking/lockdep_internals.h |   2 +
 3 files changed, 95 insertions(+), 44 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index cdb3c2f06092..b8a835fd611b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -66,10 +66,7 @@ struct lock_class_key {
 
 extern struct lock_class_key __lockdep_no_validate__;
 
-struct lock_trace {
-	unsigned int		nr_entries;
-	unsigned int		offset;
-};
+struct lock_trace;
 
 #define LOCKSTAT_POINTS		4
 
@@ -105,7 +102,7 @@ struct lock_class {
 	 * IRQ/softirq usage tracking bits:
 	 */
 	unsigned long			usage_mask;
-	struct lock_trace		usage_traces[XXX_LOCK_USAGE_STATES];
+	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
 
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
@@ -193,7 +190,7 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct lock_class		*links_to;
-	struct lock_trace		trace;
+	const struct lock_trace		*trace;
 	int				distance;
 
 	/*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index af6627866191..1a96869cb2f0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -449,33 +449,72 @@ static void print_lockdep_off(const char *bug_msg)
 unsigned long nr_stack_trace_entries;
 
 #ifdef CONFIG_PROVE_LOCKING
+/**
+ * struct lock_trace - single stack backtrace
+ * @hash_entry:	Entry in a stack_trace_hash[] list.
+ * @hash:	jhash() of @entries.
+ * @nr_entries:	Number of entries in @entries.
+ * @entries:	Actual stack backtrace.
+ */
+struct lock_trace {
+	struct hlist_node	hash_entry;
+	u32			hash;
+	u32			nr_entries;
+	unsigned long		entries[0] __aligned(sizeof(unsigned long));
+};
+#define LOCK_TRACE_SIZE_IN_LONGS				\
+	(sizeof(struct lock_trace) / sizeof(unsigned long))
 /*
- * Stack-trace: tightly packed array of stack backtrace
- * addresses. Protected by the graph_lock.
+ * Stack-trace: sequence of lock_trace structures. Protected by the graph_lock.
  */
 static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
+static struct hlist_head stack_trace_hash[STACK_TRACE_HASH_SIZE];
+
+static bool traces_identical(struct lock_trace *t1, struct lock_trace *t2)
+{
+	return t1->hash == t2->hash && t1->nr_entries == t2->nr_entries &&
+		memcmp(t1->entries, t2->entries,
+		       t1->nr_entries * sizeof(t1->entries[0])) == 0;
+}
 
-static int save_trace(struct lock_trace *trace)
+static struct lock_trace *save_trace(void)
 {
-	unsigned long *entries = stack_trace + nr_stack_trace_entries;
+	struct lock_trace *trace, *t2;
+	struct hlist_head *hash_head;
+	u32 hash;
 	unsigned int max_entries;
 
-	trace->offset = nr_stack_trace_entries;
-	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
-	trace->nr_entries = stack_trace_save(entries, max_entries, 3);
-	nr_stack_trace_entries += trace->nr_entries;
+	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
+	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
+
+	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
+	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
+		LOCK_TRACE_SIZE_IN_LONGS;
+	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
 
-	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES-1) {
+	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES -
+	    LOCK_TRACE_SIZE_IN_LONGS - 1) {
 		if (!debug_locks_off_graph_unlock())
-			return 0;
+			return NULL;
 
 		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
 		dump_stack();
 
-		return 0;
+		return NULL;
 	}
 
-	return 1;
+	hash = jhash(trace->entries, trace->nr_entries *
+		     sizeof(trace->entries[0]), 0);
+	trace->hash = hash;
+	hash_head = stack_trace_hash + (hash & (STACK_TRACE_HASH_SIZE - 1));
+	hlist_for_each_entry(t2, hash_head, hash_entry) {
+		if (traces_identical(trace, t2))
+			return t2;
+	}
+	nr_stack_trace_entries += LOCK_TRACE_SIZE_IN_LONGS + trace->nr_entries;
+	hlist_add_head(&trace->hash_entry, hash_head);
+
+	return trace;
 }
 #endif
 
@@ -1235,7 +1274,7 @@ static struct lock_list *alloc_list_entry(void)
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
-			    struct lock_trace *trace)
+			    const struct lock_trace *trace)
 {
 	struct lock_list *entry;
 	/*
@@ -1249,7 +1288,7 @@ static int add_lock_to_list(struct lock_class *this,
 	entry->class = this;
 	entry->links_to = links_to;
 	entry->distance = distance;
-	entry->trace = *trace;
+	entry->trace = trace;
 	/*
 	 * Both allocation and removal are done under the graph lock; but
 	 * iteration is under RCU-sched; see look_up_lock_class() and
@@ -1470,11 +1509,10 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 
 }
 
-static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
+static void print_lock_trace(const struct lock_trace *trace,
+			     unsigned int spaces)
 {
-	unsigned long *entries = stack_trace + trace->offset;
-
-	stack_trace_print(entries, trace->nr_entries, spaces);
+	stack_trace_print(trace->entries, trace->nr_entries, spaces);
 }
 
 /*
@@ -1489,7 +1527,7 @@ print_circular_bug_entry(struct lock_list *target, int depth)
 	printk("\n-> #%u", depth);
 	print_lock_name(target->class);
 	printk(KERN_CONT ":\n");
-	print_lock_trace(&target->trace, 6);
+	print_lock_trace(target->trace, 6);
 }
 
 static void
@@ -1592,7 +1630,8 @@ static noinline void print_circular_bug(struct lock_list *this,
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return;
 
-	if (!save_trace(&this->trace))
+	this->trace = save_trace();
+	if (!this->trace)
 		return;
 
 	depth = get_lock_depth(target);
@@ -1715,7 +1754,7 @@ check_path(struct lock_class *target, struct lock_list *src_entry,
  */
 static noinline int
 check_noncircular(struct held_lock *src, struct held_lock *target,
-		  struct lock_trace *trace)
+		  struct lock_trace **const trace)
 {
 	int ret;
 	struct lock_list *uninitialized_var(target_entry);
@@ -1729,13 +1768,13 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
 	if (unlikely(!ret)) {
-		if (!trace->nr_entries) {
+		if (!*trace) {
 			/*
 			 * If save_trace fails here, the printing might
 			 * trigger a WARN but because of the !nr_entries it
 			 * should not do bad things.
 			 */
-			save_trace(trace);
+			*trace = save_trace();
 		}
 
 		print_circular_bug(&src_entry, target_entry, src, target);
@@ -1859,7 +1898,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 			len += printk("%*s   %s", depth, "", usage_str[bit]);
 			len += printk(KERN_CONT " at:\n");
-			print_lock_trace(class->usage_traces + bit, len);
+			print_lock_trace(class->usage_traces[bit], len);
 		}
 	}
 	printk("%*s }\n", depth, "");
@@ -1884,7 +1923,7 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 	do {
 		print_lock_class_header(entry->class, depth);
 		printk("%*s ... acquired at:\n", depth, "");
-		print_lock_trace(&entry->trace, 2);
+		print_lock_trace(entry->trace, 2);
 		printk("\n");
 
 		if (depth == 0 && (entry != root)) {
@@ -1995,14 +2034,14 @@ print_bad_irq_dependency(struct task_struct *curr,
 	print_lock_name(backwards_entry->class);
 	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
 
-	print_lock_trace(backwards_entry->class->usage_traces + bit1, 1);
+	print_lock_trace(backwards_entry->class->usage_traces[bit1], 1);
 
 	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
 	print_lock_name(forwards_entry->class);
 	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
 	pr_warn("...");
 
-	print_lock_trace(forwards_entry->class->usage_traces + bit2, 1);
+	print_lock_trace(forwards_entry->class->usage_traces[bit2], 1);
 
 	pr_warn("\nother info that might help us debug this:\n\n");
 	print_irq_lock_scenario(backwards_entry, forwards_entry,
@@ -2011,13 +2050,15 @@ print_bad_irq_dependency(struct task_struct *curr,
 	lockdep_print_held_locks(curr);
 
 	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
-	if (!save_trace(&prev_root->trace))
+	prev_root->trace = save_trace();
+	if (!prev_root->trace)
 		return;
 	print_shortest_lock_dependencies(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
-	if (!save_trace(&next_root->trace))
+	next_root->trace = save_trace();
+	if (!next_root->trace)
 		return;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
 
@@ -2369,7 +2410,8 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct lock_trace *trace)
+	       struct held_lock *next, int distance,
+	       struct lock_trace **const trace)
 {
 	struct lock_list *entry;
 	int ret;
@@ -2444,8 +2486,11 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return ret;
 #endif
 
-	if (!trace->nr_entries && !save_trace(trace))
-		return 0;
+	if (!*trace) {
+		*trace = save_trace();
+		if (!*trace)
+			return 0;
+	}
 
 	/*
 	 * Ok, all validations passed, add the new lock
@@ -2453,14 +2498,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance, *trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, trace);
+			       next->acquire_ip, distance, *trace);
 	if (!ret)
 		return 0;
 
@@ -2476,7 +2521,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 static int
 check_prevs_add(struct task_struct *curr, struct held_lock *next)
 {
-	struct lock_trace trace = { .nr_entries = 0 };
+	struct lock_trace *trace = NULL;
 	int depth = curr->lockdep_depth;
 	struct held_lock *hlock;
 
@@ -3015,7 +3060,7 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	print_lock(this);
 
 	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
-	print_lock_trace(hlock_class(this)->usage_traces + prev_bit, 1);
+	print_lock_trace(hlock_class(this)->usage_traces[prev_bit], 1);
 
 	print_irqtrace_events(curr);
 	pr_warn("\nother info that might help us debug this:\n");
@@ -3096,7 +3141,8 @@ print_irq_inversion_bug(struct task_struct *curr,
 	lockdep_print_held_locks(curr);
 
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
-	if (!save_trace(&root->trace))
+	root->trace = save_trace();
+	if (!root->trace)
 		return;
 	print_shortest_lock_dependencies(other, root);
 
@@ -3580,7 +3626,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	hlock_class(this)->usage_mask |= new_mask;
 
-	if (!save_trace(hlock_class(this)->usage_traces + new_bit))
+	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
 		return 0;
 
 	switch (new_bit) {
@@ -5157,6 +5203,12 @@ void __init lockdep_init(void)
 		) / 1024
 		);
 
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+	printk(" memory used for stack traces: %zu kB\n",
+	       (sizeof(stack_trace) + sizeof(stack_trace_hash)) / 1024
+	       );
+#endif
+
 	printk(" per task-struct memory footprint: %zu bytes\n",
 	       sizeof(((struct task_struct *)NULL)->held_locks));
 }
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 2e518369add4..93a008bf77db 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -92,6 +92,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #define MAX_LOCKDEP_ENTRIES	16384UL
 #define MAX_LOCKDEP_CHAINS_BITS	15
 #define MAX_STACK_TRACE_ENTRIES	262144UL
+#define STACK_TRACE_HASH_SIZE	8192
 #else
 #define MAX_LOCKDEP_ENTRIES	32768UL
 
@@ -102,6 +103,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
  * addresses. Protected by the hash_lock.
  */
 #define MAX_STACK_TRACE_ENTRIES	524288UL
+#define STACK_TRACE_HASH_SIZE	16384
 #endif
 
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
