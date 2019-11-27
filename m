Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C024C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A9B2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfK0IUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:20:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43971 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfK0ITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXq-0002Pl-D6; Wed, 27 Nov 2019 09:19:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E00B81C1E70;
        Wed, 27 Nov 2019 09:19:29 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:29 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/doublefault/32: Rename doublefault.c to
 doublefault_32.c
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484276984.21853.4624114312884587222.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e99b6f46ee5c127d39d2f3a2682fdeef10386316
Gitweb:        https://git.kernel.org/tip/e99b6f46ee5c127d39d2f3a2682fdeef10386316
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 09:42:30 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00

x86/doublefault/32: Rename doublefault.c to doublefault_32.c

doublefault.c now only contains 32-bit code.  Rename it to
doublefault_32.c.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/Makefile         |  4 +-
 arch/x86/kernel/doublefault.c    | 75 +-------------------------------
 arch/x86/kernel/doublefault_32.c | 71 +++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 76 deletions(-)
 delete mode 100644 arch/x86/kernel/doublefault.c
 create mode 100644 arch/x86/kernel/doublefault_32.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 32acb97..6175e37 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -100,7 +100,9 @@ obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
-obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
+ifeq ($(CONFIG_X86_32),y)
+obj-$(CONFIG_DOUBLEFAULT)	+= doublefault_32.o
+endif
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/x86/kernel/doublefault.c b/arch/x86/kernel/doublefault.c
deleted file mode 100644
index 0b3c616..0000000
--- a/arch/x86/kernel/doublefault.c
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/sched/debug.h>
-#include <linux/init_task.h>
-#include <linux/fs.h>
-
-#include <linux/uaccess.h>
-#include <asm/pgtable.h>
-#include <asm/processor.h>
-#include <asm/desc.h>
-
-#ifdef CONFIG_X86_32
-
-#define DOUBLEFAULT_STACKSIZE (1024)
-static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
-#define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
-
-#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + MAXMEM)
-
-static void doublefault_fn(void)
-{
-	struct desc_ptr gdt_desc = {0, 0};
-	unsigned long gdt, tss;
-
-	native_store_gdt(&gdt_desc);
-	gdt = gdt_desc.address;
-
-	printk(KERN_EMERG "PANIC: double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size);
-
-	if (ptr_ok(gdt)) {
-		gdt += GDT_ENTRY_TSS << 3;
-		tss = get_desc_base((struct desc_struct *)gdt);
-		printk(KERN_EMERG "double fault, tss at %08lx\n", tss);
-
-		if (ptr_ok(tss)) {
-			struct x86_hw_tss *t = (struct x86_hw_tss *)tss;
-
-			printk(KERN_EMERG "eip = %08lx, esp = %08lx\n",
-			       t->ip, t->sp);
-
-			printk(KERN_EMERG "eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
-				t->ax, t->bx, t->cx, t->dx);
-			printk(KERN_EMERG "esi = %08lx, edi = %08lx\n",
-				t->si, t->di);
-		}
-	}
-
-	for (;;)
-		cpu_relax();
-}
-
-struct x86_hw_tss doublefault_tss __cacheline_aligned = {
-	.sp0		= STACK_START,
-	.ss0		= __KERNEL_DS,
-	.ldt		= 0,
-	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
-
-	.ip		= (unsigned long) doublefault_fn,
-	/* 0x2 bit is always set */
-	.flags		= X86_EFLAGS_SF | 0x2,
-	.sp		= STACK_START,
-	.es		= __USER_DS,
-	.cs		= __KERNEL_CS,
-	.ss		= __KERNEL_DS,
-	.ds		= __USER_DS,
-	.fs		= __KERNEL_PERCPU,
-#ifndef CONFIG_X86_32_LAZY_GS
-	.gs		= __KERNEL_STACK_CANARY,
-#endif
-
-	.__cr3		= __pa_nodebug(swapper_pg_dir),
-};
-
-#endif
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
new file mode 100644
index 0000000..61c707c
--- /dev/null
+++ b/arch/x86/kernel/doublefault_32.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/init_task.h>
+#include <linux/fs.h>
+
+#include <linux/uaccess.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/desc.h>
+
+#define DOUBLEFAULT_STACKSIZE (1024)
+static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
+#define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
+
+#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + MAXMEM)
+
+static void doublefault_fn(void)
+{
+	struct desc_ptr gdt_desc = {0, 0};
+	unsigned long gdt, tss;
+
+	native_store_gdt(&gdt_desc);
+	gdt = gdt_desc.address;
+
+	printk(KERN_EMERG "PANIC: double fault, gdt at %08lx [%d bytes]\n", gdt, gdt_desc.size);
+
+	if (ptr_ok(gdt)) {
+		gdt += GDT_ENTRY_TSS << 3;
+		tss = get_desc_base((struct desc_struct *)gdt);
+		printk(KERN_EMERG "double fault, tss at %08lx\n", tss);
+
+		if (ptr_ok(tss)) {
+			struct x86_hw_tss *t = (struct x86_hw_tss *)tss;
+
+			printk(KERN_EMERG "eip = %08lx, esp = %08lx\n",
+			       t->ip, t->sp);
+
+			printk(KERN_EMERG "eax = %08lx, ebx = %08lx, ecx = %08lx, edx = %08lx\n",
+				t->ax, t->bx, t->cx, t->dx);
+			printk(KERN_EMERG "esi = %08lx, edi = %08lx\n",
+				t->si, t->di);
+		}
+	}
+
+	for (;;)
+		cpu_relax();
+}
+
+struct x86_hw_tss doublefault_tss __cacheline_aligned = {
+	.sp0		= STACK_START,
+	.ss0		= __KERNEL_DS,
+	.ldt		= 0,
+	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
+
+	.ip		= (unsigned long) doublefault_fn,
+	/* 0x2 bit is always set */
+	.flags		= X86_EFLAGS_SF | 0x2,
+	.sp		= STACK_START,
+	.es		= __USER_DS,
+	.cs		= __KERNEL_CS,
+	.ss		= __KERNEL_DS,
+	.ds		= __USER_DS,
+	.fs		= __KERNEL_PERCPU,
+#ifndef CONFIG_X86_32_LAZY_GS
+	.gs		= __KERNEL_STACK_CANARY,
+#endif
+
+	.__cr3		= __pa_nodebug(swapper_pg_dir),
+};
