Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C4C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6700B2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxK80YoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgAGQAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:00:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43674 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgAGQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:00:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so67015lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5IGKqgnnqHj2l5aFpISL9b2AZ+28RDzzoNGsHjiypA=;
        b=RxK80YoGgCKJzRzKDOZCCZlyvJ0AzC4vc1fmXE+EmdXarFZ6oOXSY7NjRykxTDRoPo
         hTqOctU+iKEpI+aGO/tOUb7JS6AiJHiMjBiiMHgZqqpuqguw/+oUyDhctYhZguJ8IJgL
         /bH6EvUoI1biGO9sPtz3X2v/UfaM7l0aEozfaLhzqp36vSamvA+ZMIs/0YOEwbmBGmLx
         4NtR/qKtwwQbnic+lX1mQyPnBVSMjXNAlNki6fDoG+HjQ3+mB3suNZPhjUeBWAfNGF+u
         KCJYtxGGuMHDy1Pp9s/IhrpoJLRKcVHDPbry7Le8pM31t+gIit/w5IHHgHeNb8Ngg++e
         9sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5IGKqgnnqHj2l5aFpISL9b2AZ+28RDzzoNGsHjiypA=;
        b=Qzu87rOYbi8wi5EqVgawKySJ4MTgrf7vVlr0udkdyXtW4JZBq3mXC/lYSbmdkV0huB
         r2GVhtEHZqav75ebFAyzwEQY6L+1qgtM9nz07jJ1mcTgofL/vBytioJeK4rAPo/Uy073
         yxe/qSMmmxceOo9RNB/ZXEPh817Vc9YTt3kZ8vBFZsocHFacGEp/IrdfZPqHV8DfslE9
         xz+fZ+k+mCiFQl143rbJ4mHvQ8lKkEuK2YQttvXbVMSK3BoUrKIk+t9DO1U+WYUsaLlc
         kW6CaBWKRD76QrIURjF3bTlJ/yu03ghtzZfL1m1LZ9xzqEhWE7VHgKPEbBobBedxydct
         QJgw==
X-Gm-Message-State: APjAAAXP9dpc93FaPPk6Vvav8QXh5k7RMCFoVKq+mELAIMyRWAP4rarA
        7zr0+4jgE79WFDDNGBNZ4y3hiZDFmC14zQVk6qffZg==
X-Google-Smtp-Source: APXvYqwh6r4ZT1gmuB4kDBHibCAmORzXwEFYl++P2qh/I8n6DOrgDh3MObKp/7emtrKEOWWoCP/x3nD4JWM6pScQrI8=
X-Received: by 2002:a19:c80a:: with SMTP id y10mr80643lff.177.1578412842021;
 Tue, 07 Jan 2020 08:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20191220084252.GL3178@techsingularity.net> <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net> <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net> <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net> <CAKfTPtAtJSWGPC1t+0xj_Daid0fZaWnN+b53WQ_a1-Js5fJ6sg@mail.gmail.com>
 <20200107115646.GI3466@techsingularity.net>
In-Reply-To: <20200107115646.GI3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jan 2020 17:00:29 +0100
Message-ID: <CAKfTPtAacdmxniM9yZUrQPW39LAvhpBQt6ZiGiwk5qpEx7zicA@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 busiest->group_weight * (env->sd->imbalance_pct - 100) / 100;

On Tue, 7 Jan 2020 at 12:56, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Jan 07, 2020 at 12:17:12PM +0100, Vincent Guittot wrote:
> > On Tue, 7 Jan 2020 at 10:56, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 09:38:26AM +0100, Vincent Guittot wrote:
> > > > > > This looks weird to me because you use imbalance_pct, which is
> > > > > > meaningful only compare a ratio, to define a number that will be then
> > > > > > compared to a number of tasks without taking into account the weight
> > > > > > of the node. So whatever the node size, 32 or 128 CPUs, the
> > > > > > imbalance_adj will be the same: 3 with the default imbalance_pct of
> > > > > > NUMA level which is 125 AFAICT
> > > > > >
> > > > >
> > > > > The intent in this version was to only cover the low utilisation case
> > > > > regardless of the NUMA node size. There were too many corner cases
> > > > > where the tradeoff of local memory latency versus local memory bandwidth
> > > > > cannot be quantified. See Srikar's report as an example but it's a general
> > > > > problem. The use of imbalance_pct was simply to find the smallest number of
> > > > > running tasks were (imbalance_pct - 100) would be 1 running task and limit
> > > >
> > > > But using imbalance_pct alone doesn't mean anything.
> > >
> > > Other than figuring out "how many running tasks are required before
> > > imbalance_pct is roughly equivalent to one fully active CPU?". Even then,
> >
> > sorry, I don't see how you deduct this from only using imbalance_pct
> > which is mainly there to say how much percent of difference is
> > significant
> >
>
> Because if the difference is 25% then 1 CPU out of 4 active is enough
> for imbalance_pct to potentially be a factor. Anyway, the approach seems
> almost universally disliked so even if I had reasons for not scaling
> this by the group_weight, no one appears to agree with them :P
>
> > > it's a bit weak as imbalance_pct makes hard-coded assumptions on what
> > > the tradeoff of cross-domain migration is without considering the hardware.
> > >
> > > > Using similar to the below
> > > >
> > > >     busiest->group_weight * (env->sd->imbalance_pct - 100) / 100
> > > >
> > > > would be more meaningful
> > > >
> > >
> > > It's meaningful to some sense from a conceptual point of view but
> > > setting the low utilisation cutoff depending on the number of CPUs on
> > > the node does not account for any local memory latency vs bandwidth.
> > > i.e. on a small or mid-range machine the cutoff will make sense. On
> > > larger machines, the cutoff could be at the point where memory bandwidth
> > > is saturated leading to a scenario whereby upgrading to a larger
> > > machine performs worse than the smaller machine.
> > >
> > > Much more importantly, doing what you suggest allows an imbalance
> > > of more CPUs than are backed by a single LLC. On high-end AMD EPYC 2
> > > machines, busiest->group_weight scaled by imbalance_pct spans multiple L3
> > > caches. That is going to have side-effects. While I also do not account
> > > for the LLC group_weight, it's unlikely the cut-off I used would be
> > > smaller than an LLC cache on a large machine as the cache.
> > >
> > > These two points are why I didn't take the group weight into account.
> > >
> > > Now if you want, I can do what you suggest anyway as long as you are happy
> > > that the child domain weight is also taken into account and to bound the
> >
> > Taking into account child domain makes sense to me, but shouldn't we
> > take into account the number of child group instead ? This should
> > reflect the number of different LLC caches.
>
> I guess it would but why is it inherently better? The number of domains
> would yield a similar result if we assume that all the lower domains
> have equal weight so it simply because the weight of the SD_NUMA domain
> divided by the number of child domains.

but that's not what you are doing in your proposal. You are using
directly child->span_weight which reflects the number of CPUs in the
child and not the number of group

you should do something like  sds->busiest->span_weight /
sds->busiest->child->span_weight which gives you an approximation of
the number of independent group inside the busiest numa node from a
shared resource pov

>
> Now, I could be missing something with asymmetric setups. I don't know
> if it's possible for child domains of a NUMA domain to have different
> sizes. I would be somewhat surprised if they did but I also do not work
> on such machines nor have I ever accessed one (to my knowledge).
>
> > IIUC your reasoning, we want to make sure that tasks will not start to
> > fight for using same resources which is the connection between LLC
> > cache and memory in this case
> >
>
> Yep. I don't want a case where the allowed imbalance causes the load
> balancer to have to balance between the lower domains. *Maybe* that is
> actually better in some cases but it's far from intuitive so I would
> prefer that change would be a patch on its own with a big fat comment
> explaining the reasoning behind the additional complexity.
>
> > > largest possible allowed imbalance to deal with the case of a node having
> > > multiple small LLC caches. That means that some machines will be using the
> > > size of the node and some machines will use the size of an LLC. It's less
> > > predictable overall as some machines will be "special" relative to others
> > > making it harder to reproduce certain problems locally but it would take
> > > imbalance_pct into account in a way that you're happy with.
> > >
> > > Also bear in mind that whether LLC is accounted for or not, the final
> > > result should be halved similar to the other imbalance calculations to
> > > avoid over or under load balancing.
> > >
> > > > Or you could use the util_avg so you will take into account if the
> > > > tasks are short running ones or long running ones
> > > >
> > >
> > > util_avg can be skewed if there are big outliers. Even then, it's not
> > > a great metric for the low utilisation cutoff. Large numbers of mostly
> > > idle but running tasks would be treated similarly to small numbers of
> > > fully active tasks. It's less predictable and harder to reason about how
> >
> > Yes but this also have the advantage of reflecting more accurately how
> > the system is used.
> > with nr_running, we consider that mostly idle and fully active tasks
> > will have the exact same impact on the memory
> >
>
> Maybe, maybe not. When there is spare capacity in the domain overall and
> we are only interested in the low utilisation case, it seems to me that
> we should consider the most obvious and understandable metric. Now, if we
> were talking about a nearly fully loaded domain or an overloaded domain
> then I would fully agree with you as balancing utilisation in that case
> becomes critical.
>
> > > load balancing behaves across a variety of workloads.
> > >
> > > Based on what you suggest, the result looks like this (build tested
> > > only)
> >
> > I'm going to make a try of this patch
> >
>
> Thanks. I've queued the same patch on one machine to see what falls out.
> I don't want to tie up half my test grid until we get some sort of
> consensus.
>
> --
> Mel Gorman
> SUSE Labs
