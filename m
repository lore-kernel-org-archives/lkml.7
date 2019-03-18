Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C77C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F96520872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCROWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:22:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbfCROWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:22:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F60BEBD;
        Mon, 18 Mar 2019 07:22:01 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B03F3F59C;
        Mon, 18 Mar 2019 07:21:58 -0700 (PDT)
Date:   Mon, 18 Mar 2019 14:21:52 +0000
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
Subject: Re: [PATCH v7 03/15] sched/core: uclamp: Add system default clamps
Message-ID: <20190318142152.44biczhoby44xlfz@e110439-lin>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
 <20190313201821.GW2482@worktop.programming.kicks-ass.net>
 <20190318121804.tr3myhtgczvovmkq@e110439-lin>
 <20190318131050.GQ6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318131050.GQ6058@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-Mar 14:10, Peter Zijlstra wrote:
> On Mon, Mar 18, 2019 at 12:18:04PM +0000, Patrick Bellasi wrote:
> > On 13-Mar 21:18, Peter Zijlstra wrote:
> > > On Fri, Feb 08, 2019 at 10:05:42AM +0000, Patrick Bellasi wrote:
> > > > +static void uclamp_fork(struct task_struct *p)
> > > > +{
> > > > +	unsigned int clamp_id;
> > > > +
> > > > +	if (unlikely(!p->sched_class->uclamp_enabled))
> > > > +		return;
> > > > +
> > > > +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
> > > > +		p->uclamp[clamp_id].active = false;
> > > > +}
> > > 
> > > Because in that case .active == false, and copy_process() will have done
> > > thr right thing?
> > 
> > Don't really get what you mean here? :/
> 
> Why don't we have to set .active=false when
> !sched_class->uclamp_enabled?

Ok, got it.

In principle because:
- FAIR and RT will have uclamp_enabled
- DL cannot fork

... thus, yes, it seems that the check above is not necessary anyway.

Moreover, as per one of your comments in another message, we still need
to cover the "reset on fork" case for FAIR and RT. Thus, I'm going to
completely remove the support check in uclamp_fork and we always reset
active for all classes.

Cheers!

-- 
#include <best/regards.h>

Patrick Bellasi
