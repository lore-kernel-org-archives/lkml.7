Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A38C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2339820678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0ITn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:19:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK0ITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXs-0002RI-01; Wed, 27 Nov 2019 09:19:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D71A1C1E6D;
        Wed, 27 Nov 2019 09:19:30 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:30 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] lkdtm: Add a DOUBLE_FAULT crash type on x86
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484277010.21853.17013724751521586684.tip-bot2@tip-bot2>
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

Commit-ID:     b09511c253e5c739a60952b97c071a93e92b2e88
Gitweb:        https://git.kernel.org/tip/b09511c253e5c739a60952b97c071a93e92b2e88
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Sun, 24 Nov 2019 21:18:04 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00

lkdtm: Add a DOUBLE_FAULT crash type on x86

The DOUBLE_FAULT crash does INT $8, which is a decent approximation
of a double fault.  This is useful for testing the double fault
handling.  Use it like:

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/misc/lkdtm/bugs.c  | 39 +++++++++++++++++++++++++++++++++++++-
 drivers/misc/lkdtm/core.c  |  3 +++-
 drivers/misc/lkdtm/lkdtm.h |  3 +++-
 3 files changed, 45 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 7284a22..a4fdad0 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -12,6 +12,10 @@
 #include <linux/sched/task_stack.h>
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_X86_32
+#include <asm/desc.h>
+#endif
+
 struct lkdtm_list {
 	struct list_head node;
 };
@@ -337,3 +341,38 @@ void lkdtm_UNSET_SMEP(void)
 	pr_err("FAIL: this test is x86_64-only\n");
 #endif
 }
+
+#ifdef CONFIG_X86_32
+void lkdtm_DOUBLE_FAULT(void)
+{
+	/*
+	 * Trigger #DF by setting the stack limit to zero.  This clobbers
+	 * a GDT TLS slot, which is okay because the current task will die
+	 * anyway due to the double fault.
+	 */
+	struct desc_struct d = {
+		.type = 3,	/* expand-up, writable, accessed data */
+		.p = 1,		/* present */
+		.d = 1,		/* 32-bit */
+		.g = 0,		/* limit in bytes */
+		.s = 1,		/* not system */
+	};
+
+	local_irq_disable();
+	write_gdt_entry(get_cpu_gdt_rw(smp_processor_id()),
+			GDT_ENTRY_TLS_MIN, &d, DESCTYPE_S);
+
+	/*
+	 * Put our zero-limit segment in SS and then trigger a fault.  The
+	 * 4-byte access to (%esp) will fault with #SS, and the attempt to
+	 * deliver the fault will recursively cause #SS and result in #DF.
+	 * This whole process happens while NMIs and MCEs are blocked by the
+	 * MOV SS window.  This is nice because an NMI with an invalid SS
+	 * would also double-fault, resulting in the NMI or MCE being lost.
+	 */
+	asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
+		      "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
+
+	panic("tried to double fault but didn't die\n");
+}
+#endif
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index cbc4c90..ee0d6e7 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -171,6 +171,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_KERNEL_DS),
 	CRASHTYPE(STACKLEAK_ERASING),
 	CRASHTYPE(CFI_FORWARD_PROTO),
+#ifdef CONFIG_X86_32
+	CRASHTYPE(DOUBLE_FAULT),
+#endif
 };
 
 
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index ab446e0..c56d23e 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -28,6 +28,9 @@ void lkdtm_CORRUPT_USER_DS(void);
 void lkdtm_STACK_GUARD_PAGE_LEADING(void);
 void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
 void lkdtm_UNSET_SMEP(void);
+#ifdef CONFIG_X86_32
+void lkdtm_DOUBLE_FAULT(void);
+#endif
 
 /* lkdtm_heap.c */
 void __init lkdtm_heap_init(void);
