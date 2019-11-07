Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A7CC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B956A214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389643AbfKGQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:09:24 -0500
Received: from foss.arm.com ([217.140.110.172]:58618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389580AbfKGQJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:09:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB77B30E;
        Thu,  7 Nov 2019 08:09:21 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720B03F71A;
        Thu,  7 Nov 2019 08:09:19 -0800 (PST)
Date:   Thu, 7 Nov 2019 16:09:17 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107160916.tf2hnho57ob6bm5n@e107158-lin.cambridge.arm.com>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/19 14:26, Peter Zijlstra wrote:
> On Thu, Nov 07, 2019 at 11:36:50AM +0300, Kirill Tkhai wrote:
> > On 06.11.2019 20:27, Peter Zijlstra wrote:
> > > On Wed, Nov 06, 2019 at 05:54:37PM +0100, Peter Zijlstra wrote:
> > >> On Wed, Nov 06, 2019 at 06:51:40PM +0300, Kirill Tkhai wrote:
> > >>>> +#ifdef CONFIG_SMP
> > >>>> +	if (!rq->nr_running) {
> > >>>> +		/*
> > >>>> +		 * Make sure task_on_rq_curr() fails, such that we don't do
> > >>>> +		 * put_prev_task() + set_next_task() on this task again.
> > >>>> +		 */
> > >>>> +		prev->on_cpu = 2;
> > >>>>  		newidle_balance(rq, rf);
> > >>>
> > >>> Shouldn't we restore prev->on_cpu = 1 after newidle_balance()? Can't prev
> > >>> become pickable again after newidle_balance() releases rq->lock, and we
> > >>> take it again, so this on_cpu == 2 never will be cleared?
> > >>
> > >> Indeed so.
> > > 
> > > Oh wait, the way it was written this is not possible. Because
> > > rq->nr_running == 0 and prev->on_cpu > 0 it means the current task is
> > > going to sleep and cannot be woken back up.
> > 
> > I mostly mean throttling. AFAIR, tasks of throttled rt_rq are not accounted
> > in rq->nr_running. But it seems rt_rq may become unthrottled again after
> > newidle_balance() unlocks rq lock, and prev will become pickable again.
> 
> Urgh... throttling.
> 
> Bah.. I had just named the "->on_cpu = 2" thing leave_task(), to match
> prepare_task() and finish_task(), but when we have to flip it back to 1
> that doesn't really work.
> 
> Also, I'm still flip-flopping on where to place it. Yesterday I
> suggested placing it before put_prev_task(), but then I went to write a
> comment, and either way around put_prev_task() needs to be very careful.
> 
> So I went back to placing it after and putting lots of comments on.
> 
> How does the below look?

This looks good to me. But it makes me wonder, if there's no penalty to adding
the leave_task() before put_prev_task(), and if it results on relaxing the
requirement of 'no permanent state change before releasing the rq lock',
shouldn't we just do it?

Anyways. I'll pick this version and spin it through my reproducer.

Thanks for fixing this!

--
Qais Yousef
