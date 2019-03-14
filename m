Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F847C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5242087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCNLS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:18:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42528 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCNLSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:18:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04DA380D;
        Thu, 14 Mar 2019 04:18:55 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9A93F71D;
        Thu, 14 Mar 2019 04:18:51 -0700 (PDT)
Date:   Thu, 14 Mar 2019 11:18:49 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314111849.gx6bl6myfjtaan7r@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313135238.GC5922@hirez.programming.kicks-ass.net>
 <20190313155954.jse2tyn5iqxm6wle@e110439-lin>
 <20190313193916.GQ2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313193916.GQ2482@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar 20:39, Peter Zijlstra wrote:
> On Wed, Mar 13, 2019 at 03:59:54PM +0000, Patrick Bellasi wrote:
> > On 13-Mar 14:52, Peter Zijlstra wrote:
> 
> > Because of backetization, we potentially end up tracking tasks with
> > different requested clamp values in the same bucket.
> > 
> > For example, with 20% bucket size, we can have:
> >   Task1: util_min=25%
> >   Task2: util_min=35%
> > accounted in the same bucket.
> 
> > > Given all that, what is to stop the bucket value to climbing to
> > > uclamp_bucket_value(+1)-1 and staying there (provided there's someone
> > > runnable)?
> > 
> > Nothing... but that's an expected consequence of bucketization.
> 
> No, it is not.
> 
> > > Why are we doing this... ?
> > 
> > You can either decide to:
> > 
> >  a) always boost tasks to just the bucket nominal value
> >     thus always penalizing both Task1 and Task2 of the example above
> 
> This is the expected behaviour. When was the last time your histogram
> did something like b?

Right, I see what you mean... strictly speaking histograms always do a
floor aggregation.

> >  b) always boost tasks to the bucket "max" value
> >     thus always overboosting both Task1 and Task2 of the example above
> > 
> > The solution above instead has a very good property: in systems
> > where you have only few and well defined clamp values we always
> > provide the exact boost.
> > 
> > For example, if your system requires only 23% and 47% boost values
> > (totally random numbers), then you can always get the exact boost
> > required using just 3 bucksts or ~33% size each.
> > 
> > In systems where you don't know which boost values you will have, you
> > can still defined the maximum overboost granularity you accept for
> > each task by just tuning the number of clamp groups. For example, with
> > 20 groups you can have a 5% max overboost.
> 
> Maybe, but this is not a direct concequence of buckets, but an
> additional heuristic that might work well in this case.

Right... that's the point.

We started with mapping to be able to track exact clamp values.
Then we switched to linear mapping to remove the complexity of
mapping, but we would like to still have the possibility to track
exact numbers whenever possible.

> Maybe split this out in a separate patch? So start with the trivial
> bucket, and then do this change on top with the above few paragraphs as
> changelog?

That's doable, otherwise maybe we can just add the above paragraphs to
the changelog of this patch. But give your comment above I assume you
prefer to split it out... just let me know otherwise.


-- 
#include <best/regards.h>

Patrick Bellasi
