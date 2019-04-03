Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D60BC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB4B206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDCKbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:31:24 -0400
Received: from foss.arm.com ([217.140.101.70]:36996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDCKbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:31:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BC080D;
        Wed,  3 Apr 2019 03:31:23 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7066D3F59C;
        Wed,  3 Apr 2019 03:31:22 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.4 BACKPORT 1/2] arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug signals
Date:   Wed,  3 Apr 2019 11:31:13 +0100
Message-Id: <20190403103114.29050-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9a4b9d084d978f80eb9210727c81804588b42ff upstream.

FAR_EL1 is UNKNOWN for all debug exceptions other than those caused by
taking a hardware watchpoint. Unfortunately, if a debug handler returns
a non-zero value, then we will propagate the UNKNOWN FAR value to
userspace via the si_addr field of the SIGTRAP siginfo_t.

Instead, let's set si_addr to take on the PC of the faulting instruction,
which we have available in the current pt_regs.

Cc: <stable@vger.kernel.org> # 4.4.y
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/fault.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 04c4b88706d8..89abdf9af4e6 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -589,11 +589,12 @@ void __init hook_debug_fault_code(int nr,
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
 
@@ -604,16 +605,16 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
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
-- 
2.11.0

