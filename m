Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B251B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCMQU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:20:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMQU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:20:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8701880D;
        Wed, 13 Mar 2019 09:20:56 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9214C3F71D;
        Wed, 13 Mar 2019 09:20:53 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:20:51 +0000
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
Subject: Re: [PATCH v7 02/15] sched/core: uclamp: Enforce last task UCLAMP_MAX
Message-ID: <20190313162051.djiu5dwc5ahp5p5p@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-3-patrick.bellasi@arm.com>
 <20190313141008.GF5922@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313141008.GF5922@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar 15:10, Peter Zijlstra wrote:
> On Fri, Feb 08, 2019 at 10:05:41AM +0000, Patrick Bellasi wrote:
> > +uclamp_idle_value(struct rq *rq, unsigned int clamp_id, unsigned int clamp_value)
> > +{
> > +	/*
> > +	 * Avoid blocked utilization pushing up the frequency when we go
> > +	 * idle (which drops the max-clamp) by retaining the last known
> > +	 * max-clamp.
> > +	 */
> > +	if (clamp_id == UCLAMP_MAX) {
> > +		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
> > +		return clamp_value;
> > +	}
> > +
> > +	return uclamp_none(UCLAMP_MIN);
> 
> That's a very complicated way or writing: return 0, right?

In my mind it's just a simple way to hardcode values in just one place.

In the current implementation uclamp_none(UCLAMP_MIN) is 0 and the
compiler is not in trubles to inline a 0 there.

Is it really so disgusting ?

-- 
#include <best/regards.h>

Patrick Bellasi
