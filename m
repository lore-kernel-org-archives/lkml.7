Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80256C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4248420863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfGKSxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:53:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45213 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:53:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so3475924plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 11:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/i1NJ8gQRS0vxU8RqFTkiu0LhUQZa+4RgVnJdSmVdY=;
        b=GfY0DMwfH3qxbp0D3nqMHlj6US1YxGMDZU2uqyunYQol7cfteifQV4DkiTiA9wLV/R
         M0ZPh/5RovsB84txcD+RS0oBUzlBdLBlqimchNdJ6LzF3ILMLsOMfNxo9PmPVhNfm8Tb
         oWXcSwQj8u3KtcHL75THiF0mexqTFUcT7yJDVneaaZ31890TmDMHnoyYY1mfHK4u0Hnb
         sH71B1XzZXfV+bKnqYmsqqtcH1IcojgGCloNdHm1nHa3/8guwSMYth8+K8VzTyQJk63x
         WKD6QfZCU9UKNdncRxlx9FJnPkROHXdAOGGoZt9Atl4cFGNW5m4MO+AE03tok7fFedf0
         +apA==
X-Gm-Message-State: APjAAAUyVLZyjIjXRYPAEGM1W75StS47M6DU7q7Qk3hWKbk2LsQnhVZs
        2p/7BR6Q5K8OHP0Lw+skavg=
X-Google-Smtp-Source: APXvYqzGjfYiWLhcfR5RT9bUWIl3aCN0ItlFIGD126V1Ahb0cSdHMniy2RB7DmQ4PjjrSyq5KDxT2w==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr3819076plk.91.1562871195827;
        Thu, 11 Jul 2019 11:53:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i15sm6236418pfd.160.2019.07.11.11.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:53:14 -0700 (PDT)
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <b378a903-d0fc-a137-e6b9-dec55277cf16@acm.org>
 <20190710170057.GB801@sol.localdomain> <20190710172123.GC801@sol.localdomain>
 <f498d8cc-ba82-d3dc-7557-142a1b35976a@acm.org>
 <20190710180242.GA193819@gmail.com>
 <a19779d0-0192-8dc0-d51b-e6938a455f31@acm.org>
 <47a9287d-1f02-95d5-a5cf-55f0c0d38378@gmail.com>
 <cdfeb3f8-8dc5-aa60-2782-7b3c5110edf5@acm.org>
 <ee3bac8d-d061-7d07-5990-59871e7e2a4b@gmail.com>
 <9219c421-0868-f97f-2d84-df48aed9f8a8@acm.org>
 <20190710220943.GM3419@hirez.programming.kicks-ass.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e10e95c7-b832-5560-e3ca-3ce584bc0ca3@acm.org>
Date:   Thu, 11 Jul 2019 11:53:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710220943.GM3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/19 3:09 PM, Peter Zijlstra wrote:
> One thing I mentioned when Thomas did the unwinder API changes was
> trying to move lockdep over to something like stackdepot.
> 
> We can't directly use stackdepot as is, because it uses locks and memory
> allocation, but we could maybe add a lower level API to it and use that
> under the graph_lock() on static storage or something.
> 
> Otherwise we'll have to (re)implement something like it.
> 
> I've not looked at it in detail.

Hi Peter,

Is something like the untested patch below perhaps what you had in mind?

Thanks,

Bart.

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 57baa27f238c..a5c7c1813d35 100644
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
index 341f52117f88..c3022367ba2a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -449,33 +449,72 @@ static void print_lockdep_off(const char *bug_msg)
  unsigned long nr_stack_trace_entries;

  #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
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
@@ -5158,6 +5204,12 @@ void __init lockdep_init(void)
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
index cc83568d5012..92c472fb838f 100644
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

