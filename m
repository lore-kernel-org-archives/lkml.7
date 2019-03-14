Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF899C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A20620811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCNPAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:00:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45998 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfCNPAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:00:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A6DA78;
        Thu, 14 Mar 2019 08:00:54 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 254A73F59C;
        Thu, 14 Mar 2019 08:00:51 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:00:48 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190314150048.td6o3g7ucb7fg2yy@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <21171fa0-7fd5-ebbf-dd48-d6668ed563af@arm.com>
 <20190313151535.q5ivsuywvwkewrk5@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313151535.q5ivsuywvwkewrk5@e110439-lin>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar 15:15, Patrick Bellasi wrote:
> On 12-Mar 13:52, Dietmar Eggemann wrote:
> > On 2/8/19 11:05 AM, Patrick Bellasi wrote:

[...]

> > > + * within each bucket the exact "requested" clamp value whenever all tasks
> > > + * RUNNABLE in that bucket require the same clamp.
> > > + */
> > > +static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
> > > +				    unsigned int clamp_id)
> > > +{
> > > +	unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > > +	unsigned int rq_clamp, bkt_clamp, tsk_clamp;
> > 
> > Wouldn't it be easier to have a pointer to the task's and rq's uclamp
> > structure as well to the bucket?
> > 
> > -       unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > +       struct uclamp_se *uc_se = &p->uclamp[clamp_id];
> > +       struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
> > +       struct uclamp_bucket *bucket = &uc_rq->bucket[uc_se->bucket_id];
> 
> I think I went back/forth a couple of times in using pointer or the
> extended version, which both have pros and cons.
> 
> I personally prefer the pointers as you suggest but I've got the
> impression in the past that since everybody cleared "basic C trainings"
> it's not so difficult to read the code above too.
> 
> > The code in uclamp_rq_inc_id() and uclamp_rq_dec_id() for example becomes
> > much more readable.
> 
> Agree... let's try to switch once again in v8 and see ;)

This is not as straightforward as I thought.

We either still need local variables to use with max(), which does not
play well with bitfields values, or we have to avoid using it and go
back to conditional updates:

---8<---
static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
				    unsigned int clamp_id)
{
	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
	struct uclamp_req *uc_se = &p->uclamp_se[clamp_id];
	struct uclamp_bucket *bucket = &uc_rq->bucket[uc_se->bucket_id];

	bucket->tasks++;

	/*
	 * Local clamping: rq's buckets always track the max "requested"
	 * clamp value from all RUNNABLE tasks in that bucket.
	 */
	if (uc_se->value > bucket->value)
		bucket->value = uc_se->value;

	if (uc_se->value > READ_ONCE(uc_rq->value))
		WRITE_ONCE(uc_rq->value, uc_se->value);
}
---8<---

I remember Peter asking for max() in one of the past reviews.. but the
code above looks simpler to me too... let see if this time it can be
accepted. :)

-- 
#include <best/regards.h>

Patrick Bellasi
