Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C77AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA75020748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKOJoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:44:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfKOJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8D-0004Mc-Rk; Fri, 15 Nov 2019 10:43:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7DE551C08AC;
        Fri, 15 Nov 2019 10:43:09 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:09 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/ftrace: Use text_gen_insn()
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191111132457.932808000@infradead.org>
References: <20191111132457.932808000@infradead.org>
MIME-Version: 1.0
Message-ID: <157381098912.29467.11454367355444311258.tip-bot2@tip-bot2>
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

Commit-ID:     a02273c89f76df917b49694a7f836b2d61c0ff87
Gitweb:        https://git.kernel.org/tip/a02273c89f76df917b49694a7f836b2d61c0ff87
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Oct 2019 12:44:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 09:07:43 +01:00

x86/ftrace: Use text_gen_insn()

Replace the ftrace_code_union with the generic text_gen_insn() helper,
which does exactly this.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.932808000@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h | 30 ++++++++++++++++++++++++-
 arch/x86/kernel/alternative.c        | 26 +----------------------
 arch/x86/kernel/ftrace.c             | 32 +++++----------------------
 3 files changed, 36 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 93e4266..ad8f9f4 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -80,7 +80,35 @@ static inline int text_opcode_size(u8 opcode)
 	return size;
 }
 
-extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
+union text_poke_insn {
+	u8 text[POKE_MAX_OPCODE_SIZE];
+	struct {
+		u8 opcode;
+		s32 disp;
+	} __attribute__((packed));
+};
+
+static __always_inline
+void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+{
+	static union text_poke_insn insn; /* per instance */
+	int size = text_opcode_size(opcode);
+
+	insn.opcode = opcode;
+
+	if (size > 1) {
+		insn.disp = (long)dest - (long)(addr + size);
+		if (size == 2) {
+			/*
+			 * Ensure that for JMP9 the displacement
+			 * actually fits the signed byte.
+			 */
+			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+		}
+	}
+
+	return &insn.text;
+}
 
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f8f34f9..cfcfadf 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1247,29 +1247,3 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
-
-union text_poke_insn {
-	u8 text[POKE_MAX_OPCODE_SIZE];
-	struct {
-		u8 opcode;
-		s32 disp;
-	} __attribute__((packed));
-};
-
-void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
-{
-	static union text_poke_insn insn; /* text_mutex */
-	int size = text_opcode_size(opcode);
-
-	lockdep_assert_held(&text_mutex);
-
-	insn.opcode = opcode;
-
-	if (size > 1) {
-		insn.disp = (long)dest - (long)(addr + size);
-		if (size == 2)
-			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
-	}
-
-	return &insn.text;
-}
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 3d8adeb..2a179fb 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -63,24 +63,6 @@ int ftrace_arch_code_modify_post_process(void)
 	return 0;
 }
 
-union ftrace_code_union {
-	char code[MCOUNT_INSN_SIZE];
-	struct {
-		char op;
-		int offset;
-	} __attribute__((packed));
-};
-
-static const char *ftrace_text_replace(char op, unsigned long ip, unsigned long addr)
-{
-	static union ftrace_code_union calc;
-
-	calc.op = op;
-	calc.offset = (int)(addr - (ip + MCOUNT_INSN_SIZE));
-
-	return calc.code;
-}
-
 static const char *ftrace_nop_replace(void)
 {
 	return ideal_nops[NOP_ATOMIC5];
@@ -88,7 +70,7 @@ static const char *ftrace_nop_replace(void)
 
 static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
-	return ftrace_text_replace(CALL_INSN_OPCODE, ip, addr);
+	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
 }
 
 static int ftrace_verify_code(unsigned long ip, const char *old_code)
@@ -480,20 +462,20 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 /* Return the address of the function the trampoline calls */
 static void *addr_from_call(void *ptr)
 {
-	union ftrace_code_union calc;
+	union text_poke_insn call;
 	int ret;
 
-	ret = probe_kernel_read(&calc, ptr, MCOUNT_INSN_SIZE);
+	ret = probe_kernel_read(&call, ptr, CALL_INSN_SIZE);
 	if (WARN_ON_ONCE(ret < 0))
 		return NULL;
 
 	/* Make sure this is a call */
-	if (WARN_ON_ONCE(calc.op != 0xe8)) {
-		pr_warn("Expected e8, got %x\n", calc.op);
+	if (WARN_ON_ONCE(call.opcode != CALL_INSN_OPCODE)) {
+		pr_warn("Expected E8, got %x\n", call.opcode);
 		return NULL;
 	}
 
-	return ptr + MCOUNT_INSN_SIZE + calc.offset;
+	return ptr + CALL_INSN_SIZE + call.disp;
 }
 
 void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
@@ -562,7 +544,7 @@ extern void ftrace_graph_call(void);
 
 static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
-	return ftrace_text_replace(JMP32_INSN_OPCODE, ip, addr);
+	return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
 }
 
 static int ftrace_mod_jmp(unsigned long ip, void *func)
