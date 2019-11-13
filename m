Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BD1C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53A206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKMVCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:02:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38984 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfKMVC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:27 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmT-000695-TP; Wed, 13 Nov 2019 22:02:26 +0100
Message-Id: <20191113210105.557339819@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:59 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 19/20] x86/ioperm: Extend IOPL config to control ioperm()
 as well
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If iopl() is disabled, then providing ioperm() does not make much sense.

Rename the config option and disable/enable both syscalls with it. Guard
the code with #ifdefs where appropriate.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 arch/x86/Kconfig                   |    7 +++++--
 arch/x86/include/asm/io_bitmap.h   |    6 ++++++
 arch/x86/include/asm/processor.h   |    9 ++++++++-
 arch/x86/include/asm/thread_info.h |    7 ++++++-
 arch/x86/kernel/cpu/common.c       |   26 +++++++++++++++++---------
 arch/x86/kernel/ioport.c           |   26 +++++++++++++++++++-------
 arch/x86/kernel/process.c          |    4 ++++
 7 files changed, 65 insertions(+), 20 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1254,10 +1254,13 @@ config X86_VSYSCALL_EMULATION
 	 Disabling this option saves about 7K of kernel size and
 	 possibly 4K of additional runtime pagetable memory.
 
-config X86_IOPL_EMULATION
-	bool "IOPL Emulation"
+config X86_IOPL_IOPERM
+	bool "IOPERM and IOPL Emulation"
 	default y
 	---help---
+	  This enables the ioperm() and iopl() syscalls which are necessary
+	  for legacy applications.
+
 	  Legacy IOPL support is an overbroad mechanism which allows user
 	  space aside of accessing all 65536 I/O ports also to disable
 	  interrupts. To gain this access the caller needs CAP_SYS_RAWIO
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -15,9 +15,15 @@ struct io_bitmap {
 
 struct task_struct;
 
+#ifdef CONFIG_X86_IOPL_IOPERM
 void io_bitmap_share(struct task_struct *tsk);
 void io_bitmap_exit(void);
 
 void tss_update_io_bitmap(void);
+#else
+static inline void io_bitmap_share(struct task_struct *tsk) { }
+static inline void io_bitmap_exit(void) { }
+static inline void tss_update_io_bitmap(void) { }
+#endif
 
 #endif
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -340,13 +340,18 @@ struct x86_hw_tss {
 	(offsetof(struct tss_struct, io_bitmap.mapall) -	\
 	 offsetof(struct tss_struct, x86_tss))
 
+#ifdef CONFIG_X86_IOPL_IOPERM
 /*
  * sizeof(unsigned long) coming from an extra "long" at the end of the
  * iobitmap. The limit is inclusive, i.e. the last valid byte.
  */
-#define __KERNEL_TSS_LIMIT	\
+# define __KERNEL_TSS_LIMIT	\
 	(IO_BITMAP_OFFSET_VALID_ALL + IO_BITMAP_BYTES + \
 	 sizeof(unsigned long) - 1)
+#else
+# define __KERNEL_TSS_LIMIT	\
+	(offsetof(struct tss_struct, x86_tss) + sizeof(struct x86_hw_tss) - 1)
+#endif
 
 /* Base offset outside of TSS_LIMIT so unpriviledged IO causes #GP */
 #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
@@ -398,7 +403,9 @@ struct tss_struct {
 	 */
 	struct x86_hw_tss	x86_tss;
 
+#ifdef CONFIG_X86_IOPL_IOPERM
 	struct x86_io_bitmap	io_bitmap;
+#endif
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -156,8 +156,13 @@ struct thread_info {
 # define _TIF_WORK_CTXSW	(_TIF_WORK_CTXSW_BASE)
 #endif
 
-#define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | \
+#ifdef CONFIG_X86_IOPL_IOPERM
+# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | \
 				 _TIF_IO_BITMAP)
+#else
+# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY)
+#endif
+
 #define _TIF_WORK_CTXSW_NEXT	(_TIF_WORK_CTXSW)
 
 #define STACK_WARN		(THREAD_SIZE/8)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1804,6 +1804,22 @@ static inline void gdt_setup_doublefault
 }
 #endif /* !CONFIG_X86_64 */
 
+static inline void tss_setup_io_bitmap(struct tss_struct *tss)
+{
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
+
+#ifdef CONFIG_X86_IOPL_IOPERM
+	tss->io_bitmap.prev_max = 0;
+	tss->io_bitmap.prev_sequence = 0;
+	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
+	/*
+	 * Invalidate the extra array entry past the end of the all
+	 * permission bitmap as required by the hardware.
+	 */
+	tss->io_bitmap.mapall[IO_BITMAP_LONGS] = ~0UL;
+#endif
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -1860,15 +1876,7 @@ void cpu_init(void)
 
 	/* Initialize the TSS. */
 	tss_setup_ist(tss);
-	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-	tss->io_bitmap.prev_max = 0;
-	tss->io_bitmap.prev_sequence = 0;
-	memset(tss->io_bitmap.bitmap, 0xff, sizeof(tss->io_bitmap.bitmap));
-	/*
-	 * Invalidate the extra array entry past the end of the all
-	 * permission bitmap as required by the hardware.
-	 */
-	tss->io_bitmap.mapall[IO_BITMAP_LONGS] = ~0UL;
+	tss_setup_io_bitmap(tss);
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
 	load_TR_desc();
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -14,6 +14,8 @@
 #include <asm/io_bitmap.h>
 #include <asm/desc.h>
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+
 static atomic64_t io_bitmap_sequence;
 
 void io_bitmap_share(struct task_struct *tsk)
@@ -172,13 +174,6 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
 	struct thread_struct *t = &current->thread;
 	unsigned int old;
 
-	/*
-	 * Careful: the IOPL bits in regs->flags are undefined under Xen PV
-	 * and changing them has no effect.
-	 */
-	if (IS_ENABLED(CONFIG_X86_IOPL_NONE))
-		return -ENOSYS;
-
 	if (level > 3)
 		return -EINVAL;
 
@@ -200,3 +195,20 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
 
 	return 0;
 }
+
+#else /* CONFIG_X86_IOPL_IOPERM */
+
+long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
+{
+	return -ENOSYS;
+}
+SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
+{
+	return -ENOSYS;
+}
+
+SYSCALL_DEFINE1(iopl, unsigned int, level)
+{
+	return -ENOSYS;
+}
+#endif
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -316,6 +316,7 @@ void arch_setup_new_exec(void)
 	}
 }
 
+#ifdef CONFIG_X86_IOPL_IOPERM
 static inline void tss_invalidate_io_bitmap(struct tss_struct *tss)
 {
 	/*
@@ -403,6 +404,9 @@ void tss_update_io_bitmap(void)
 		tss_invalidate_io_bitmap(tss);
 	}
 }
+#else /* CONFIG_X86_IOPL_IOPERM */
+static inline void switch_to_bitmap(unsigned long tifp) { }
+#endif
 
 #ifdef CONFIG_SMP
 


