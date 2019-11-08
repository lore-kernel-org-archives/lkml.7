Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E22FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A0C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nDl0RKwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391526AbfKHMBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:01:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43250 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390977AbfKHMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LzWFQdxb4LwLZQfLCTEGrcAMyzovJYdVyqlUvic3qgI=; b=nDl0RKwL5GyOZJA56UhKYSZgD
        8a0RbGKX4LEAkfSpM38JDQJ3Hz3Of/dtf9bDDsQhwAU5qb54nvJ7STnjA5o2Kn0002LLK3lsqNEHI
        uBaPoWPOhn1KICAYhsaGpS7uSOE380Xr7Jpv2jLaJ18OTcMTW3Mlp1xDiaIbDRjETkgsf8K3bGy4F
        ClMFX7Kx0z+d0C8PUlohQt7oNYXyCvjm4fjETEjn3rLu4JgL8L6VXd+CBPmnsMy55VsuF20lJNZL4
        yaw5AmIZ6QAwN7kagYCFnxH7g+iUn5FZdSpfu9xlzTpgVJa8+pMkBCwbhXR7Ip7EmVOWCDH031MhG
        GZa9m6KNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT2wP-0001zg-In; Fri, 08 Nov 2019 12:00:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 141053075F0;
        Fri,  8 Nov 2019 12:59:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0755B2025EDB2; Fri,  8 Nov 2019 13:00:35 +0100 (CET)
Date:   Fri, 8 Nov 2019 13:00:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108120034.GK4131@hirez.programming.kicks-ass.net>
References: <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
 <20191108110212.GA204618@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108110212.GA204618@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 11:02:12AM +0000, Quentin Perret wrote:
> On Thursday 07 Nov 2019 at 20:29:07 (+0100), Peter Zijlstra wrote:
> > I still havne't had food, but this here compiles...
> 
> And it seems to work, too :)

Excellent!

> > @@ -3929,13 +3929,17 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  	}
> > 
> >  restart:
> > -	/*
> > -	 * Ensure that we put DL/RT tasks before the pick loop, such that they
> > -	 * can PULL higher prio tasks when we lower the RQ 'priority'.
> > -	 */
> > -	prev->sched_class->put_prev_task(rq, prev, rf);
> > -	if (!rq->nr_running)
> > -		newidle_balance(rq, rf);
> > +#ifdef CONFIG_SMP
> > +	for (class = prev->sched_class;
> > +	     class != &idle_sched_class;
> > +	     class = class->next) {
> > +
> > +		if (class->balance(rq, prev, rf))
> > +			break;
> > +	}
> > +#endif
> > +
> > +	put_prev_task(rq, prev);
> 
> Right, that looks much cleaner IMO. I'm thinking if we killed the
> special case for CFS above we could do with a single loop to iterate the
> classes, and you could fold ->balance() in ->pick_next_task() ...

No, you can't, because then you're back to having to restart the pick
when something happens when we drop the rq halfway down the pick.  Which
is something I really wanted to get rid of.

> That would remove one call site to newidle_balance() too, which I think
> is good. Hackbench probably won't like that, though.

Yeah, that fast path really is important. I've got a few patches pending
there, fixing a few things and that gets me 2% extra on a sched-yield
benchmark.

> > +static int balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > +{
> > +	if (rq->cfs.nr_running)

FWIW that must test rq->nr_running.

> > +		return 1;
> > +
> > +	return newidle_balance(rq, rf) != 0;
> 
> And you can ignore the RETRY_TASK case here under the assumption that
> we must have tried to pull from RT/DL before ending up here ?

Well, the balance callback can always return 0 and be correct. The point
is mostly to avoid more work.

In this case, since fair is the last class and we've already excluded
idle for balancing, the win is minimal. But since we have the code,
might as well dtrt.
