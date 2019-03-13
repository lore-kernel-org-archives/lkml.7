Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF60C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB105213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2efAug8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfCMTql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:46:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfCMTql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A6s9/htiIv/3TV7CEQdjo1YKJWC3g9qNU18XwRg5TLA=; b=2efAug8e0gqj0ZHi0kFbeRFS7
        wLksMRNFYKBQ5tM+eWSqEc16UnHa8pW9oRehedJpjcuti/qi5w0pl31iF1bGNrpocz+Y1jkc6yUpi
        x03AUVH4ZD9yrenvecQSvO9jJuV8DmnGCL69SBV6tyK4NhJeI996DcyzWM9XsI8jG1digvy6YFq0m
        OCoArxcFX4z5cfU6zpSdRr3pTApbqhCYJ3H0/KLg+wsUDtEjGI0pEguZ9no9WGLXzKiuhV5g5Uzwa
        FV7Z3zCGKy2iqSD6vX3spgCaWUwbleIaQmz7QHjyZ5jrjLj6ZNU672tYdheStSGIWLTRC7tJE42v+
        QSjPJSkcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h49pV-00085Z-Sr; Wed, 13 Mar 2019 19:46:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2566E9826C0; Wed, 13 Mar 2019 20:46:19 +0100 (CET)
Date:   Wed, 13 Mar 2019 20:46:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20190313194619.GR2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313140925.GE5922@hirez.programming.kicks-ass.net>
 <20190313152359.lkyzel7fakjoi5hu@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313152359.lkyzel7fakjoi5hu@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 03:23:59PM +0000, Patrick Bellasi wrote:
> On 13-Mar 15:09, Peter Zijlstra wrote:
> > On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:

> > > +static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> > > +{
> > > +	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> > > +	unsigned int max_value = uclamp_none(clamp_id);
> > 
> > That's 1024 for uclamp_max
> > 
> > > +	unsigned int bucket_id;
> > > +
> > > +	/*
> > > +	 * Both min and max clamps are MAX aggregated, thus the topmost
> > > +	 * bucket with some tasks defines the rq's clamp value.
> > > +	 */
> > > +	bucket_id = UCLAMP_BUCKETS;
> > > +	do {
> > > +		--bucket_id;
> > > +		if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
> > > +			continue;
> > > +		max_value = bucket[bucket_id].value;
> > 
> > but this will then _lower_ it. That's not a MAX aggregate.
> 
> For uclamp_max we want max_value=1024 when there are no active tasks,
> which means: no max clamp enforced on CFS/RT "idle" cpus.
> 
> If instead there are active RT/CFS tasks then we want the clamp value
> of the max group, which means: MAX aggregate active clamps.
> 
> That's what the code above does and the comment says.

That's (obviously) not how I read it... maybe something like:

static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
{
	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
	int i;

	/*
	 * Since both min and max clamps are max aggregated, find the
	 * top most bucket with tasks in.
	 */
	for (i = UCLMAP_BUCKETS-1; i>=0; i--) {
		if (!bucket[i].tasks)
			continue;
		return bucket[i].value;
	}

	/* No tasks -- default clamp values */
	return uclamp_none(clamp_id);
}

would make it clearer?
