Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12272073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKOVMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:12:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44588 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKOVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitJ-0007N4-8w; Fri, 15 Nov 2019 22:12:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EFC931C18CF;
        Fri, 15 Nov 2019 22:12:28 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:28 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/iopl: Restrict iopl() permission scope
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210105.369055550@linutronix.de>
References: <20191113210105.369055550@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385234895.12247.7259230718260076464.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     ede65f28e61e5a5ccf6c46d9c8169abbd89fe24d
Gitweb:        https://git.kernel.org/tip/ede65f28e61e5a5ccf6c46d9c8169abbd89fe24d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:07 +01:00

x86/iopl: Restrict iopl() permission scope

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210105.369055550@linutronix.de

---
 arch/x86/Kconfig                        | 32 +++++++++-
 arch/x86/include/asm/pgtable_32_types.h |  2 +-
 arch/x86/include/asm/processor.h        | 28 ++++++--
 arch/x86/kernel/cpu/common.c            |  5 +-
 arch/x86/kernel/ioport.c                | 87 ++++++++++++++++--------
 arch/x86/kernel/process.c               | 32 +++++----
 6 files changed, 139 insertions(+), 47 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa..2aad1cd 100644
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
+	  capabilities and permission from potentially active security
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
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index b0bc0ff..0fab4bf 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -44,7 +44,7 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
  * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
  * to avoid include recursion hell
  */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 40)
+#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 41)
 
 #define CPU_ENTRY_AREA_BASE						\
 	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 40bb0f7..b0e02aa 100644
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
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 79dd544..7bf402b 100644
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
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 3548563..9ed9458 100644
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
@@ -157,36 +173,55 @@ SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
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
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index bfc935d..8ba2707 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -370,21 +370,27 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 void tss_update_io_bitmap(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	u16 *base = &tss->x86_tss.io_bitmap_base;
 
 	if (test_thread_flag(TIF_IO_BITMAP)) {
-		struct io_bitmap *iobm = current->thread.io_bitmap;
-
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
-
+		struct thread_struct *t = &current->thread;
+
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
+
+			/* Enable the bitmap */
+			*base = IO_BITMAP_OFFSET_VALID_MAP;
+		}
 		/*
 		 * Make sure that the TSS limit is covering the io bitmap.
 		 * It might have been cut down by a VMEXIT to 0x67 which
