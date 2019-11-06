Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A6C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB4B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbfKFU5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:57:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbfKFU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:56:48 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSSMA-000338-DS; Wed, 06 Nov 2019 21:56:46 +0100
Message-Id: <20191106202806.425388355@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 20:35:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch 7/9] x86/iopl: Restrict iopl() permission scope
References: <20191106193459.581614484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The access to the full I/O port range can be also provided by the TSS I/O
bitmap, but that would require to copy 8k of data on scheduling in the
task. As shown with the sched out optimization TSS.io_bitmap_base can be
used to switch the incoming task to a preallocated I/O bitmap which has all
bits zero, i.e. allows access to all I/O ports.

Implementing this allows to provide an iopl() emulation mode which restricts
the IOPL level 3 permissions to I/O port access but removes the STI/CLI
permission which is coming with the hardware IOPL mechansim.

Provide a config option to switch IOPL to emulation mode, make it the
default and while at it also provide an option to disable IOPL completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                 |   32 ++++++++++++++++
 arch/x86/include/asm/processor.h |   24 +++++++++---
 arch/x86/kernel/cpu/common.c     |    4 +-
 arch/x86/kernel/ioport.c         |   75 ++++++++++++++++++++++++++++++---------
 arch/x86/kernel/process.c        |   15 +++++--
 5 files changed, 123 insertions(+), 27 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1254,6 +1254,38 @@ config X86_VSYSCALL_EMULATION
 	 Disabling this option saves about 7K of kernel size and
 	 possibly 4K of additional runtime pagetable memory.
 
+choice
+	prompt "IOPL"
+	default X86_IOPL_EMULATION
+
+config X86_IOPL_EMULATION
+	bool "IOPL Emulation"
+	---help---
+	  Legacy IOPL support is an overbroad mechanism which allows user
+	  space aside of accessing all 65536 I/O ports also to disable
+	  interrupts. To gain this access the caller needs CAP_SYS_RAWIO
+	  capabilities and permission from eventually active security
+	  modules.
+
+	  The emulation restricts the functionality of the syscall to
+	  only allowing the full range I/O port access, but prevents the
+	  ability to disable interrupts from user space.
+
+config X86_IOPL_LEGACY
+	bool "IOPL Legacy"
+	---help---
+	Allow the full IOPL permissions, i.e. user space access to all
+	65536 I/O ports and also the ability to disable interrupts, which
+	is overbroad and can result in system lockups.
+
+config X86_IOPL_NONE
+	bool "IOPL None"
+	---help---
+	Disable the IOPL permission syscall. That's the safest option as
+	no sane application should depend on this functionality.
+
+endchoice
+
 config TOSHIBA
 	tristate "Toshiba Laptop support"
 	depends on X86_32
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -331,8 +331,12 @@ struct x86_hw_tss {
 #define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
 #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
 
-#define IO_BITMAP_OFFSET_VALID				\
-	(offsetof(struct tss_struct, io_bitmap) -	\
+#define IO_BITMAP_OFFSET_VALID_MAP			\
+	(offsetof(struct tss_struct, io_bitmap_map) -	\
+	 offsetof(struct tss_struct, x86_tss))
+
+#define IO_BITMAP_OFFSET_VALID_ALL			\
+	(offsetof(struct tss_struct, io_bitmap_all) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
 /*
@@ -343,7 +347,7 @@ struct x86_hw_tss {
  * last valid byte
  */
 #define __KERNEL_TSS_LIMIT	\
-	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
+	(IO_BITMAP_OFFSET_VALID_ALL + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
 
 /* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
 #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
@@ -379,7 +383,8 @@ struct tss_struct {
 	 * byte beyond the end of the I/O permission bitmap. The extra byte
 	 * must have all bits set and must be within the TSS limit.
 	 */
-	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
+	unsigned long		io_bitmap_map[IO_BITMAP_LONGS + 1];
+	unsigned long		io_bitmap_all[IO_BITMAP_LONGS + 1];
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
@@ -495,7 +500,6 @@ struct thread_struct {
 #endif
 	/* IO permissions: */
 	unsigned long		*io_bitmap_ptr;
-	unsigned long		iopl;
 	/*
 	 * The byte range in the I/O permission bitmap which contains zero
 	 * bits.
@@ -503,6 +507,13 @@ struct thread_struct {
 	unsigned int		io_zerobits_start;
 	unsigned int		io_zerobits_end;
 
+	/*
+	 * IOPL. Priviledge level dependent I/O permission which includes
+	 * user space CLI/STI when granted.
+	 */
+	unsigned long		iopl;
+	unsigned long		iopl_emul;
+
 	mm_segment_t		addr_limit;
 
 	unsigned int		sig_on_uaccess_err:1;
@@ -524,6 +535,9 @@ static inline void arch_thread_struct_wh
 	*size = fpu_kernel_xstate_size;
 }
 
+extern void tss_update_io_bitmap(struct tss_struct *tss,
+				 struct thread_struct *thread);
+
 /*
  * Thread-synchronous status.
  *
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1866,7 +1866,9 @@ void cpu_init(void)
 	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
 	tss->io_zerobits_start = IO_BITMAP_BYTES;
 	tss->io_zerobits_end = 0;
-	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
+	memset(tss->io_bitmap_map, 0xff, sizeof(tss->io_bitmap_map));
+	/* Invalidate the extra tail entry of the allow all I/O bitmap */
+	tss->io_bitmap_all[IO_BITMAP_LONGS] = ~0UL;
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
 	load_TR_desc();
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -109,7 +109,7 @@ long ksys_ioperm(unsigned long from, uns
 	}
 
 	/* Copy the changed range over to the TSS bitmap */
-	dst = (char *)tss->io_bitmap;
+	dst = (char *)tss->io_bitmap_map;
 	src = (char *)bitmap;
 	memcpy(dst + copy_start, src + copy_start, copy_len);
 
@@ -130,7 +130,7 @@ long ksys_ioperm(unsigned long from, uns
 		 * is correct. It might have been wreckaged by a VMEXiT.
 		 */
 		set_thread_flag(TIF_IO_BITMAP);
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
+		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID_MAP;
 		refresh_tss_limit();
 	}
 
@@ -184,36 +184,77 @@ SYSCALL_DEFINE3(ioperm, unsigned long, f
  */
 SYSCALL_DEFINE1(iopl, unsigned int, level)
 {
-	struct pt_regs *regs = current_pt_regs();
 	struct thread_struct *t = &current->thread;
+	struct pt_regs *regs = current_pt_regs();
+	unsigned int old;
 
 	/*
 	 * Careful: the IOPL bits in regs->flags are undefined under Xen PV
 	 * and changing them has no effect.
 	 */
-	unsigned int old = t->iopl >> X86_EFLAGS_IOPL_BIT;
+	if (IS_ENABLED(CONFIG_X86_IOPL_NONE))
+		return -ENOSYS;
 
 	if (level > 3)
 		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION))
+		old = t->iopl_emul;
+	else
+		old = t->iopl >> X86_EFLAGS_IOPL_BIT;
+
+	/* No point in going further if nothing changes */
+	if (level == old)
+		return 0;
+
 	/* Trying to gain more privileges? */
 	if (level > old) {
 		if (!capable(CAP_SYS_RAWIO) ||
 		    security_locked_down(LOCKDOWN_IOPORT))
 			return -EPERM;
 	}
-	/*
-	 * Change the flags value on the return stack, which has been set
-	 * up on system-call entry. See also the fork and signal handling
-	 * code how this is handled.
-	 */
-	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
-		(level << X86_EFLAGS_IOPL_BIT);
-	/* Store the new level in the thread struct */
-	t->iopl = level << X86_EFLAGS_IOPL_BIT;
-	/*
-	 * X86_32 switches immediately and XEN handles it via emulation.
-	 */
-	set_iopl_mask(t->iopl);
+
+	if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION)) {
+		struct tss_struct *tss;
+		unsigned int tss_base;
+
+		/* Prevent racing against a task switch */
+		preempt_disable();
+		tss = this_cpu_ptr(&cpu_tss_rw);
+		if (level == 3) {
+			/* Grant access to all I/O ports */
+			set_thread_flag(TIF_IO_BITMAP);
+			tss_base = IO_BITMAP_OFFSET_VALID_ALL;
+		} else if (t->io_bitmap_ptr) {
+			/* Thread has a I/O bitmap */
+			tss_update_io_bitmap(tss, t);
+			set_thread_flag(TIF_IO_BITMAP);
+			tss_base = IO_BITMAP_OFFSET_VALID_MAP;
+		} else {
+			/* Take it out of the context switch work burden */
+			clear_thread_flag(TIF_IO_BITMAP);
+			tss_base = IO_BITMAP_OFFSET_INVALID;
+		}
+		tss->x86_tss.io_bitmap_base = tss_base;
+		t->iopl_emul = level;
+		preempt_enable();
+
+	} else {
+		/*
+		 * Change the flags value on the return stack, which has
+		 * been set up on system-call entry. See also the fork and
+		 * signal handling code how this is handled.
+		 */
+		regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
+			(level << X86_EFLAGS_IOPL_BIT);
+		/* Store the new level in the thread struct */
+		t->iopl = level << X86_EFLAGS_IOPL_BIT;
+		/*
+		 * X86_32 switches immediately and XEN handles it via
+		 * emulation.
+		 */
+		set_iopl_mask(t->iopl);
+	}
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -357,8 +357,7 @@ void arch_setup_new_exec(void)
 	}
 }
 
-static void tss_update_io_bitmap(struct tss_struct *tss,
-				 struct thread_struct *thread)
+void tss_update_io_bitmap(struct tss_struct *tss, struct thread_struct *thread)
 {
 	unsigned int start, len;
 	char *src, *dst;
@@ -387,9 +386,17 @@ static inline void switch_to_bitmap(stru
 				    unsigned long tifp, unsigned long tifn)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	u16 *base = &tss->x86_tss.io_bitmap_base;
 
 	if (tifn & _TIF_IO_BITMAP) {
-		tss_update_io_bitmap(tss, next);
+		/*
+		 * IF IOPL emulation is enabled and the emulated I/O
+		 * priviledge level is 3, switch to the 'grant all' bitmap.
+		 */
+		if (IS_ENABLED(CONFIG_IOPL_EMULATION) && next->iopl_emul == 3)
+			*base = IO_BITMAP_OFFSET_VALID_ALL;
+		else
+			tss_update_io_bitmap(tss, next);
 		/*
 		 * Make sure that the TSS limit is covering the io bitmap.
 		 * It might have been cut down by a VMEXIT to 0x67 which
@@ -405,7 +412,7 @@ static inline void switch_to_bitmap(stru
 		 * by moving it outside the TSS limit so any subsequent I/O
 		 * access from user space will trigger a #GP.
 		 */
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+		*base = IO_BITMAP_OFFSET_INVALID;
 	}
 }
 


