Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8455C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FC2207FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgAGHhE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:37:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44287 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgAGHhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:37:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iojPs-0002Uz-Fh; Tue, 07 Jan 2020 08:36:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2544E1C2CCD;
        Tue,  7 Jan 2020 08:36:40 +0100 (CET)
Date:   Tue, 07 Jan 2020 07:36:40 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/context-tracking: Remove exception_enter/exit()
 from do_page_fault()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191227163612.10039-2-frederic@kernel.org>
References: <20191227163612.10039-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157838260004.30329.1599335012779534814.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ee6352b2c47a24234398e06381edd93a8e965976
Gitweb:        https://git.kernel.org/tip/ee6352b2c47a24234398e06381edd93a8e965976
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 27 Dec 2019 17:36:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 07 Jan 2020 08:11:23 +01:00

x86/context-tracking: Remove exception_enter/exit() from do_page_fault()

do_page_fault(), like other exceptions, is already covered by
user_enter() and user_exit() when the exception triggers in userspace.

As explained in:

  8c84014f3bbb11 ("x86/entry: Remove exception_enter() from most trap handlers")

exception_enter/exit() only remained to handle possible page fault from
kernel mode while context tracking is in CONTEXT_USER mode, ie: on
kernel entry before we manage to call user_exit(). The only known
offender was do_fast_syscall_32() fetching EBP register from where
vDSO stashed it.

Meanwhile this got fixed in:

  9999c8c01f34c9 ("x86/entry: Call enter_from_user_mode() with IRQs off")

that moved enter_from_user_mode() before the call to get_user().

So we can safely remove it now.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191227163612.10039-2-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 304d31d..2b4ab28 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1486,27 +1486,6 @@ good_area:
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
-/*
- * Explicitly marked noinline such that the function tracer sees this as the
- * page_fault entry point.
- */
-static noinline void
-__do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
-		unsigned long address)
-{
-	prefetchw(&current->mm->mmap_sem);
-
-	if (unlikely(kmmio_fault(regs, address)))
-		return;
-
-	/* Was the fault on kernel-controlled part of the address space? */
-	if (unlikely(fault_in_kernel_space(address)))
-		do_kern_addr_fault(regs, hw_error_code, address);
-	else
-		do_user_addr_fault(regs, hw_error_code, address);
-}
-NOKPROBE_SYMBOL(__do_page_fault);
-
 static __always_inline void
 trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 			 unsigned long address)
@@ -1521,13 +1500,19 @@ trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 }
 
 dotraplinkage void
-do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
+do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
+		unsigned long address)
 {
-	enum ctx_state prev_state;
+	prefetchw(&current->mm->mmap_sem);
+	trace_page_fault_entries(regs, hw_error_code, address);
 
-	prev_state = exception_enter();
-	trace_page_fault_entries(regs, error_code, address);
-	__do_page_fault(regs, error_code, address);
-	exception_exit(prev_state);
+	if (unlikely(kmmio_fault(regs, address)))
+		return;
+
+	/* Was the fault on kernel-controlled part of the address space? */
+	if (unlikely(fault_in_kernel_space(address)))
+		do_kern_addr_fault(regs, hw_error_code, address);
+	else
+		do_user_addr_fault(regs, hw_error_code, address);
 }
 NOKPROBE_SYMBOL(do_page_fault);
