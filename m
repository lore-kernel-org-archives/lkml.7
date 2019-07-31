Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C37206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfGaUVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:21:01 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:34075 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:21:00 -0400
Received: from [151.41.39.6] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 141248120; Wed, 31 Jul 2019 22:20:56 +0200
Date:   Wed, 31 Jul 2019 22:20:46 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
Message-ID: <20190731222046.5ff83259@sweethome>
In-Reply-To: <c93f6c12-b804-99da-7e38-bbaf55fe7a1b@arm.com>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
        <20190726082756.5525-5-dietmar.eggemann@arm.com>
        <20190729164932.GN31398@hirez.programming.kicks-ass.net>
        <20190730064115.GC8927@localhost.localdomain>
        <20190730082108.GJ31381@hirez.programming.kicks-ass.net>
        <c93f6c12-b804-99da-7e38-bbaf55fe7a1b@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 18:32:47 +0100
Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
[...]
> >>>>  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
> >>>>  {
> >>>> +	if (!on_dl_rq(dl_se))
> >>>> +		return;  
> >>>
> >>> Why allow double dequeue instead of WARN?  
> >>
> >> As I was saying to Valentin, it can currently happen that a task
> >> could have already been dequeued by update_curr_dl()->throttle
> >> called by dequeue_task_dl() before calling __dequeue_task_dl(). Do
> >> you think we should check for this condition before calling into
> >> dequeue_dl_entity()?  
> > 
> > Yes, that's what ->dl_throttled is for, right? And !->dl_throttled
> > && !on_dl_rq() is a BUG.  
> 
> OK, I will add the following snippet to the patch.
> Although it's easy to provoke a situation in which DL tasks are
> throttled, I haven't seen a throttling happening when the task is
> being dequeued.

This is a not-so-common situation, that can happen with periodic tasks
(a-la rt-app) blocking on clock_nanosleep() (or similar) after
executing for an amount of time comparable with the SCHED_DEADLINE
runtime.

It might happen that the task consumed a little bit more than the
remaining runtime (but has not been throttled yet, because the
accounting happens at every tick)... So, when dequeue_task_dl() invokes
update_task_dl() the runtime becomes negative and the task is throttled.

This happens infrequently, but if you try rt-app tasksets with multiple
tasks and execution times near to the runtime you will see it
happening, sooner or later.


[...]
> @@ -1592,6 +1591,10 @@ static void __dequeue_task_dl(struct rq *rq,
> struct task_struct *p) static void dequeue_task_dl(struct rq *rq,
> struct task_struct *p, int flags) {
>         update_curr_dl(rq);
> +
> +       if (p->dl.dl_throttled)
> +               return;

Sorry, I missed part of the previous discussion, so maybe I am missing
something... But I suspect this "return" might be wrong (you risk to
miss a call to task_non_contending(), coming later in this function).

Maybe you cound use
	if (!p->dl_throttled)
		__dequeue_task_dl(rq, p)

Or did I misunderstand something?



			Thanks,
				Luca
