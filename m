Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505482073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKOVMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:12:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44591 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfKOVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitJ-0007N1-03; Fri, 15 Nov 2019 22:12:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9CC0B1C18CD;
        Fri, 15 Nov 2019 22:12:28 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:28 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Extend IOPL config to control ioperm() as well
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210105.557339819@linutronix.de>
References: <20191113210105.557339819@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385234859.12247.7075966754785602380.tip-bot2@tip-bot2>
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

Commit-ID:     845fa6a960f45e07ab22b660bee7f7644dd29610
Gitweb:        https://git.kernel.org/tip/845fa6a960f45e07ab22b660bee7f7644dd29610
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:08 +01:00

x86/ioperm: Extend IOPL config to control ioperm() as well

If iopl() is disabled, then providing ioperm() does not make much sense.

Rename the config option and disable/enable both syscalls with it. Guard
the code with #ifdefs where appropriate.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210105.557339819@linutronix.de

---
 arch/x86/Kconfig                   |  7 +++++--
 arch/x86/include/asm/io_bitmap.h   |  6 ++++++
 arch/x86/include/asm/processor.h   |  9 ++++++++-
 arch/x86/include/asm/thread_info.h |  7 ++++++-
 arch/x86/kernel/cpu/common.c       | 26 +++++++++++++++++---------
 arch/x86/kernel/ioport.c           | 26 +++++++++++++++++++-------
 arch/x86/kernel/process.c          |  4 ++++
 7 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1f926e3..b162ce1 100644
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
diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index b664baa..02c6ef8 100644
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
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 1387d31..45f416a 100644
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
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0accf44..d779366 100644
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7bf402b..6f6ca6b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1804,6 +1804,22 @@ static inline void gdt_setup_doublefault_tss(int cpu)
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
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index d5dcde9..8abeee0 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -14,6 +14,8 @@
 #include <asm/io_bitmap.h>
 #include <asm/desc.h>
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+
 static atomic64_t io_bitmap_sequence;
 
 void io_bitmap_share(struct task_struct *tsk)
@@ -172,13 +174,6 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
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
 
@@ -200,3 +195,20 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 
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
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 8ba2707..77a7d8f 100644
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
 
