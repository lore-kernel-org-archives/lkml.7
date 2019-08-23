Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA40C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCB921019
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404857AbfHWSDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:03:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404603AbfHWSDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:03:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE14D3082231;
        Fri, 23 Aug 2019 18:03:44 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E12600C1;
        Fri, 23 Aug 2019 18:03:44 +0000 (UTC)
Date:   Fri, 23 Aug 2019 14:03:42 -0400
From:   Phil Auld <pauld@redhat.com>
To:     bsegall@google.com
Cc:     Dave Chiluk <chiluk+linux@indeed.com>, Qian Cai <cai@lca.pw>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable
 warnings
Message-ID: <20190823180342.GC14209@pauld.bos.csb>
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
 <xm26tvaaifoy.fsf@bsegall-linux.svl.corp.google.com>
 <CAC=E7cWYSEAjUhgN5vBECmR5ATXWmt4M7n8sNN0xXStEsb4YjA@mail.gmail.com>
 <xm26h867iyfx.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26h867iyfx.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 23 Aug 2019 18:03:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:28:02AM -0700 bsegall@google.com wrote:
> Dave Chiluk <chiluk+linux@indeed.com> writes:
> 
> > On Wed, Aug 21, 2019 at 12:36 PM <bsegall@google.com> wrote:
> >>
> >> Qian Cai <cai@lca.pw> writes:
> >>
> >> > The linux-next commit "sched/fair: Fix low cpu usage with high
> >> > throttling by removing expiration of cpu-local slices" [1] introduced a
> >> > few compilation warnings,
> >> >
> >> > kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
> >> > kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
> >> > [-Wunused-but-set-variable]
> >> > kernel/sched/fair.c: In function 'start_cfs_bandwidth':
> >> > kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
> >> > [-Wunused-but-set-variable]
> >> >
> >> > Also, __refill_cfs_bandwidth_runtime() does no longer update the
> >> > expiration time, so fix the comments accordingly.
> >> >
> >> > [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux@indeed.com/
> >> >
> >> > Signed-off-by: Qian Cai <cai@lca.pw>
> >>
> >> Reviewed-by: Ben Segall <bsegall@google.com>
> >>
> >> > ---
> >> >
> >> > v2: Keep hrtimer_forward_now() in start_cfs_bandwidth() per Ben.
> >> >
> >> >  kernel/sched/fair.c | 19 ++++++-------------
> >> >  1 file changed, 6 insertions(+), 13 deletions(-)
> >> >
> >> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> > index 84959d3285d1..06782491691f 100644
> >> > --- a/kernel/sched/fair.c
> >> > +++ b/kernel/sched/fair.c
> >> > @@ -4354,21 +4354,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
> >> >  }
> >> >
> >> >  /*
> >> > - * Replenish runtime according to assigned quota and update expiration time.
> >> > - * We use sched_clock_cpu directly instead of rq->clock to avoid adding
> >> > - * additional synchronization around rq->lock.
> >> > + * Replenish runtime according to assigned quota. We use sched_clock_cpu
> >> > + * directly instead of rq->clock to avoid adding additional synchronization
> >> > + * around rq->lock.
> >> >   *
> >> >   * requires cfs_b->lock
> >> >   */
> >> >  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
> >> >  {
> >> > -     u64 now;
> >> > -
> >> > -     if (cfs_b->quota == RUNTIME_INF)
> >> > -             return;
> >> > -
> >> > -     now = sched_clock_cpu(smp_processor_id());
> >> > -     cfs_b->runtime = cfs_b->quota;
> >> > +     if (cfs_b->quota != RUNTIME_INF)
> >> > +             cfs_b->runtime = cfs_b->quota;
> >> >  }
> >> >
> >> >  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> >> > @@ -4989,15 +4984,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> >> >
> >> >  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >> >  {
> >> > -     u64 overrun;
> >> > -
> >> >       lockdep_assert_held(&cfs_b->lock);
> >> >
> >> >       if (cfs_b->period_active)
> >> >               return;
> >> >
> >> >       cfs_b->period_active = 1;
> >> > -     overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> >> > +     hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> >> >       hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> >> >  }
> >
> > Looks good.
> > Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
> >
> > Sorry for the slow response, I was on vacation.
> >
> > @Ben do you think it would be useful to still capture overrun, and
> > WARN on any overruns?  We wouldn't expect overruns, but their
> > existence would indicate an over-loaded node or too short of a
> > cfs_period.  Additionally, it would be interesting to see if we could
> > capture the offset between when the bandwidth was refilled, and when
> > the timer was supposed to fire.  I've always done all my calculations
> > assuming that the timer fires and is handled exceedingly close to the
> > time it was supposed to fire.  Although, if the node is running that
> > overloaded you probably have many more problems than worrying about
> > timer warnings.
> 
> That "overrun" there is not really an overrun - it's the number of
> complete periods the timer has been inactive for. It was used so that a
> given tg's period timer would keep the same
> phase/offset/whatever-you-call-it, even if it goes idle for a while,
> rather than having the next period start N ms after a task wakes up.
> 
> Also, poor choices by userspace is not generally something the kernel
> generally WARNs on, as I understand it.

I don't think it matters in the start_cfs_bandwidth case, anyway. We do 
effectively check in sched_cfs_period_timer. 

Cleanup looks okay to me as well.


Cheers,
Phil

-- 
