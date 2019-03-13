Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32692C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0947320693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfCMQMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:12:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60018 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfCMQMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:12:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C150080D;
        Wed, 13 Mar 2019 09:12:34 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD2E13F71D;
        Wed, 13 Mar 2019 09:12:31 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:12:29 +0000
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
Message-ID: <20190313161229.pkib2tmjass5chtb@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313134022.GB5922@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313134022.GB5922@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar 14:40, Peter Zijlstra wrote:
> On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> > +static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
> > +{
> > +	return clamp_value / UCLAMP_BUCKET_DELTA;
> > +}
> > +
> > +static inline unsigned int uclamp_bucket_value(unsigned int clamp_value)
> > +{
> > +	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
> 
> 	return clamp_value - (clamp_value % UCLAMP_BUCKET_DELTA);
> 
> might generate better code; just a single division, instead of a div and
> mult.

Wondering if compilers cannot do these optimizations... but yes, looks
cool and will do it in v8, thanks.

> > +}
> > +
> > +static inline unsigned int uclamp_none(int clamp_id)
> > +{
> > +	if (clamp_id == UCLAMP_MIN)
> > +		return 0;
> > +	return SCHED_CAPACITY_SCALE;
> > +}
> > +
> > +static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> > +{
> > +	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> > +	unsigned int max_value = uclamp_none(clamp_id);
> > +	unsigned int bucket_id;
> > +
> > +	/*
> > +	 * Both min and max clamps are MAX aggregated, thus the topmost
> > +	 * bucket with some tasks defines the rq's clamp value.
> > +	 */
> > +	bucket_id = UCLAMP_BUCKETS;
> > +	do {
> > +		--bucket_id;
> > +		if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
> > +			continue;
> > +		max_value = bucket[bucket_id].value;
> > +		break;
> 
> If you flip the if condition the code will be nicer.
> 
> > +	} while (bucket_id);
> 
> But you can also use a for loop:
> 
> 	for (i = UCLAMP_BUCKETS-1; i>=0; i--) {
> 		if (rq->uclamp[clamp_id].bucket[i].tasks) {
> 			max_value = bucket[i].value;
> 			break;
> 		}
> 	}

Yes, the for looks better, but perhaps like that:

	unsigned int bucket_id = UCLAMP_BUCKETS;

 	/*
 	 * Both min and max clamps are MAX aggregated, thus the topmost
 	 * bucket with some tasks defines the rq's clamp value.
 	 */
	for (; bucket_id >= 0; --bucket_id) {
		if (!bucket[bucket_id].tasks)
			continue;
		max_value = bucket[bucket_id].value;
		break;
	}

... just to save a {} block.


> > +	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
> > +}

-- 
#include <best/regards.h>

Patrick Bellasi
