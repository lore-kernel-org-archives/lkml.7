Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BE620659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfKKWgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:36:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfKKWfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:50 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHk-0000va-Qa; Mon, 11 Nov 2019 23:35:48 +0100
Message-Id: <20191111223052.881699933@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:28 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V2 14/16] x86/iopl: Restrict iopl() permission scope
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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

V2:	Fixed the 32bit build fail by increasing the cpu entry area size
	Move the TSS update out of the iopl() emulation code.
---
 arch/x86/Kconfig                        |   32 ++++++++++++++
 arch/x86/include/asm/pgtable_32_types.h |    2 
 arch/x86/include/asm/processor.h        |   20 ++++++++-
 arch/x86/kernel/ioport.c                |   70 +++++++++++++++++++++++---------
 arch/x86/kernel/process.c               |   29 +++++++++----
 5 files changed, 122 insertions(+), 31 deletions(-)

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
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,7 +44,7 @@ extern bool __vmalloc_start_set; /* set
  * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
  * to avoid include recursion hell
  */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
+#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 41)
 
 #define CPU_ENTRY_AREA_BASE						\
 	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -332,10 +332,14 @@ struct x86_hw_tss {
 #define IO_BITMAP_BYTES			(IO_BITMAP_BITS / BITS_PER_BYTE)
 #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES / sizeof(long))
 
-#define IO_BITMAP_OFFSET_VALID				\
+#define IO_BITMAP_OFFSET_VALID_MAP			\
 	(offsetof(struct tss_struct, io_bitmap_bytes) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
+#define IO_BITMAP_OFFSET_VALID_ALL			\
+	(offsetof(struct tss_struct, io_bitmap_all) -	\
+	 offsetof(struct tss_struct, x86_tss))
+
 /*
  * The extra byte at the end is required by the hardware. It has all
  * bits set.
@@ -344,7 +348,7 @@ struct x86_hw_tss {
  * last valid byte
  */
 #define __KERNEL_TSS_LIMIT	\
-	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + 1 - 1)
+	(IO_BITMAP_OFFSET_VALID_ALL + IO_BITMAP_BYTES + 1 - 1)
 
 /* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
 #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
@@ -390,6 +394,12 @@ struct tss_struct {
 	 */
 	unsigned char		io_bitmap_bytes[IO_BITMAP_BYTES + 1]
 				__aligned(sizeof(unsigned long));
+	/*
+	 * Special I/O bitmap to emulate IOPL(3). All bytes zero,
+	 * except the additional byte at the end.
+	 */
+	unsigned char		io_bitmap_all[IO_BITMAP_BYTES + 1]
+				__aligned(sizeof(unsigned long));
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
@@ -505,7 +515,13 @@ struct thread_struct {
 #endif
 	/* IO permissions: */
 	struct io_bitmap	*io_bitmap;
+
+	/*
+	 * IOPL. Priviledge level dependent I/O permission which includes
+	 * user space CLI/STI when granted.
+	 */
 	unsigned long		iopl;
+	unsigned long		iopl_emul;
 
 	mm_segment_t		addr_limit;
 
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -27,15 +27,28 @@ void io_bitmap_share(struct task_struct
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
+static void task_update_io_bitmap(void)
+{
+	struct thread_struct *t = &current->thread;
+
+	preempt_disable();
+	if (t->iopl_emul == 3 || t->io_bitmap) {
+		/* TSS update is handled on exit to user space */
+		set_thread_flag(TIF_IO_BITMAP);
+	} else {
+		clear_thread_flag(TIF_IO_BITMAP);
+		/* Invalidate TSS */
+		tss_update_io_bitmap();
+	}
+	preempt_enable();
+}
+
 void io_bitmap_exit(void)
 {
 	struct io_bitmap *iobm = current->thread.io_bitmap;
 
-	preempt_disable();
 	current->thread.io_bitmap = NULL;
-	clear_thread_flag(TIF_IO_BITMAP);
-	tss_update_io_bitmap();
-	preempt_enable();
+	task_update_io_bitmap();
 	if (iobm && refcount_dec_and_test(&iobm->refcnt))
 		kfree(iobm);
 }
@@ -151,36 +164,55 @@ SYSCALL_DEFINE3(ioperm, unsigned long, f
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
+		t->iopl_emul = level;
+		task_update_io_bitmap();
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
@@ -368,22 +368,33 @@ static void tss_copy_io_bitmap(struct ts
 void tss_update_io_bitmap(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	u16 *base = &tss->x86_tss.io_bitmap_base;
 
 	if (test_thread_flag(TIF_IO_BITMAP)) {
-		struct io_bitmap *iobm = current->thread.io_bitmap;
+		struct thread_struct *t = &current->thread;
 
 		/*
-		 * Only copy bitmap data when the bitmap or the sequence
-		 * number differs. The update time is accounted to the
-		 * incoming task.
+		 * IF IOPL emulation is enabled and the emulated I/O
+		 * priviledge level is 3, switch to the 'grant all' bitmap.
 		 */
-		if (tss->last_bitmap != iobm ||
-		    tss->last_sequence != iobm->sequence)
-			tss_copy_io_bitmap(tss, iobm);
+		if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION) &&
+		    t->iopl_emul == 3) {
+			*base = IO_BITMAP_OFFSET_VALID_ALL;
+		} else {
+			struct io_bitmap *iobm = t->io_bitmap;
 
-		/* Enable the bitmap */
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
+			/*
+			 * Only copy bitmap data when the bitmap or the
+			 * sequence number differs. The update time is
+			 * accounted to the incoming task.
+			 */
+			if (tss->last_bitmap != iobm ||
+			    tss->last_sequence != iobm->sequence)
+				tss_copy_io_bitmap(tss, iobm);
 
+			/* Enable the bitmap */
+			*base = IO_BITMAP_OFFSET_VALID_MAP;
+		}
 		/*
 		 * Make sure that the TSS limit is covering the io bitmap.
 		 * It might have been cut down by a VMEXIT to 0x67 which


