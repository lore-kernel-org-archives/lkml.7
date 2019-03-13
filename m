Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132AB20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epxItowi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCMUNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:13:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfCMUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A6srmjvvJh+hUj2FSayXw3F3/P3B8oZnrD94Im0VWvI=; b=epxItowi9rrP35jg53C5FfLMI
        3YvCzWzLkDQNGTdTBnW6UVbfc70ze5rn11oinJGXnojuU28kP1QOIR1WepEDtW2tuGK+5QHgeIhYn
        MnDqRBzPusHuw2ypnbT/pFCnxKxYRs/QAgt4TkvcHLQZm59DizoDJov71juGEnw1sFAZlNUjp8X5m
        +Bud7R/vDjKw3aHSViEuhp3UZ47chMaJkr2t588FvUmQufiOJLg5vAdlSpRbMIOCrlRr1nZNuAmwp
        cctX5r2FDS56vKBRbYY6A6mGWJ9tDwpFhG2Ch9cpEZaU0cHjLU05K0a97LUzbGV9I7oSTXcQ1+R0h
        v8nuS9UXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4AG1-0002nf-4Q; Wed, 13 Mar 2019 20:13:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3AEF9826C0; Wed, 13 Mar 2019 21:13:42 +0100 (CET)
Date:   Wed, 13 Mar 2019 21:13:42 +0100
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
Subject: Re: [PATCH v7 03/15] sched/core: uclamp: Add system default clamps
Message-ID: <20190313201342.GV2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:42AM +0000, Patrick Bellasi wrote:
> +int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> +				void __user *buffer, size_t *lenp,
> +				loff_t *ppos)
> +{
> +	int old_min, old_max;
> +	int result = 0;

Should this not have an internal mutex to serialize concurrent usage?
See for example sched_rt_handler().

> +
> +	old_min = sysctl_sched_uclamp_util_min;
> +	old_max = sysctl_sched_uclamp_util_max;
> +
> +	result = proc_dointvec(table, write, buffer, lenp, ppos);
> +	if (result)
> +		goto undo;
> +	if (!write)
> +		goto done;
> +
> +	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
> +	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
> +		result = -EINVAL;
> +		goto undo;
> +	}
> +
> +	if (old_min != sysctl_sched_uclamp_util_min) {
> +		uclamp_default[UCLAMP_MIN].value =
> +			sysctl_sched_uclamp_util_min;
> +		uclamp_default[UCLAMP_MIN].bucket_id =
> +			uclamp_bucket_id(sysctl_sched_uclamp_util_min);
> +	}
> +	if (old_max != sysctl_sched_uclamp_util_max) {
> +		uclamp_default[UCLAMP_MAX].value =
> +			sysctl_sched_uclamp_util_max;
> +		uclamp_default[UCLAMP_MAX].bucket_id =
> +			uclamp_bucket_id(sysctl_sched_uclamp_util_max);
> +	}
> +
> +	/*
> +	 * Updating all the RUNNABLE task is expensive, keep it simple and do
> +	 * just a lazy update at each next enqueue time.
> +	 */
> +	goto done;
> +
> +undo:
> +	sysctl_sched_uclamp_util_min = old_min;
> +	sysctl_sched_uclamp_util_max = old_max;
> +done:
> +
> +	return result;
> +}
