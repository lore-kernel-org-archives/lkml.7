Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BD12054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257704;
	bh=rbAQW8FIwOjyTYbkgLkbQT0+Ek40RrizhduilU2oNKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HulruDAUVRGXVrl3P8Cs2N7GPbeqRopg/Gr2jsPJpTU7aRhiEPQocYMMMasK82X6y
	 3oFKhVib96KIt53fLHMITwD1Lfj3kvWyeuAiAe6/KyX4y26VJBhnwlp9upv+5AKUw2
	 5XOLionA3DLIhiC4ghVsYGPZW0yd8XUGp8WG4T7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbfCVMUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390224AbfCVMUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:20:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10FE621900;
        Fri, 22 Mar 2019 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257236;
        bh=rbAQW8FIwOjyTYbkgLkbQT0+Ek40RrizhduilU2oNKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZ/1JBEq4ujEnP1iowlMZLDPBGVHwLeNUwTFkdVgkOH/FaJsBWZAX9zkIS0I7CNzz
         u+PAfw2yh4ohPHaJIb295hAEY9jcdkxItRtlYodoiRwSD+FL9byghGf0tfzcij6cM5
         CuQW9A5GnDfCq2R6uDD1fT9f1IoVNVmYbr33cWXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.0 172/238] arm64: debug: Dont propagate UNKNOWN FAR into si_code for debug signals
Date:   Fri, 22 Mar 2019 12:16:31 +0100
Message-Id: <20190322111308.434783417@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arm64/mm/fault.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -824,11 +824,12 @@ void __init hook_debug_fault_code(int nr
 	debug_fault_info[nr].name	= name;
 }
 
-asmlinkage int __exception do_debug_exception(unsigned long addr,
+asmlinkage int __exception do_debug_exception(unsigned long addr_if_watchpoint,
 					      unsigned int esr,
 					      struct pt_regs *regs)
 {
 	const struct fault_info *inf = esr_to_debug_fault_info(esr);
+	unsigned long pc = instruction_pointer(regs);
 	int rv;
 
 	/*
@@ -838,14 +839,14 @@ asmlinkage int __exception do_debug_exce
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs) && !is_ttbr0_addr(instruction_pointer(regs)))
+	if (user_mode(regs) && !is_ttbr0_addr(pc))
 		arm64_apply_bp_hardening();
 
-	if (!inf->fn(addr, esr, regs)) {
+	if (!inf->fn(addr_if_watchpoint, esr, regs)) {
 		rv = 1;
 	} else {
 		arm64_notify_die(inf->name, regs,
-				 inf->sig, inf->code, (void __user *)addr, esr);
+				 inf->sig, inf->code, (void __user *)pc, esr);
 		rv = 0;
 	}
 


