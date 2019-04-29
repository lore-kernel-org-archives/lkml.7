Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8B82087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZX/J2JGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfD2Spb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:45:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfD2Spb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:45:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIhk5V1029172
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:43:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIhk5V1029172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563428;
        bh=rViD+XMM7EBNlNz00zv8jkI+5eOk0R10zn22Bzm+pYg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZX/J2JGRjuSsWzIMXcLnnJ2wlaplr2XBJuoG27H1URR/+LCUdVGWkCulAaxUatD7J
         ezqZuAAbNps4dRWdt5h4yYlXLu5Mf2S9eHJfYHDAMOMFHI9Ve+bXxIe1CJhDWGPkDj
         7yerEWde55VatAGDFL3/4MgGdaaC/taL7G2wHKxmhGxjYzxG24Nx6tDJkXHEnicgiO
         xWGUvRPGIwb4KFpwC4+Qbo2j8L/J/bNNE5VTgNGisScqHwA8Ddmyf2Mfd0WzQrS+Jo
         NFkOmHxbLLr7FfeSVddIL/Cab/W1JvslTtyaq3bmE6Qz7/A1LWcOajdIwvNYIQXsWE
         C8/jeem0zaXTA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIhk6r1029168;
        Mon, 29 Apr 2019 11:43:46 -0700
Date:   Mon, 29 Apr 2019 11:43:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c120bce78065cbea460a58b1572c215db9c148ba@git.kernel.org>
Cc:     tom.zanussi@linux.intel.com, rientjes@google.com, mbenes@suse.cz,
        tglx@linutronix.de, dsterba@suse.com, robin.murphy@arm.com,
        airlied@linux.ie, agk@redhat.com, hpa@zytor.com,
        adobriyan@gmail.com, peterz@infradead.org,
        jani.nikula@linux.intel.com, catalin.marinas@arm.com,
        dvyukov@google.com, daniel@ffwll.ch, m.szyprowski@samsung.com,
        aryabinin@virtuozzo.com, jthumshirn@suse.de, hch@lst.de,
        jpoimboe@redhat.com, cl@linux.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, clm@fb.com, rostedt@goodmis.org,
        rppt@linux.vnet.ibm.com, akinobu.mita@gmail.com, luto@kernel.org,
        penberg@kernel.org, josef@toxicpanda.com, snitzer@redhat.com,
        maarten.lankhorst@linux.intel.com, rodrigo.vivi@intel.com,
        akpm@linux-foundation.org, joonas.lahtinen@linux.intel.com,
        glider@google.com
Reply-To: glider@google.com, joonas.lahtinen@linux.intel.com,
          akpm@linux-foundation.org, josef@toxicpanda.com,
          snitzer@redhat.com, rodrigo.vivi@intel.com,
          maarten.lankhorst@linux.intel.com, akinobu.mita@gmail.com,
          rostedt@goodmis.org, rppt@linux.vnet.ibm.com, clm@fb.com,
          mingo@kernel.org, penberg@kernel.org, luto@kernel.org,
          cl@linux.com, linux-kernel@vger.kernel.org,
          aryabinin@virtuozzo.com, jthumshirn@suse.de, jpoimboe@redhat.com,
          hch@lst.de, m.szyprowski@samsung.com, dvyukov@google.com,
          daniel@ffwll.ch, peterz@infradead.org, catalin.marinas@arm.com,
          jani.nikula@linux.intel.com, adobriyan@gmail.com, hpa@zytor.com,
          agk@redhat.com, airlied@linux.ie, robin.murphy@arm.com,
          tglx@linutronix.de, dsterba@suse.com, rientjes@google.com,
          tom.zanussi@linux.intel.com, mbenes@suse.cz
In-Reply-To: <20190425094802.891724020@linutronix.de>
References: <20190425094802.891724020@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] lockdep: Simplify stack trace handling
Git-Commit-ID: c120bce78065cbea460a58b1572c215db9c148ba
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

Commit-ID:  c120bce78065cbea460a58b1572c215db9c148ba
Gitweb:     https://git.kernel.org/tip/c120bce78065cbea460a58b1572c215db9c148ba
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:12 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:54 +0200

lockdep: Simplify stack trace handling

Replace the indirection through struct stack_trace by using the storage
array based interfaces and storing the information is a small lockdep
specific data structure.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094802.891724020@linutronix.de

---
 include/linux/lockdep.h  |  9 ++++++--
 kernel/locking/lockdep.c | 55 ++++++++++++++++++++++++------------------------
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 79c3873d58ac..6f165d625320 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -66,6 +66,11 @@ struct lock_class_key {
 
 extern struct lock_class_key __lockdep_no_validate__;
 
+struct lock_trace {
+	unsigned int		nr_entries;
+	unsigned int		offset;
+};
+
 #define LOCKSTAT_POINTS		4
 
 /*
@@ -100,7 +105,7 @@ struct lock_class {
 	 * IRQ/softirq usage tracking bits:
 	 */
 	unsigned long			usage_mask;
-	struct stack_trace		usage_traces[XXX_LOCK_USAGE_STATES];
+	struct lock_trace		usage_traces[XXX_LOCK_USAGE_STATES];
 
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
@@ -188,7 +193,7 @@ struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
 	struct lock_class		*links_to;
-	struct stack_trace		trace;
+	struct lock_trace		trace;
 	int				distance;
 
 	/*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3603893d5bbd..45bcaf2e4cb6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -434,18 +434,14 @@ static void print_lockdep_off(const char *bug_msg)
 #endif
 }
 
-static int save_trace(struct stack_trace *trace)
+static int save_trace(struct lock_trace *trace)
 {
-	trace->nr_entries = 0;
-	trace->max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
-	trace->entries = stack_trace + nr_stack_trace_entries;
-
-	trace->skip = 3;
-
-	save_stack_trace(trace);
-
-	trace->max_entries = trace->nr_entries;
+	unsigned long *entries = stack_trace + nr_stack_trace_entries;
+	unsigned int max_entries;
 
+	trace->offset = nr_stack_trace_entries;
+	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
+	trace->nr_entries = stack_trace_save(entries, max_entries, 3);
 	nr_stack_trace_entries += trace->nr_entries;
 
 	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES-1) {
@@ -1196,7 +1192,7 @@ static struct lock_list *alloc_list_entry(void)
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
-			    struct stack_trace *trace)
+			    struct lock_trace *trace)
 {
 	struct lock_list *entry;
 	/*
@@ -1415,6 +1411,13 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
  * checking.
  */
 
+static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
+{
+	unsigned long *entries = stack_trace + trace->offset;
+
+	stack_trace_print(entries, trace->nr_entries, spaces);
+}
+
 /*
  * Print a dependency chain entry (this is only done when a deadlock
  * has been detected):
@@ -1427,8 +1430,7 @@ print_circular_bug_entry(struct lock_list *target, int depth)
 	printk("\n-> #%u", depth);
 	print_lock_name(target->class);
 	printk(KERN_CONT ":\n");
-	print_stack_trace(&target->trace, 6);
-
+	print_lock_trace(&target->trace, 6);
 	return 0;
 }
 
@@ -1740,7 +1742,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 			len += printk("%*s   %s", depth, "", usage_str[bit]);
 			len += printk(KERN_CONT " at:\n");
-			print_stack_trace(class->usage_traces + bit, len);
+			print_lock_trace(class->usage_traces + bit, len);
 		}
 	}
 	printk("%*s }\n", depth, "");
@@ -1765,7 +1767,7 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 	do {
 		print_lock_class_header(entry->class, depth);
 		printk("%*s ... acquired at:\n", depth, "");
-		print_stack_trace(&entry->trace, 2);
+		print_lock_trace(&entry->trace, 2);
 		printk("\n");
 
 		if (depth == 0 && (entry != root)) {
@@ -1878,14 +1880,14 @@ print_bad_irq_dependency(struct task_struct *curr,
 	print_lock_name(backwards_entry->class);
 	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
 
-	print_stack_trace(backwards_entry->class->usage_traces + bit1, 1);
+	print_lock_trace(backwards_entry->class->usage_traces + bit1, 1);
 
 	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
 	print_lock_name(forwards_entry->class);
 	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
 	pr_warn("...");
 
-	print_stack_trace(forwards_entry->class->usage_traces + bit2, 1);
+	print_lock_trace(forwards_entry->class->usage_traces + bit2, 1);
 
 	pr_warn("\nother info that might help us debug this:\n\n");
 	print_irq_lock_scenario(backwards_entry, forwards_entry,
@@ -2158,7 +2160,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next,
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct stack_trace *trace)
+	       struct held_lock *next, int distance, struct lock_trace *trace)
 {
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
@@ -2196,7 +2198,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	this.parent = NULL;
 	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
 	if (unlikely(!ret)) {
-		if (!trace->entries) {
+		if (!trace->nr_entries) {
 			/*
 			 * If save_trace fails here, the printing might
 			 * trigger a WARN but because of the !nr_entries it
@@ -2252,7 +2254,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return print_bfs_bug(ret);
 
 
-	if (!trace->entries && !save_trace(trace))
+	if (!trace->nr_entries && !save_trace(trace))
 		return 0;
 
 	/*
@@ -2284,14 +2286,9 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 static int
 check_prevs_add(struct task_struct *curr, struct held_lock *next)
 {
+	struct lock_trace trace = { .nr_entries = 0 };
 	int depth = curr->lockdep_depth;
 	struct held_lock *hlock;
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.max_entries = 0,
-		.entries = NULL,
-		.skip = 0,
-	};
 
 	/*
 	 * Debugging checks.
@@ -2719,6 +2716,10 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
+
+static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
+{
+}
 #endif
 
 /*
@@ -2815,7 +2816,7 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	print_lock(this);
 
 	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
-	print_stack_trace(hlock_class(this)->usage_traces + prev_bit, 1);
+	print_lock_trace(hlock_class(this)->usage_traces + prev_bit, 1);
 
 	print_irqtrace_events(curr);
 	pr_warn("\nother info that might help us debug this:\n");
