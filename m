Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44DCC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9429E206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKMVDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:03:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKMVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:26 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmS-00068e-Le; Wed, 13 Nov 2019 22:02:24 +0100
Message-Id: <20191113210105.369055550@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:57 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 17/20] x86/iopl: Restrict iopl() permission scope
References: <20191113204240.767922595@linutronix.de>
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
Acked-by: Andy Lutomirski <luto@kernel.org>
---
V3:	Folded the missing NULL pointer check, reduced preempt disable
	scope (Ingo)

V2:	Fixed the 32bit build fail by increasing the cpu entry area size
	Move the TSS update out of the iopl() emulation code.
---
 arch/x86/Kconfig                        |   32 +++++++++++
 arch/x86/include/asm/pgtable_32_types.h |    2 
 arch/x86/include/asm/processor.h        |   28 +++++++---
 arch/x86/kernel/cpu/common.c            |    5 +
 arch/x86/kernel/ioport.c                |   87 ++++++++++++++++++++++----------
 arch/x86/kernel/process.c               |   28 ++++++----
 6 files changed, 137 insertions(+), 45 deletions(-)

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
@@ -332,19 +332,21 @@ struct x86_hw_tss {
 #define IO_BITMAP_BYTES			(IO_BITMAP_BITS / BITS_PER_BYTE)
 #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES / sizeof(long))
 
-#define IO_BITMAP_OFFSET_VALID					\
+#define IO_BITMAP_OFFSET_VALID_MAP				\
 	(offsetof(struct tss_struct, io_bitmap.bitmap) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
+#define IO_BITMAP_OFFSET_VALID_ALL				\
+	(offsetof(struct tss_struct, io_bitmap.mapall) -	\
+	 offsetof(struct tss_struct, x86_tss))
+
 /*
- * sizeof(unsigned long) coming from an extra "long" at the end
- * of the iobitmap.
- *
- * -1? seg base+limit should be pointing to the address of the
- * last valid byte
+ * sizeof(unsigned long) coming from an extra "long" at the end of the
+ * iobitmap. The limit is inclusive, i.e. the last valid byte.
  */
 #define __KERNEL_TSS_LIMIT	\
-	(IO_BITMAP_OFFSET_VALID + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
+	(IO_BITMAP_OFFSET_VALID_ALL + IO_BITMAP_BYTES + \
+	 sizeof(unsigned long) - 1)
 
 /* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
 #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
@@ -380,6 +382,12 @@ struct x86_io_bitmap {
 	 * be within the limit.
 	 */
 	unsigned long		bitmap[IO_BITMAP_LONGS + 1];
+
+	/*
+	 * Special I/O bitmap to emulate IOPL(3). All bytes zero,
+	 * except the additional byte at the end.
+	 */
+	unsigned long		mapall[IO_BITMAP_LONGS + 1];
 };
 
 struct tss_struct {
@@ -506,7 +514,13 @@ struct thread_struct {
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
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1864,6 +1864,11 @@ void cpu_init(void)
 	tss->io_bitmap.prev_max = 0;
 	tss->io_bitmap.prev_sequence = 0;
 	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
+	/*
+	 * Invalidate the extra array entry past the end of the all
+	 * permission bitmap as required by the hardware.
+	 */
+	tss->io_bitmap.mapall[IO_BITMAP_LONGS] = ~0UL;
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
 	load_TR_desc();
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -17,25 +17,41 @@
 static atomic64_t io_bitmap_sequence;
 
 void io_bitmap_share(struct task_struct *tsk)
- {
-	/*
-	 * Take a refcount on current's bitmap. It can be used by
-	 * both tasks as long as none of them changes the bitmap.
-	 */
-	refcount_inc(&current->thread.io_bitmap->refcnt);
-	tsk->thread.io_bitmap = current->thread.io_bitmap;
+{
+	/* Can be NULL when current->thread.iopl_emul == 3 */
+	if (current->thread.io_bitmap) {
+		/*
+		 * Take a refcount on current's bitmap. It can be used by
+		 * both tasks as long as none of them changes the bitmap.
+		 */
+		refcount_inc(&current->thread.io_bitmap->refcnt);
+		tsk->thread.io_bitmap = current->thread.io_bitmap;
+	}
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
+static void task_update_io_bitmap(void)
+{
+	struct thread_struct *t = &current->thread;
+
+	if (t->iopl_emul == 3 || t->io_bitmap) {
+		/* TSS update is handled on exit to user space */
+		set_thread_flag(TIF_IO_BITMAP);
+	} else {
+		clear_thread_flag(TIF_IO_BITMAP);
+		/* Invalidate TSS */
+		preempt_disable();
+		tss_update_io_bitmap();
+		preempt_enable();
+	}
+}
+
 void io_bitmap_exit(void)
 {
 	struct io_bitmap *iobm = current->thread.io_bitmap;
 
 	current->thread.io_bitmap = NULL;
-	clear_thread_flag(TIF_IO_BITMAP);
-	preempt_disable();
-	tss_update_io_bitmap();
-	preempt_enable();
+	task_update_io_bitmap();
 	if (iobm && refcount_dec_and_test(&iobm->refcnt))
 		kfree(iobm);
 }
@@ -157,36 +173,55 @@ SYSCALL_DEFINE3(ioperm, unsigned long, f
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
@@ -370,21 +370,27 @@ static void tss_copy_io_bitmap(struct ts
 void tss_update_io_bitmap(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	u16 *base = &tss->x86_tss.io_bitmap_base;
 
 	if (test_thread_flag(TIF_IO_BITMAP)) {
-		struct io_bitmap *iobm = current->thread.io_bitmap;
+		struct thread_struct *t = &current->thread;
 
-		/*
-		 * Only copy bitmap data when the sequence number
-		 * differs. The update time is accounted to the incoming
-		 * task.
-		 */
-		if (tss->io_bitmap.prev_sequence != iobm->sequence)
-			tss_copy_io_bitmap(tss, iobm);
-
-		/* Enable the bitmap */
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_VALID;
+		if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION) &&
+		    t->iopl_emul == 3) {
+			*base = IO_BITMAP_OFFSET_VALID_ALL;
+		} else {
+			struct io_bitmap *iobm = t->io_bitmap;
+			/*
+			 * Only copy bitmap data when the sequence number
+			 * differs. The update time is accounted to the
+			 * incoming task.
+			 */
+			if (tss->io_bitmap.prev_sequence != iobm->sequence)
+				tss_copy_io_bitmap(tss, iobm);
 
+			/* Enable the bitmap */
+			*base = IO_BITMAP_OFFSET_VALID_MAP;
+		}
 		/*
 		 * Make sure that the TSS limit is covering the io bitmap.
 		 * It might have been cut down by a VMEXIT to 0x67 which


