Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA905C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A967F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tlXTQ4gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfD2Sqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:46:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfD2Sqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:46:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIj6rg1031054
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:45:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIj6rg1031054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563508;
        bh=v58FdPGlwTZThwGXK/xjS2qQtMcOvzihC/eurJ9F7b0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tlXTQ4guqy6WNPM2bD44ME/PHcyCIU3KZaI3XI2//YPCAu7hGUJCAtyche+7rdnA5
         s2fYClgiOL0UjX8dc4q+Jm+Mk953XN+BoWB2j9VV8K9z82jRooJTNrJPdrNeCnHW4p
         inNw+KzViXyxmz/ds2aiLsMetO8mgpeqCNST+OyzsWmR4FBg4uj0ljJmAcl5/JLSh1
         tkTCyvqXHwyl+525f/EAvEh8cOYzo5PKBTPzGr885FjmGZ9fe+B9xQJHDaugA/xxep
         u4mLrraln9BlyKWbOfPdjnzK0dmtUuYpsA3cNQ1igTbWHwFgFuOxEzbgqm9peyBVzj
         K3lRoJPkmCQ6g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIj6VC1031047;
        Mon, 29 Apr 2019 11:45:06 -0700
Date:   Mon, 29 Apr 2019 11:45:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2a820bf74918d61ea54f7c1001f4a6a2e457577c@git.kernel.org>
Cc:     airlied@linux.ie, jpoimboe@redhat.com, jani.nikula@linux.intel.com,
        mbenes@suse.cz, catalin.marinas@arm.com, mingo@kernel.org,
        tom.zanussi@linux.intel.com, akpm@linux-foundation.org,
        robin.murphy@arm.com, aryabinin@virtuozzo.com,
        rppt@linux.vnet.ibm.com, hch@lst.de, rientjes@google.com,
        m.szyprowski@samsung.com, glider@google.com, josef@toxicpanda.com,
        dsterba@suse.com, cl@linux.com, snitzer@redhat.com, hpa@zytor.com,
        akinobu.mita@gmail.com, rostedt@goodmis.org,
        joonas.lahtinen@linux.intel.com, dvyukov@google.com,
        rodrigo.vivi@intel.com, jthumshirn@suse.de,
        maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
        clm@fb.com, penberg@kernel.org, daniel@ffwll.ch, agk@redhat.com,
        tglx@linutronix.de, luto@kernel.org, adobriyan@gmail.com
Reply-To: hch@lst.de, rppt@linux.vnet.ibm.com, akpm@linux-foundation.org,
          robin.murphy@arm.com, aryabinin@virtuozzo.com, dsterba@suse.com,
          cl@linux.com, glider@google.com, josef@toxicpanda.com,
          m.szyprowski@samsung.com, rientjes@google.com, airlied@linux.ie,
          tom.zanussi@linux.intel.com, mingo@kernel.org,
          catalin.marinas@arm.com, jani.nikula@linux.intel.com,
          mbenes@suse.cz, jpoimboe@redhat.com, clm@fb.com,
          linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com,
          jthumshirn@suse.de, maarten.lankhorst@linux.intel.com,
          adobriyan@gmail.com, tglx@linutronix.de, luto@kernel.org,
          agk@redhat.com, penberg@kernel.org, daniel@ffwll.ch,
          akinobu.mita@gmail.com, rostedt@goodmis.org, hpa@zytor.com,
          snitzer@redhat.com, dvyukov@google.com,
          joonas.lahtinen@linux.intel.com
In-Reply-To: <20190425094803.066064076@linutronix.de>
References: <20190425094803.066064076@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] tracing: Use percpu stack trace buffer more
 intelligently
Git-Commit-ID: 2a820bf74918d61ea54f7c1001f4a6a2e457577c
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

Commit-ID:  2a820bf74918d61ea54f7c1001f4a6a2e457577c
Gitweb:     https://git.kernel.org/tip/2a820bf74918d61ea54f7c1001f4a6a2e457577c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:55 +0200

tracing: Use percpu stack trace buffer more intelligently

The per cpu stack trace buffer usage pattern is odd at best. The buffer has
place for 512 stack trace entries on 64-bit and 1024 on 32-bit. When
interrupts or exceptions nest after the per cpu buffer was acquired the
stacktrace length is hardcoded to 8 entries. 512/1024 stack trace entries
in kernel stacks are unrealistic so the buffer is a complete waste.

Split the buffer into 4 nest levels, which are 128/256 entries per
level. This allows nesting contexts (interrupts, exceptions) to utilize the
cpu buffer for stack retrieval and avoids the fixed length allocation along
with the conditional execution pathes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
Link: https://lkml.kernel.org/r/20190425094803.066064076@linutronix.de

---
 kernel/trace/trace.c | 73 ++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 21153e64bf1c..4fc93004feab 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2749,12 +2749,21 @@ trace_function(struct trace_array *tr,
 
 #ifdef CONFIG_STACKTRACE
 
-#define FTRACE_STACK_MAX_ENTRIES (PAGE_SIZE / sizeof(unsigned long))
+/* Allow 4 levels of nesting: normal, softirq, irq, NMI */
+#define FTRACE_KSTACK_NESTING	4
+
+#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
+
 struct ftrace_stack {
-	unsigned long		calls[FTRACE_STACK_MAX_ENTRIES];
+	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
+};
+
+
+struct ftrace_stacks {
+	struct ftrace_stack	stacks[FTRACE_KSTACK_NESTING];
 };
 
-static DEFINE_PER_CPU(struct ftrace_stack, ftrace_stack);
+static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
 static void __ftrace_trace_stack(struct ring_buffer *buffer,
@@ -2763,10 +2772,11 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 {
 	struct trace_event_call *call = &event_kernel_stack;
 	struct ring_buffer_event *event;
+	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	struct stack_trace trace;
-	int use_stack;
-	int size = FTRACE_STACK_ENTRIES;
+	int size = FTRACE_KSTACK_ENTRIES;
+	int stackidx;
 
 	trace.nr_entries	= 0;
 	trace.skip		= skip;
@@ -2788,29 +2798,32 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 	 */
 	preempt_disable_notrace();
 
-	use_stack = __this_cpu_inc_return(ftrace_stack_reserve);
+	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
+
+	/* This should never happen. If it does, yell once and skip */
+	if (WARN_ON_ONCE(stackidx > FTRACE_KSTACK_NESTING))
+		goto out;
+
 	/*
-	 * We don't need any atomic variables, just a barrier.
-	 * If an interrupt comes in, we don't care, because it would
-	 * have exited and put the counter back to what we want.
-	 * We just need a barrier to keep gcc from moving things
-	 * around.
+	 * The above __this_cpu_inc_return() is 'atomic' cpu local. An
+	 * interrupt will either see the value pre increment or post
+	 * increment. If the interrupt happens pre increment it will have
+	 * restored the counter when it returns.  We just need a barrier to
+	 * keep gcc from moving things around.
 	 */
 	barrier();
-	if (use_stack == 1) {
-		trace.entries		= this_cpu_ptr(ftrace_stack.calls);
-		trace.max_entries	= FTRACE_STACK_MAX_ENTRIES;
 
-		if (regs)
-			save_stack_trace_regs(regs, &trace);
-		else
-			save_stack_trace(&trace);
+	fstack = this_cpu_ptr(ftrace_stacks.stacks) + stackidx;
+	trace.entries		= fstack->calls;
+	trace.max_entries	= FTRACE_KSTACK_ENTRIES;
 
-		if (trace.nr_entries > size)
-			size = trace.nr_entries;
-	} else
-		/* From now on, use_stack is a boolean */
-		use_stack = 0;
+	if (regs)
+		save_stack_trace_regs(regs, &trace);
+	else
+		save_stack_trace(&trace);
+
+	if (trace.nr_entries > size)
+		size = trace.nr_entries;
 
 	size *= sizeof(unsigned long);
 
@@ -2820,19 +2833,7 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 		goto out;
 	entry = ring_buffer_event_data(event);
 
-	memset(&entry->caller, 0, size);
-
-	if (use_stack)
-		memcpy(&entry->caller, trace.entries,
-		       trace.nr_entries * sizeof(unsigned long));
-	else {
-		trace.max_entries	= FTRACE_STACK_ENTRIES;
-		trace.entries		= entry->caller;
-		if (regs)
-			save_stack_trace_regs(regs, &trace);
-		else
-			save_stack_trace(&trace);
-	}
+	memcpy(&entry->caller, trace.entries, size);
 
 	entry->size = trace.nr_entries;
 
