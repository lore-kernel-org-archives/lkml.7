Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0809EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93CF20644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JmMzddkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfF1MiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:38:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfF1MiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FojrDMPPmqbimK77TYezVK4kRVrgRTN5l96O/2ImwMI=; b=JmMzddkUbEhnT2ek+gUHcvRWv
        5t1OvaVQKIG9pjj6czOKMGxqFBa7R+IFEDTXCE3RqUuUi6hahTdkmrLmWxZ7ruPre7DCTY+VKOzWw
        IzF/VyJFtMqho2QRWVnSSUsAuIJkfYLm8FrDfghiGPWUz29C80lOubuS/9V2lmuAsP6vy2vemIenm
        oepwbbKxoEktwhjlyvXolby5NKaSlo+uHUWdt4yxgMhCMYudzl9Qu4dx81QMA6skh6GltsfgkWVKr
        fjbSqxoDBI05scDRTX2arf6pWFcQr0qg6xLdOJUzVV5SQo3EgPlFbWTC/yun1Oj71RygB8jMcaSVt
        A/wxz8WoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq8h-0000WE-Ka; Fri, 28 Jun 2019 12:38:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BB47201F4619; Fri, 28 Jun 2019 14:38:00 +0200 (CEST)
Date:   Fri, 28 Jun 2019 14:38:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization
 increases
Message-ID: <20190628123800.GS3419@hirez.programming.kicks-ass.net>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628100751.lpcwsouacsi2swkm@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:08:14AM +0100, Patrick Bellasi wrote:
> On 26-Jun 13:40, Vincent Guittot wrote:
> > Hi Patrick,
> > 
> > On Thu, 20 Jun 2019 at 17:06, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > >
> > > The estimated utilization for a task is currently defined based on:
> > >  - enqueued: the utilization value at the end of the last activation
> > >  - ewma:     an exponential moving average which samples are the enqueued values
> > >
> > > According to this definition, when a task suddenly change it's bandwidth
> > > requirements from small to big, the EWMA will need to collect multiple
> > > samples before converging up to track the new big utilization.
> > >
> > > Moreover, after the PELT scale invariance update [1], in the above scenario we
> > > can see that the utilization of the task has a significant drop from the first
> > > big activation to the following one. That's implied by the new "time-scaling"
> > 
> > Could you give us more details about this? I'm not sure to understand
> > what changes between the 1st big activation and the following one ?
> 
> We are after a solution for the problem Douglas Raillard discussed at
> OSPM, specifically the "Task util drop after 1st idle" highlighted in
> slide 6 of his presentation:
> 
>   http://retis.sssup.it/ospm-summit/Downloads/02_05-Douglas_Raillard-How_can_we_make_schedutil_even_more_effective.pdf
> 

So I see the problem, and I don't hate the patch, but I'm still
struggling to understand how exactly it related to the time-scaling
stuff. Afaict the fundamental problem here is layering two averages. The
second (EWMA in our case) will always lag/delay the input of the first
(PELT).

The time-scaling thing might make matters worse, because that helps PELT
ramp up faster, but that is not the primary issue.

Or am I missing something?
