Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8774E20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCNMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:23:03 -0400
Received: from foss.arm.com ([217.140.101.70]:43332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbfCNMXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:23:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E6880D;
        Thu, 14 Mar 2019 05:23:01 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85A503F614;
        Thu, 14 Mar 2019 05:22:58 -0700 (PDT)
Date:   Thu, 14 Mar 2019 12:22:56 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
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
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314122256.7wb3ydswpkfmntvf@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313140925.GE5922@hirez.programming.kicks-ass.net>
 <20190313152359.lkyzel7fakjoi5hu@e110439-lin>
 <20190313194619.GR2482@worktop.programming.kicks-ass.net>
 <CAJuCfpHy0+6f9mRd+cF-oQrrUWJ4m8mOQJ7XMzkDL4mhfYyj2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHy0+6f9mRd+cF-oQrrUWJ4m8mOQJ7XMzkDL4mhfYyj2g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar 14:08, Suren Baghdasaryan wrote:
> On Wed, Mar 13, 2019 at 12:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 13, 2019 at 03:23:59PM +0000, Patrick Bellasi wrote:
> > > On 13-Mar 15:09, Peter Zijlstra wrote:
> > > > On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> >
> > > > > +static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> > > > > +{
> > > > > + struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> > > > > + unsigned int max_value = uclamp_none(clamp_id);
> > > >
> > > > That's 1024 for uclamp_max
> > > >
> > > > > + unsigned int bucket_id;
> > > > > +
> > > > > + /*
> > > > > +  * Both min and max clamps are MAX aggregated, thus the topmost
> > > > > +  * bucket with some tasks defines the rq's clamp value.
> > > > > +  */
> > > > > + bucket_id = UCLAMP_BUCKETS;
> > > > > + do {
> > > > > +         --bucket_id;
> > > > > +         if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
> > > > > +                 continue;
> > > > > +         max_value = bucket[bucket_id].value;
> > > >
> > > > but this will then _lower_ it. That's not a MAX aggregate.
> > >
> > > For uclamp_max we want max_value=1024 when there are no active tasks,
> > > which means: no max clamp enforced on CFS/RT "idle" cpus.
> > >
> > > If instead there are active RT/CFS tasks then we want the clamp value
> > > of the max group, which means: MAX aggregate active clamps.
> > >
> > > That's what the code above does and the comment says.
> >
> > That's (obviously) not how I read it... maybe something like:
> >
> > static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> > {
> >         struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> >         int i;
> >
> >         /*
> >          * Since both min and max clamps are max aggregated, find the
> >          * top most bucket with tasks in.
> >          */
> >         for (i = UCLMAP_BUCKETS-1; i>=0; i--) {
> >                 if (!bucket[i].tasks)
> >                         continue;
> >                 return bucket[i].value;
> >         }
> >
> >         /* No tasks -- default clamp values */
> >         return uclamp_none(clamp_id);
> > }
> >
> > would make it clearer?
> 
> This way it's also more readable/obvious when it's used inside
> uclamp_rq_dec_id, assuming uclamp_rq_update is renamed into smth like
> get_max_rq_uclamp.

Rightm, I have now something like that:

---8<---
static inline unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
{
	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
	int bucket_id;

	/*
	 * Since both min and max clamps are max aggregated, find the
	 * top most bucket with tasks in.
	 */
	for (bucket_id = UCLMAP_BUCKETS-1; bucket_id >= 0; bucket_id--) {
		if (!bucket[bucket_id].tasks)
			continue;
		return bucket[bucket_id].value;
	}

	/* No tasks -- default clamp value */
	return uclamp_none(clamp_id);
}

static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
				    unsigned int clamp_id)
{
        //...
	if (bucket->value >= rq_clamp) {
		/*
		 * Reset rq's clamp bucket value to its nominal value whenever
		 * there are anymore RUNNABLE tasks refcounting it.
		 */
		bucket->value = uclamp_bucket_nominal_value(rq_clamp);
		WRITE_ONCE(uc_rq->value, uclamp_rq_max_value(rq, clamp_id));
	}
}
---8<---

-- 
#include <best/regards.h>

Patrick Bellasi
