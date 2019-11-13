Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE656C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE076206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKMVC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:02:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKMVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:26 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmS-00068V-31; Wed, 13 Nov 2019 22:02:24 +0100
Message-Id: <20191113210105.276580787@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:56 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 16/20] x86/iopl: Fixup misleading comment
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The comment for the sys_iopl() implementation is outdated and actively
misleading in some parts. Fix it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ioport.c |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

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
@@ -136,14 +136,24 @@ SYSCALL_DEFINE3(ioperm, unsigned long, f
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
@@ -164,9 +174,18 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
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


