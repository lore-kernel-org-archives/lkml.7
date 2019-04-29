Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A1BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C851F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cjy/Ls/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfD2Sd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:33:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2Sd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:33:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIWeQV1027062
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:32:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIWeQV1027062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562761;
        bh=HNzyHm2E21S5Gbgg0B/008ePq/R4+OjiNJA63VMyUtQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cjy/Ls/Jm+H/lC9QuUTB+d5/zjmfy47wCd9tdA3uwA/HZnt4+zbQOa13zf0Xri8gQ
         H3dsFlLJIujpYUzYAYJkmC/1axU1dPF4TbSpFhbr9EfQ15k6ioxo+Qig/L0O/p2t5A
         5JBWZeg9w6QCRg8YWCbRVLFPfteDz5z21Dyh81P6d4okt/fL722dKknS0CKbwlTD59
         nV7lVw49FVbwDPCqldUf1p46W6+Vyrooc8MYXCWsTN6k/TO9aHFs96ZHkw0ac6Qadu
         m8lRd0gxqQh1AeYwotbnJhm70x031LV1Q5c5qWSUyVU9+tQ0ITm1lesd6z2rXhWGDh
         foPuJZ2a4uf6w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIWdse1027058;
        Mon, 29 Apr 2019 11:32:39 -0700
Date:   Mon, 29 Apr 2019 11:32:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c0cfc337264c5e02e0bc79de6b62857999588879@git.kernel.org>
Cc:     mbenes@suse.cz, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, tom.zanussi@linux.intel.com,
        jthumshirn@suse.de, jpoimboe@redhat.com, cl@linux.com,
        maarten.lankhorst@linux.intel.com, agk@redhat.com, hpa@zytor.com,
        adobriyan@gmail.com, robin.murphy@arm.com, clm@fb.com,
        akinobu.mita@gmail.com, hch@lst.de, luto@kernel.org,
        catalin.marinas@arm.com, joonas.lahtinen@linux.intel.com,
        rostedt@goodmis.org, mingo@kernel.org, rientjes@google.com,
        penberg@kernel.org, glider@google.com, daniel@ffwll.ch,
        snitzer@redhat.com, jani.nikula@linux.intel.com,
        aryabinin@virtuozzo.com, dsterba@suse.com,
        akpm@linux-foundation.org, rodrigo.vivi@intel.com,
        airlied@linux.ie, dvyukov@google.com, m.szyprowski@samsung.com,
        tglx@linutronix.de, josef@toxicpanda.com
Reply-To: jpoimboe@redhat.com, tom.zanussi@linux.intel.com,
          jthumshirn@suse.de, linux-kernel@vger.kernel.org,
          rppt@linux.vnet.ibm.com, mbenes@suse.cz, robin.murphy@arm.com,
          maarten.lankhorst@linux.intel.com, hpa@zytor.com,
          adobriyan@gmail.com, agk@redhat.com, cl@linux.com,
          rostedt@goodmis.org, mingo@kernel.org, catalin.marinas@arm.com,
          joonas.lahtinen@linux.intel.com, hch@lst.de, luto@kernel.org,
          clm@fb.com, akinobu.mita@gmail.com, rientjes@google.com,
          daniel@ffwll.ch, glider@google.com, penberg@kernel.org,
          akpm@linux-foundation.org, jani.nikula@linux.intel.com,
          aryabinin@virtuozzo.com, dsterba@suse.com, snitzer@redhat.com,
          m.szyprowski@samsung.com, airlied@linux.ie, dvyukov@google.com,
          rodrigo.vivi@intel.com, josef@toxicpanda.com, tglx@linutronix.de
In-Reply-To: <20190425094801.414574828@linutronix.de>
References: <20190425094801.414574828@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] lib/stackdepot: Provide functions which
 operate on plain storage arrays
Git-Commit-ID: c0cfc337264c5e02e0bc79de6b62857999588879
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

Commit-ID:  c0cfc337264c5e02e0bc79de6b62857999588879
Gitweb:     https://git.kernel.org/tip/c0cfc337264c5e02e0bc79de6b62857999588879
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:44:56 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:47 +0200

lib/stackdepot: Provide functions which operate on plain storage arrays

The struct stack_trace indirection in the stack depot functions is a truly
pointless excercise which requires horrible code at the callsites.

Provide interfaces based on plain storage arrays.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Alexander Potapenko <glider@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
Link: https://lkml.kernel.org/r/20190425094801.414574828@linutronix.de

---
 include/linux/stackdepot.h |  4 +++
 lib/stackdepot.c           | 70 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 7978b3e2c1e1..4297c6d2991d 100644
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
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e513459a5601..e84f8e58495c 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -194,40 +194,60 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 	return NULL;
 }
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
+/**
+ * stack_depot_fetch - Fetch stack entries from a depot
+ *
+ * @handle:		Stack depot handle which was returned from
+ *			stack_depot_save().
+ * @entries:		Pointer to store the entries address
+ *
+ * Return: The number of trace entries for this depot.
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
+ *
+ * @entries:		Pointer to storage array
+ * @nr_entries:		Size of the storage array
+ * @alloc_flags:	Allocation gfp flags
  *
- * Returns the handle of the stack struct stored in depot.
+ * Return: The handle of the stack struct stored in depot
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
@@ -235,8 +255,8 @@ depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |bucket| below.
 	 */
-	found = find_stack(smp_load_acquire(bucket), trace->entries,
-			   trace->nr_entries, hash);
+	found = find_stack(smp_load_acquire(bucket), entries,
+			   nr_entries, hash);
 	if (found)
 		goto exit;
 
@@ -264,10 +284,10 @@ depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
 
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
@@ -297,4 +317,16 @@ exit:
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
