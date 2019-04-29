Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67593C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243FF2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F4iOaLW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfD2Swf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:52:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfD2Swe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:52:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIoQb31031940
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:50:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIoQb31031940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563828;
        bh=69iuZUbQZghv2pvlYoZXl3afITuZra5yGWDn7uRA19Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=F4iOaLW8tLSVO5kQWUyxBe/6pcf7LgFKeB2pQgpsNOOw4OTHPliE2qS9HMx2EdZJR
         oiXaj7Gf/plSugZV9+WT3V6lZGS3vdtZKRs7cKSFCgmSfQWVx3lpk+PJ5Szfj0umAB
         W0mqtLQgMKr/rts3BBItVEo67RI2rA/j7Z+r56qkabOgzFul08bPlJUowABmyV30qV
         20Ic8wII5/IM/iJst0Bm7thuyOdi7yZ1mJrB1/Kr9I6BO7s27LIFJdSkWeptKxjMIJ
         WmxmEultm0QL5MWx5MU4/3p9TuVnIgKwokFTgNICZhovYVUffYznLhO+VovYad4/lX
         9tHtBMN13ENtg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIoPon1031936;
        Mon, 29 Apr 2019 11:50:25 -0700
Date:   Mon, 29 Apr 2019 11:50:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3599fe12a125fa7118da2bcc5033d7741fb5f3a1@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tom.zanussi@linux.intel.com,
        aryabinin@virtuozzo.com, m.szyprowski@samsung.com,
        jpoimboe@redhat.com, tglx@linutronix.de, luto@kernel.org,
        rodrigo.vivi@intel.com, clm@fb.com, glider@google.com,
        josef@toxicpanda.com, hch@lst.de, joonas.lahtinen@linux.intel.com,
        akpm@linux-foundation.org, agk@redhat.com, rientjes@google.com,
        rostedt@goodmis.org, robin.murphy@arm.com, jthumshirn@suse.de,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        dsterba@suse.com, cl@linux.com, rppt@linux.vnet.ibm.com,
        mbenes@suse.cz, daniel@ffwll.ch, snitzer@redhat.com,
        akinobu.mita@gmail.com, adobriyan@gmail.com, dvyukov@google.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        penberg@kernel.org, catalin.marinas@arm.com
Reply-To: snitzer@redhat.com, daniel@ffwll.ch, mbenes@suse.cz,
          rppt@linux.vnet.ibm.com, cl@linux.com, dsterba@suse.com,
          linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
          robin.murphy@arm.com, jthumshirn@suse.de,
          catalin.marinas@arm.com, penberg@kernel.org, airlied@linux.ie,
          maarten.lankhorst@linux.intel.com, dvyukov@google.com,
          adobriyan@gmail.com, akinobu.mita@gmail.com,
          m.szyprowski@samsung.com, aryabinin@virtuozzo.com,
          tom.zanussi@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
          rostedt@goodmis.org, rientjes@google.com,
          akpm@linux-foundation.org, joonas.lahtinen@linux.intel.com,
          agk@redhat.com, hch@lst.de, josef@toxicpanda.com,
          glider@google.com, clm@fb.com, rodrigo.vivi@intel.com,
          tglx@linutronix.de, luto@kernel.org, jpoimboe@redhat.com
In-Reply-To: <20190425094803.816485461@linutronix.de>
References: <20190425094803.816485461@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] x86/stacktrace: Use common infrastructure
Git-Commit-ID: 3599fe12a125fa7118da2bcc5033d7741fb5f3a1
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

Commit-ID:  3599fe12a125fa7118da2bcc5033d7741fb5f3a1
Gitweb:     https://git.kernel.org/tip/3599fe12a125fa7118da2bcc5033d7741fb5f3a1
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:57 +0200

x86/stacktrace: Use common infrastructure

Replace the stack_trace_save*() functions with the new arch_stack_walk()
interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-arch@vger.kernel.org
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
Link: https://lkml.kernel.org/r/20190425094803.816485461@linutronix.de

---
 arch/x86/Kconfig             |   1 +
 arch/x86/kernel/stacktrace.c | 116 +++++++------------------------------------
 2 files changed, 20 insertions(+), 97 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..b5978e35a8a8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -74,6 +74,7 @@ config X86
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index b2f706f1e0b7..2abf27d7df6b 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -12,75 +12,31 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-static int save_stack_address(struct stack_trace *trace, unsigned long addr,
-			      bool nosched)
-{
-	if (nosched && in_sched_functions(addr))
-		return 0;
-
-	if (trace->skip > 0) {
-		trace->skip--;
-		return 0;
-	}
-
-	if (trace->nr_entries >= trace->max_entries)
-		return -1;
-
-	trace->entries[trace->nr_entries++] = addr;
-	return 0;
-}
-
-static void noinline __save_stack_trace(struct stack_trace *trace,
-			       struct task_struct *task, struct pt_regs *regs,
-			       bool nosched)
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
 {
 	struct unwind_state state;
 	unsigned long addr;
 
-	if (regs)
-		save_stack_address(trace, regs->ip, nosched);
+	if (regs && !consume_entry(cookie, regs->ip, false))
+		return;
 
 	for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
 	     unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
-		if (!addr || save_stack_address(trace, addr, nosched))
+		if (!addr || !consume_entry(cookie, addr, false))
 			break;
 	}
 }
 
 /*
- * Save stack-backtrace addresses into a stack_trace buffer.
+ * This function returns an error if it detects any unreliable features of the
+ * stack.  Otherwise it guarantees that the stack trace is reliable.
+ *
+ * If the task is not 'current', the caller *must* ensure the task is inactive.
  */
-void save_stack_trace(struct stack_trace *trace)
-{
-	trace->skip++;
-	__save_stack_trace(trace, current, NULL, false);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace);
-
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
-{
-	__save_stack_trace(trace, current, regs, false);
-}
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	if (!try_get_task_stack(tsk))
-		return;
-
-	if (tsk == current)
-		trace->skip++;
-	__save_stack_trace(trace, tsk, NULL, true);
-
-	put_task_stack(tsk);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-
-#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
-
-static int __always_inline
-__save_stack_trace_reliable(struct stack_trace *trace,
-			    struct task_struct *task)
+int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
+			     void *cookie, struct task_struct *task)
 {
 	struct unwind_state state;
 	struct pt_regs *regs;
@@ -117,7 +73,7 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 		if (!addr)
 			return -EINVAL;
 
-		if (save_stack_address(trace, addr, false))
+		if (!consume_entry(cookie, addr, false))
 			return -EINVAL;
 	}
 
@@ -132,32 +88,6 @@ __save_stack_trace_reliable(struct stack_trace *trace,
 	return 0;
 }
 
-/*
- * This function returns an error if it detects any unreliable features of the
- * stack.  Otherwise it guarantees that the stack trace is reliable.
- *
- * If the task is not 'current', the caller *must* ensure the task is inactive.
- */
-int save_stack_trace_tsk_reliable(struct task_struct *tsk,
-				  struct stack_trace *trace)
-{
-	int ret;
-
-	/*
-	 * If the task doesn't have a stack (e.g., a zombie), the stack is
-	 * "reliably" empty.
-	 */
-	if (!try_get_task_stack(tsk))
-		return 0;
-
-	ret = __save_stack_trace_reliable(trace, tsk);
-
-	put_task_stack(tsk);
-
-	return ret;
-}
-#endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
-
 /* Userspace stacktrace - based on kernel/trace/trace_sysprof.c */
 
 struct stack_frame_user {
@@ -182,15 +112,15 @@ copy_stack_frame(const void __user *fp, struct stack_frame_user *frame)
 	return ret;
 }
 
-static inline void __save_stack_trace_user(struct stack_trace *trace)
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
 {
-	const struct pt_regs *regs = task_pt_regs(current);
 	const void __user *fp = (const void __user *)regs->bp;
 
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = regs->ip;
+	if (!consume_entry(cookie, regs->ip, false))
+		return;
 
-	while (trace->nr_entries < trace->max_entries) {
+	while (1) {
 		struct stack_frame_user frame;
 
 		frame.next_fp = NULL;
@@ -200,8 +130,8 @@ static inline void __save_stack_trace_user(struct stack_trace *trace)
 		if ((unsigned long)fp < regs->sp)
 			break;
 		if (frame.ret_addr) {
-			trace->entries[trace->nr_entries++] =
-				frame.ret_addr;
+			if (!consume_entry(cookie, frame.ret_addr, false))
+				return;
 		}
 		if (fp == frame.next_fp)
 			break;
@@ -209,11 +139,3 @@ static inline void __save_stack_trace_user(struct stack_trace *trace)
 	}
 }
 
-void save_stack_trace_user(struct stack_trace *trace)
-{
-	/*
-	 * Trace user stack if we are not a kernel thread
-	 */
-	if (current->mm)
-		__save_stack_trace_user(trace);
-}
