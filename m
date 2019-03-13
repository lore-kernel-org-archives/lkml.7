Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E85BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E4D214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="smmxmC4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCMNkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:40:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49026 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sLBbsxetkWlLWSyLKbfNbHStCqosiSducrzxoQYCUAE=; b=smmxmC4gTIGZLwVqPRb6R77Le
        010XND4sT3oLXcrZALneO8oLF80SgV73/+FEm4KpqYsoPY/6fz8zHX4Fo2EBszjAEEx1nO4ve3w49
        8rY6cW3Lw1qj07mHGdzYNWI80408pUcY4Bgk153uAE8DRUXMvaVjNi5RvpjYhfj2Cgl4eT1cNTSie
        SMZ6neKe/PVk8W6wDZrnat2tHYrleLBLZabCX/YyvMxkyXUWpSrSu1SncWMtRPuRVTsEQFZe4ZW/o
        S3LsFpxVl95qKmTKF2yt4y+ysjRTMfeydWybZRuxNU451Vwh/h2CkMhYNcde0m3wZY1PR3F1QfU7/
        pTzCG1QjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h447M-0002vW-Qc; Wed, 13 Mar 2019 13:40:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A8282028B0E8; Wed, 13 Mar 2019 14:40:22 +0100 (CET)
Date:   Wed, 13 Mar 2019 14:40:22 +0100
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
Message-ID: <20190313134022.GB5922@hirez.programming.kicks-ass.net>
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
> +static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
> +{
> +	return clamp_value / UCLAMP_BUCKET_DELTA;
> +}
> +
> +static inline unsigned int uclamp_bucket_value(unsigned int clamp_value)
> +{
> +	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);

	return clamp_value - (clamp_value % UCLAMP_BUCKET_DELTA);

might generate better code; just a single division, instead of a div and
mult.

> +}
> +
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
> +		break;

If you flip the if condition the code will be nicer.

> +	} while (bucket_id);

But you can also use a for loop:

	for (i = UCLAMP_BUCKETS-1; i>=0; i--) {
		if (rq->uclamp[clamp_id].bucket[i].tasks) {
			max_value = bucket[i].value;
			break;
		}
	}

> +	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
> +}
