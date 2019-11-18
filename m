Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56104C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKRP1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:27:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:37566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbfKRP1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:27:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22DD6AE55;
        Mon, 18 Nov 2019 15:27:39 +0000 (UTC)
Date:   Mon, 18 Nov 2019 16:27:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
Message-ID: <20191118152738.az364dczadskgimc@pathway.suse.cz>
References: <20190904061501.GB3838@dhcp22.suse.cz>
 <20190904064144.GA5487@jagdpanzerIV>
 <20190904065455.GE3838@dhcp22.suse.cz>
 <20190904071911.GB11968@jagdpanzerIV>
 <20190904074312.GA25744@jagdpanzerIV>
 <1567599263.5576.72.camel@lca.pw>
 <20190904144850.GA8296@tigerII.localdomain>
 <1567629737.5576.87.camel@lca.pw>
 <20190905113208.GA521@jagdpanzerIV>
 <1573751570.5937.122.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573751570.5937.122.camel@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-14 12:12:50, Qian Cai wrote:
> On Thu, 2019-09-05 at 20:32 +0900, Sergey Senozhatsky wrote:
> > On (09/04/19 16:42), Qian Cai wrote:
> > > > Let me think more.
> > > 
> > > To summary, those look to me are all good long-term improvement that would
> > > reduce the likelihood of this kind of livelock in general especially for other
> > > unknown allocations that happen while processing softirqs, but it is still up to
> > > the air if it fixes it 100% in all situations as printk() is going to take more
> > > time
> > 
> > Well. So. I guess that we don't need irq_work most of the time.
> > 
> > We need to queue irq_work for "safe" wake_up_interruptible(), when we
> > know that we can deadlock in scheduler. IOW, only when we are invoked
> > from the scheduler. Scheduler has printk_deferred(), which tells printk()
> > that it cannot do wake_up_interruptible(). Otherwise we can just use
> > normal wake_up_process() and don't need that irq_work->wake_up_interruptible()
> > indirection. The parts of the scheduler, which by mistake call plain printk()
> > from under pi_lock or rq_lock have chances to deadlock anyway and should
> > be switched to printk_deferred().
> > 
> > I think we can queue significantly much less irq_work-s from printk().
> > 
> > Petr, Steven, what do you think?
> 
> Sergey, do you still plan to get this patch merged?
> 
> > 
> > Something like this. Call wake_up_interruptible(), switch to
> > wake_up_klogd() only when called from sched code.
> > 
> > ---
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index cd51aa7d08a9..89cb47882254 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2027,8 +2027,11 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  	pending_output = (curr_log_seq != log_next_seq);
> >  	logbuf_unlock_irqrestore(flags);
> >  
> > +	if (!pending_output)
> > +		return printed_len;
> > +
> >  	/* If called from the scheduler, we can not call up(). */
> > -	if (!in_sched && pending_output) {
> > +	if (!in_sched) {
> >  		/*
> >  		 * Disable preemption to avoid being preempted while holding
> >  		 * console_sem which would prevent anyone from printing to
> > @@ -2043,10 +2046,11 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  		if (console_trylock_spinning())
> >  			console_unlock();
> >  		preempt_enable();
> > -	}
> >  
> > -	if (pending_output)
> > +		wake_up_interruptible(&log_wait);

I do not like this. As a result, normal printk() will always deadlock
in the scheduler code, including WARN() calls. The chance of the
deadlock is small now. It happens only when there is another
process waiting for console_sem.

We want to remove locks from printk() and not add them.

Best Regards,
Petr
