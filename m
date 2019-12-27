Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3ADC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6295421744
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577464585;
	bh=yvFmJENlJl0f4+plgpEQaevuRXsB8/FB/+qR1v/NkEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wnNYi+81SIpqBHh5SmrMMg0AAzoETIZ0JkBj2JGhDQ7kIs853jGn2cDWd5LV6QI1r
	 LTdKwTBmhBggB/VL1paeHwr35iF37OrQ20g/N+9CP/EXrK1M1ciEP7+kFm+FdJuYf6
	 ceVMDiTS0xAleMcaPBY2laA/eP05nuO3qVu/Q9uI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfL0QgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 11:36:23 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E53C52173E;
        Fri, 27 Dec 2019 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577464582;
        bh=yvFmJENlJl0f4+plgpEQaevuRXsB8/FB/+qR1v/NkEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRk8NdRbKZ6RCQzZ7AHsQ43vv0ct0ffmyW+D4qgPhezHjRAR07hG7pA/LWDEAyO4Q
         aOm6e5uIfi+m4D7ZK1tL//PTUw3BRuRVkKr90/rBlGpnY+akWtxwuItnCrMCaWdjhC
         Jl1jq5YYxrORgub8gSwot1o4azAmYhQrP/JOzP5Y=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 1/2] x86/context-tracking: Remove exception_enter/exit() from do_page_fault()
Date:   Fri, 27 Dec 2019 17:36:11 +0100
Message-Id: <20191227163612.10039-2-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191227163612.10039-1-frederic@kernel.org>
References: <20191227163612.10039-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_page_fault(), like other exceptions, is already covered by
user_enter() and user_exit() when the exception triggers in userspace.

As explained in 8c84014f3bbb112d07e73f30a10ac8a3a72f8649
("x86/entry: Remove exception_enter() from most trap handlers"),
exception_enter/exit() only remained to handle possible page fault from
kernel mode while context tracking is in CONTEXT_USER mode, ie: on
kernel entry before we manage to call user_exit(). And the only known
offender was do_fast_syscall_32() fetching EBP register from where
vDSO stashed it.

Meanwhile this got fixed with 9999c8c01f34c918a57d6e5ba2f5d8b79aa04801
("x86/entry: Call enter_from_user_mode() with IRQs off") that moved
enter_from_user_mode() before the call to get_user().

So we can safely remove it now.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/mm/fault.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 304d31d8cbbc..2b4ab2862eda 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1486,27 +1486,6 @@ void do_user_addr_fault(struct pt_regs *regs,
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
-- 
2.23.0

