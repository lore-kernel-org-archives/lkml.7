Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53E9C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885EF20883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405400AbfFKTaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:30:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59437 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404836AbfFKTaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:30:14 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hamTD-0003rD-BK; Tue, 11 Jun 2019 21:30:11 +0200
Date:   Tue, 11 Jun 2019 21:30:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND 1/7] sched/core: Fix preempt_schedule() interrupt
 return comment
In-Reply-To: <73f842f0-b07f-9a6b-cd23-ca3eafad7245@arm.com>
Message-ID: <alpine.DEB.2.21.1906112129340.2214@nanos.tec.linutronix.de>
References: <20190528104848.13160-1-valentin.schneider@arm.com> <20190528104848.13160-2-valentin.schneider@arm.com> <73f842f0-b07f-9a6b-cd23-ca3eafad7245@arm.com>
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

On Tue, 28 May 2019, Valentin Schneider wrote:
> Duh, forgot to cc the relevant folks on this one...

Nevertheless:

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> On 28/05/2019 11:48, Valentin Schneider wrote:
> > preempt_schedule_irq() is the one that should be called on return from
> > interrupt, clean up the comment to avoid any ambiguity.
> > 
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> >  kernel/sched/core.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 874c427742a9..55ebc2cfb08c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3600,9 +3600,8 @@ static void __sched notrace preempt_schedule_common(void)
> >  
> >  #ifdef CONFIG_PREEMPT
> >  /*
> > - * this is the entry point to schedule() from in-kernel preemption
> > - * off of preempt_enable. Kernel preemptions off return from interrupt
> > - * occur there and call schedule directly.
> > + * This is the entry point to schedule() from in-kernel preemption
> > + * off of preempt_enable.
> >   */
> >  asmlinkage __visible void __sched notrace preempt_schedule(void)
> >  {
> > @@ -3673,7 +3672,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
> >  #endif /* CONFIG_PREEMPT */
> >  
> >  /*
> > - * this is the entry point to schedule() from kernel preemption
> > + * This is the entry point to schedule() from kernel preemption
> >   * off of irq context.
> >   * Note, that this is called and return with irqs disabled. This will
> >   * protect us against recursive calling from irq.
> > 
> 
