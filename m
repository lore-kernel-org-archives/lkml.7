Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9146C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A853421655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbfG2NRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:17:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43173 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387433AbfG2NRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:17:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so61786473wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3T5zwzzf32/EMpw+oBsnUVI2h6RQdI7LnOERRC7yayA=;
        b=Zj8OYpYCRhvnqKZNcGSoFxGLKe9CPT9SG3G+7tXcQ6dO5AuGbWUim4dOLDn/T4jOWv
         L9si36ErtNWLcv+SbFJ3XH/tzBcc5Q3oSdDxi99gLaPTzSZQunEZdMVSdqzKfWelYlTL
         mkY8WcgLNURyb26Q7llCyRsu8iaTkcKlYXyvPFqdxF7Kb76PUTA2svUxeTY6kn5qPPbl
         GqROFw8E38nu96R440/14/yZIme6pdKeMNPE6R6E1GVXF6B5/1v3x0KK2IC7FgpKK57z
         V0l0c/070NmQcxk3hDZ8omNaeZH5LsUcJfF8M/YDIa12LFszkVtyfbOfI4ygn6ply7Kt
         e7Uw==
X-Gm-Message-State: APjAAAXUU1mvSt0Eg0jQjzVAWi6/xf8CIRlGbunrA5F4WTf+G+QxUszQ
        qluFMbgXEoJfYngM3YO2cWIoKg==
X-Google-Smtp-Source: APXvYqwnZ+N26SDlNfrEqgUI3i3MZOmGTLSWO4BS+fJLA+8beXCNgUUWlkTT0HCgurm5WUJej/Na7A==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr87179767wri.224.1564406224074;
        Mon, 29 Jul 2019 06:17:04 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id m7sm50008378wrx.65.2019.07.29.06.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 06:17:03 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:17:01 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 04/13] sched/{rt,deadline}: Fix set_next_task vs
 pick_next_task
Message-ID: <20190729131701.GB8927@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.579899041@infradead.org>
 <20190729092519.GR25636@localhost.localdomain>
 <20190729111510.GD31398@hirez.programming.kicks-ass.net>
 <20190729112702.GA8927@localhost.localdomain>
 <20190729130438.GE31398@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729130438.GE31398@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 15:04, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 01:27:02PM +0200, Juri Lelli wrote:
> > On 29/07/19 13:15, Peter Zijlstra wrote:
> > > On Mon, Jul 29, 2019 at 11:25:19AM +0200, Juri Lelli wrote:
> > > > Hi,
> > > > 
> > > > On 26/07/19 16:54, Peter Zijlstra wrote:
> > > > > Because pick_next_task() implies set_curr_task() and some of the
> > > > > details haven't matter too much, some of what _should_ be in
> > > > > set_curr_task() ended up in pick_next_task, correct this.
> > > > > 
> > > > > This prepares the way for a pick_next_task() variant that does not
> > > > > affect the current state; allowing remote picking.
> > > > > 
> > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > ---
> > > > >  kernel/sched/deadline.c |   23 ++++++++++++-----------
> > > > >  kernel/sched/rt.c       |   27 ++++++++++++++-------------
> > > > >  2 files changed, 26 insertions(+), 24 deletions(-)
> > > > > 
> > > > > --- a/kernel/sched/deadline.c
> > > > > +++ b/kernel/sched/deadline.c
> > > > > @@ -1694,12 +1694,21 @@ static void start_hrtick_dl(struct rq *r
> > > > >  }
> > > > >  #endif
> > > > >  
> > > > > -static inline void set_next_task(struct rq *rq, struct task_struct *p)
> > > > > +static void set_next_task_dl(struct rq *rq, struct task_struct *p)
> > > > >  {
> > > > >  	p->se.exec_start = rq_clock_task(rq);
> > > > >  
> > > > >  	/* You can't push away the running task */
> > > > >  	dequeue_pushable_dl_task(rq, p);
> > > > > +
> > > > > +	if (hrtick_enabled(rq))
> > > > > +		start_hrtick_dl(rq, p);
> > > > > +
> > > > > +	if (rq->curr->sched_class != &dl_sched_class)
> > > > > +		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> > > > > +
> > > > > +	if (rq->curr != p)
> > > > > +		deadline_queue_push_tasks(rq);
> > > > 
> > > > It's a minor thing, but I was wondering why you added the check on curr.
> > > > deadline_queue_push_tasks() already checks if are there pushable tasks,
> > > > plus curr can still be of a different class at this point?
> > > 
> > > Hmm, so by moving that code into set_next_task() it is exposed to the:
> > > 
> > >   if (queued)
> > >     deuque_task();
> > >   if (running)
> > >     put_prev_task();
> > > 
> > >   /* do stuff */
> > > 
> > >   if (queued)
> > >     enqueue_task();
> > >   if (running)
> > >     set_next_task();
> > > 
> > > patter from core.c; and in that case nothing changes. That said; I
> > > might've gotten it wrong.
> > 
> > Right. But, I was wondering about the __schedule()->pick_next_task()
> > case, where, say, prev (rq->curr) is RT/CFS and next (p) is DEADLINE.
> 
> So we do pick_next_task() first and then set rq->curr (obviously). So
> the first set_next_task() will see rq->curr != p and we'll do the push
> balance stuff.
> 
> Then the above pattern will always see rq->curr == p and we'll not
> trigger push balancing.
> 
> Now, looking at it, this also doesn't do push balancing when we
> re-select the same task, even though we really should be doing it. So I
> suppose not adding the condition, and always doing the push balance,
> while wasteful, is not wrong.

Right, also because deadline_queue_push_tasks() already checks if there
are tasks to potentially push around before queuing the balance
callback.
