Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA8C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAEA21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfDQBx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:53:57 -0400
Received: from mail.windriver.com ([147.11.1.11]:40494 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQBxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:53:53 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3H1qmhg027856
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 16 Apr 2019 18:52:48 -0700 (PDT)
Received: from [128.224.162.199] (128.224.162.199) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Apr
 2019 18:52:47 -0700
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190320221534.165ab87b@oasis.local.home>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <bb376e6b-3ba4-8cd1-9fa4-8cfd421f8413@windriver.com>
Date:   Wed, 17 Apr 2019 09:52:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190320221534.165ab87b@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.199]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the last replies in the thread, it seems some work is going on. May I ask
when we can possibly roughly have a fix or workaround?

Thanks,
Zhe


On 3/21/19 10:15 AM, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> He Zhe reported a crash by enabling trace events and selecting
> "userstacktrace" which will read the stack of userspace for every trace
> event recorded. Zhe narrowed it down to:
>
>  c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
>
> With the problem config, I was able to also reproduce the error. I
> narrowed it down to just having to do the following:
>
>  # cd /sys/kernel/tracing
>  # echo 1 > options/userstacktrace
>  # echo 1 > events/preemptirq/irq_disable/enable
>
> And sure enough, I triggered a crash. Well, it was systemd crashing
> with a bad memory access??
>
>  systemd-journal[537]: segfault at ed8cb8 ip 00007f7fffc9fef5 sp 00007ffc4062cb10 error 7
>
> And it would crash similarly each time I tried it, but always at a
> different place. After spending the day on this, I finally figured it
> out. The bug is happening in entry_64.S right after error_entry.
> There's two TRACE_IRQS_OFF in that code path, which if I comment out,
> the bug goes away. Then it dawned on me that the crash always happens
> when systemd does a normal page fault. We had this bug before, and it
> was with the exception trace points.
>
> The issue is that a tracepoint can fault (reading vmalloc or whatever).
> And doing a userspace stack trace most definitely will fault. But if we
> are coming from a legitimate page fault, the address of that fault (in
> the CR2 register) will be lost if we fault before we get to the page
> fault handler. That's exactly what is happening.
>
> To solve this, a TRACE_IRQS_OFF_CR2 (and ON for consistency) was added
> that saves the CR2 register. A new trace_hardirqs_off_thunk_cr2 is
> created that stores the cr2 register, calls the
> trace_hardirqs_off_caller, then on return restores the cr2 register if
> it changed, before returning.
>
> On my tests this fixes the issue. I just want to know if this is a
> legitimate fix or if someone can come up with a better fix?
>
> Note: this also saves the exception context just like the
> do_page_fault() function does.
>
> Note2: This only gets enabled when lockdep or irq tracing is enabled,
> which is not recommended for production environments.
>
> Link: http://lkml.kernel.org/r/897cf5cf-fc24-8a64-cb28-847f2d2e63d2@windriver.com
>
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 7bc105f47d21..7edffec328e2 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -292,6 +292,32 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>  
>  	syscall_return_slowpath(regs);
>  }
> +
> +extern void trace_hardirqs_on_caller(unsigned long caller_addr);
> +__visible void trace_hardirqs_on_caller_cr2(unsigned long caller_addr)
> +{
> +	unsigned long address = read_cr2(); /* Get the faulting address */
> +	enum ctx_state prev_state;
> +
> +	prev_state = exception_enter();
> +	trace_hardirqs_on_caller(caller_addr);
> +	if (address != read_cr2())
> +		write_cr2(address);
> +	exception_exit(prev_state);
> +}
> +
> +extern void trace_hardirqs_off_caller(unsigned long caller_addr);
> +__visible void trace_hardirqs_off_caller_cr2(unsigned long caller_addr)
> +{
> +	unsigned long address = read_cr2(); /* Get the faulting address */
> +	enum ctx_state prev_state;
> +
> +	prev_state = exception_enter();
> +	trace_hardirqs_off_caller(caller_addr);
> +	if (address != read_cr2())
> +		write_cr2(address);
> +	exception_exit(prev_state);
> +}
>  #endif
>  
>  #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 1f0efdb7b629..73ddf24fed3e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1248,12 +1248,12 @@ ENTRY(error_entry)
>  	 * we fix gsbase, and we should do it before enter_from_user_mode
>  	 * (which can take locks).
>  	 */
> -	TRACE_IRQS_OFF
> +	TRACE_IRQS_OFF_CR2
>  	CALL_enter_from_user_mode
>  	ret
>  
>  .Lerror_entry_done:
> -	TRACE_IRQS_OFF
> +	TRACE_IRQS_OFF_CR2
>  	ret
>  
>  	/*
> diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
> index be36bf4e0957..1300b53b98cb 100644
> --- a/arch/x86/entry/thunk_64.S
> +++ b/arch/x86/entry/thunk_64.S
> @@ -41,6 +41,8 @@
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
>  	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
> +	THUNK trace_hardirqs_on_thunk_cr2,trace_hardirqs_on_caller_cr2,1
> +	THUNK trace_hardirqs_off_thunk_cr2,trace_hardirqs_off_caller_cr2,1
>  #endif
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 058e40fed167..dd511742ca2e 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -172,9 +172,13 @@ static inline int arch_irqs_disabled(void)
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  #  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk;
>  #  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk;
> +#  define TRACE_IRQS_ON_CR2	call trace_hardirqs_on_thunk_cr2;
> +#  define TRACE_IRQS_OFF_CR2	call trace_hardirqs_off_thunk_cr2;
>  #else
>  #  define TRACE_IRQS_ON
>  #  define TRACE_IRQS_OFF
> +#  define TRACE_IRQS_ON_CR2
> +#  define TRACE_IRQS_OFF_CR2
>  #endif
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  #  ifdef CONFIG_X86_64
>

