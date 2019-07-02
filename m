Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B87C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AFB21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gll/V/7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGBH2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:28:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfGBH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K8QOsQqzfq5CPRmQump69XRimOndfchhan89rRQjWSk=; b=gll/V/7KHwt/whSmEKez1Ymgm
        t4o2zf9HhgQX4x+P7F++xQWfer/TAPPWm/QfuSmpkFrh7GifmvXs+HmmugEERdaeaJaVQGmmkr92D
        dUtyhxEqVpId+CwKcfFq2+BUHi/NDwfQGsCnlVCimhzaEZxrbAqmUehzpCXgCYUjBht32XY9kL5U/
        B0fDa8Y0gjaQ5Ye5X1+txfLCLx2It1C24/C791EpCRyedlwnoPU3kT2jwz4uoVMDTuWl2Xx1OCKKm
        Y+n0IH6WHHLC+Gu4oY0s9pi+BZn003BCpwnV0XtyoROcB7zScgvXKh0x/VxdPiNJpebDMfyRDmyjh
        iFD7kyrxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiDDE-0002Be-D1; Tue, 02 Jul 2019 07:28:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A60720245BD9; Tue,  2 Jul 2019 09:28:22 +0200 (CEST)
Date:   Tue, 2 Jul 2019 09:28:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     rostedt@goodmis.org, edwintorok@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
Message-ID: <20190702072821.GX3419@hirez.programming.kicks-ass.net>
References: <20190702053151.26922-1-devel@etsukata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702053151.26922-1-devel@etsukata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 02:31:51PM +0900, Eiichi Tsukata wrote:
> Put the boundary check before it accesses user space to prevent unnecessary
> access which might crash the machine.
> 
> Especially, ftrace preemptirq/irq_disable event with user stack trace
> option can trigger SEGV in pid 1 which leads to panic.
> 
> Reproducer:
> 
>   CONFIG_PREEMPTIRQ_TRACEPOINTS=y
>   # echo 1 > events/preemptirq/enable
>   # echo userstacktrace > trace_options
> 
> Output:
> 
>   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>   CPU: 1 PID: 1 Comm: systemd Not tainted 5.2.0-rc7+ #10

Killing systemd is a feature :-)

>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   Call Trace:
>    dump_stack+0x67/0x90
>    panic+0x100/0x2c6
>    do_exit.cold+0x4e/0x101
>    do_group_exit+0x3a/0xa0
>    get_signal+0x14a/0x8e0
>    do_signal+0x36/0x650
>    exit_to_usermode_loop+0x92/0xb0
>    prepare_exit_to_usermode+0x6f/0xb0
>    retint_user+0x8/0x18
>   RIP: 0033:0x55be7ad1c89f
>   Code: Bad RIP value.

^^^ that's weird, no amount of unwinding should affect regs->ip.

>   RSP: 002b:00007ffe329a4b00 EFLAGS: 00010202
>   RAX: 0000000000000768 RBX: 00007ffe329a4ba0 RCX: 00007ff0063aa469
>   RDX: 00007ff0066761de RSI: 00007ffe329a4b20 RDI: 0000000000000768
>   RBP: 000000000000000b R08: 0000000000000000 R09: 00007ffe329a4e2f
>   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000768
>   R13: 0000000000000000 R14: 0000000000000004 R15: 000055be7b3d3560
>   Kernel Offset: 0x2a000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Fixes: 02b67518e2b1 ("tracing: add support for userspace stacktraces in tracing/iter_ctrl")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> ---
>  arch/x86/kernel/stacktrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index 2abf27d7df6b..6d0c608ffe34 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -123,12 +123,12 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>  	while (1) {
>  		struct stack_frame_user frame;
>  
> +		if ((unsigned long)fp < regs->sp)
> +			break;
>  		frame.next_fp = NULL;
>  		frame.ret_addr = 0;
>  		if (!copy_stack_frame(fp, &frame))
>  			break;
> -		if ((unsigned long)fp < regs->sp)
> -			break;

Aside of which, that doesn't make sense, even if copy_stack_frame() was
fed utter garbage it should never result in the user process being
affected.

It does: "pagefault_disable(); __copy_from_user_inatomic()", which
should take the fault and catch it in an extable and have it return
-EFAULT.

Something is really fishy here, maybe Josh has an idea?

>  		if (frame.ret_addr) {
>  			if (!consume_entry(cookie, frame.ret_addr, false))
>  				return;
> -- 
> 2.21.0
> 
