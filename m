Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8299C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AD720856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfETNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:05:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbfETNFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:05:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5622A7FDFE;
        Mon, 20 May 2019 13:04:59 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B775DE81;
        Mon, 20 May 2019 13:04:56 +0000 (UTC)
Date:   Mon, 20 May 2019 09:04:54 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 13/17] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190520130454.GA677@pauld.bos.csb>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtZo0BQg_u9ZPNY_Rk2JY4YT8d5NDRKFQMWeYyAviVShA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrtZo0BQg_u9ZPNY_Rk2JY4YT8d5NDRKFQMWeYyAviVShA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 20 May 2019 13:04:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 11:37:56PM +0800 Aubrey Li wrote:
> On Wed, Apr 24, 2019 at 12:18 AM Vineeth Remanan Pillai
> <vpillai@digitalocean.com> wrote:
> >
> > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Instead of only selecting a local task, select a task for all SMT
> > siblings for every reschedule on the core (irrespective which logical
> > CPU does the reschedule).
> >
> > NOTE: there is still potential for siblings rivalry.
> > NOTE: this is far too complicated; but thus far I've failed to
> >       simplify it further.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/core.c  | 222 ++++++++++++++++++++++++++++++++++++++++++-
> >  kernel/sched/sched.h |   5 +-
> >  2 files changed, 224 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index e5bdc1c4d8d7..9e6e90c6f9b9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3574,7 +3574,7 @@ static inline void schedule_debug(struct task_struct *prev)
> >   * Pick up the highest-prio task:
> >   */
> >  static inline struct task_struct *
> > -pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > +__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  {
> >         const struct sched_class *class;
> >         struct task_struct *p;
> > @@ -3619,6 +3619,220 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >         BUG();
> >  }
> >
> > +#ifdef CONFIG_SCHED_CORE
> > +
> > +static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
> > +{
> > +       if (is_idle_task(a) || is_idle_task(b))
> > +               return true;
> > +
> > +       return a->core_cookie == b->core_cookie;
> > +}
> > +
> > +// XXX fairness/fwd progress conditions
> > +static struct task_struct *
> > +pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
> > +{
> > +       struct task_struct *class_pick, *cookie_pick;
> > +       unsigned long cookie = 0UL;
> > +
> > +       /*
> > +        * We must not rely on rq->core->core_cookie here, because we fail to reset
> > +        * rq->core->core_cookie on new picks, such that we can detect if we need
> > +        * to do single vs multi rq task selection.
> > +        */
> > +
> > +       if (max && max->core_cookie) {
> > +               WARN_ON_ONCE(rq->core->core_cookie != max->core_cookie);
> > +               cookie = max->core_cookie;
> > +       }
> > +
> > +       class_pick = class->pick_task(rq);
> > +       if (!cookie)
> > +               return class_pick;
> > +
> > +       cookie_pick = sched_core_find(rq, cookie);
> > +       if (!class_pick)
> > +               return cookie_pick;
> > +
> > +       /*
> > +        * If class > max && class > cookie, it is the highest priority task on
> > +        * the core (so far) and it must be selected, otherwise we must go with
> > +        * the cookie pick in order to satisfy the constraint.
> > +        */
> > +       if (cpu_prio_less(cookie_pick, class_pick) && core_prio_less(max, class_pick))
> > +               return class_pick;
> > +
> > +       return cookie_pick;
> > +}
> > +
> > +static struct task_struct *
> > +pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > +{
> > +       struct task_struct *next, *max = NULL;
> > +       const struct sched_class *class;
> > +       const struct cpumask *smt_mask;
> > +       int i, j, cpu;
> > +
> > +       if (!sched_core_enabled(rq))
> > +               return __pick_next_task(rq, prev, rf);
> > +
> > +       /*
> > +        * If there were no {en,de}queues since we picked (IOW, the task
> > +        * pointers are all still valid), and we haven't scheduled the last
> > +        * pick yet, do so now.
> > +        */
> > +       if (rq->core->core_pick_seq == rq->core->core_task_seq &&
> > +           rq->core->core_pick_seq != rq->core_sched_seq) {
> > +               WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
> > +
> > +               next = rq->core_pick;
> > +               if (next != prev) {
> > +                       put_prev_task(rq, prev);
> > +                       set_next_task(rq, next);
> > +               }
> > +               return next;
> > +       }
> > +
> 
> The following patch improved my test cases.
> Welcome any comments.
> 

This is certainly better than violating the point of the core scheduler :)

If I'm understanding this right what will happen in this case is instead
of using the idle process selected by the sibling we do the core scheduling
again. This may start with a newidle_balance which might bring over something
to run that matches what we want to put on the sibling. If that works then I 
can see this helping. 

But I'd be a little concerned that we could end up thrashing. Once we do core 
scheduling again here we'd force the sibling to resched and if we got a different 
result which "helped" him pick idle we'd go around again.  

I think inherent in the concept of core scheduling (barring a perfectly aligned set 
of jobs) is some extra idle time on siblings. 



Cheers,
Phil



> Thanks,
> -Aubrey
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3e3162f..86031f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3685,10 +3685,12 @@ pick_next_task(struct rq *rq, struct
> task_struct *prev, struct rq_flags *rf)
>         /*
>          * If there were no {en,de}queues since we picked (IOW, the task
>          * pointers are all still valid), and we haven't scheduled the last
> -        * pick yet, do so now.
> +        * pick yet, do so now. If the last pick is idle task, we abandon
> +        * last pick and try to pick up task this time.
>          */
>         if (rq->core->core_pick_seq == rq->core->core_task_seq &&
> -           rq->core->core_pick_seq != rq->core_sched_seq) {
> +           rq->core->core_pick_seq != rq->core_sched_seq &&
> +           !is_idle_task(rq->core_pick)) {
>                 WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
> 
>                 next = rq->core_pick;

-- 
