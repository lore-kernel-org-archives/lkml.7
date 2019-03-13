Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63144C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313802171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R78+p2QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCMOJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:09:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfCMOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1O9otNqbUSZ4NBzoCNgVtlgqndPz2p5r0zu5jHpoZWY=; b=R78+p2QKmRTcdakB6zwwnzC2z
        jvh+Z+YNuYmDkU77XSNvqEDlM/DDWIz+C+leyv1FYHdZGLUO+Nlm3upSHtrJRJNT79RjgXzFZCwvo
        HT3MRUyVEt7VpyYRhkBFyrC8uvhojGqjTd+6jgIk5Dx5Vhes/efFNJu2SAz5zyi/0n87W2zD49axz
        1OjZgAGP3xeb+Ku69ZQj4Jtk7M9SRhnMXo87T/9K+cmgjPwTC/W4VSAPB1Oa1v4oVIay94E9aeBI8
        nWxRfTaTTV6GpqVYc2AwAse3AUWpNdyudjNYEJH3nZJTdzoclZThP6hReb3AmixPwNzbF9XHNnKME
        HGSc/MYMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h44ZT-0003Xj-FI; Wed, 13 Mar 2019 14:09:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B898B2028B0E8; Wed, 13 Mar 2019 15:09:25 +0100 (CET)
Date:   Wed, 13 Mar 2019 15:09:25 +0100
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
Message-ID: <20190313140925.GE5922@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> +static inline unsigned int uclamp_none(int clamp_id)
> +{
> +	if (clamp_id == UCLAMP_MIN)
> +		return 0;
> +	return SCHED_CAPACITY_SCALE;
> +}
> +
> +static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> +{
> +	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> +	unsigned int max_value = uclamp_none(clamp_id);

That's 1024 for uclamp_max

> +	unsigned int bucket_id;
> +
> +	/*
> +	 * Both min and max clamps are MAX aggregated, thus the topmost
> +	 * bucket with some tasks defines the rq's clamp value.
> +	 */
> +	bucket_id = UCLAMP_BUCKETS;
> +	do {
> +		--bucket_id;
> +		if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
> +			continue;
> +		max_value = bucket[bucket_id].value;

but this will then _lower_ it. That's not a MAX aggregate.

> +		break;
> +	} while (bucket_id);
> +
> +	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
> +}
