Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A25D21905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126163;
	bh=+rwgGm67nFXmqJ4K2sK5t0ijncT6EQ2QInH63QJbkEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dnMOI9nTmCsemzXQc/VhJNVflZcil/7Bd1FexSAo6EVHbWyqTlbfnMTqhpkBfDCcU
	 qs1RgD3UmcLLblGv+vSZwFqZtrUAltQT1hACe1jA0fQH80AybQb9+9kn67Us7u0yz5
	 oq8hEVefW8wccwtoWynZEeIA9FOEdUCr7JTAZpNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfDXRQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388311AbfDXRPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B597F2054F;
        Wed, 24 Apr 2019 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126152;
        bh=+rwgGm67nFXmqJ4K2sK5t0ijncT6EQ2QInH63QJbkEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klgZ8Jg1AfiCg8y8wQtuwPRWeHIQHtDm2zEMsZrWrhcBPHDbxAMqcB1cn2KAVMz7b
         buqOEeoIWveuxhAPPbJkI3X4XDbcmw5GsGoLB3TdK/cv/8JRdDJ9Q57n+UERMEGeTu
         G8MzRebtUlvl3XnP1xaC98YlBEtmQoc4HdF/liWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.4 001/168] arm64: debug: Dont propagate UNKNOWN FAR into si_code for debug signals
Date:   Wed, 24 Apr 2019 19:07:25 +0200
Message-Id: <20190424170923.531979936@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
@@ -589,11 +589,12 @@ void __init hook_debug_fault_code(int nr
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
 
@@ -604,16 +605,16 @@ asmlinkage int __exception do_debug_exce
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


