Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9352C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41D0206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbfG2L1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:27:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42923 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387664AbfG2L1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:27:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so11517440wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XY9MnmnbN3bR4WP4q1Vs7UayuQZkuHXaeJmGe0r/6yw=;
        b=XeA2XRTsnDiUkSjB8bCe8Zqi8r2puQr83xDNS2z/n7AKZncRLoQcsDdyg9xEl523JI
         5lzcK5NxkiCwuNC39bsGji7PxoV1iqAZ9q5Fj80acoBQ8T45aya8VCk8sU93kI7gRS96
         w5N/FdDNrAp8JVfifPy6Cd+L0/gfygNHgaOubW9K/t0YLuLfF9TvpuIBPCSOn44YmLif
         5a3nXC4rXZKqGb4Ed8fIGU9AjjJsU9CbS1JDj2EbLtQYQpBiC8/mlQ9TyE8rEpkPFEFv
         WJEkhRprp2atmHG6CQdbuzYhzwYS5nDPzQE8oU42Uw77sWN522KiXHQOpjHudCC1zVbV
         tvgA==
X-Gm-Message-State: APjAAAW8l7dPTMAYxIfTCFa2Jn3O3JrEkyZd6VtzQFsLquZO4qgn6D1l
        /VhHPqd7AlQlGewdhuDawm0sWQ==
X-Google-Smtp-Source: APXvYqy37KzTziTHSZm+RtNAM7/AEf2dZOKvrB2ThYc3rZPvpWRBF3G4cnA6pdkbGbsQuSRbXji5/w==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr120094209wrq.143.1564399625253;
        Mon, 29 Jul 2019 04:27:05 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id p18sm60039427wrm.16.2019.07.29.04.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 04:27:04 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:27:02 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 04/13] sched/{rt,deadline}: Fix set_next_task vs
 pick_next_task
Message-ID: <20190729112702.GA8927@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.579899041@infradead.org>
 <20190729092519.GR25636@localhost.localdomain>
 <20190729111510.GD31398@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729111510.GD31398@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:15, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 11:25:19AM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 26/07/19 16:54, Peter Zijlstra wrote:
> > > Because pick_next_task() implies set_curr_task() and some of the
> > > details haven't matter too much, some of what _should_ be in
> > > set_curr_task() ended up in pick_next_task, correct this.
> > > 
> > > This prepares the way for a pick_next_task() variant that does not
> > > affect the current state; allowing remote picking.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/sched/deadline.c |   23 ++++++++++++-----------
> > >  kernel/sched/rt.c       |   27 ++++++++++++++-------------
> > >  2 files changed, 26 insertions(+), 24 deletions(-)
> > > 
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1694,12 +1694,21 @@ static void start_hrtick_dl(struct rq *r
> > >  }
> > >  #endif
> > >  
> > > -static inline void set_next_task(struct rq *rq, struct task_struct *p)
> > > +static void set_next_task_dl(struct rq *rq, struct task_struct *p)
> > >  {
> > >  	p->se.exec_start = rq_clock_task(rq);
> > >  
> > >  	/* You can't push away the running task */
> > >  	dequeue_pushable_dl_task(rq, p);
> > > +
> > > +	if (hrtick_enabled(rq))
> > > +		start_hrtick_dl(rq, p);
> > > +
> > > +	if (rq->curr->sched_class != &dl_sched_class)
> > > +		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> > > +
> > > +	if (rq->curr != p)
> > > +		deadline_queue_push_tasks(rq);
> > 
> > It's a minor thing, but I was wondering why you added the check on curr.
> > deadline_queue_push_tasks() already checks if are there pushable tasks,
> > plus curr can still be of a different class at this point?
> 
> Hmm, so by moving that code into set_next_task() it is exposed to the:
> 
>   if (queued)
>     deuque_task();
>   if (running)
>     put_prev_task();
> 
>   /* do stuff */
> 
>   if (queued)
>     enqueue_task();
>   if (running)
>     set_next_task();
> 
> patter from core.c; and in that case nothing changes. That said; I
> might've gotten it wrong.

Right. But, I was wondering about the __schedule()->pick_next_task()
case, where, say, prev (rq->curr) is RT/CFS and next (p) is DEADLINE.
