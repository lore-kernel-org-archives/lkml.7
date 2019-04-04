Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A19C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D39206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371582;
	bh=ePEQiDtnmMnNgkaakzmsLqIC7m6BOfhOF7za9kbqbmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aCQDzOB60DA34yWJRiRSAo06F2Pnl/m7WxI00OvR4Pv2nRvvQze6/qtudLDyuxjVO
	 lQ4lvuuFs0Bp77rRXjUHAXHt4b4+9sRw1rE2AmowdYwYS3ii7z2v1kwMxNuAG1cQdu
	 p7Iui4bwBQCHF0Q+pnf1v+/tvud7YRrnaII672dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfDDJxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbfDDIxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:53:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B5B62171F;
        Thu,  4 Apr 2019 08:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368024;
        bh=ePEQiDtnmMnNgkaakzmsLqIC7m6BOfhOF7za9kbqbmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srZLFgEzeIN6iccWgd9TMj5MRjvb6R7mdw5sVhNyGvL+NnpUbdMry3WR1d7RPNodA
         mplDZstfNan2l9AJnomT+2AaDtgoiu7JYXxqsIjoFSNy0wqFpNrok4tWqoPnJYHwfb
         zDkqpMfnydr2uGGKwyDnLQ6k1PTcOMZM0zaW6ZQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 001/121] arm64: debug: Dont propagate UNKNOWN FAR into si_code for debug signals
Date:   Thu,  4 Apr 2019 10:46:29 +0200
Message-Id: <20190404084545.339361826@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit b9a4b9d084d978f80eb9210727c81804588b42ff upstream.

FAR_EL1 is UNKNOWN for all debug exceptions other than those caused by
taking a hardware watchpoint. Unfortunately, if a debug handler returns
a non-zero value, then we will propagate the UNKNOWN FAR value to
userspace via the si_addr field of the SIGTRAP siginfo_t.

Instead, let's set si_addr to take on the PC of the faulting instruction,
which we have available in the current pt_regs.

Cc: <stable@vger.kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/mm/fault.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -834,11 +834,12 @@ void __init hook_debug_fault_code(int nr
 	debug_fault_info[nr].name	= name;
 }
 
-asmlinkage int __exception do_debug_exception(unsigned long addr,
+asmlinkage int __exception do_debug_exception(unsigned long addr_if_watchpoint,
 					      unsigned int esr,
 					      struct pt_regs *regs)
 {
 	const struct fault_info *inf = debug_fault_info + DBG_ESR_EVT(esr);
+	unsigned long pc = instruction_pointer(regs);
 	struct siginfo info;
 	int rv;
 
@@ -849,19 +850,19 @@ asmlinkage int __exception do_debug_exce
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs) && instruction_pointer(regs) > TASK_SIZE)
+	if (user_mode(regs) && pc > TASK_SIZE)
 		arm64_apply_bp_hardening();
 
-	if (!inf->fn(addr, esr, regs)) {
+	if (!inf->fn(addr_if_watchpoint, esr, regs)) {
 		rv = 1;
 	} else {
 		pr_alert("Unhandled debug exception: %s (0x%08x) at 0x%016lx\n",
-			 inf->name, esr, addr);
+			 inf->name, esr, pc);
 
 		info.si_signo = inf->sig;
 		info.si_errno = 0;
 		info.si_code  = inf->code;
-		info.si_addr  = (void __user *)addr;
+		info.si_addr  = (void __user *)pc;
 		arm64_notify_die("", regs, &info, 0);
 		rv = 0;
 	}


