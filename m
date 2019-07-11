Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22717C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC68921537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfGKUFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:05:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50863 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbfGKUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:05:18 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlfJb-0005Rn-LZ; Thu, 11 Jul 2019 22:05:15 +0200
Date:   Thu, 11 Jul 2019 20:02:36 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.3-rc1
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
Message-ID: <156287535656.8320.9936716199898120027.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  cbf5b73d162b: x86/stacktrace: Prevent infinite loop in arch_stack_walk_user()

A collection of assorted fixes:

 - Fix for the pinned cr0/4 fallout which escaped all testing efforts
   because the kvm-intel module was never loaded when the kernel was
   compiled with CONFIG_PARAVIRT=n. The cr0/4 accessors are moved out of
   line and static key is now solely used in the core code and therefore
   can stay in the RO after init section. So the kvm-intel and other
   modules do not longer reference the (read only) static key which the
   module loader tried to update.

 - Prevent an infinite loop in arch_stack_walk_user() by breaking out of
   the loop once the return address is detected to be 0.

 - Prevent the int3_emulate_call() selftest from corrupting the stack when
   KASAN is enabled. KASASN clobbers more registers than covered by the
   emulated call implementation. Convert the int3_magic() selftest to a ASM
   function so the compiler cannot KASANify it.

 - Unbreak the build with old GCC versions and with the Gold linker by
   reverting the 'Move of _etext to the actual end of .text'. In both cases
   the build fails with 'Invalid absolute R_X86_64_32S relocation: _etext'

 - Initialize the context lock for init_mm, which was never an issue until
   the alternatives code started to use a temporary mm for patching.

 - Fix a build warning vs. the LOWMEM_PAGES constant where clang complains
   rightfully about a signed integer overflow in the shift operation by
   converting the operand to an ULL.

 - Adjust the misnomed ENDPROC() of common_spurious in the 32bit entry code.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      x86/pgtable/32: Fix LOWMEM_PAGES constant

Eiichi Tsukata (1):
      x86/stacktrace: Prevent infinite loop in arch_stack_walk_user()

Jiri Slaby (1):
      x86/entry/32: Fix ENDPROC of common_spurious

Peter Zijlstra (1):
      x86/alternatives: Fix int3_emulate_call() selftest stack corruption

Ross Zwisler (1):
      Revert "x86/build: Move _etext to actual end of .text"

Sebastian Andrzej Siewior (1):
      x86/ldt: Initialize the context lock for init_mm

Thomas Gleixner (1):
      x86/asm: Move native_write_cr0/4() out of line


 arch/x86/entry/entry_32.S            |  2 +-
 arch/x86/include/asm/mmu.h           |  1 +
 arch/x86/include/asm/pgtable_32.h    |  2 +-
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/include/asm/special_insns.h | 41 +-------------------
 arch/x86/kernel/alternative.c        | 25 ++++++++++---
 arch/x86/kernel/cpu/common.c         | 72 ++++++++++++++++++++++++++++--------
 arch/x86/kernel/smpboot.c            | 14 +------
 arch/x86/kernel/stacktrace.c         |  8 ++--
 arch/x86/kernel/vmlinux.lds.S        |  6 +--
 arch/x86/xen/smp_pv.c                |  1 +
 11 files changed, 90 insertions(+), 83 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 1285e5abf669..90b473297299 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1189,7 +1189,7 @@ common_spurious:
 	movl	%esp, %eax
 	call	smp_spurious_interrupt
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+ENDPROC(common_spurious)
 #endif
 
 /*
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5ff3e8af2c20..e78c7db87801 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -59,6 +59,7 @@ typedef struct {
 #define INIT_MM_CONTEXT(mm)						\
 	.context = {							\
 		.ctx_id = 1,						\
+		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
 	}
 
 void leave_mm(int cpu);
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 4fe9e7fc74d3..c78da8eda8f2 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -106,6 +106,6 @@ do {						\
  * with only a host target support using a 32-bit type for internal
  * representation.
  */
-#define LOWMEM_PAGES ((((2<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
+#define LOWMEM_PAGES ((((_ULL(2)<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
 
 #endif /* _ASM_X86_PGTABLE_32_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3eab6ece52b4..6e0a3b43d027 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -741,6 +741,7 @@ extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
+extern void cr4_init(void);
 
 static inline unsigned long get_debugctlmsr(void)
 {
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index b2e84d113f2a..219be88a59d2 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -18,9 +18,7 @@
  */
 extern unsigned long __force_order;
 
-/* Starts false and gets enabled once CPU feature detection is done. */
-DECLARE_STATIC_KEY_FALSE(cr_pinning);
-extern unsigned long cr4_pinned_bits;
+void native_write_cr0(unsigned long val);
 
 static inline unsigned long native_read_cr0(void)
 {
@@ -29,24 +27,6 @@ static inline unsigned long native_read_cr0(void)
 	return val;
 }
 
-static inline void native_write_cr0(unsigned long val)
-{
-	unsigned long bits_missing = 0;
-
-set_register:
-	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
-
-	if (static_branch_likely(&cr_pinning)) {
-		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
-			bits_missing = X86_CR0_WP;
-			val |= bits_missing;
-			goto set_register;
-		}
-		/* Warn after we've set the missing bits. */
-		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
-	}
-}
-
 static inline unsigned long native_read_cr2(void)
 {
 	unsigned long val;
@@ -91,24 +71,7 @@ static inline unsigned long native_read_cr4(void)
 	return val;
 }
 
-static inline void native_write_cr4(unsigned long val)
-{
-	unsigned long bits_missing = 0;
-
-set_register:
-	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
-
-	if (static_branch_likely(&cr_pinning)) {
-		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
-			bits_missing = ~val & cr4_pinned_bits;
-			val |= bits_missing;
-			goto set_register;
-		}
-		/* Warn after we've set the missing bits. */
-		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
-			  bits_missing);
-	}
-}
+void native_write_cr4(unsigned long val);
 
 #ifdef CONFIG_X86_64
 static inline unsigned long native_read_cr8(void)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 99ef8b6f9a1a..ccd32013c47a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -625,10 +625,23 @@ extern struct paravirt_patch_site __start_parainstructions[],
  *
  * See entry_{32,64}.S for more details.
  */
-static void __init int3_magic(unsigned int *ptr)
-{
-	*ptr = 1;
-}
+
+/*
+ * We define the int3_magic() function in assembly to control the calling
+ * convention such that we can 'call' it from assembly.
+ */
+
+extern void int3_magic(unsigned int *ptr); /* defined in asm */
+
+asm (
+"	.pushsection	.init.text, \"ax\", @progbits\n"
+"	.type		int3_magic, @function\n"
+"int3_magic:\n"
+"	movl	$1, (%" _ASM_ARG1 ")\n"
+"	ret\n"
+"	.size		int3_magic, .-int3_magic\n"
+"	.popsection\n"
+);
 
 extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
 
@@ -676,7 +689,9 @@ static void __init int3_selftest(void)
 		      "int3_selftest_ip:\n\t"
 		      __ASM_SEL(.long, .quad) " 1b\n\t"
 		      ".popsection\n\t"
-		      : : __ASM_SEL_RAW(a, D) (&val) : "memory");
+		      : ASM_CALL_CONSTRAINT
+		      : __ASM_SEL_RAW(a, D) (&val)
+		      : "memory");
 
 	BUG_ON(val != 1);
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 309b6b9b49d4..11472178e17f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,10 +366,62 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
-DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
-EXPORT_SYMBOL(cr_pinning);
-unsigned long cr4_pinned_bits __ro_after_init;
-EXPORT_SYMBOL(cr4_pinned_bits);
+static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
+static unsigned long cr4_pinned_bits __ro_after_init;
+
+void native_write_cr0(unsigned long val)
+{
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
+			bits_missing = X86_CR0_WP;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
+	}
+}
+EXPORT_SYMBOL(native_write_cr0);
+
+void native_write_cr4(unsigned long val)
+{
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
+			bits_missing = ~val & cr4_pinned_bits;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
+			  bits_missing);
+	}
+}
+EXPORT_SYMBOL(native_write_cr4);
+
+void cr4_init(void)
+{
+	unsigned long cr4 = __read_cr4();
+
+	if (boot_cpu_has(X86_FEATURE_PCID))
+		cr4 |= X86_CR4_PCIDE;
+	if (static_branch_likely(&cr_pinning))
+		cr4 |= cr4_pinned_bits;
+
+	__write_cr4(cr4);
+
+	/* Initialize cr4 shadow for this CPU. */
+	this_cpu_write(cpu_tlbstate.cr4, cr4);
+}
 
 /*
  * Once CPU feature detection is finished (and boot params have been
@@ -1723,12 +1775,6 @@ void cpu_init(void)
 
 	wait_for_master_cpu(cpu);
 
-	/*
-	 * Initialize the CR4 shadow before doing anything that could
-	 * try to read it.
-	 */
-	cr4_init_shadow();
-
 	if (cpu)
 		load_ucode_ap();
 
@@ -1823,12 +1869,6 @@ void cpu_init(void)
 
 	wait_for_master_cpu(cpu);
 
-	/*
-	 * Initialize the CR4 shadow before doing anything that could
-	 * try to read it.
-	 */
-	cr4_init_shadow();
-
 	show_ucode_info_early();
 
 	pr_info("Initializing CPU#%d\n", cpu);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f78801114ee1..259d1d2be076 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -210,28 +210,16 @@ static int enable_start_cpu0;
  */
 static void notrace start_secondary(void *unused)
 {
-	unsigned long cr4 = __read_cr4();
-
 	/*
 	 * Don't put *anything* except direct CPU state initialization
 	 * before cpu_init(), SMP booting is too fragile that we want to
 	 * limit the things done here to the most necessary things.
 	 */
-	if (boot_cpu_has(X86_FEATURE_PCID))
-		cr4 |= X86_CR4_PCIDE;
-	if (static_branch_likely(&cr_pinning))
-		cr4 |= cr4_pinned_bits;
-
-	__write_cr4(cr4);
+	cr4_init();
 
 #ifdef CONFIG_X86_32
 	/* switch away from the initial page table */
 	load_cr3(swapper_pg_dir);
-	/*
-	 * Initialize the CR4 shadow before doing anything that could
-	 * try to read it.
-	 */
-	cr4_init_shadow();
 	__flush_tlb_all();
 #endif
 	load_current_idt();
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2abf27d7df6b..4f36d3241faf 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -129,11 +129,9 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			break;
 		if ((unsigned long)fp < regs->sp)
 			break;
-		if (frame.ret_addr) {
-			if (!consume_entry(cookie, frame.ret_addr, false))
-				return;
-		}
-		if (fp == frame.next_fp)
+		if (!frame.ret_addr)
+			break;
+		if (!consume_entry(cookie, frame.ret_addr, false))
 			break;
 		fp = frame.next_fp;
 	}
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0850b5149345..4d1517022a14 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -141,10 +141,10 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-	} :text = 0x9090
 
-	/* End of text section */
-	_etext = .;
+		/* End of text section */
+		_etext = .;
+	} :text = 0x9090
 
 	NOTES :text :note
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 77d81c1a63e9..802ee5bba66c 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -58,6 +58,7 @@ static void cpu_bringup(void)
 {
 	int cpu;
 
+	cr4_init();
 	cpu_init();
 	touch_softlockup_watchdog();
 	preempt_disable();

