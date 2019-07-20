Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B29C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEFE21873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfGTMwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:52:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34311 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfGTMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:52:17 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hooqQ-0005QT-0z; Sat, 20 Jul 2019 14:52:10 +0200
Date:   Sat, 20 Jul 2019 12:50:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for 5.3-rc1
Message-ID: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

up to:  b68b9907069a: objtool: Support conditional retpolines

This update contains:

   - A collection of objtool fixes which address recent fallout partially
     exposed by newer toolchains, clang, BPF and general code changes.

   - Force USER_DS for user stack traces

Thanks,

	tglx

------------------>
Jann Horn (1):
      objtool: Support repeated uses of the same C jump table

Josh Poimboeuf (23):
      objtool: Add support for C jump tables
      bpf: Fix ORC unwinding in non-JIT BPF code
      x86/paravirt: Fix callee-saved function ELF sizes
      x86/kvm: Fix fastop function ELF metadata
      x86/kvm: Replace vmx_vmenter()'s call to kvm_spurious_fault() with UD2
      x86/kvm: Don't call kvm_spurious_fault() from .fixup
      x86/entry: Fix thunk function ELF sizes
      x86/head/64: Annotate start_cpu0() as non-callable
      x86/uaccess: Remove ELF function annotation from copy_user_handle_tail()
      x86/uaccess: Don't leak AC flag into fentry from mcsafe_handle_tail()
      x86/uaccess: Remove redundant CLACs in getuser/putuser error paths
      bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
      objtool: Add mcsafe_handle_tail() to the uaccess safe list
      objtool: Track original function across branches
      objtool: Refactor function alias logic
      objtool: Warn on zero-length functions
      objtool: Change dead_end_function() to return boolean
      objtool: Do frame pointer check before dead end check
      objtool: Refactor sibling call detection logic
      objtool: Refactor jump table code
      objtool: Fix seg fault on bad switch table entry
      objtool: Convert insn type to enum
      objtool: Support conditional retpolines

Michael Forney (2):
      objtool: Use Elf_Scn typedef instead of assuming struct name
      objtool: Rename elf_open() to prevent conflict with libelf from elftoolchain

Peter Zijlstra (1):
      stacktrace: Force USER_DS for stack_trace_save_user()


 arch/x86/entry/thunk_64.S       |   5 +-
 arch/x86/include/asm/kvm_host.h |  34 ++--
 arch/x86/include/asm/paravirt.h |   1 +
 arch/x86/kernel/head_64.S       |   4 +-
 arch/x86/kernel/kvm.c           |   1 +
 arch/x86/kvm/emulate.c          |  44 ++++--
 arch/x86/kvm/vmx/vmenter.S      |   6 +-
 arch/x86/lib/copy_user_64.S     |   2 +-
 arch/x86/lib/getuser.S          |  20 +--
 arch/x86/lib/putuser.S          |  29 ++--
 arch/x86/lib/usercopy_64.c      |   2 +-
 include/linux/compiler-gcc.h    |   2 +
 include/linux/compiler.h        |   5 +
 include/linux/compiler_types.h  |   4 +
 kernel/bpf/core.c               |   5 +-
 kernel/stacktrace.c             |   5 +
 tools/objtool/arch.h            |  36 +++--
 tools/objtool/arch/x86/decode.c |   2 +-
 tools/objtool/check.c           | 333 +++++++++++++++++++++-------------------
 tools/objtool/check.h           |   3 +-
 tools/objtool/elf.c             |   8 +-
 tools/objtool/elf.h             |   5 +-
 22 files changed, 311 insertions(+), 245 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index cfdca8b42c70..cc20465b2867 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -12,9 +12,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func, put_ret_addr_in_rdi=0
-	.globl \name
-	.type \name, @function
-\name:
+	ENTRY(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -35,6 +33,7 @@
 
 	call \func
 	jmp  .L_restore
+	ENDPROC(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0cc5b611a113..8282b8d41209 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1496,25 +1496,29 @@ enum {
 #define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
 #define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
 
+asmlinkage void __noreturn kvm_spurious_fault(void);
+
 /*
  * Hardware virtualization extension instructions may fault if a
  * reboot turns off virtualization while processes are running.
- * Trap the fault and ignore the instruction if that happens.
+ * Usually after catching the fault we just panic; during reboot
+ * instead the instruction is ignored.
  */
-asmlinkage void kvm_spurious_fault(void);
-
-#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)	\
-	"666: " insn "\n\t" \
-	"668: \n\t"                           \
-	".pushsection .fixup, \"ax\" \n" \
-	"667: \n\t" \
-	cleanup_insn "\n\t"		      \
-	"cmpb $0, kvm_rebooting \n\t"	      \
-	"jne 668b \n\t"      		      \
-	__ASM_SIZE(push) " $666b \n\t"	      \
-	"jmp kvm_spurious_fault \n\t"	      \
-	".popsection \n\t" \
-	_ASM_EXTABLE(666b, 667b)
+#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)		\
+	"666: \n\t"							\
+	insn "\n\t"							\
+	"jmp	668f \n\t"						\
+	"667: \n\t"							\
+	"call	kvm_spurious_fault \n\t"				\
+	"668: \n\t"							\
+	".pushsection .fixup, \"ax\" \n\t"				\
+	"700: \n\t"							\
+	cleanup_insn "\n\t"						\
+	"cmpb	$0, kvm_rebooting\n\t"					\
+	"je	667b \n\t"						\
+	"jmp	668b \n\t"						\
+	".popsection \n\t"						\
+	_ASM_EXTABLE(666b, 700b)
 
 #define __kvm_handle_fault_on_reboot(insn)		\
 	____kvm_handle_fault_on_reboot(insn, "")
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c25c38a05c1c..d6f5ae2c79ab 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -746,6 +746,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	    PV_RESTORE_ALL_CALLER_REGS					\
 	    FRAME_END							\
 	    "ret;"							\
+	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
 /* Get a reference to a callee-save function */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index bcd206c8ac90..66b4a7757397 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -253,10 +253,10 @@ END(secondary_startup_64)
  * start_secondary() via .Ljump_to_C_code.
  */
 ENTRY(start_cpu0)
-	movq	initial_stack(%rip), %rsp
 	UNWIND_HINT_EMPTY
+	movq	initial_stack(%rip), %rsp
 	jmp	.Ljump_to_C_code
-ENDPROC(start_cpu0)
+END(start_cpu0)
 #endif
 
 	/* Both SMP bootup and ACPI suspend change these variables */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 82caf01b63dd..6661bd2f08a6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -838,6 +838,7 @@ asm(
 "cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
 "setne	%al;"
 "ret;"
+".size __raw_callee_save___kvm_vcpu_is_preempted, .-__raw_callee_save___kvm_vcpu_is_preempted;"
 ".popsection");
 
 #endif
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8e409ad448f9..718f7d9afedc 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -312,29 +312,42 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
 
 static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 
-#define FOP_FUNC(name) \
+#define __FOP_FUNC(name) \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t"
 
-#define FOP_RET   "ret \n\t"
+#define FOP_FUNC(name) \
+	__FOP_FUNC(#name)
+
+#define __FOP_RET(name) \
+	"ret \n\t" \
+	".size " name ", .-" name "\n\t"
+
+#define FOP_RET(name) \
+	__FOP_RET(#name)
 
 #define FOP_START(op) \
 	extern void em_##op(struct fastop *fake); \
 	asm(".pushsection .text, \"ax\" \n\t" \
 	    ".global em_" #op " \n\t" \
-	    FOP_FUNC("em_" #op)
+	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
+	    "em_" #op ":\n\t"
 
 #define FOP_END \
 	    ".popsection")
 
+#define __FOPNOP(name) \
+	__FOP_FUNC(name) \
+	__FOP_RET(name)
+
 #define FOPNOP() \
-	FOP_FUNC(__stringify(__UNIQUE_ID(nop))) \
-	FOP_RET
+	__FOPNOP(__stringify(__UNIQUE_ID(nop)))
 
 #define FOP1E(op,  dst) \
-	FOP_FUNC(#op "_" #dst) \
-	"10: " #op " %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst) \
+	"10: " #op " %" #dst " \n\t" \
+	__FOP_RET(#op "_" #dst)
 
 #define FOP1EEX(op,  dst) \
 	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
@@ -366,8 +379,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	FOP_END
 
 #define FOP2E(op,  dst, src)	   \
-	FOP_FUNC(#op "_" #dst "_" #src) \
-	#op " %" #src ", %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst "_" #src) \
+	#op " %" #src ", %" #dst " \n\t" \
+	__FOP_RET(#op "_" #dst "_" #src)
 
 #define FASTOP2(op) \
 	FOP_START(op) \
@@ -405,8 +419,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	FOP_END
 
 #define FOP3E(op,  dst, src, src2) \
-	FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
-	#op " %" #src2 ", %" #src ", %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
+	#op " %" #src2 ", %" #src ", %" #dst " \n\t"\
+	__FOP_RET(#op "_" #dst "_" #src "_" #src2)
 
 /* 3-operand, word-only, src2=cl */
 #define FASTOP3WCL(op) \
@@ -423,7 +438,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
 	#op " %al \n\t" \
-	FOP_RET
+	__FOP_RET(#op)
 
 asm(".pushsection .fixup, \"ax\"\n"
     ".global kvm_fastop_exception \n"
@@ -449,7 +464,10 @@ FOP_SETCC(setle)
 FOP_SETCC(setnle)
 FOP_END;
 
-FOP_START(salc) "pushf; sbb %al, %al; popf \n\t" FOP_RET
+FOP_START(salc)
+FOP_FUNC(salc)
+"pushf; sbb %al, %al; popf \n\t"
+FOP_RET(salc)
 FOP_END;
 
 /*
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index d4cb1945b2e3..4010d519eb8c 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -54,9 +54,9 @@ ENTRY(vmx_vmenter)
 	ret
 
 3:	cmpb $0, kvm_rebooting
-	jne 4f
-	call kvm_spurious_fault
-4:	ret
+	je 4f
+	ret
+4:	ud2
 
 	.pushsection .fixup, "ax"
 5:	jmp 3b
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 378a1f70ae7d..4fe1601dbc5d 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -239,7 +239,7 @@ copy_user_handle_tail:
 	ret
 
 	_ASM_EXTABLE_UA(1b, 2b)
-ENDPROC(copy_user_handle_tail)
+END(copy_user_handle_tail)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 74fdff968ea3..304f958c27b2 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -115,29 +115,29 @@ ENDPROC(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 
+bad_get_user_clac:
+	ASM_CLAC
 bad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
-	ASM_CLAC
 	ret
-END(bad_get_user)
 
 #ifdef CONFIG_X86_32
+bad_get_user_8_clac:
+	ASM_CLAC
 bad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
-	ASM_CLAC
 	ret
-END(bad_get_user_8)
 #endif
 
-	_ASM_EXTABLE_UA(1b, bad_get_user)
-	_ASM_EXTABLE_UA(2b, bad_get_user)
-	_ASM_EXTABLE_UA(3b, bad_get_user)
+	_ASM_EXTABLE_UA(1b, bad_get_user_clac)
+	_ASM_EXTABLE_UA(2b, bad_get_user_clac)
+	_ASM_EXTABLE_UA(3b, bad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(4b, bad_get_user)
+	_ASM_EXTABLE_UA(4b, bad_get_user_clac)
 #else
-	_ASM_EXTABLE_UA(4b, bad_get_user_8)
-	_ASM_EXTABLE_UA(5b, bad_get_user_8)
+	_ASM_EXTABLE_UA(4b, bad_get_user_8_clac)
+	_ASM_EXTABLE_UA(5b, bad_get_user_8_clac)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index d2e5c9c39601..14bf78341d3c 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -32,8 +32,6 @@
  */
 
 #define ENTER	mov PER_CPU_VAR(current_task), %_ASM_BX
-#define EXIT	ASM_CLAC ;	\
-		ret
 
 .text
 ENTRY(__put_user_1)
@@ -43,7 +41,8 @@ ENTRY(__put_user_1)
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	ret
 ENDPROC(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
@@ -56,7 +55,8 @@ ENTRY(__put_user_2)
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	ret
 ENDPROC(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
@@ -69,7 +69,8 @@ ENTRY(__put_user_4)
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	ret
 ENDPROC(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
@@ -85,19 +86,21 @@ ENTRY(__put_user_8)
 5:	movl %edx,4(%_ASM_CX)
 #endif
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	RET
 ENDPROC(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
+bad_put_user_clac:
+	ASM_CLAC
 bad_put_user:
 	movl $-EFAULT,%eax
-	EXIT
-END(bad_put_user)
+	RET
 
-	_ASM_EXTABLE_UA(1b, bad_put_user)
-	_ASM_EXTABLE_UA(2b, bad_put_user)
-	_ASM_EXTABLE_UA(3b, bad_put_user)
-	_ASM_EXTABLE_UA(4b, bad_put_user)
+	_ASM_EXTABLE_UA(1b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(2b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(3b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(4b, bad_put_user_clac)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(5b, bad_put_user)
+	_ASM_EXTABLE_UA(5b, bad_put_user_clac)
 #endif
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index e0e006f1624e..fff28c6f73a2 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL(clear_user);
  * but reuse __memcpy_mcsafe in case a new read error is encountered.
  * clac() is handled in _copy_to_iter_mcsafe().
  */
-__visible unsigned long
+__visible notrace unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len)
 {
 	for (; len; --len, to++, from++) {
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e8579412ad21..d7ee4c6bad48 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -170,3 +170,5 @@
 #else
 #define __diag_GCC_8(s)
 #endif
+
+#define __no_fgcse __attribute__((optimize("-fno-gcse")))
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8aaf7cd026b0..f0fd5636fddb 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -116,9 +116,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	".pushsection .discard.unreachable\n\t"				\
 	".long 999b - .\n\t"						\
 	".popsection\n\t"
+
+/* Annotate a C jump table to allow objtool to follow the code flow */
+#define __annotate_jump_table __section(".rodata..c_jump_table")
+
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
+#define __annotate_jump_table
 #endif
 
 #ifndef ASM_UNREACHABLE
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 095d55c3834d..599c27b56c29 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -189,6 +189,10 @@ struct ftrace_likely_data {
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
 
+#ifndef __no_fgcse
+# define __no_fgcse
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 16079550db6d..8191a7db2777 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1295,11 +1295,11 @@ bool bpf_opcode_in_insntable(u8 code)
  *
  * Decode and execute eBPF instructions.
  */
-static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
+static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 {
 #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
 #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
-	static const void *jumptable[256] = {
+	static const void * const jumptable[256] __annotate_jump_table = {
 		[0 ... 255] = &&default_label,
 		/* Now overwrite non-defaults ... */
 		BPF_INSN_MAP(BPF_INSN_2_LBL, BPF_INSN_3_LBL),
@@ -1558,7 +1558,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 		BUG_ON(1);
 		return 0;
 }
-STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
 
 #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
 #define DEFINE_BPF_PROG_RUN(stack_size) \
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index e6a02b274b73..f5440abb7532 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -226,12 +226,17 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 		.store	= store,
 		.size	= size,
 	};
+	mm_segment_t fs;
 
 	/* Trace user stack if not a kernel thread */
 	if (current->flags & PF_KTHREAD)
 		return 0;
 
+	fs = get_fs();
+	set_fs(USER_DS);
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
+	set_fs(fs);
+
 	return c.len;
 }
 #endif
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 580e344db3dd..ced3765c4f44 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -11,22 +11,24 @@
 #include "elf.h"
 #include "cfi.h"
 
-#define INSN_JUMP_CONDITIONAL	1
-#define INSN_JUMP_UNCONDITIONAL	2
-#define INSN_JUMP_DYNAMIC	3
-#define INSN_CALL		4
-#define INSN_CALL_DYNAMIC	5
-#define INSN_RETURN		6
-#define INSN_CONTEXT_SWITCH	7
-#define INSN_STACK		8
-#define INSN_BUG		9
-#define INSN_NOP		10
-#define INSN_STAC		11
-#define INSN_CLAC		12
-#define INSN_STD		13
-#define INSN_CLD		14
-#define INSN_OTHER		15
-#define INSN_LAST		INSN_OTHER
+enum insn_type {
+	INSN_JUMP_CONDITIONAL,
+	INSN_JUMP_UNCONDITIONAL,
+	INSN_JUMP_DYNAMIC,
+	INSN_JUMP_DYNAMIC_CONDITIONAL,
+	INSN_CALL,
+	INSN_CALL_DYNAMIC,
+	INSN_RETURN,
+	INSN_CONTEXT_SWITCH,
+	INSN_STACK,
+	INSN_BUG,
+	INSN_NOP,
+	INSN_STAC,
+	INSN_CLAC,
+	INSN_STD,
+	INSN_CLD,
+	INSN_OTHER,
+};
 
 enum op_dest_type {
 	OP_DEST_REG,
@@ -68,7 +70,7 @@ void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, unsigned char *type,
+			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate, struct stack_op *op);
 
 bool arch_callee_saved_reg(unsigned char reg);
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 584568f27a83..0567c47a91b1 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -68,7 +68,7 @@ bool arch_callee_saved_reg(unsigned char reg)
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, unsigned char *type,
+			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate, struct stack_op *op)
 {
 	struct insn insn;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..5f26620f13f5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,8 @@
 
 #define FAKE_JUMP_OFFSET -1
 
+#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -95,6 +97,20 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static bool is_sibling_call(struct instruction *insn)
+{
+	/* An indirect jump is either a sibling call or a jump to a table. */
+	if (insn->type == INSN_JUMP_DYNAMIC)
+		return list_empty(&insn->alts);
+
+	if (insn->type != INSN_JUMP_CONDITIONAL &&
+	    insn->type != INSN_JUMP_UNCONDITIONAL)
+		return false;
+
+	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
+	return !!insn->call_dest;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -103,14 +119,9 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
  *
  * For local functions, we have to detect them manually by simply looking for
  * the lack of a return instruction.
- *
- * Returns:
- *  -1: error
- *   0: no dead end
- *   1: dead end
  */
-static int __dead_end_function(struct objtool_file *file, struct symbol *func,
-			       int recursion)
+static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
+				int recursion)
 {
 	int i;
 	struct instruction *insn;
@@ -136,30 +147,33 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"rewind_stack_do_exit",
 	};
 
+	if (!func)
+		return false;
+
 	if (func->bind == STB_WEAK)
-		return 0;
+		return false;
 
 	if (func->bind == STB_GLOBAL)
 		for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
 			if (!strcmp(func->name, global_noreturns[i]))
-				return 1;
+				return true;
 
 	if (!func->len)
-		return 0;
+		return false;
 
 	insn = find_insn(file, func->sec, func->offset);
 	if (!insn->func)
-		return 0;
+		return false;
 
 	func_for_each_insn_all(file, func, insn) {
 		empty = false;
 
 		if (insn->type == INSN_RETURN)
-			return 0;
+			return false;
 	}
 
 	if (empty)
-		return 0;
+		return false;
 
 	/*
 	 * A function can have a sibling call instead of a return.  In that
@@ -167,40 +181,31 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * of the sibling call returns.
 	 */
 	func_for_each_insn_all(file, func, insn) {
-		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+		if (is_sibling_call(insn)) {
 			struct instruction *dest = insn->jump_dest;
 
 			if (!dest)
 				/* sibling call to another file */
-				return 0;
-
-			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
+				return false;
 
-				/* local sibling call */
-				if (recursion == 5) {
-					/*
-					 * Infinite recursion: two functions
-					 * have sibling calls to each other.
-					 * This is a very rare case.  It means
-					 * they aren't dead ends.
-					 */
-					return 0;
-				}
-
-				return __dead_end_function(file, dest->func,
-							   recursion + 1);
+			/* local sibling call */
+			if (recursion == 5) {
+				/*
+				 * Infinite recursion: two functions have
+				 * sibling calls to each other.  This is a very
+				 * rare case.  It means they aren't dead ends.
+				 */
+				return false;
 			}
-		}
 
-		if (insn->type == INSN_JUMP_DYNAMIC && list_empty(&insn->alts))
-			/* sibling call */
-			return 0;
+			return __dead_end_function(file, dest->func, recursion+1);
+		}
 	}
 
-	return 1;
+	return true;
 }
 
-static int dead_end_function(struct objtool_file *file, struct symbol *func)
+static bool dead_end_function(struct objtool_file *file, struct symbol *func)
 {
 	return __dead_end_function(file, func, 0);
 }
@@ -262,19 +267,12 @@ static int decode_instructions(struct objtool_file *file)
 			if (ret)
 				goto err;
 
-			if (!insn->type || insn->type > INSN_LAST) {
-				WARN_FUNC("invalid instruction type %d",
-					  insn->sec, insn->offset, insn->type);
-				ret = -1;
-				goto err;
-			}
-
 			hash_add(file->insn_hash, &insn->hash, insn->offset);
 			list_add_tail(&insn->list, &file->insn_list);
 		}
 
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
+			if (func->type != STT_FUNC || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -284,8 +282,7 @@ static int decode_instructions(struct objtool_file *file)
 			}
 
 			func_for_each_insn(file, func, insn)
-				if (!insn->func)
-					insn->func = func;
+				insn->func = func;
 		}
 	}
 
@@ -488,6 +485,7 @@ static const char *uaccess_safe_builtin[] = {
 	/* misc */
 	"csum_partial_copy_generic",
 	"__memcpy_mcsafe",
+	"mcsafe_handle_tail",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	NULL
 };
@@ -505,7 +503,7 @@ static void add_uaccess_safe(struct objtool_file *file)
 		if (!func)
 			continue;
 
-		func->alias->uaccess_safe = true;
+		func->uaccess_safe = true;
 	}
 }
 
@@ -577,13 +575,16 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
 			 */
-			insn->type = INSN_JUMP_DYNAMIC;
+			if (insn->type == INSN_JUMP_UNCONDITIONAL)
+				insn->type = INSN_JUMP_DYNAMIC;
+			else
+				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
+
 			insn->retpoline_safe = true;
 			continue;
 		} else {
-			/* sibling call */
+			/* external sibling call */
 			insn->call_dest = rela->sym;
-			insn->jump_dest = NULL;
 			continue;
 		}
 
@@ -623,7 +624,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * However this code can't completely replace the
 			 * read_symbols() code because this doesn't detect the
 			 * case where the parent function's only reference to a
-			 * subfunction is through a switch table.
+			 * subfunction is through a jump table.
 			 */
 			if (!strstr(insn->func->name, ".cold.") &&
 			    strstr(insn->jump_dest->func->name, ".cold.")) {
@@ -633,9 +634,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
 
-				/* sibling class */
+				/* internal sibling call */
 				insn->call_dest = insn->jump_dest->func;
-				insn->jump_dest = NULL;
 			}
 		}
 	}
@@ -896,20 +896,26 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
-static int add_switch_table(struct objtool_file *file, struct instruction *insn,
-			    struct rela *table, struct rela *next_table)
+static int add_jump_table(struct objtool_file *file, struct instruction *insn,
+			    struct rela *table)
 {
 	struct rela *rela = table;
-	struct instruction *alt_insn;
+	struct instruction *dest_insn;
 	struct alternative *alt;
 	struct symbol *pfunc = insn->func->pfunc;
 	unsigned int prev_offset = 0;
 
-	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
-		if (rela == next_table)
+	/*
+	 * Each @rela is a switch table relocation which points to the target
+	 * instruction.
+	 */
+	list_for_each_entry_from(rela, &table->sec->rela_list, list) {
+
+		/* Check for the end of the table: */
+		if (rela != table && rela->jump_table_start)
 			break;
 
-		/* Make sure the switch table entries are consecutive: */
+		/* Make sure the table entries are consecutive: */
 		if (prev_offset && rela->offset != prev_offset + 8)
 			break;
 
@@ -918,12 +924,12 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 		    rela->addend == pfunc->offset)
 			break;
 
-		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!alt_insn)
+		dest_insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!dest_insn)
 			break;
 
-		/* Make sure the jmp dest is in the function or subfunction: */
-		if (alt_insn->func->pfunc != pfunc)
+		/* Make sure the destination is in the same function: */
+		if (!dest_insn->func || dest_insn->func->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
@@ -932,7 +938,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 			return -1;
 		}
 
-		alt->insn = alt_insn;
+		alt->insn = dest_insn;
 		list_add_tail(&alt->list, &insn->alts);
 		prev_offset = rela->offset;
 	}
@@ -947,7 +953,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 }
 
 /*
- * find_switch_table() - Given a dynamic jump, find the switch jump table in
+ * find_jump_table() - Given a dynamic jump, find the switch jump table in
  * .rodata associated with it.
  *
  * There are 3 basic patterns:
@@ -989,13 +995,13 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
  *
  *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
-static struct rela *find_switch_table(struct objtool_file *file,
+static struct rela *find_jump_table(struct objtool_file *file,
 				      struct symbol *func,
 				      struct instruction *insn)
 {
-	struct rela *text_rela, *rodata_rela;
+	struct rela *text_rela, *table_rela;
 	struct instruction *orig_insn = insn;
-	struct section *rodata_sec;
+	struct section *table_sec;
 	unsigned long table_offset;
 
 	/*
@@ -1028,42 +1034,52 @@ static struct rela *find_switch_table(struct objtool_file *file,
 			continue;
 
 		table_offset = text_rela->addend;
-		rodata_sec = text_rela->sym->sec;
+		table_sec = text_rela->sym->sec;
 
 		if (text_rela->type == R_X86_64_PC32)
 			table_offset += 4;
 
 		/*
 		 * Make sure the .rodata address isn't associated with a
-		 * symbol.  gcc jump tables are anonymous data.
+		 * symbol.  GCC jump tables are anonymous data.
+		 *
+		 * Also support C jump tables which are in the same format as
+		 * switch jump tables.  For objtool to recognize them, they
+		 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
+		 * have symbols associated with them.
 		 */
-		if (find_symbol_containing(rodata_sec, table_offset))
+		if (find_symbol_containing(table_sec, table_offset) &&
+		    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
 			continue;
 
-		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
-		if (rodata_rela) {
-			/*
-			 * Use of RIP-relative switch jumps is quite rare, and
-			 * indicates a rare GCC quirk/bug which can leave dead
-			 * code behind.
-			 */
-			if (text_rela->type == R_X86_64_PC32)
-				file->ignore_unreachables = true;
+		/* Each table entry has a rela associated with it. */
+		table_rela = find_rela_by_dest(table_sec, table_offset);
+		if (!table_rela)
+			continue;
 
-			return rodata_rela;
-		}
+		/*
+		 * Use of RIP-relative switch jumps is quite rare, and
+		 * indicates a rare GCC quirk/bug which can leave dead code
+		 * behind.
+		 */
+		if (text_rela->type == R_X86_64_PC32)
+			file->ignore_unreachables = true;
+
+		return table_rela;
 	}
 
 	return NULL;
 }
 
-
-static int add_func_switch_tables(struct objtool_file *file,
-				  struct symbol *func)
+/*
+ * First pass: Mark the head of each jump table so that in the next pass,
+ * we know when a given jump table ends and the next one starts.
+ */
+static void mark_func_jump_tables(struct objtool_file *file,
+				    struct symbol *func)
 {
-	struct instruction *insn, *last = NULL, *prev_jump = NULL;
-	struct rela *rela, *prev_rela = NULL;
-	int ret;
+	struct instruction *insn, *last = NULL;
+	struct rela *rela;
 
 	func_for_each_insn_all(file, func, insn) {
 		if (!last)
@@ -1071,7 +1087,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 
 		/*
 		 * Store back-pointers for unconditional forward jumps such
-		 * that find_switch_table() can back-track using those and
+		 * that find_jump_table() can back-track using those and
 		 * avoid some potentially confusing code.
 		 */
 		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
@@ -1086,27 +1102,25 @@ static int add_func_switch_tables(struct objtool_file *file,
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
-		rela = find_switch_table(file, func, insn);
-		if (!rela)
-			continue;
-
-		/*
-		 * We found a switch table, but we don't know yet how big it
-		 * is.  Don't add it until we reach the end of the function or
-		 * the beginning of another switch table in the same function.
-		 */
-		if (prev_jump) {
-			ret = add_switch_table(file, prev_jump, prev_rela, rela);
-			if (ret)
-				return ret;
+		rela = find_jump_table(file, func, insn);
+		if (rela) {
+			rela->jump_table_start = true;
+			insn->jump_table = rela;
 		}
-
-		prev_jump = insn;
-		prev_rela = rela;
 	}
+}
+
+static int add_func_jump_tables(struct objtool_file *file,
+				  struct symbol *func)
+{
+	struct instruction *insn;
+	int ret;
 
-	if (prev_jump) {
-		ret = add_switch_table(file, prev_jump, prev_rela, NULL);
+	func_for_each_insn_all(file, func, insn) {
+		if (!insn->jump_table)
+			continue;
+
+		ret = add_jump_table(file, insn, insn->jump_table);
 		if (ret)
 			return ret;
 	}
@@ -1119,7 +1133,7 @@ static int add_func_switch_tables(struct objtool_file *file,
  * section which contains a list of addresses within the function to jump to.
  * This finds these jump tables and adds them to the insn->alts lists.
  */
-static int add_switch_table_alts(struct objtool_file *file)
+static int add_jump_table_alts(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
@@ -1133,7 +1147,8 @@ static int add_switch_table_alts(struct objtool_file *file)
 			if (func->type != STT_FUNC)
 				continue;
 
-			ret = add_func_switch_tables(file, func);
+			mark_func_jump_tables(file, func);
+			ret = add_func_jump_tables(file, func);
 			if (ret)
 				return ret;
 		}
@@ -1277,13 +1292,18 @@ static void mark_rodata(struct objtool_file *file)
 	bool found = false;
 
 	/*
-	 * This searches for the .rodata section or multiple .rodata.func_name
-	 * sections if -fdata-sections is being used. The .str.1.1 and .str.1.8
-	 * rodata sections are ignored as they don't contain jump tables.
+	 * Search for the following rodata sections, each of which can
+	 * potentially contain jump tables:
+	 *
+	 * - .rodata: can contain GCC switch tables
+	 * - .rodata.<func>: same, if -fdata-sections is being used
+	 * - .rodata..c_jump_table: contains C annotated jump tables
+	 *
+	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
-		    !strstr(sec->name, ".str1.")) {
+		if ((!strncmp(sec->name, ".rodata", 7) && !strstr(sec->name, ".str1.")) ||
+		    !strcmp(sec->name, C_JUMP_TABLE_SECTION)) {
 			sec->rodata = true;
 			found = true;
 		}
@@ -1325,7 +1345,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = add_switch_table_alts(file);
+	ret = add_jump_table_alts(file);
 	if (ret)
 		return ret;
 
@@ -1873,12 +1893,12 @@ static bool insn_state_match(struct instruction *insn, struct insn_state *state)
 static inline bool func_uaccess_safe(struct symbol *func)
 {
 	if (func)
-		return func->alias->uaccess_safe;
+		return func->uaccess_safe;
 
 	return false;
 }
 
-static inline const char *insn_dest_name(struct instruction *insn)
+static inline const char *call_dest_name(struct instruction *insn)
 {
 	if (insn->call_dest)
 		return insn->call_dest->name;
@@ -1890,13 +1910,13 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 {
 	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
 		WARN_FUNC("call to %s() with UACCESS enabled",
-				insn->sec, insn->offset, insn_dest_name(insn));
+				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
 
 	if (state->df) {
 		WARN_FUNC("call to %s() with DF set",
-				insn->sec, insn->offset, insn_dest_name(insn));
+				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
 
@@ -1920,13 +1940,12 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
  * each instruction and validate all the rules described in
  * tools/objtool/Documentation/stack-validation.txt.
  */
-static int validate_branch(struct objtool_file *file, struct instruction *first,
-			   struct insn_state state)
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *first, struct insn_state state)
 {
 	struct alternative *alt;
 	struct instruction *insn, *next_insn;
 	struct section *sec;
-	struct symbol *func = NULL;
 	int ret;
 
 	insn = first;
@@ -1947,9 +1966,6 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			return 1;
 		}
 
-		if (insn->func)
-			func = insn->func->pfunc;
-
 		if (func && insn->ignore) {
 			WARN_FUNC("BUG: why am I validating an ignored function?",
 				  sec, insn->offset);
@@ -1971,7 +1987,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 				i = insn;
 				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, insn->func, i) {
+				func_for_each_insn_continue_reverse(file, func, i) {
 					if (i->save) {
 						save_insn = i;
 						break;
@@ -2017,7 +2033,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 				if (alt->skip_orig)
 					skip_orig = true;
 
-				ret = validate_branch(file, alt->insn, state);
+				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(alt)", insn);
@@ -2055,7 +2071,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			if (state.bp_scratch) {
 				WARN("%s uses BP as a scratch register",
-				     insn->func->name);
+				     func->name);
 				return 1;
 			}
 
@@ -2067,36 +2083,28 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			if (ret)
 				return ret;
 
-			if (insn->type == INSN_CALL) {
-				if (is_fentry_call(insn))
-					break;
-
-				ret = dead_end_function(file, insn->call_dest);
-				if (ret == 1)
-					return 0;
-				if (ret == -1)
-					return 1;
-			}
-
-			if (!no_fp && func && !has_valid_stack_frame(&state)) {
+			if (!no_fp && func && !is_fentry_call(insn) &&
+			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
 			}
+
+			if (dead_end_function(file, insn->call_dest))
+				return 0;
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (func && !insn->jump_dest) {
+			if (func && is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
 
-			} else if (insn->jump_dest &&
-				   (!func || !insn->jump_dest->func ||
-				    insn->jump_dest->func->pfunc == func)) {
-				ret = validate_branch(file, insn->jump_dest,
-						      state);
+			} else if (insn->jump_dest) {
+				ret = validate_branch(file, func,
+						      insn->jump_dest, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(branch)", insn);
@@ -2110,13 +2118,17 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (func && list_empty(&insn->alts)) {
+		case INSN_JUMP_DYNAMIC_CONDITIONAL:
+			if (func && is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
 			}
 
-			return 0;
+			if (insn->type == INSN_JUMP_DYNAMIC)
+				return 0;
+
+			break;
 
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
@@ -2162,7 +2174,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			break;
 
 		case INSN_CLAC:
-			if (!state.uaccess && insn->func) {
+			if (!state.uaccess && func) {
 				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
 				return 1;
 			}
@@ -2183,7 +2195,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			break;
 
 		case INSN_CLD:
-			if (!state.df && insn->func)
+			if (!state.df && func)
 				WARN_FUNC("redundant CLD", sec, insn->offset);
 
 			state.df = false;
@@ -2222,7 +2234,7 @@ static int validate_unwind_hints(struct objtool_file *file)
 
 	for_each_insn(file, insn) {
 		if (insn->hint && !insn->visited) {
-			ret = validate_branch(file, insn, state);
+			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -2345,16 +2357,25 @@ static int validate_functions(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC || func->pfunc != func)
+			if (func->type != STT_FUNC)
+				continue;
+
+			if (!func->len) {
+				WARN("%s() is missing an ELF size annotation",
+				     func->name);
+				warnings++;
+			}
+
+			if (func->pfunc != func || func->alias != func)
 				continue;
 
 			insn = find_insn(file, sec, func->offset);
-			if (!insn || insn->ignore)
+			if (!insn || insn->ignore || insn->visited)
 				continue;
 
-			state.uaccess = func->alias->uaccess_safe;
+			state.uaccess = func->uaccess_safe;
 
-			ret = validate_branch(file, insn, state);
+			ret = validate_branch(file, func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (func)", insn);
 			warnings += ret;
@@ -2407,7 +2428,7 @@ int check(const char *_objname, bool orc)
 
 	objname = _objname;
 
-	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
 		return 1;
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index cb60b9acf5cf..b881fafcf55d 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,13 +31,14 @@ struct instruction {
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
-	unsigned char type;
+	enum insn_type type;
 	unsigned long immediate;
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
 	bool retpoline_safe;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
+	struct rela *jump_table;
 	struct list_head alts;
 	struct symbol *func;
 	struct stack_op stack_op;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e99e1be19ad9..edba4745f25a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -278,7 +278,7 @@ static int read_symbols(struct elf *elf)
 			}
 
 			if (sym->offset == s->offset) {
-				if (sym->len == s->len && alias == sym)
+				if (sym->len && sym->len == s->len && alias == sym)
 					alias = s;
 
 				if (sym->len >= s->len) {
@@ -385,7 +385,7 @@ static int read_relas(struct elf *elf)
 			rela->offset = rela->rela.r_offset;
 			symndx = GELF_R_SYM(rela->rela.r_info);
 			rela->sym = find_symbol_by_index(elf, symndx);
-			rela->rela_sec = sec;
+			rela->sec = sec;
 			if (!rela->sym) {
 				WARN("can't find rela entry symbol %d for %s",
 				     symndx, sec->name);
@@ -401,7 +401,7 @@ static int read_relas(struct elf *elf)
 	return 0;
 }
 
-struct elf *elf_open(const char *name, int flags)
+struct elf *elf_read(const char *name, int flags)
 {
 	struct elf *elf;
 	Elf_Cmd cmd;
@@ -463,7 +463,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 {
 	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
-	struct Elf_Scn *s;
+	Elf_Scn *s;
 	Elf_Data *data;
 
 	sec = malloc(sizeof(*sec));
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index e44ca5d51871..44150204db4d 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -57,11 +57,12 @@ struct rela {
 	struct list_head list;
 	struct hlist_node hash;
 	GElf_Rela rela;
-	struct section *rela_sec;
+	struct section *sec;
 	struct symbol *sym;
 	unsigned int type;
 	unsigned long offset;
 	int addend;
+	bool jump_table_start;
 };
 
 struct elf {
@@ -74,7 +75,7 @@ struct elf {
 };
 
 
-struct elf *elf_open(const char *name, int flags);
+struct elf *elf_read(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(struct elf *elf, const char *name);

