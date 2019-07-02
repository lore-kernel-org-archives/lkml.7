Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BFEC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C9E21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGBOOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:14:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45979 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:14:23 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hiJXq-0002S7-DV; Tue, 02 Jul 2019 16:14:06 +0200
Date:   Tue, 2 Jul 2019 16:14:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Eiichi Tsukata <devel@etsukata.com>, rostedt@goodmis.org,
        edwintorok@gmail.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
In-Reply-To: <20190702072821.GX3419@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
References: <20190702053151.26922-1-devel@etsukata.com> <20190702072821.GX3419@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019, Peter Zijlstra wrote:

> On Tue, Jul 02, 2019 at 02:31:51PM +0900, Eiichi Tsukata wrote:
> > Put the boundary check before it accesses user space to prevent unnecessary
> > access which might crash the machine.
> > 
> > Especially, ftrace preemptirq/irq_disable event with user stack trace
> > option can trigger SEGV in pid 1 which leads to panic.

It triggers segfaults in random user processes which is bad enough.

And even with that 'fix' applied I can see random segfaults just less
frequent.

> >   RIP: 0033:0x55be7ad1c89f
> >   Code: Bad RIP value.
> 
> ^^^ that's weird, no amount of unwinding should affect regs->ip.

True.

I've gathered a trace from a crash. It's available here:

     https://tglx.de/~tglx/log.1.xz

The interesting part is:

[  352.756926]  systemd-1       1d..2 346277977us : <user stack trace>0000000004
[  352.756926]  =>  <00007f785ae26289>
[  352.758084]  systemd-1       1...1 346277978us : sys_clone -> 0x495
[  352.758846]  systemd-1       1...1 346277978us : <stack trace>    5
[  352.758846]  => do_syscall_64
[  352.758846]  => entry_SYSCALL_64_after_hwframe
[  352.760399]  systemd-1       1...1 346277979us : <user stack trace>
[  352.760399]  =>  <00007f785ae26289>TS]
[  352.761556]  systemd-1       1d... 346277979us : irq_disable: caller=do_syscall_64+0x87/0x110 parent=entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  352.763048]  systemd-1       1d... 346277979us : <stack trace>
[  352.763048]  => trace_hardirqs_off
[  352.763048]  => do_syscall_64
[  352.763048]  => entry_SYSCALL_64_after_hwframe
[  352.765015]  systemd-1       1d... 346277979us : <user 
[  352.765015]  =>  <00007f785ae26289>
[  352.766173]  systemd-1       1d... 346277980us : irq_enable: caller=trace_hardirqs_on_thunk+0x1a/0x1c parent=entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  352.767745]  systemd-1       1d... 346277980us : <stack trace>
[  352.767745]  => trace_hardirqs_on_caller
[  352.767745]  => trace_hardirqs_on_thunk
[  352.767745]  => entry_SYSCALL_64_after_hwframe
[  352.769831]  systemd-1       1d... 346277981us : <user stack trace>
[  352.769831]  =>  <00007f785ae26289>
[  352.770989]  systemd-1       1d... 346277982us : irq_disable: caller=trace_hardirqs_off_thunk+0x1a/0x1c parent=error_entry+0x80/0x100
[  352.772408]  systemd-1       1d... 346277983us : <stack trace>
[  352.772408]  => trace_hardirqs_off_caller
[  352.772408]  => trace_hardirqs_off_thunk
[  352.772408]  => error_entry
[  352.774334]  systemd-1       1d... 346277983us : <user stack trace>
[  352.774334]  =>  <00005614ef9dde48>ter_hwframe
[  352.775505]  systemd-1       1d... 346277984us : page_fault_user: address=0x7ffd52fd0038 ip=0x5614ef9dde48 error_code=0x7
[  352.776811]  systemd-1       1d... 346277984us : <stack trace>
-UU-52.776811]  => do_page_fault
    52.776811]  => do_async_page_fault

....

[  353.078313]  =>  <00005614ef9dde48>
[  353.079486]  systemd-1       1d... 346278040us : irq_disable: caller=trace_hardirqs_off_thunk+0x1a/0x1c parent=error_entry+0x80/0x100
[  353.080952]  systemd-1       1d... 346278041us : <stack trace>
[  353.080952]  => trace_hardirqs_off_caller
[  353.080952]  => trace_hardirqs_off_thunk6278021us : <user stack trace>
[  353.080952]  => error_entry
[  353.082890]  systemd-1       1d... 346278041us : <user stack trace>rcu_irq_exit_irqson+0x2b/0x30 parent=trace_preempt_off+0xa1/0xd0
[  353.082890]  =>  <00007f785ab9ba85>
[  353.084059]  systemd-1       1d... 346278042us : page_fault_user: address=0x495 ip=0x7f785ab9ba85 error_code=0x7p_page_copy+0x344/0x790
[  353.085277]  systemd-1       1d... 346278042us : <stack trace>
[  353.085277]  => do1       1...1 346278034us : <user 
[  353.085277]  => do_async_page_fault
[  353.085277]  => async_page_fault
[  353.087114]  systemd-1       1d... 346278043us : <user stack trace>
[  353.087114]  =>  <00007f785ab9ba85>
[  353.088391]  systemd-1       1d... 346278043us : irq_enable: caller=__do_page_fault+0x2a7/0x4b0 parent=do_page_fault+0x28/0xf0
[  353.089761]  systemd-1       1d... 346278044us : <stack trace>

That last #PF kills it. What's weird is the PF address 0x495 which is the
return value of sys_clone() above. Might be coincidence, but I don't think
so.

Haven't had time to dig deeper.

Thanks,

	tglx


