Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA75C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23282173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGBPd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfGBPd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:33:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD473206A3;
        Tue,  2 Jul 2019 15:33:57 +0000 (UTC)
Date:   Tue, 2 Jul 2019 11:33:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
Message-ID: <20190702113355.5be9ebfe@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
References: <20190702053151.26922-1-devel@etsukata.com>
        <20190702072821.GX3419@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 16:14:05 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 2 Jul 2019, Peter Zijlstra wrote:
> 
> > On Tue, Jul 02, 2019 at 02:31:51PM +0900, Eiichi Tsukata wrote:  
> > > Put the boundary check before it accesses user space to prevent unnecessary
> > > access which might crash the machine.
> > > 
> > > Especially, ftrace preemptirq/irq_disable event with user stack trace
> > > option can trigger SEGV in pid 1 which leads to panic.  

Note, I'm only able to trigger this crash with the irq_disable event.
The irq_enable and preempt_disable/enable events work just fine. This
leads me to believe that the TRACE_IRQS_OFF macro (which uses a thunk
trampoline) may have some issues and is probably the place to look at.

-- Steve

> 
> It triggers segfaults in random user processes which is bad enough.
> 
> And even with that 'fix' applied I can see random segfaults just less
> frequent.
> 
> > >   RIP: 0033:0x55be7ad1c89f
> > >   Code: Bad RIP value.  
> > 
> > ^^^ that's weird, no amount of unwinding should affect regs->ip.  
> 
>

