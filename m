Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82462ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECF121D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uBh43PJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfJGLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfJGLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jsI7ay5WgDiCwNhPDciNxugsQbCjPXibCC6LUrS196Q=; b=uBh43PJiVIYIJjp1aGez01gYWL
        fzf5a9676ttuzOlWv0WGUpPevHk8WIeKfZG24rjU7WPJODDqyjA/MaNCVu9BuN95/GaPhPTRUd0FW
        OaQ3DDfUkL4ySkNdH+ggUe4MGjHzYFnaM5TWMMU9gZwXFGSHuHXr0WSbluJXublZ1CIAgjpsahEaJ
        h4f8YhIuurai3emI2FH82Resl6gPqFsXY9V0saqmzRqfo3/ieXnmbBlwfplpcgM+zUk71Di2LXeLk
        F48LDTGZlvxXr3cmapqq4FnpnSPIkQQ4R0CmArH9iY16Yb+3jg2+rl6zIRx43Sdx7wO7xNNFbqp2/
        gxtl5VNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6z-0002Bq-Pw; Mon, 07 Oct 2019 11:23:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D5FC30655C;
        Mon,  7 Oct 2019 13:22:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1934720244E4C; Mon,  7 Oct 2019 13:23:27 +0200 (CEST)
Message-Id: <20191007090012.28803430.0@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 9/9] jump_label, x86: Enable JMP8/NOP2 support
References: <20191007084443.79370128.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and emit short JMP/NOP jump_label entries.

A lot of the jumps are in fact short, like around tracepoints:

0000 0000000000000920 <native_read_msr>:                                   | 0000 0000000000000920 <native_read_msr>:
0000      920:  53                      push   %rbx                        | 0000      920:  53                      push   %rbx
0001      921:  89 f9                   mov    %edi,%ecx                   | 0001      921:  89 f9                   mov    %edi,%ecx
0003      923:  0f 32                   rdmsr                              | 0003      923:  0f 32                   rdmsr
0005      925:  48 c1 e2 20             shl    $0x20,%rdx                  | 0005      925:  48 c1 e2 20             shl    $0x20,%rdx
0009      929:  48 89 d3                mov    %rdx,%rbx                   | 0009      929:  48 89 d3                mov    %rdx,%rbx
000c      92c:  48 09 c3                or     %rax,%rbx                   | 000c      92c:  48 09 c3                or     %rax,%rbx
000f      92f:  0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)            \ 000f      92f:  66 90                   xchg   %ax,%ax
0014      934:  48 89 d8                mov    %rbx,%rax                   \ 0011      931:  48 89 d8                mov    %rbx,%rax
0017      937:  5b                      pop    %rbx                        \ 0014      934:  5b                      pop    %rbx
0018      938:  c3                      retq                               \ 0015      935:  c3                      retq
0019      939:  48 89 de                mov    %rbx,%rsi                   \ 0016      936:  48 89 de                mov    %rbx,%rsi
001c      93c:  31 d2                   xor    %edx,%edx                   \ 0019      939:  31 d2                   xor    %edx,%edx
001e      93e:  e8 00 00 00 00          callq  943 <native_read_msr+0x23>  \ 001b      93b:  e8 00 00 00 00          callq  940 <native_read_msr+0x20>
001f                    93f: R_X86_64_PLT32     do_trace_read_msr-0x4      \ 001c                    93c: R_X86_64_PLT32     do_trace_read_msr-0x4
0023      943:  48 89 d8                mov    %rbx,%rax                   \ 0020      940:  48 89 d8                mov    %rbx,%rax
0026      946:  5b                      pop    %rbx                        \ 0023      943:  5b                      pop    %rbx
0027      947:  c3                      retq                               \ 0024      944:  c3                      retq

.rela__jump_table
  000000000010  000200000002 R_X86_64_PC32     0000000000000000 .text + 92f
  000000000014  000200000002 R_X86_64_PC32     0000000000000000 .text + 939 (or 936)
  000000000018  014500000018 R_X86_64_PC64     0000000000000000 __tracepoint_read_msr + 8

The below patch works as long as the jump doesn't cross sections; the
moment GCC generates a branch crossing sections and feeds it into our
asm-goto things come apart like:

  /tmp/ccM70dCh.s: Assembler messages:
  /tmp/ccM70dCh.s: Error: invalid operands (.text.unlikely and .text sections) for `-' when setting `disp'
  ../arch/x86/include/asm/jump_label.h:39: Error: invalid operands (.text.unlikely and *ABS* sections) for `>>'
  ../arch/x86/include/asm/jump_label.h:39: Error: invalid operands (.text.unlikely and *ABS* sections) for `>>'

Which is really unfortunate since it is a completely sane thing to
happen. We really need a GAS extention to handle this :-/

All we really need is to detect the two offsets are from different
sections and punt to the 5 byte nop. But AFAICT there is nothing that
can do that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>
---
 arch/x86/Kconfig                  |   10 ++++++++++
 arch/x86/include/asm/jump_label.h |   36 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/jump_label.c      |   17 +++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -230,6 +230,16 @@ config X86
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 
+#
+# This mostly depends on the asm ".nops 5" directive existing and emitting a
+# single instruction nop, this is true for x86_64, but not for i386, which
+# violates the single instruction constraint.
+#
+config CC_HAS_ASM_NOPS
+	def_bool y
+	depends on X86_64
+	depends on $(success,echo 'void foo(void) { asm inline (".nops 5"); }' | $(CC) -x c - -c -o /dev/null)
+
 config INSTRUCTION_DECODER
 	def_bool y
 	depends on KPROBES || PERF_EVENTS || UPROBES
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -4,6 +4,10 @@
 
 #define HAVE_JUMP_LABEL_BATCH
 
+#ifdef CONFIG_CC_HAS_ASM_NOPS
+#define HAVE_JUMP_LABEL_VARIABLE
+#endif
+
 #ifdef CONFIG_X86_64
 # define STATIC_KEY_NOP2 P6_NOP2
 # define STATIC_KEY_NOP5 P6_NOP5_ATOMIC
@@ -31,7 +35,29 @@
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
+#ifdef HAVE_JUMP_LABEL_VARIABLE
+		/*
+		 * This comes apart mightily when %[l_yes] and 1b are in
+		 * different sections; like for instance .text and
+		 * .text.unlikely. Sadly there is nothing to actually detect
+		 * and handle this case explicitly.
+		 *
+		 * GAS sucks!!
+		 */
+		".set disp, (%l[l_yes]) - (1b + 2) \n\t"
+		".set res, (disp >> 31) == (disp >> 7) \n\t"
+		".set is_byte, -res \n\t"
+		".set is_long, -(~res) \n\t"
+
+		/*
+		 * This relies on .nops:
+		 *  - matching the above STATIC_KEY_NOP* bytes
+		 *  - emitting a single instruction nop for 2 and 5 bytes.
+		 */
+		".nops (2*is_byte) + (5*is_long)\n\t"
+#else
 		".byte " __stringify(STATIC_KEY_NOP5) "\n\t"
+#endif
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -43,8 +69,13 @@ static __always_inline bool arch_static_
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
+#ifdef HAVE_JUMP_LABEL_VARIABLE
+		"jmp %l[l_yes] \n\t"
+#else
+		/* Equivalent to "jmp.d32 \target" */
 		".byte 0xe9 \n\t"
 		".long %l[l_yes] - (. + 4) \n\t"
+#endif
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -59,9 +90,12 @@ extern int arch_jump_entry_size(struct j
 
 .macro STATIC_BRANCH_FALSE_LIKELY target, key
 .Lstatic_jump_\@:
-	/* Equivalent to "jmp.d32 \target" */
+#ifdef HAVE_JUMP_LABEL_VARIABLE
+	jmp \target
+#else
 	.byte		0xe9
 	.long		\target - (. + 4)
+#endif
 
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -18,7 +18,24 @@
 
 int arch_jump_entry_size(struct jump_entry *entry)
 {
+#ifdef HAVE_JUMP_LABEL_VARIABLE
+	struct insn insn;
+
+	/*
+	 * Because the instruction size heuristic doesn't purely rely on
+	 * displacement, but also on section, and we're hindered by GNU as UB
+	 * to emit the assemble time choice, we have to discover the size at
+	 * runtime.
+	 */
+	kernel_insn_init(&insn, (void *)jump_entry_code(entry), MAX_INSN_SIZE);
+	insn_get_length(&insn);
+	BUG_ON(!insn_complete(&insn));
+	BUG_ON(insn.length != 2 && insn.length != 5);
+
+	return insn.length;
+#else
 	return JMP32_INSN_SIZE;
+#endif
 }
 
 struct jump_label_patch {


