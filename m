Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA5C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266EC2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfGTMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:52:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34326 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfGTMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:52:19 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hooqS-0005Qq-6R; Sat, 20 Jul 2019 14:52:12 +0200
Date:   Sat, 20 Jul 2019 12:50:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.3-rc1
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
Message-ID: <156362700019.18624.7822425287291380783.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  6879298bd067: x86/entry/64: Prevent clobbering of saved CR2 value

A set of x86 specific fixes and updates:

 - The CR2 corruption fixes which store CR2 early in the entry code and
   hand the stored address to the fault handlers.

 - Revert a forgotten leftover of the dropped FSGSBASE series.

 - Plug a memory leak in the boot code.

 - Make the Hyper-V assist functionality robust by zeroing the shadow page.

 - Remove a useless check for dead processes with LDT

 - Update paravirt and VMware maintainers entries.

 - A few cleanup patches addressing various compiler warnings.

Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      Revert "x86/ptrace: Prevent ptrace from clearing the FS/GS selector" and fix the test

Arnd Bergmann (1):
      x86: math-emu: Hide clang warnings for 16-bit overflow

David Rientjes (2):
      x86/boot: Fix memory leak in default_get_smp_config()
      x86/mm: Free sme_early_buffer after init

Dexuan Cui (1):
      x86/hyper-v: Zero out the VP ASSIST PAGE on allocation

Jann Horn (1):
      x86/process: Delete useless check for dead process with LDT

Peter Zijlstra (5):
      x86/paravirt: Make read_cr2() CALLEE_SAVE
      x86/entry/32: Simplify common_exception
      x86/entry/64: Simplify idtentry a little
      x86/entry/64: Update comments and sanity tests for create_gap
      x86/mm, tracing: Fix CR2 corruption

Qian Cai (1):
      x86/apic: Silence -Wtype-limits compiler warnings

Thomas Gleixner (1):
      x86/entry/64: Prevent clobbering of saved CR2 value

Thomas Hellstrom (1):
      MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and VMWARE_HYPERVISOR_INTERFACE

Yi Wang (1):
      x86/e820: Use proper booleans instead of 0/1

Zhenzhong Duan (3):
      x86/boot/efi: Remove unused variables
      x86/boot/compressed/64: Remove unused variable
      x86, boot: Remove multiple copy of static function sanitize_boot_params()


 MAINTAINERS                            |   6 +-
 arch/x86/boot/compressed/eboot.c       |  10 +--
 arch/x86/boot/compressed/misc.c        |   1 +
 arch/x86/boot/compressed/misc.h        |   1 -
 arch/x86/boot/compressed/pgtable_64.c  |   1 -
 arch/x86/entry/calling.h               |   6 ++
 arch/x86/entry/entry_32.S              |  61 +++++++------
 arch/x86/entry/entry_64.S              | 155 +++++++++++++++++----------------
 arch/x86/hyperv/hv_init.c              |  13 ++-
 arch/x86/include/asm/apic.h            |   2 +-
 arch/x86/include/asm/kvm_para.h        |   2 +-
 arch/x86/include/asm/paravirt.h        |  22 +++--
 arch/x86/include/asm/paravirt_types.h  |   2 +-
 arch/x86/include/asm/traps.h           |   4 +-
 arch/x86/kernel/apic/apic.c            |   2 +-
 arch/x86/kernel/asm-offsets.c          |   1 +
 arch/x86/kernel/e820.c                 |   4 +-
 arch/x86/kernel/head_64.S              |   4 +-
 arch/x86/kernel/kvm.c                  |   8 +-
 arch/x86/kernel/mpparse.c              |  10 +--
 arch/x86/kernel/paravirt.c             |   2 +-
 arch/x86/kernel/process_64.c           |  12 +--
 arch/x86/kernel/ptrace.c               |  14 ++-
 arch/x86/kernel/traps.c                |   6 +-
 arch/x86/math-emu/fpu_emu.h            |   2 +-
 arch/x86/math-emu/reg_constant.c       |   2 +-
 arch/x86/mm/fault.c                    |  30 +++----
 arch/x86/mm/mem_encrypt.c              |   2 +-
 arch/x86/xen/enlighten_pv.c            |   3 +-
 arch/x86/xen/mmu_pv.c                  |  12 +--
 arch/x86/xen/xen-asm.S                 |  16 ++++
 arch/x86/xen/xen-ops.h                 |   3 +
 tools/testing/selftests/x86/fsgsbase.c |  22 +----
 33 files changed, 226 insertions(+), 215 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5533d1bda2e..80fa7a4a0b56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12074,7 +12074,8 @@ F:	Documentation/parport*.txt
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Alok Kataria <akataria@vmware.com>
+M:	Thomas Hellstrom <thellstrom@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	Documentation/virtual/paravirt_ops.txt
@@ -17087,7 +17088,8 @@ S:	Maintained
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Alok Kataria <akataria@vmware.com>
+M:	Thomas Hellstrom <thellstrom@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	arch/x86/kernel/cpu/vmware.c
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 220d1279d0e2..d6662fdef300 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -384,14 +384,11 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	struct apm_bios_info *bi;
 	struct setup_header *hdr;
 	efi_loaded_image_t *image;
-	void *options, *handle;
+	void *handle;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
 	char *cmdline_ptr;
-	u16 *s2;
-	u8 *s1;
-	int i;
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
 
@@ -494,8 +491,6 @@ static void add_e820ext(struct boot_params *params,
 			struct setup_data *e820ext, u32 nr_entries)
 {
 	struct setup_data *data;
-	efi_status_t status;
-	unsigned long size;
 
 	e820ext->type = SETUP_E820_EXT;
 	e820ext->len  = nr_entries * sizeof(struct boot_e820_entry);
@@ -677,8 +672,6 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 				   void *priv)
 {
 	const char *signature;
-	__u32 nr_desc;
-	efi_status_t status;
 	struct exit_boot_struct *p = priv;
 
 	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
@@ -747,7 +740,6 @@ struct boot_params *
 efi_main(struct efi_config *c, struct boot_params *boot_params)
 {
 	struct desc_ptr *gdt = NULL;
-	efi_loaded_image_t *image;
 	struct setup_header *hdr = &boot_params->hdr;
 	efi_status_t status;
 	struct desc_struct *desc;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 24e65a0f756d..53ac0cb2396d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -17,6 +17,7 @@
 #include "pgtable.h"
 #include "../string.h"
 #include "../voffset.h"
+#include <asm/bootparam_utils.h>
 
 /*
  * WARNING!!
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index d2f184165934..c8181392f70d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -23,7 +23,6 @@
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
-#include <asm/bootparam_utils.h>
 
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index f8debf7aeb4c..5f2d03067ae5 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -40,7 +40,6 @@ int cmdline_find_option_bool(const char *option);
 static unsigned long find_trampoline_placement(void)
 {
 	unsigned long bios_start = 0, ebda_start = 0;
-	unsigned long trampoline_start;
 	struct boot_e820_entry *entry;
 	char *signature;
 	int i;
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9f1f9e3b8230..830bd984182b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -343,3 +343,9 @@ For 32-bit we have the following conventions - kernel is built with
 .Lafter_call_\@:
 #endif
 .endm
+
+#ifdef CONFIG_PARAVIRT_XXL
+#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
+#else
+#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
+#endif
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 90b473297299..2bb986f305ac 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -294,9 +294,11 @@
 .Lfinished_frame_\@:
 .endm
 
-.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0
 	cld
+.if \skip_gs == 0
 	PUSH_GS
+.endif
 	FIXUP_FRAME
 	pushl	%fs
 	pushl	%es
@@ -313,13 +315,13 @@
 	movl	%edx, %es
 	movl	$(__KERNEL_PERCPU), %edx
 	movl	%edx, %fs
+.if \skip_gs == 0
 	SET_KERNEL_GS %edx
-
+.endif
 	/* Switch to kernel stack if necessary */
 .if \switch_stacks > 0
 	SWITCH_TO_KERNEL_STACK
 .endif
-
 .endm
 
 .macro SAVE_ALL_NMI cr3_reg:req
@@ -1441,39 +1443,46 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
 ENTRY(page_fault)
 	ASM_CLAC
-	pushl	$do_page_fault
-	ALIGN
-	jmp common_exception
+	pushl	$0; /* %gs's slot on the stack */
+
+	SAVE_ALL switch_stacks=1 skip_gs=1
+
+	ENCODE_FRAME_POINTER
+	UNWIND_ESPFIX_STACK
+
+	/* fixup %gs */
+	GS_TO_REG %ecx
+	REG_TO_PTGS %ecx
+	SET_KERNEL_GS %ecx
+
+	GET_CR2_INTO(%ecx)			# might clobber %eax
+
+	/* fixup orig %eax */
+	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
+	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
+
+	TRACE_IRQS_OFF
+	movl	%esp, %eax			# pt_regs pointer
+	call	do_page_fault
+	jmp	ret_from_exception
 END(page_fault)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
-	FIXUP_FRAME
-	pushl	%fs
-	pushl	%es
-	pushl	%ds
-	pushl	%eax
-	movl	$(__USER_DS), %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	$(__KERNEL_PERCPU), %eax
-	movl	%eax, %fs
-	pushl	%ebp
-	pushl	%edi
-	pushl	%esi
-	pushl	%edx
-	pushl	%ecx
-	pushl	%ebx
-	SWITCH_TO_KERNEL_STACK
+	SAVE_ALL switch_stacks=1 skip_gs=1
 	ENCODE_FRAME_POINTER
-	cld
 	UNWIND_ESPFIX_STACK
+
+	/* fixup %gs */
 	GS_TO_REG %ecx
 	movl	PT_GS(%esp), %edi		# get the function address
-	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
-	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
 	REG_TO_PTGS %ecx
 	SET_KERNEL_GS %ecx
+
+	/* fixup orig %eax */
+	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
+	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
+
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0ea4831a72a4..f7c70c1bee8b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -864,18 +864,84 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
+.macro idtentry_part do_sym, has_error_code:req, read_cr2:req, paranoid:req, shift_ist=-1, ist_offset=0
+
+	.if \paranoid
+	call	paranoid_entry
+	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
+	.else
+	call	error_entry
+	.endif
+	UNWIND_HINT_REGS
+
+	.if \read_cr2
+	/*
+	 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
+	 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
+	 * GET_CR2_INTO can clobber RAX.
+	 */
+	GET_CR2_INTO(%r12);
+	.endif
+
+	.if \shift_ist != -1
+	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
+	.else
+	TRACE_IRQS_OFF
+	.endif
+
+	.if \paranoid == 0
+	testb	$3, CS(%rsp)
+	jz	.Lfrom_kernel_no_context_tracking_\@
+	CALL_enter_from_user_mode
+.Lfrom_kernel_no_context_tracking_\@:
+	.endif
+
+	movq	%rsp, %rdi			/* pt_regs pointer */
+
+	.if \has_error_code
+	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
+	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
+	.else
+	xorl	%esi, %esi			/* no error code */
+	.endif
+
+	.if \shift_ist != -1
+	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
+	.endif
+
+	.if \read_cr2
+	movq	%r12, %rdx			/* Move CR2 into 3rd argument */
+	.endif
+
+	call	\do_sym
+
+	.if \shift_ist != -1
+	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
+	.endif
+
+	.if \paranoid
+	/* this procedure expect "no swapgs" flag in ebx */
+	jmp	paranoid_exit
+	.else
+	jmp	error_exit
+	.endif
+
+.endm
+
 /**
  * idtentry - Generate an IDT entry stub
  * @sym:		Name of the generated entry point
- * @do_sym: 		C function to be called
- * @has_error_code: 	True if this IDT vector has an error code on the stack
- * @paranoid: 		non-zero means that this vector may be invoked from
+ * @do_sym:		C function to be called
+ * @has_error_code:	True if this IDT vector has an error code on the stack
+ * @paranoid:		non-zero means that this vector may be invoked from
  *			kernel mode with user GSBASE and/or user CR3.
  *			2 is special -- see below.
  * @shift_ist:		Set to an IST index if entries from kernel mode should
- *             		decrement the IST stack so that nested entries get a
+ *			decrement the IST stack so that nested entries get a
  *			fresh stack.  (This is for #DB, which has a nasty habit
- *             		of recursing.)
+ *			of recursing.)
+ * @create_gap:		create a 6-word stack gap when coming from kernel mode.
+ * @read_cr2:		load CR2 into the 3rd argument; done before calling any C code
  *
  * idtentry generates an IDT stub that sets up a usable kernel context,
  * creates struct pt_regs, and calls @do_sym.  The stub has the following
@@ -900,15 +966,19 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
 	/* Sanity check */
-	.if \shift_ist != -1 && \paranoid == 0
+	.if \shift_ist != -1 && \paranoid != 1
 	.error "using shift_ist requires paranoid=1"
 	.endif
 
+	.if \create_gap && \paranoid
+	.error "using create_gap requires paranoid=0"
+	.endif
+
 	ASM_CLAC
 
 	.if \has_error_code == 0
@@ -934,47 +1004,7 @@ ENTRY(\sym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	.if \paranoid
-	call	paranoid_entry
-	.else
-	call	error_entry
-	.endif
-	UNWIND_HINT_REGS
-	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
-
-	.if \paranoid
-	.if \shift_ist != -1
-	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
-	.else
-	TRACE_IRQS_OFF
-	.endif
-	.endif
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
-	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
-	.else
-	xorl	%esi, %esi			/* no error code */
-	.endif
-
-	.if \shift_ist != -1
-	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	call	\do_sym
-
-	.if \shift_ist != -1
-	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	/* these procedures expect "no swapgs" flag in ebx */
-	.if \paranoid
-	jmp	paranoid_exit
-	.else
-	jmp	error_exit
-	.endif
+	idtentry_part \do_sym, \has_error_code, \read_cr2, \paranoid, \shift_ist, \ist_offset
 
 	.if \paranoid == 1
 	/*
@@ -983,21 +1013,9 @@ ENTRY(\sym)
 	 * run in real process context if user_mode(regs).
 	 */
 .Lfrom_usermode_switch_stack_\@:
-	call	error_entry
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
-	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
-	.else
-	xorl	%esi, %esi			/* no error code */
+	idtentry_part \do_sym, \has_error_code, \read_cr2, paranoid=0
 	.endif
 
-	call	\do_sym
-
-	jmp	error_exit
-	.endif
 _ASM_NOKPROBE(\sym)
 END(\sym)
 .endm
@@ -1007,7 +1025,7 @@ idtentry overflow			do_overflow			has_error_code=0
 idtentry bounds				do_bounds			has_error_code=0
 idtentry invalid_op			do_invalid_op			has_error_code=0
 idtentry device_not_available		do_device_not_available		has_error_code=0
-idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2
+idtentry double_fault			do_double_fault			has_error_code=1 paranoid=2 read_cr2=1
 idtentry coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry invalid_TSS			do_invalid_TSS			has_error_code=1
 idtentry segment_not_present		do_segment_not_present		has_error_code=1
@@ -1180,10 +1198,10 @@ idtentry xenint3		do_int3			has_error_code=0
 #endif
 
 idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1
+idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
 
 #ifdef CONFIG_KVM_GUEST
-idtentry async_page_fault	do_async_page_fault	has_error_code=1
+idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
 #endif
 
 #ifdef CONFIG_X86_MCE
@@ -1282,18 +1300,9 @@ ENTRY(error_entry)
 	movq	%rax, %rsp			/* switch stack */
 	ENCODE_FRAME_POINTER
 	pushq	%r12
-
-	/*
-	 * We need to tell lockdep that IRQs are off.  We can't do this until
-	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).
-	 */
-	TRACE_IRQS_OFF
-	CALL_enter_from_user_mode
 	ret
 
 .Lerror_entry_done:
-	TRACE_IRQS_OFF
 	ret
 
 	/*
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0e033ef11a9f..0d258688c8cf 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -60,8 +60,17 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
-	if (!*hvp)
-		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+	/*
+	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
+	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
+	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
+	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
+	 * not be stopped in the case of CPU offlining and the VM will hang.
+	 */
+	if (!*hvp) {
+		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
+				 PAGE_KERNEL);
+	}
 
 	if (*hvp) {
 		u64 val;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 050e5f9ebf81..e647aa095867 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -49,7 +49,7 @@ static inline void generic_apic_probe(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-extern unsigned int apic_verbosity;
+extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern int disable_apic;
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 5ed3cf1c3934..9b4df6eaa11a 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -92,7 +92,7 @@ void kvm_async_pf_task_wait(u32 token, int interrupt_kernel);
 void kvm_async_pf_task_wake(u32 token);
 u32 kvm_read_and_reset_pf_reason(void);
 extern void kvm_disable_steal_time(void);
-void do_async_page_fault(struct pt_regs *regs, unsigned long error_code);
+void do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init kvm_spinlock_init(void);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c25c38a05c1c..5135282683d4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -116,7 +116,7 @@ static inline void write_cr0(unsigned long x)
 
 static inline unsigned long read_cr2(void)
 {
-	return PVOP_CALL0(unsigned long, mmu.read_cr2);
+	return PVOP_CALLEE0(unsigned long, mmu.read_cr2);
 }
 
 static inline void write_cr2(unsigned long x)
@@ -909,13 +909,7 @@ extern void default_banner(void);
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_ops+PV_CPU_swapgs);		\
 		 )
-#endif
-
-#define GET_CR2_INTO_RAX				\
-	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);
 
-#ifdef CONFIG_PARAVIRT_XXL
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
@@ -929,9 +923,19 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
-#endif
+#endif /* CONFIG_PARAVIRT_XXL */
+#endif	/* CONFIG_X86_64 */
+
+#ifdef CONFIG_PARAVIRT_XXL
+
+#define GET_CR2_INTO_AX							\
+	PARA_SITE(PARA_PATCH(PV_MMU_read_cr2),				\
+		  ANNOTATE_RETPOLINE_SAFE;				\
+		  call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);		\
+		 )
+
+#endif /* CONFIG_PARAVIRT_XXL */
 
-#endif	/* CONFIG_X86_32 */
 
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 946f8f1f1efc..639b2df445ee 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -220,7 +220,7 @@ struct pv_mmu_ops {
 	void (*exit_mmap)(struct mm_struct *mm);
 
 #ifdef CONFIG_PARAVIRT_XXL
-	unsigned long (*read_cr2)(void);
+	struct paravirt_callee_save read_cr2;
 	void (*write_cr2)(unsigned long);
 
 	unsigned long (*read_cr3)(void);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7d6f3f3fad78..5dd1674ddf4c 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -74,14 +74,14 @@ dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
 dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_64
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code);
+dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long address);
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
 #endif
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
-dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code);
+dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 1bd91cb7b320..f5291362da1a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -183,7 +183,7 @@ EXPORT_SYMBOL_GPL(local_apic_timer_c2_ok);
 /*
  * Debug level, exported for io_apic.c
  */
-unsigned int apic_verbosity;
+int apic_verbosity;
 
 int pic_mode;
 
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index da64452584b0..5c7ee3df4d0b 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -76,6 +76,7 @@ static void __used common(void)
 	BLANK();
 	OFFSET(XEN_vcpu_info_mask, vcpu_info, evtchn_upcall_mask);
 	OFFSET(XEN_vcpu_info_pending, vcpu_info, evtchn_upcall_pending);
+	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
 	BLANK();
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index e69408bf664b..7da2bcd2b8eb 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -86,9 +86,9 @@ static bool _e820__mapped_any(struct e820_table *table,
 			continue;
 		if (entry->addr >= end || entry->addr + entry->size <= start)
 			continue;
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index bcd206c8ac90..0e2d72929a8c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -29,9 +29,7 @@
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
-#define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
 #else
-#define GET_CR2_INTO(reg) movq %cr2, reg
 #define INTERRUPT_RETURN iretq
 #endif
 
@@ -323,7 +321,7 @@ early_idt_handler_common:
 
 	cmpq $14,%rsi		/* Page fault? */
 	jnz 10f
-	GET_CR2_INTO(%rdi)	/* Can clobber any volatile register if pv */
+	GET_CR2_INTO(%rdi)	/* can clobber %rax if pv */
 	call early_make_pgtable
 	andl %eax,%eax
 	jz 20f			/* All good */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 82caf01b63dd..3231440d6253 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -242,23 +242,23 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
 NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 
 dotraplinkage void
-do_async_page_fault(struct pt_regs *regs, unsigned long error_code)
+do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
 	enum ctx_state prev_state;
 
 	switch (kvm_read_and_reset_pf_reason()) {
 	default:
-		do_page_fault(regs, error_code);
+		do_page_fault(regs, error_code, address);
 		break;
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
 		/* page is swapped out by the host. */
 		prev_state = exception_enter();
-		kvm_async_pf_task_wait((u32)read_cr2(), !user_mode(regs));
+		kvm_async_pf_task_wait((u32)address, !user_mode(regs));
 		exception_exit(prev_state);
 		break;
 	case KVM_PV_REASON_PAGE_READY:
 		rcu_irq_enter();
-		kvm_async_pf_task_wake((u32)read_cr2());
+		kvm_async_pf_task_wake((u32)address);
 		rcu_irq_exit();
 		break;
 	}
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 1bfe5c6e6cfe..afac7ccce72f 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -546,17 +546,15 @@ void __init default_get_smp_config(unsigned int early)
 			 * local APIC has default address
 			 */
 			mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-			return;
+			goto out;
 		}
 
 		pr_info("Default MP configuration #%d\n", mpf->feature1);
 		construct_default_ISA_mptable(mpf->feature1);
 
 	} else if (mpf->physptr) {
-		if (check_physptr(mpf, early)) {
-			early_memunmap(mpf, sizeof(*mpf));
-			return;
-		}
+		if (check_physptr(mpf, early))
+			goto out;
 	} else
 		BUG();
 
@@ -565,7 +563,7 @@ void __init default_get_smp_config(unsigned int early)
 	/*
 	 * Only use the first configuration found.
 	 */
-
+out:
 	early_memunmap(mpf, sizeof(*mpf));
 }
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 98039d7fb998..0aa6256eedd8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -370,7 +370,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.exit_mmap		= paravirt_nop,
 
 #ifdef CONFIG_PARAVIRT_XXL
-	.mmu.read_cr2		= native_read_cr2,
+	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
 	.mmu.write_cr2		= native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 250e4c4ac6d9..af64519b2695 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -143,17 +143,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 
 void release_thread(struct task_struct *dead_task)
 {
-	if (dead_task->mm) {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-		if (dead_task->mm->context.ldt) {
-			pr_warn("WARNING: dead process %s still has LDT? <%p/%d>\n",
-				dead_task->comm,
-				dead_task->mm->context.ldt->entries,
-				dead_task->mm->context.ldt->nr_entries);
-			BUG();
-		}
-#endif
-	}
+	WARN_ON(dead_task->mm);
 }
 
 enum which_selector {
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 71691a8310e7..0fdbe89d0754 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -369,12 +369,22 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		x86_fsbase_write_task(child, value);
+		/*
+		 * When changing the FS base, use do_arch_prctl_64()
+		 * to set the index to zero and to set the base
+		 * as requested.
+		 */
+		if (child->thread.fsbase != value)
+			return do_arch_prctl_64(child, ARCH_SET_FS, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
+		/*
+		 * Exactly the same here as the %fs handling above.
+		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		x86_gsbase_write_task(child, value);
+		if (child->thread.gsbase != value)
+			return do_arch_prctl_64(child, ARCH_SET_GS, value);
 		return 0;
 #endif
 	}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 87095a477154..4bb0f8447112 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -313,13 +313,10 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 
 #ifdef CONFIG_X86_64
 /* Runs on IST stack */
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
+dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2)
 {
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
-#ifdef CONFIG_VMAP_STACK
-	unsigned long cr2;
-#endif
 
 #ifdef CONFIG_X86_ESPFIX64
 	extern unsigned char native_irq_return_iret[];
@@ -415,7 +412,6 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
 	 * stack even if the actual trigger for the double fault was
 	 * something else.
 	 */
-	cr2 = read_cr2();
 	if ((unsigned long)task_stack_page(tsk) - 1 - cr2 < PAGE_SIZE)
 		handle_stack_overflow("kernel stack overflow (double-fault)", regs, cr2);
 #endif
diff --git a/arch/x86/math-emu/fpu_emu.h b/arch/x86/math-emu/fpu_emu.h
index a5a41ec58072..0c122226ca56 100644
--- a/arch/x86/math-emu/fpu_emu.h
+++ b/arch/x86/math-emu/fpu_emu.h
@@ -177,7 +177,7 @@ static inline void reg_copy(FPU_REG const *x, FPU_REG *y)
 #define setexponentpos(x,y) { (*(short *)&((x)->exp)) = \
   ((y) + EXTENDED_Ebias) & 0x7fff; }
 #define exponent16(x)         (*(short *)&((x)->exp))
-#define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (y); }
+#define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (u16)(y); }
 #define addexponent(x,y)    { (*(short *)&((x)->exp)) += (y); }
 #define stdexp(x)           { (*(short *)&((x)->exp)) += EXTENDED_Ebias; }
 
diff --git a/arch/x86/math-emu/reg_constant.c b/arch/x86/math-emu/reg_constant.c
index 8dc9095bab22..742619e94bdf 100644
--- a/arch/x86/math-emu/reg_constant.c
+++ b/arch/x86/math-emu/reg_constant.c
@@ -18,7 +18,7 @@
 #include "control_w.h"
 
 #define MAKE_REG(s, e, l, h) { l, h, \
-		((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
+		(u16)((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
 
 FPU_REG const CONST_1 = MAKE_REG(POS, 0, 0x00000000, 0x80000000);
 #if 0
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 794f364cb882..0799cc79efd3 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1507,9 +1507,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
 /*
- * This routine handles page faults.  It determines the address,
- * and the problem, and then passes it off to one of the appropriate
- * routines.
+ * Explicitly marked noinline such that the function tracer sees this as the
+ * page_fault entry point.
  */
 static noinline void
 __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
@@ -1528,33 +1527,26 @@ __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 }
 NOKPROBE_SYMBOL(__do_page_fault);
 
-static nokprobe_inline void
-trace_page_fault_entries(unsigned long address, struct pt_regs *regs,
-			 unsigned long error_code)
+static __always_inline void
+trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
+			 unsigned long address)
 {
+	if (!trace_pagefault_enabled())
+		return;
+
 	if (user_mode(regs))
 		trace_page_fault_user(address, regs, error_code);
 	else
 		trace_page_fault_kernel(address, regs, error_code);
 }
 
-/*
- * We must have this function blacklisted from kprobes, tagged with notrace
- * and call read_cr2() before calling anything else. To avoid calling any
- * kind of tracing machinery before we've observed the CR2 value.
- *
- * exception_{enter,exit}() contains all sorts of tracepoints.
- */
-dotraplinkage void notrace
-do_page_fault(struct pt_regs *regs, unsigned long error_code)
+dotraplinkage void
+do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	unsigned long address = read_cr2(); /* Get the faulting address */
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
-	if (trace_pagefault_enabled())
-		trace_page_fault_entries(address, regs, error_code);
-
+	trace_page_fault_entries(regs, error_code, address);
 	__do_page_fault(regs, error_code, address);
 	exception_exit(prev_state);
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index e0df96fdfe46..e94e0a62ba92 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -41,7 +41,7 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
 bool sev_enabled __section(.data);
 
 /* Buffer used for early in-place encryption by BSP, no locking needed */
-static char sme_early_buffer[PAGE_SIZE] __aligned(PAGE_SIZE);
+static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
 /*
  * This routine does not change the underlying encryption setting of the
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4722ba2966ac..26b63d051bda 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -998,7 +998,8 @@ void __init xen_setup_vcpu_info_placement(void)
 			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
 		pv_ops.irq.irq_enable =
 			__PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
-		pv_ops.mmu.read_cr2 = xen_read_cr2_direct;
+		pv_ops.mmu.read_cr2 =
+			__PV_IS_CALLEE_SAVE(xen_read_cr2_direct);
 	}
 }
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index f6e5eeecfc69..26e8b326966d 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1307,16 +1307,6 @@ static void xen_write_cr2(unsigned long cr2)
 	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
 }
 
-static unsigned long xen_read_cr2(void)
-{
-	return this_cpu_read(xen_vcpu)->arch.cr2;
-}
-
-unsigned long xen_read_cr2_direct(void)
-{
-	return this_cpu_read(xen_vcpu_info.arch.cr2);
-}
-
 static noinline void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
@@ -2397,7 +2387,7 @@ static void xen_leave_lazy_mmu(void)
 }
 
 static const struct pv_mmu_ops xen_mmu_ops __initconst = {
-	.read_cr2 = xen_read_cr2,
+	.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
 	.write_cr2 = xen_write_cr2,
 
 	.read_cr3 = xen_read_cr3,
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 8019edd0125c..be104eef80be 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -10,6 +10,7 @@
 #include <asm/percpu.h>
 #include <asm/processor-flags.h>
 #include <asm/frame.h>
+#include <asm/asm.h>
 
 #include <linux/linkage.h>
 
@@ -135,3 +136,18 @@ ENTRY(check_events)
 	FRAME_END
 	ret
 ENDPROC(check_events)
+
+ENTRY(xen_read_cr2)
+	FRAME_BEGIN
+	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
+	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2);
+
+ENTRY(xen_read_cr2_direct)
+	FRAME_BEGIN
+	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2_direct);
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 2f111f47ba98..45a441c33d6d 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -134,6 +134,9 @@ __visible void xen_irq_disable_direct(void);
 __visible unsigned long xen_save_fl_direct(void);
 __visible void xen_restore_fl_direct(unsigned long);
 
+__visible unsigned long xen_read_cr2(void);
+__visible unsigned long xen_read_cr2_direct(void);
+
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
 __visible void xen_sysret32(void);
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 5ab4c60c100e..15a329da59fa 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -489,25 +489,11 @@ static void test_ptrace_write_gsbase(void)
 		 * selector value is changed or not by the GSBASE write in
 		 * a ptracer.
 		 */
-		if (gs != *shared_scratch) {
-			nerrs++;
-			printf("[FAIL]\tGS changed to %lx\n", gs);
-
-			/*
-			 * On older kernels, poking a nonzero value into the
-			 * base would zero the selector.  On newer kernels,
-			 * this behavior has changed -- poking the base
-			 * changes only the base and, if FSGSBASE is not
-			 * available, this may have no effect.
-			 */
-			if (gs == 0)
-				printf("\tNote: this is expected behavior on older kernels.\n");
-		} else if (have_fsgsbase && (base != 0xFF)) {
-			nerrs++;
-			printf("[FAIL]\tGSBASE changed to %lx\n", base);
+		if (gs == 0 && base == 0xFF) {
+			printf("[OK]\tGS was reset as expected\n");
 		} else {
-			printf("[OK]\tGS remained 0x%hx%s", *shared_scratch, have_fsgsbase ? " and GSBASE changed to 0xFF" : "");
-			printf("\n");
+			nerrs++;
+			printf("[FAIL]\tGS=0x%lx, GSBASE=0x%lx (should be 0, 0xFF)\n", gs, base);
 		}
 	}
 

