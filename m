Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F33C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D16215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p44VRK6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfD2Ssl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:48:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41663 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2Ssl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:48:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIkQL51031184
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:46:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIkQL51031184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563588;
        bh=iIPzJzN88Ldq4KztePevor+oaTGNeeuMHs1Eu33goKA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p44VRK6Dvi+NbOiarhTeTkk4G8SKYfU8huTVemtMn8CKNz1felSNRF0T/E/s7akdE
         pxroLcJTFUN3OkyxgzbE/9TNx/YVG3brmpyJH60ABjsTew3JkfY9uv93OSjsy5pBdf
         OuqQyvQE/p1KE71IJxjQ1HlKjHEXCW+XeD9/aXqoYbzfyNk0fzbv5FD7oyO6AhZG3I
         0DGYd2a/bxsaQd3S9l6cXHTjJBkiInKoY4F7f7d2ZsLkMHbh3ewdDI0U1sZ23Z2Mlk
         7aUmNyDix5mM6XTH+3g7JDRErMHzQPad4jrxlsDv3KNEnSN/KCr/47tKngDZ7aXyfC
         AUncWtY65GwOw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIkOsV1031179;
        Mon, 29 Apr 2019 11:46:24 -0700
Date:   Mon, 29 Apr 2019 11:46:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-ee6dd0db4d8de41a0a0bc37d8d87a0b1623f83b0@git.kernel.org>
Cc:     mingo@kernel.org, adobriyan@gmail.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com,
        jani.nikula@linux.intel.com, tglx@linutronix.de,
        snitzer@redhat.com, m.szyprowski@samsung.com, airlied@linux.ie,
        penberg@kernel.org, luto@kernel.org, aryabinin@virtuozzo.com,
        rientjes@google.com, joonas.lahtinen@linux.intel.com,
        robin.murphy@arm.com, jpoimboe@redhat.com,
        maarten.lankhorst@linux.intel.com, rppt@linux.vnet.ibm.com,
        hch@lst.de, dsterba@suse.com, cl@linux.com, josef@toxicpanda.com,
        jthumshirn@suse.de, catalin.marinas@arm.com, daniel@ffwll.ch,
        tom.zanussi@linux.intel.com, akinobu.mita@gmail.com,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, clm@fb.com,
        agk@redhat.com, rodrigo.vivi@intel.com, glider@google.com,
        rostedt@goodmis.org
Reply-To: airlied@linux.ie, penberg@kernel.org, tglx@linutronix.de,
          snitzer@redhat.com, m.szyprowski@samsung.com,
          aryabinin@virtuozzo.com, luto@kernel.org, robin.murphy@arm.com,
          rientjes@google.com, joonas.lahtinen@linux.intel.com,
          jpoimboe@redhat.com, maarten.lankhorst@linux.intel.com,
          mingo@kernel.org, adobriyan@gmail.com, dvyukov@google.com,
          akpm@linux-foundation.org, hpa@zytor.com,
          jani.nikula@linux.intel.com, daniel@ffwll.ch,
          catalin.marinas@arm.com, akinobu.mita@gmail.com,
          linux-kernel@vger.kernel.org, mbenes@suse.cz,
          tom.zanussi@linux.intel.com, agk@redhat.com, clm@fb.com,
          rostedt@goodmis.org, glider@google.com, rodrigo.vivi@intel.com,
          hch@lst.de, dsterba@suse.com, rppt@linux.vnet.ibm.com,
          cl@linux.com, jthumshirn@suse.de, josef@toxicpanda.com
In-Reply-To: <20190425094803.248604594@linutronix.de>
References: <20190425094803.248604594@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] tracing: Simplify stack trace retrieval
Git-Commit-ID: ee6dd0db4d8de41a0a0bc37d8d87a0b1623f83b0
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

Commit-ID:  ee6dd0db4d8de41a0a0bc37d8d87a0b1623f83b0
Gitweb:     https://git.kernel.org/tip/ee6dd0db4d8de41a0a0bc37d8d87a0b1623f83b0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:55 +0200

tracing: Simplify stack trace retrieval

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
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
Link: https://lkml.kernel.org/r/20190425094803.248604594@linutronix.de

---
 kernel/trace/trace.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d8369d27c1af..0ce8515dd470 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2774,22 +2774,18 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 {
 	struct trace_event_call *call = &event_kernel_stack;
 	struct ring_buffer_event *event;
+	unsigned int size, nr_entries;
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
-	struct stack_trace trace;
-	int size = FTRACE_KSTACK_ENTRIES;
 	int stackidx;
 
-	trace.nr_entries	= 0;
-	trace.skip		= skip;
-
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
 	 * If regs is set, then these functions will not be in the way.
 	 */
 #ifndef CONFIG_UNWINDER_ORC
 	if (!regs)
-		trace.skip++;
+		skip++;
 #endif
 
 	/*
@@ -2816,28 +2812,24 @@ static void __ftrace_trace_stack(struct ring_buffer *buffer,
 	barrier();
 
 	fstack = this_cpu_ptr(ftrace_stacks.stacks) + stackidx;
-	trace.entries		= fstack->calls;
-	trace.max_entries	= FTRACE_KSTACK_ENTRIES;
-
-	if (regs)
-		save_stack_trace_regs(regs, &trace);
-	else
-		save_stack_trace(&trace);
-
-	if (trace.nr_entries > size)
-		size = trace.nr_entries;
+	size = ARRAY_SIZE(fstack->calls);
 
-	size *= sizeof(unsigned long);
+	if (regs) {
+		nr_entries = stack_trace_save_regs(regs, fstack->calls,
+						   size, skip);
+	} else {
+		nr_entries = stack_trace_save(fstack->calls, size, skip);
+	}
 
+	size = nr_entries * sizeof(unsigned long);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 					    sizeof(*entry) + size, flags, pc);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, trace.entries, size);
-
-	entry->size = trace.nr_entries;
+	memcpy(&entry->caller, fstack->calls, size);
+	entry->size = nr_entries;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
@@ -2916,7 +2908,6 @@ ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags, int pc)
 	struct trace_event_call *call = &event_user_stack;
 	struct ring_buffer_event *event;
 	struct userstack_entry *entry;
-	struct stack_trace trace;
 
 	if (!(global_trace.trace_flags & TRACE_ITER_USERSTACKTRACE))
 		return;
@@ -2947,12 +2938,7 @@ ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags, int pc)
 	entry->tgid		= current->tgid;
 	memset(&entry->caller, 0, sizeof(entry->caller));
 
-	trace.nr_entries	= 0;
-	trace.max_entries	= FTRACE_STACK_ENTRIES;
-	trace.skip		= 0;
-	trace.entries		= entry->caller;
-
-	save_stack_trace_user(&trace);
+	stack_trace_save_user(entry->caller, FTRACE_STACK_ENTRIES);
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
 
