Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D524C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5915F276B0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfFCQKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfFCQKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:10:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38B0731628E3;
        Mon,  3 Jun 2019 16:10:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0B0785D6A9;
        Mon,  3 Jun 2019 16:09:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  3 Jun 2019 18:09:58 +0200 (CEST)
Date:   Mon, 3 Jun 2019 18:09:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, hch@lst.de, gkohli@codeaurora.org,
        mingo@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190603160953.GA15244@redhat.com>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <20190603124401.GB3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603124401.GB3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 03 Jun 2019 16:10:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03, Peter Zijlstra wrote:
>
> It now also has concurrency on wakeup; but afaict that's harmless, we'll
> get racing stores of p->state = TASK_RUNNING, much the same as if there
> was a remote wakeup vs a wait-loop terminating early.
>
> I suppose the tracepoint consumers might have to deal with some
> artifacts there, but that's their problem.

I guess you mean that trace_sched_waking/wakeup can be reported twice if
try_to_wake_up(current) races with ttwu_remote(). And ttwu_stat().

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1990,6 +1990,28 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	unsigned long flags;
> >  	int cpu, success = 0;
> >  
> > +	if (p == current) {
> > +		/*
> > +		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
> > +		 * == smp_processor_id()'. Together this means we can special
> > +		 * case the whole 'p->on_rq && ttwu_remote()' case below
> > +		 * without taking any locks.
> > +		 *
> > +		 * In particular:
> > +		 *  - we rely on Program-Order guarantees for all the ordering,
> > +		 *  - we're serialized against set_special_state() by virtue of
> > +		 *    it disabling IRQs (this allows not taking ->pi_lock).
> > +		 */
> > +		if (!(p->state & state))
> > +			goto out;
> > +
> > +		success = 1;
> > +		trace_sched_waking(p);
> > +		p->state = TASK_RUNNING;
> > +		trace_sched_woken(p);
                ^^^^^^^^^^^^^^^^^
trace_sched_wakeup(p) ?

I see nothing wrong... but probably this is because I don't fully understand
this change. In particular, I don't really understand who else can benefit from
this optimization...

Oleg.

