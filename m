Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4D2196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uG6Ef4kX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfKMJ1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:27:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35676 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZVfxfkF9g4hBv743yfpuDiV5akcWiNbuAeJoSU5Y/NA=; b=uG6Ef4kXxJ/eYhTn9zV368mar
        XrO50junT0zmYAokzxueiRYjBwd4O0DRDlnw4MQZngpBoyaPQfmKiW8Vm8kSFQ2HcqKRcXPXx9w12
        sXNrMoJseotzcLkVGSL7cqg0TnhyXLo8exbG8wwCCcEIRfkKaFCRxNyaGlCAP6QDVwMLcJTdS/TuW
        xG20zjizUelRPn7A69J1MUOLyXUh+zcZDuW9I0qngtO/SHHFEBondU5yZdsV7reTAPYBog9CdvQgt
        FvzchmoeoXn2McaJZ/lE8sAJmeo4P+6yaR4irjWmq/jL1RjHG4pzUsk1mzs+fJRWorEiBNl+waUEN
        DC3D/kt4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUovA-0007lH-Hw; Wed, 13 Nov 2019 09:26:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 676E0301120;
        Wed, 13 Nov 2019 10:25:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 871A520261861; Wed, 13 Nov 2019 10:26:36 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:26:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Subject: [PATCH -v5mkII 13/17] arm/ftrace: Use __patch_text()
Message-ID: <20191113092636.GG4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.220458362@infradead.org>
 <20191111164703.GA11521@willie-the-truck>
 <20191111171955.GO4114@hirez.programming.kicks-ass.net>
 <20191111172541.GT5671@hirez.programming.kicks-ass.net>
 <20191112112950.GB17835@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112112950.GB17835@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:29:51AM +0000, Will Deacon wrote:
> This fails to compile. I bodged it as below, but maybe this stuff should
> actually live in insn.c. Not fussed either way. I ran the ftrace tests,
> loaded a module and toggled ftrace on/off with this applied and it looks
> like it works to me:
> 
> Tested-by: Will Deacon <will@kernel.org>

Thanks, I've folded that and will leave any further cleanup to some ARM
person that is capable of testing :-)

---
Subject: arm/ftrace: Use __patch_text()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Oct 15 21:07:35 CEST 2019

Instead of flipping text protection, use the patch_text infrastructure
that uses a fixmap alias where required.

This removes the last user of set_all_modules_text_*().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Will Deacon <will@kernel.org>
Cc: rabin@rab.in
Cc: ard.biesheuvel@linaro.org
Cc: james.morse@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/Makefile |    4 ++--
 arch/arm/kernel/ftrace.c |   10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -49,8 +49,8 @@ obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_ARM_ARCH_TIMER)	+= arch_timer.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
-obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
-obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o
+obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 #include <asm/set_memory.h>
+#include <asm/patch.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
@@ -35,9 +36,7 @@ static int __ftrace_modify_code(void *da
 {
 	int *command = data;
 
-	set_kernel_text_rw();
 	ftrace_modify_all_code(*command);
-	set_kernel_text_ro();
 
 	return 0;
 }
@@ -59,13 +58,11 @@ static unsigned long adjust_address(stru
 
 int ftrace_arch_code_modify_prepare(void)
 {
-	set_all_modules_text_rw();
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
 {
-	set_all_modules_text_ro();
 	/* Make sure any TLB misses during machine stop are cleared. */
 	flush_tlb_all();
 	return 0;
@@ -97,10 +94,7 @@ static int ftrace_modify_code(unsigned l
 			return -EINVAL;
 	}
 
-	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
-		return -EPERM;
-
-	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
+	__patch_text((void *)pc, new);
 
 	return 0;
 }
