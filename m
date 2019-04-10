Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25417C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCBF2196F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfDJLF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:05:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfDJLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:53 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB39-00057a-FC; Wed, 10 Apr 2019 13:05:51 +0200
Message-Id: <20190410103645.315084160@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:13 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 19/41] lib/stackdepot: Provide functions which operate on
 plain storage arrays
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct stack_trace indirection in the stack depot functions is a truly
pointless excercise which requires horrible code at the callsites.

Provide interfaces based on plain storage arrays.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/stackdepot.h |    4 ++
 lib/stackdepot.c           |   66 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 51 insertions(+), 19 deletions(-)

--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -26,7 +26,11 @@ typedef u32 depot_stack_handle_t;
 struct stack_trace;
 
 depot_stack_handle_t depot_save_stack(struct stack_trace *trace, gfp_t flags);
+depot_stack_handle_t stack_depot_save(unsigned long *entries,
+				      unsigned int nr_entries, gfp_t gfp_flags);
 
 void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace);
+unsigned int stack_depot_fetch(depot_stack_handle_t handle,
+			       unsigned long **entries);
 
 #endif
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -194,40 +194,56 @@ static inline struct stack_record *find_
 	return NULL;
 }
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
+/**
+ * stack_depot_fetch - Fetch stack entries from a depot
+ *
+ * @entries:		Pointer to store the entries address
+ */
+unsigned int stack_depot_fetch(depot_stack_handle_t handle,
+			       unsigned long **entries)
 {
 	union handle_parts parts = { .handle = handle };
 	void *slab = stack_slabs[parts.slabindex];
 	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
 	struct stack_record *stack = slab + offset;
 
-	trace->nr_entries = trace->max_entries = stack->size;
-	trace->entries = stack->entries;
-	trace->skip = 0;
+	*entries = stack->entries;
+	return stack->size;
+}
+EXPORT_SYMBOL_GPL(stack_depot_fetch);
+
+void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
+{
+	unsigned int nent = stack_depot_fetch(handle, &trace->entries);
+
+	trace->max_entries = trace->nr_entries = nent;
 }
 EXPORT_SYMBOL_GPL(depot_fetch_stack);
 
 /**
- * depot_save_stack - save stack in a stack depot.
- * @trace - the stacktrace to save.
- * @alloc_flags - flags for allocating additional memory if required.
+ * stack_depot_save - Save a stack trace from an array
  *
- * Returns the handle of the stack struct stored in depot.
+ * @entries:		Pointer to storage array
+ * @nr_entries:		Size of the storage array
+ * @alloc_flags:	Allocation gfp flags
+ *
+ * Returns the handle of the stack struct stored in depot
  */
-depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
-				    gfp_t alloc_flags)
+depot_stack_handle_t stack_depot_save(unsigned long *entries,
+				      unsigned int nr_entries,
+				      gfp_t alloc_flags)
 {
-	u32 hash;
-	depot_stack_handle_t retval = 0;
 	struct stack_record *found = NULL, **bucket;
-	unsigned long flags;
+	depot_stack_handle_t retval = 0;
 	struct page *page = NULL;
 	void *prealloc = NULL;
+	unsigned long flags;
+	u32 hash;
 
-	if (unlikely(trace->nr_entries == 0))
+	if (unlikely(nr_entries == 0))
 		goto fast_exit;
 
-	hash = hash_stack(trace->entries, trace->nr_entries);
+	hash = hash_stack(entries, nr_entries);
 	bucket = &stack_table[hash & STACK_HASH_MASK];
 
 	/*
@@ -235,8 +251,8 @@ depot_stack_handle_t depot_save_stack(st
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |bucket| below.
 	 */
-	found = find_stack(smp_load_acquire(bucket), trace->entries,
-			   trace->nr_entries, hash);
+	found = find_stack(smp_load_acquire(bucket), entries,
+			   nr_entries, hash);
 	if (found)
 		goto exit;
 
@@ -264,10 +280,10 @@ depot_stack_handle_t depot_save_stack(st
 
 	spin_lock_irqsave(&depot_lock, flags);
 
-	found = find_stack(*bucket, trace->entries, trace->nr_entries, hash);
+	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
 		struct stack_record *new =
-			depot_alloc_stack(trace->entries, trace->nr_entries,
+			depot_alloc_stack(entries, nr_entries,
 					  hash, &prealloc, alloc_flags);
 		if (new) {
 			new->next = *bucket;
@@ -297,4 +313,16 @@ depot_stack_handle_t depot_save_stack(st
 fast_exit:
 	return retval;
 }
+EXPORT_SYMBOL_GPL(stack_depot_save);
+
+/**
+ * depot_save_stack - save stack in a stack depot.
+ * @trace - the stacktrace to save.
+ * @alloc_flags - flags for allocating additional memory if required.
+ */
+depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
+				      gfp_t alloc_flags)
+{
+	return stack_depot_save(trace->entries, trace->nr_entries, alloc_flags);
+}
 EXPORT_SYMBOL_GPL(depot_save_stack);


