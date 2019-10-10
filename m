Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D90C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FB320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfJJPyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJPyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:54:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41F1206A1;
        Thu, 10 Oct 2019 15:54:51 +0000 (UTC)
Date:   Thu, 10 Oct 2019 11:54:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191010115449.22044b53@gandalf.local.home>
In-Reply-To: <20191010140513.GT2311@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.10951536.8@infradead.org>
        <20191008104335.6fcd78c9@gandalf.local.home>
        <20191009224135.2dcf7767@oasis.local.home>
        <20191010092054.GR2311@hirez.programming.kicks-ass.net>
        <20191010091956.48fbcf42@gandalf.local.home>
        <20191010140513.GT2311@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 16:05:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Because we can't do the above once we have more than one CPU running.  
> 
> We loose BOOTING _long_ before we gain SMP.

Ah, yep. But I finally got it working with the following patch:

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 95beb85aef65..d7037d038005 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -25,7 +25,7 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
  */
 #define POKE_MAX_OPCODE_SIZE	5
 
-extern void text_poke_early(void *addr, const void *opcode, size_t len);
+extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index fa5dfde9b09a..2ee644a20f46 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -267,7 +267,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
-void text_poke_early(void *addr, const void *opcode, size_t len);
+void *text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Are we looking at a near JMP with a 1 or 4-byte displacement.
@@ -756,8 +756,8 @@ void __init alternative_instructions(void)
  * instructions. And on the local CPU you need to be protected against NMI or
  * MCE handlers seeing an inconsistent instruction while you patch.
  */
-void __init_or_module text_poke_early(void *addr, const void *opcode,
-				      size_t len)
+void *__init_or_module text_poke_early(void *addr, const void *opcode,
+				       size_t len)
 {
 	unsigned long flags;
 
@@ -780,6 +780,7 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 		 * that causes hangs on some VIA CPUs.
 		 */
 	}
+	return NULL;
 }
 
 __ro_after_init struct mm_struct *poking_mm;
@@ -1058,10 +1059,14 @@ static int tp_vec_nr;
  */
 static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
+	void *(*poke)(void *addr, const void *opcode, size_t len) = text_poke;
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
 	int do_sync;
 
+	if (system_state == SYSTEM_BOOTING)
+		poke = text_poke_early;
+
 	lockdep_assert_held(&text_mutex);
 
 	bp_patching.vec = tp;
@@ -1077,7 +1082,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < nr_entries; i++)
-		text_poke(tp[i].addr, &int3, sizeof(int3));
+		poke(tp[i].addr, &int3, sizeof(int3));
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
@@ -1086,8 +1091,8 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		if (tp[i].len - sizeof(int3) > 0) {
-			text_poke((char *)tp[i].addr + sizeof(int3),
-				  (const char *)tp[i].text + sizeof(int3),
+			poke((char *)tp[i].addr + sizeof(int3),
+			     (const char *)tp[i].text + sizeof(int3),
 				  tp[i].len - sizeof(int3));
 			do_sync++;
 		}
@@ -1110,7 +1115,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		if (tp[i].text[0] == INT3_INSN_OPCODE)
 			continue;
 
-		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
+		poke(tp[i].addr, tp[i].text, sizeof(int3));
 		do_sync++;
 	}
 
@@ -1234,6 +1239,10 @@ void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulat
 {
 	struct text_poke_loc tp;
 
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(addr, opcode, len);
+		return;
+	}
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index f2e59d858ca9..2dd462f86d1f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -308,7 +308,8 @@ union ftrace_op_code_union {
 #define RET_SIZE		1
 
 static unsigned long
-create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
+create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size,
+		  unsigned int *pages)
 {
 	unsigned long start_offset;
 	unsigned long end_offset;
@@ -394,8 +395,11 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	set_vm_flush_reset_perms(trampoline);
 
-	set_memory_ro((unsigned long)trampoline, npages);
+	/* We can't use text_poke_bp() at start up */
+	if (system_state != SYSTEM_BOOTING)
+		set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
+	*pages = npages;
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline);
@@ -423,7 +427,9 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 	ftrace_func_t func;
 	unsigned long offset;
 	unsigned long ip;
+	unsigned int pages;
 	unsigned int size;
+	bool set_ro = false;
 	const char *new;
 
 	if (ops->trampoline) {
@@ -434,7 +440,9 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 		if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 			return;
 	} else {
-		ops->trampoline = create_trampoline(ops, &size);
+		if (system_state == SYSTEM_BOOTING)
+			set_ro = true;
+		ops->trampoline = create_trampoline(ops, &size, &pages);
 		if (!ops->trampoline)
 			return;
 		ops->trampoline_size = size;
@@ -450,6 +458,8 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 	mutex_unlock(&text_mutex);
+	if (set_ro)
+		set_memory_ro((unsigned long)ops->trampoline, pages);
 }
 
 /* Return the address of the function the trampoline calls */



Is it really important to use text_poke() on text that is coming live?
That is, I really hate the above "set_ro" hack. This is because you
moved the ro setting to create_trampoline() and then forcing the
text_poke() on text that has just been created. I prefer to just modify
it and then setting it to ro before it gets executed. Otherwise we need
to do all these dances.

The same is with the module code. My patch was turning text to
read-write that is not to be executed yet. Really, what's wrong with
that?

-- Steve
