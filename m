Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD5BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914AC2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfKOJnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:43:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42950 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfKOJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8F-0004Ob-BM; Fri, 15 Nov 2019 10:43:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EB0A71C18B4;
        Fri, 15 Nov 2019 10:43:10 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:10 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/ftrace: Use text_poke()
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191111132457.761255803@infradead.org>
References: <20191111132457.761255803@infradead.org>
MIME-Version: 1.0
Message-ID: <157381099055.29467.10982011694493970062.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     9706f7c3531fee00505ebd03bf3aa0af76510877
Gitweb:        https://git.kernel.org/tip/9706f7c3531fee00505ebd03bf3aa0af76510877
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 26 Aug 2019 14:48:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 09:07:42 +01:00

x86/ftrace: Use text_poke()

Move ftrace over to using the generic x86 text_poke functions; this
avoids having a second/different copy of that code around.

This also avoids ftrace violating the (new) W^X rule and avoids
fragmenting the kernel text page-tables, due to no longer having to
toggle them RW.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.761255803@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/ftrace.h |   2 +-
 arch/x86/kernel/alternative.c |  18 +-
 arch/x86/kernel/ftrace.c      | 663 +++++----------------------------
 arch/x86/kernel/traps.c       |   9 +-
 4 files changed, 134 insertions(+), 558 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index c38a666..dbd9b08 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -34,8 +34,6 @@ struct dyn_arch_ftrace {
 	/* No extra data needed for x86 */
 };
 
-int ftrace_int3_handler(struct pt_regs *regs);
-
 #define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
 
 #endif /*  CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 714b4a2..ce737f1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -949,7 +949,7 @@ static struct bp_patching_desc {
 	int nr_entries;
 } bp_patching;
 
-static int patch_cmp(const void *key, const void *elt)
+static int notrace patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
@@ -961,7 +961,7 @@ static int patch_cmp(const void *key, const void *elt)
 }
 NOKPROBE_SYMBOL(patch_cmp);
 
-int poke_int3_handler(struct pt_regs *regs)
+int notrace poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_loc *tp;
 	void *ip;
@@ -1209,10 +1209,15 @@ void text_poke_finish(void)
 	text_poke_flush(NULL);
 }
 
-void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct text_poke_loc *tp;
 
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(addr, opcode, len);
+		return;
+	}
+
 	text_poke_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
@@ -1230,10 +1235,15 @@ void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emu
  * dynamically allocated memory. This function should be used when it is
  * not possible to allocate memory.
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct text_poke_loc tp;
 
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(addr, opcode, len);
+		return;
+	}
+
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 024c305..3d8adeb 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -34,6 +34,8 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+static int ftrace_poke_late = 0;
+
 int ftrace_arch_code_modify_prepare(void)
     __acquires(&text_mutex)
 {
@@ -43,16 +45,20 @@ int ftrace_arch_code_modify_prepare(void)
 	 * ftrace has it set to "read/write".
 	 */
 	mutex_lock(&text_mutex);
-	set_kernel_text_rw();
-	set_all_modules_text_rw();
+	ftrace_poke_late = 1;
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
     __releases(&text_mutex)
 {
-	set_all_modules_text_ro();
-	set_kernel_text_ro();
+	/*
+	 * ftrace_make_{call,nop}() may be called during
+	 * module load, and we need to finish the text_poke_queue()
+	 * that they do, here.
+	 */
+	text_poke_finish();
+	ftrace_poke_late = 0;
 	mutex_unlock(&text_mutex);
 	return 0;
 }
@@ -60,67 +66,34 @@ int ftrace_arch_code_modify_post_process(void)
 union ftrace_code_union {
 	char code[MCOUNT_INSN_SIZE];
 	struct {
-		unsigned char op;
+		char op;
 		int offset;
 	} __attribute__((packed));
 };
 
-static int ftrace_calc_offset(long ip, long addr)
-{
-	return (int)(addr - ip);
-}
-
-static unsigned char *
-ftrace_text_replace(unsigned char op, unsigned long ip, unsigned long addr)
+static const char *ftrace_text_replace(char op, unsigned long ip, unsigned long addr)
 {
 	static union ftrace_code_union calc;
 
-	calc.op		= op;
-	calc.offset	= ftrace_calc_offset(ip + MCOUNT_INSN_SIZE, addr);
+	calc.op = op;
+	calc.offset = (int)(addr - (ip + MCOUNT_INSN_SIZE));
 
 	return calc.code;
 }
 
-static unsigned char *
-ftrace_call_replace(unsigned long ip, unsigned long addr)
-{
-	return ftrace_text_replace(0xe8, ip, addr);
-}
-
-static inline int
-within(unsigned long addr, unsigned long start, unsigned long end)
+static const char *ftrace_nop_replace(void)
 {
-	return addr >= start && addr < end;
-}
-
-static unsigned long text_ip_addr(unsigned long ip)
-{
-	/*
-	 * On x86_64, kernel text mappings are mapped read-only, so we use
-	 * the kernel identity mapping instead of the kernel text mapping
-	 * to modify the kernel text.
-	 *
-	 * For 32bit kernels, these mappings are same and we can use
-	 * kernel identity mapping to modify code.
-	 */
-	if (within(ip, (unsigned long)_text, (unsigned long)_etext))
-		ip = (unsigned long)__va(__pa_symbol(ip));
-
-	return ip;
+	return ideal_nops[NOP_ATOMIC5];
 }
 
-static const unsigned char *ftrace_nop_replace(void)
+static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
-	return ideal_nops[NOP_ATOMIC5];
+	return ftrace_text_replace(CALL_INSN_OPCODE, ip, addr);
 }
 
-static int
-ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
-		   unsigned const char *new_code)
+static int ftrace_verify_code(unsigned long ip, const char *old_code)
 {
-	unsigned char replaced[MCOUNT_INSN_SIZE];
-
-	ftrace_expected = old_code;
+	char cur_code[MCOUNT_INSN_SIZE];
 
 	/*
 	 * Note:
@@ -129,31 +102,41 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 	 * Carefully read and modify the code with probe_kernel_*(), and make
 	 * sure what we read is what we expected it to be before modifying it.
 	 */
-
 	/* read the text we want to modify */
-	if (probe_kernel_read(replaced, (void *)ip, MCOUNT_INSN_SIZE))
+	if (probe_kernel_read(cur_code, (void *)ip, MCOUNT_INSN_SIZE)) {
+		WARN_ON(1);
 		return -EFAULT;
+	}
 
 	/* Make sure it is what we expect it to be */
-	if (memcmp(replaced, old_code, MCOUNT_INSN_SIZE) != 0)
+	if (memcmp(cur_code, old_code, MCOUNT_INSN_SIZE) != 0) {
+		WARN_ON(1);
 		return -EINVAL;
+	}
 
-	ip = text_ip_addr(ip);
-
-	/* replace the text with the new text */
-	if (probe_kernel_write((void *)ip, new_code, MCOUNT_INSN_SIZE))
-		return -EPERM;
+	return 0;
+}
 
-	sync_core();
+static int
+ftrace_modify_code_direct(unsigned long ip, const char *old_code,
+			  const char *new_code)
+{
+	int ret = ftrace_verify_code(ip, old_code);
+	if (ret)
+		return ret;
 
+	/* replace the text with the new text */
+	if (ftrace_poke_late)
+		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
+	else
+		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	return 0;
 }
 
-int ftrace_make_nop(struct module *mod,
-		    struct dyn_ftrace *rec, unsigned long addr)
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned const char *new, *old;
 	unsigned long ip = rec->ip;
+	const char *new, *old;
 
 	old = ftrace_call_replace(ip, addr);
 	new = ftrace_nop_replace();
@@ -167,19 +150,20 @@ int ftrace_make_nop(struct module *mod,
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(rec->ip, old, new);
+		return ftrace_modify_code_direct(ip, old, new);
 
-	ftrace_expected = NULL;
-
-	/* Normal cases use add_brk_on_nop */
+	/*
+	 * x86 overrides ftrace_replace_code -- this function will never be used
+	 * in this case.
+	 */
 	WARN_ONCE(1, "invalid use of ftrace_make_nop");
 	return -EINVAL;
 }
 
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned const char *new, *old;
 	unsigned long ip = rec->ip;
+	const char *new, *old;
 
 	old = ftrace_nop_replace();
 	new = ftrace_call_replace(ip, addr);
@@ -189,43 +173,6 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 }
 
 /*
- * The modifying_ftrace_code is used to tell the breakpoint
- * handler to call ftrace_int3_handler(). If it fails to
- * call this handler for a breakpoint added by ftrace, then
- * the kernel may crash.
- *
- * As atomic_writes on x86 do not need a barrier, we do not
- * need to add smp_mb()s for this to work. It is also considered
- * that we can not read the modifying_ftrace_code before
- * executing the breakpoint. That would be quite remarkable if
- * it could do that. Here's the flow that is required:
- *
- *   CPU-0                          CPU-1
- *
- * atomic_inc(mfc);
- * write int3s
- *				<trap-int3> // implicit (r)mb
- *				if (atomic_read(mfc))
- *					call ftrace_int3_handler()
- *
- * Then when we are finished:
- *
- * atomic_dec(mfc);
- *
- * If we hit a breakpoint that was not set by ftrace, it does not
- * matter if ftrace_int3_handler() is called or not. It will
- * simply be ignored. But it is crucial that a ftrace nop/caller
- * breakpoint is handled. No other user should ever place a
- * breakpoint on an ftrace nop/caller location. It must only
- * be done by this code.
- */
-atomic_t modifying_ftrace_code __read_mostly;
-
-static int
-ftrace_modify_code(unsigned long ip, unsigned const char *old_code,
-		   unsigned const char *new_code);
-
-/*
  * Should never be called:
  *  As it is only called by __ftrace_replace_code() which is called by
  *  ftrace_replace_code() that x86 overrides, and by ftrace_update_code()
@@ -237,452 +184,84 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 				 unsigned long addr)
 {
 	WARN_ON(1);
-	ftrace_expected = NULL;
 	return -EINVAL;
 }
 
-static unsigned long ftrace_update_func;
-static unsigned long ftrace_update_func_call;
-
-static int update_ftrace_func(unsigned long ip, void *new)
-{
-	unsigned char old[MCOUNT_INSN_SIZE];
-	int ret;
-
-	memcpy(old, (void *)ip, MCOUNT_INSN_SIZE);
-
-	ftrace_update_func = ip;
-	/* Make sure the breakpoints see the ftrace_update_func update */
-	smp_wmb();
-
-	/* See comment above by declaration of modifying_ftrace_code */
-	atomic_inc(&modifying_ftrace_code);
-
-	ret = ftrace_modify_code(ip, old, new);
-
-	atomic_dec(&modifying_ftrace_code);
-
-	return ret;
-}
-
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
-	unsigned long ip = (unsigned long)(&ftrace_call);
-	unsigned char *new;
-	int ret;
-
-	ftrace_update_func_call = (unsigned long)func;
-
-	new = ftrace_call_replace(ip, (unsigned long)func);
-	ret = update_ftrace_func(ip, new);
-
-	/* Also update the regs callback function */
-	if (!ret) {
-		ip = (unsigned long)(&ftrace_regs_call);
-		new = ftrace_call_replace(ip, (unsigned long)func);
-		ret = update_ftrace_func(ip, new);
-	}
-
-	return ret;
-}
-
-static nokprobe_inline int is_ftrace_caller(unsigned long ip)
-{
-	if (ip == ftrace_update_func)
-		return 1;
-
-	return 0;
-}
-
-/*
- * A breakpoint was added to the code address we are about to
- * modify, and this is the handle that will just skip over it.
- * We are either changing a nop into a trace call, or a trace
- * call to a nop. While the change is taking place, we treat
- * it just like it was a nop.
- */
-int ftrace_int3_handler(struct pt_regs *regs)
-{
 	unsigned long ip;
+	const char *new;
 
-	if (WARN_ON_ONCE(!regs))
-		return 0;
-
-	ip = regs->ip - INT3_INSN_SIZE;
-
-	if (ftrace_location(ip)) {
-		int3_emulate_call(regs, (unsigned long)ftrace_regs_caller);
-		return 1;
-	} else if (is_ftrace_caller(ip)) {
-		if (!ftrace_update_func_call) {
-			int3_emulate_jmp(regs, ip + CALL_INSN_SIZE);
-			return 1;
-		}
-		int3_emulate_call(regs, ftrace_update_func_call);
-		return 1;
-	}
-
-	return 0;
-}
-NOKPROBE_SYMBOL(ftrace_int3_handler);
-
-static int ftrace_write(unsigned long ip, const char *val, int size)
-{
-	ip = text_ip_addr(ip);
-
-	if (probe_kernel_write((void *)ip, val, size))
-		return -EPERM;
-
-	return 0;
-}
-
-static int add_break(unsigned long ip, const char *old)
-{
-	unsigned char replaced[MCOUNT_INSN_SIZE];
-	unsigned char brk = BREAKPOINT_INSTRUCTION;
-
-	if (probe_kernel_read(replaced, (void *)ip, MCOUNT_INSN_SIZE))
-		return -EFAULT;
-
-	ftrace_expected = old;
-
-	/* Make sure it is what we expect it to be */
-	if (memcmp(replaced, old, MCOUNT_INSN_SIZE) != 0)
-		return -EINVAL;
-
-	return ftrace_write(ip, &brk, 1);
-}
-
-static int add_brk_on_call(struct dyn_ftrace *rec, unsigned long addr)
-{
-	unsigned const char *old;
-	unsigned long ip = rec->ip;
-
-	old = ftrace_call_replace(ip, addr);
-
-	return add_break(rec->ip, old);
-}
-
-
-static int add_brk_on_nop(struct dyn_ftrace *rec)
-{
-	unsigned const char *old;
-
-	old = ftrace_nop_replace();
-
-	return add_break(rec->ip, old);
-}
-
-static int add_breakpoints(struct dyn_ftrace *rec, bool enable)
-{
-	unsigned long ftrace_addr;
-	int ret;
-
-	ftrace_addr = ftrace_get_addr_curr(rec);
-
-	ret = ftrace_test_record(rec, enable);
-
-	switch (ret) {
-	case FTRACE_UPDATE_IGNORE:
-		return 0;
-
-	case FTRACE_UPDATE_MAKE_CALL:
-		/* converting nop to call */
-		return add_brk_on_nop(rec);
-
-	case FTRACE_UPDATE_MODIFY_CALL:
-	case FTRACE_UPDATE_MAKE_NOP:
-		/* converting a call to a nop */
-		return add_brk_on_call(rec, ftrace_addr);
-	}
-	return 0;
-}
-
-/*
- * On error, we need to remove breakpoints. This needs to
- * be done caefully. If the address does not currently have a
- * breakpoint, we know we are done. Otherwise, we look at the
- * remaining 4 bytes of the instruction. If it matches a nop
- * we replace the breakpoint with the nop. Otherwise we replace
- * it with the call instruction.
- */
-static int remove_breakpoint(struct dyn_ftrace *rec)
-{
-	unsigned char ins[MCOUNT_INSN_SIZE];
-	unsigned char brk = BREAKPOINT_INSTRUCTION;
-	const unsigned char *nop;
-	unsigned long ftrace_addr;
-	unsigned long ip = rec->ip;
-
-	/* If we fail the read, just give up */
-	if (probe_kernel_read(ins, (void *)ip, MCOUNT_INSN_SIZE))
-		return -EFAULT;
-
-	/* If this does not have a breakpoint, we are done */
-	if (ins[0] != brk)
-		return 0;
-
-	nop = ftrace_nop_replace();
-
-	/*
-	 * If the last 4 bytes of the instruction do not match
-	 * a nop, then we assume that this is a call to ftrace_addr.
-	 */
-	if (memcmp(&ins[1], &nop[1], MCOUNT_INSN_SIZE - 1) != 0) {
-		/*
-		 * For extra paranoidism, we check if the breakpoint is on
-		 * a call that would actually jump to the ftrace_addr.
-		 * If not, don't touch the breakpoint, we make just create
-		 * a disaster.
-		 */
-		ftrace_addr = ftrace_get_addr_new(rec);
-		nop = ftrace_call_replace(ip, ftrace_addr);
-
-		if (memcmp(&ins[1], &nop[1], MCOUNT_INSN_SIZE - 1) == 0)
-			goto update;
-
-		/* Check both ftrace_addr and ftrace_old_addr */
-		ftrace_addr = ftrace_get_addr_curr(rec);
-		nop = ftrace_call_replace(ip, ftrace_addr);
-
-		ftrace_expected = nop;
-
-		if (memcmp(&ins[1], &nop[1], MCOUNT_INSN_SIZE - 1) != 0)
-			return -EINVAL;
-	}
-
- update:
-	return ftrace_write(ip, nop, 1);
-}
-
-static int add_update_code(unsigned long ip, unsigned const char *new)
-{
-	/* skip breakpoint */
-	ip++;
-	new++;
-	return ftrace_write(ip, new, MCOUNT_INSN_SIZE - 1);
-}
-
-static int add_update_call(struct dyn_ftrace *rec, unsigned long addr)
-{
-	unsigned long ip = rec->ip;
-	unsigned const char *new;
-
-	new = ftrace_call_replace(ip, addr);
-	return add_update_code(ip, new);
-}
-
-static int add_update_nop(struct dyn_ftrace *rec)
-{
-	unsigned long ip = rec->ip;
-	unsigned const char *new;
-
-	new = ftrace_nop_replace();
-	return add_update_code(ip, new);
-}
-
-static int add_update(struct dyn_ftrace *rec, bool enable)
-{
-	unsigned long ftrace_addr;
-	int ret;
-
-	ret = ftrace_test_record(rec, enable);
-
-	ftrace_addr  = ftrace_get_addr_new(rec);
-
-	switch (ret) {
-	case FTRACE_UPDATE_IGNORE:
-		return 0;
-
-	case FTRACE_UPDATE_MODIFY_CALL:
-	case FTRACE_UPDATE_MAKE_CALL:
-		/* converting nop to call */
-		return add_update_call(rec, ftrace_addr);
-
-	case FTRACE_UPDATE_MAKE_NOP:
-		/* converting a call to a nop */
-		return add_update_nop(rec);
-	}
-
-	return 0;
-}
-
-static int finish_update_call(struct dyn_ftrace *rec, unsigned long addr)
-{
-	unsigned long ip = rec->ip;
-	unsigned const char *new;
-
-	new = ftrace_call_replace(ip, addr);
-
-	return ftrace_write(ip, new, 1);
-}
-
-static int finish_update_nop(struct dyn_ftrace *rec)
-{
-	unsigned long ip = rec->ip;
-	unsigned const char *new;
-
-	new = ftrace_nop_replace();
-
-	return ftrace_write(ip, new, 1);
-}
-
-static int finish_update(struct dyn_ftrace *rec, bool enable)
-{
-	unsigned long ftrace_addr;
-	int ret;
-
-	ret = ftrace_update_record(rec, enable);
-
-	ftrace_addr = ftrace_get_addr_new(rec);
-
-	switch (ret) {
-	case FTRACE_UPDATE_IGNORE:
-		return 0;
-
-	case FTRACE_UPDATE_MODIFY_CALL:
-	case FTRACE_UPDATE_MAKE_CALL:
-		/* converting nop to call */
-		return finish_update_call(rec, ftrace_addr);
+	ip = (unsigned long)(&ftrace_call);
+	new = ftrace_call_replace(ip, (unsigned long)func);
+	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 
-	case FTRACE_UPDATE_MAKE_NOP:
-		/* converting a call to a nop */
-		return finish_update_nop(rec);
-	}
+	ip = (unsigned long)(&ftrace_regs_call);
+	new = ftrace_call_replace(ip, (unsigned long)func);
+	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 
 	return 0;
 }
 
-static void do_sync_core(void *data)
-{
-	sync_core();
-}
-
-static void run_sync(void)
-{
-	int enable_irqs;
-
-	/* No need to sync if there's only one CPU */
-	if (num_online_cpus() == 1)
-		return;
-
-	enable_irqs = irqs_disabled();
-
-	/* We may be called with interrupts disabled (on bootup). */
-	if (enable_irqs)
-		local_irq_enable();
-	on_each_cpu(do_sync_core, NULL, 1);
-	if (enable_irqs)
-		local_irq_disable();
-}
-
 void ftrace_replace_code(int enable)
 {
 	struct ftrace_rec_iter *iter;
 	struct dyn_ftrace *rec;
-	const char *report = "adding breakpoints";
-	int count = 0;
+	const char *new, *old;
 	int ret;
 
 	for_ftrace_rec_iter(iter) {
 		rec = ftrace_rec_iter_record(iter);
 
-		ret = add_breakpoints(rec, enable);
-		if (ret)
-			goto remove_breakpoints;
-		count++;
-	}
-
-	run_sync();
+		switch (ftrace_test_record(rec, enable)) {
+		case FTRACE_UPDATE_IGNORE:
+		default:
+			continue;
 
-	report = "updating code";
-	count = 0;
+		case FTRACE_UPDATE_MAKE_CALL:
+			old = ftrace_nop_replace();
+			break;
 
-	for_ftrace_rec_iter(iter) {
-		rec = ftrace_rec_iter_record(iter);
+		case FTRACE_UPDATE_MODIFY_CALL:
+		case FTRACE_UPDATE_MAKE_NOP:
+			old = ftrace_call_replace(rec->ip, ftrace_get_addr_curr(rec));
+			break;
+		}
 
-		ret = add_update(rec, enable);
-		if (ret)
-			goto remove_breakpoints;
-		count++;
+		ret = ftrace_verify_code(rec->ip, old);
+		if (ret) {
+			ftrace_bug(ret, rec);
+			return;
+		}
 	}
 
-	run_sync();
-
-	report = "removing breakpoints";
-	count = 0;
-
 	for_ftrace_rec_iter(iter) {
 		rec = ftrace_rec_iter_record(iter);
 
-		ret = finish_update(rec, enable);
-		if (ret)
-			goto remove_breakpoints;
-		count++;
-	}
+		switch (ftrace_test_record(rec, enable)) {
+		case FTRACE_UPDATE_IGNORE:
+		default:
+			continue;
 
-	run_sync();
+		case FTRACE_UPDATE_MAKE_CALL:
+		case FTRACE_UPDATE_MODIFY_CALL:
+			new = ftrace_call_replace(rec->ip, ftrace_get_addr_new(rec));
+			break;
 
-	return;
+		case FTRACE_UPDATE_MAKE_NOP:
+			new = ftrace_nop_replace();
+			break;
+		}
 
- remove_breakpoints:
-	pr_warn("Failed on %s (%d):\n", report, count);
-	ftrace_bug(ret, rec);
-	for_ftrace_rec_iter(iter) {
-		rec = ftrace_rec_iter_record(iter);
-		/*
-		 * Breakpoints are handled only when this function is in
-		 * progress. The system could not work with them.
-		 */
-		if (remove_breakpoint(rec))
-			BUG();
+		text_poke_queue((void *)rec->ip, new, MCOUNT_INSN_SIZE, NULL);
+		ftrace_update_record(rec, enable);
 	}
-	run_sync();
-}
-
-static int
-ftrace_modify_code(unsigned long ip, unsigned const char *old_code,
-		   unsigned const char *new_code)
-{
-	int ret;
-
-	ret = add_break(ip, old_code);
-	if (ret)
-		goto out;
-
-	run_sync();
-
-	ret = add_update_code(ip, new_code);
-	if (ret)
-		goto fail_update;
-
-	run_sync();
-
-	ret = ftrace_write(ip, new_code, 1);
-	/*
-	 * The breakpoint is handled only when this function is in progress.
-	 * The system could not work if we could not remove it.
-	 */
-	BUG_ON(ret);
- out:
-	run_sync();
-	return ret;
-
- fail_update:
-	/* Also here the system could not work with the breakpoint */
-	if (ftrace_write(ip, old_code, 1))
-		BUG();
-	goto out;
+	text_poke_finish();
 }
 
 void arch_ftrace_update_code(int command)
 {
-	/* See comment above by declaration of modifying_ftrace_code */
-	atomic_inc(&modifying_ftrace_code);
-
 	ftrace_modify_all_code(command);
-
-	atomic_dec(&modifying_ftrace_code);
 }
 
 int __init ftrace_dyn_arch_init(void)
@@ -747,6 +326,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long start_offset;
 	unsigned long end_offset;
 	unsigned long op_offset;
+	unsigned long call_offset;
 	unsigned long offset;
 	unsigned long npages;
 	unsigned long size;
@@ -763,10 +343,12 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		start_offset = (unsigned long)ftrace_regs_caller;
 		end_offset = (unsigned long)ftrace_regs_caller_end;
 		op_offset = (unsigned long)ftrace_regs_caller_op_ptr;
+		call_offset = (unsigned long)ftrace_regs_call;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
 		end_offset = (unsigned long)ftrace_epilogue;
 		op_offset = (unsigned long)ftrace_caller_op_ptr;
+		call_offset = (unsigned long)ftrace_call;
 	}
 
 	size = end_offset - start_offset;
@@ -823,16 +405,21 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* put in the new offset to the ftrace_ops */
 	memcpy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
 
+	/* put in the call to the function */
+	mutex_lock(&text_mutex);
+	call_offset -= start_offset;
+	memcpy(trampoline + call_offset,
+	       text_gen_insn(CALL_INSN_OPCODE,
+			     trampoline + call_offset,
+			     ftrace_ops_get_func(ops)), CALL_INSN_SIZE);
+	mutex_unlock(&text_mutex);
+
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
 	set_vm_flush_reset_perms(trampoline);
 
-	/*
-	 * Module allocation needs to be completed by making the page
-	 * executable. The page is still writable, which is a security hazard,
-	 * but anyhow ftrace breaks W^X completely.
-	 */
+	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
@@ -859,43 +446,35 @@ static unsigned long calc_trampoline_call_offset(bool save_regs)
 void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 {
 	ftrace_func_t func;
-	unsigned char *new;
 	unsigned long offset;
 	unsigned long ip;
 	unsigned int size;
-	int ret, npages;
+	const char *new;
 
-	if (ops->trampoline) {
-		/*
-		 * The ftrace_ops caller may set up its own trampoline.
-		 * In such a case, this code must not modify it.
-		 */
-		if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
-			return;
-		npages = PAGE_ALIGN(ops->trampoline_size) >> PAGE_SHIFT;
-		set_memory_rw(ops->trampoline, npages);
-	} else {
+	if (!ops->trampoline) {
 		ops->trampoline = create_trampoline(ops, &size);
 		if (!ops->trampoline)
 			return;
 		ops->trampoline_size = size;
-		npages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+		return;
 	}
 
+	/*
+	 * The ftrace_ops caller may set up its own trampoline.
+	 * In such a case, this code must not modify it.
+	 */
+	if (!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
+		return;
+
 	offset = calc_trampoline_call_offset(ops->flags & FTRACE_OPS_FL_SAVE_REGS);
 	ip = ops->trampoline + offset;
-
 	func = ftrace_ops_get_func(ops);
 
-	ftrace_update_func_call = (unsigned long)func;
-
+	mutex_lock(&text_mutex);
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
-	ret = update_ftrace_func(ip, new);
-	set_memory_ro(ops->trampoline, npages);
-
-	/* The update should never fail */
-	WARN_ON(ret);
+	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	mutex_unlock(&text_mutex);
 }
 
 /* Return the address of the function the trampoline calls */
@@ -981,19 +560,18 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern void ftrace_graph_call(void);
 
-static unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
+static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
-	return ftrace_text_replace(0xe9, ip, addr);
+	return ftrace_text_replace(JMP32_INSN_OPCODE, ip, addr);
 }
 
 static int ftrace_mod_jmp(unsigned long ip, void *func)
 {
-	unsigned char *new;
+	const char *new;
 
-	ftrace_update_func_call = 0UL;
 	new = ftrace_jmp_replace(ip, (unsigned long)func);
-
-	return update_ftrace_func(ip, new);
+	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	return 0;
 }
 
 int ftrace_enable_ftrace_graph_caller(void)
@@ -1019,10 +597,9 @@ int ftrace_disable_ftrace_graph_caller(void)
 void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 			   unsigned long frame_pointer)
 {
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
 	int faulted;
-	unsigned long return_hooker = (unsigned long)
-				&return_to_handler;
 
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4bb0f84..c91d117 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -568,15 +568,6 @@ NOKPROBE_SYMBOL(do_general_protection);
 
 dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 {
-#ifdef CONFIG_DYNAMIC_FTRACE
-	/*
-	 * ftrace must be first, everything else may cause a recursive crash.
-	 * See note by declaration of modifying_ftrace_code in ftrace.c
-	 */
-	if (unlikely(atomic_read(&modifying_ftrace_code)) &&
-	    ftrace_int3_handler(regs))
-		return;
-#endif
 	if (poke_int3_handler(regs))
 		return;
 
