Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CC2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB1921783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573558200;
	bh=bi5c2ytAf+LDDZaU2jB1n6T+DiUwKpN3HCu/2m5i3JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JVScyZcv253IRoncfN+969oQwp9Jwv3HbnWSq1++Sj10stGl2dHHWycjpMp4ZumTZ
	 IaXq0WDm7uYOXeQcJ++CAtLSuxOHY4SIBWsuxcLMgsiDMDS2RrjGds+7S+/Cxffzb6
	 UaYQxC2kcDJLZfMNhgwyiUpAfnX/MMtwOci4g+dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKLL37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfKLL37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:29:59 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B99206BB;
        Tue, 12 Nov 2019 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573558197;
        bh=bi5c2ytAf+LDDZaU2jB1n6T+DiUwKpN3HCu/2m5i3JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TanGBgEjapQS+VSynY/DayCSfznsMC7p9mDIk5H51thXu/4oaMcURjfMt6Lo7DrSO
         NHd4nV/sUzSeCKucqAZskEwDlMTHIvxl42zCEyWWldDZUVPIKo0YFKlpF4bfdReOSS
         5KSrLhzPVeHa4RimN6oG0PD/ZuqxaxPucUq571cw=
Date:   Tue, 12 Nov 2019 11:29:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Subject: Re: [PATCH -v5 13/17] arm/ftrace: Use __patch_text_real()
Message-ID: <20191112112950.GB17835@willie-the-truck>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.220458362@infradead.org>
 <20191111164703.GA11521@willie-the-truck>
 <20191111171955.GO4114@hirez.programming.kicks-ass.net>
 <20191111172541.GT5671@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111172541.GT5671@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 06:25:41PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 11, 2019 at 06:19:55PM +0100, Peter Zijlstra wrote:
> 
> > If you can give me a Tested-by, I'll replace it with the below... :-)
> > 
> > --- a/arch/arm/kernel/ftrace.c
> > +++ b/arch/arm/kernel/ftrace.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/ftrace.h>
> >  #include <asm/insn.h>
> >  #include <asm/set_memory.h>
> > +#include <asm/patch.h>
> >  
> >  #ifdef CONFIG_THUMB2_KERNEL
> >  #define	NOP		0xf85deb04	/* pop.w {lr} */
> > @@ -35,9 +36,7 @@ static int __ftrace_modify_code(void *da
> >  {
> >  	int *command = data;
> >  
> > -	set_kernel_text_rw();
> >  	ftrace_modify_all_code(*command);
> > -	set_kernel_text_ro();
> >  
> >  	return 0;
> >  }
> > @@ -59,13 +58,11 @@ static unsigned long adjust_address(stru
> >  
> >  int ftrace_arch_code_modify_prepare(void)
> >  {
> > -	set_all_modules_text_rw();
> >  	return 0;
> >  }
> >  
> >  int ftrace_arch_code_modify_post_process(void)
> >  {
> > -	set_all_modules_text_ro();
> >  	/* Make sure any TLB misses during machine stop are cleared. */
> >  	flush_tlb_all();
> >  	return 0;
> > @@ -97,10 +94,7 @@ static int ftrace_modify_code(unsigned l
> >  			return -EINVAL;
> >  	}
> >  
> > -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> > -		return -EPERM;
> > -
> > -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> > +	__patch_text_real((void *)pc, new, true);
> 
> I'll even make that: __patch_text((void *)pc, new);

This fails to compile. I bodged it as below, but maybe this stuff should
actually live in insn.c. Not fussed either way. I ran the ftrace tests,
loaded a module and toggled ftrace on/off with this applied and it looks
like it works to me:

Tested-by: Will Deacon <will@kernel.org>

Will

--->8

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 8cad59465af3..a885172e504c 100644
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
