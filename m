Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A2AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF13020740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKOVNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:13:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfKOVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitJ-0007N7-DA; Fri, 15 Nov 2019 22:12:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1864B1C18D0;
        Fri, 15 Nov 2019 22:12:29 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/iopl: Fixup misleading comment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210105.276580787@linutronix.de>
References: <20191113210105.276580787@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385234906.12247.16814215844130409013.tip-bot2@tip-bot2>
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

Commit-ID:     7543e168c1d3c135d21747e494d99e60550c3828
Gitweb:        https://git.kernel.org/tip/7543e168c1d3c135d21747e494d99e60550c3828
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:06 +01:00

x86/iopl: Fixup misleading comment

The comment for the sys_iopl() implementation is outdated and actively
misleading in some parts. Fix it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210105.276580787@linutronix.de

---
 arch/x86/kernel/ioport.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index f82ca1c..3548563 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -41,7 +41,7 @@ void io_bitmap_exit(void)
 }
 
 /*
- * this changes the io permissions bitmap in the current task.
+ * This changes the io permissions bitmap in the current task.
  */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
@@ -136,14 +136,24 @@ SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
 }
 
 /*
- * sys_iopl has to be used when you want to access the IO ports
- * beyond the 0x3ff range: to get the full 65536 ports bitmapped
- * you'd need 8kB of bitmaps/process, which is a bit excessive.
+ * The sys_iopl functionality depends on the level argument, which if
+ * granted for the task is used by the CPU to check I/O instruction and
+ * CLI/STI against the current priviledge level (CPL). If CPL is less than
+ * or equal the tasks IOPL level the instructions take effect. If not a #GP
+ * is raised. The default IOPL is 0, i.e. no permissions.
  *
- * Here we just change the flags value on the stack: we allow
- * only the super-user to do it. This depends on the stack-layout
- * on system-call entry - see also fork() and the signal handling
- * code.
+ * Setting IOPL to level 0-2 is disabling the userspace access. Only level
+ * 3 enables it. If set it allows the user space thread:
+ *
+ * - Unrestricted access to all 65535 I/O ports
+ * - The usage of CLI/STI instructions
+ *
+ * The advantage over ioperm is that the context switch does not require to
+ * update the I/O bitmap which is especially true when a large number of
+ * ports is accessed. But the allowance of CLI/STI in userspace is
+ * considered a major problem.
+ *
+ * IOPL is strictly per thread and inherited on fork.
  */
 SYSCALL_DEFINE1(iopl, unsigned int, level)
 {
@@ -164,9 +174,18 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		    security_locked_down(LOCKDOWN_IOPORT))
 			return -EPERM;
 	}
+	/*
+	 * Change the flags value on the return stack, which has been set
+	 * up on system-call entry. See also the fork and signal handling
+	 * code how this is handled.
+	 */
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
 		(level << X86_EFLAGS_IOPL_BIT);
+	/* Store the new level in the thread struct */
 	t->iopl = level << X86_EFLAGS_IOPL_BIT;
+	/*
+	 * X86_32 switches immediately and XEN handles it via emulation.
+	 */
 	set_iopl_mask(t->iopl);
 
 	return 0;
