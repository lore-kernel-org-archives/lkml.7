Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255C120684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfCELBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:01:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfCELBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:01:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D5DA78;
        Tue,  5 Mar 2019 03:01:40 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C19713F71D;
        Tue,  5 Mar 2019 03:01:38 -0800 (PST)
Date:   Tue, 5 Mar 2019 11:01:37 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        peterz@infradead.org
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Message-ID: <20190305110135.jdgc6vtdivs5rdjv@queper01-lin>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <3017597.CVkTxgYgAs@aspire.rjw.lan>
 <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2336151.IZk3Z8DVvP@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Mar 2019 at 11:50:56 (+0100), Rafael J. Wysocki wrote:
> On Tuesday, March 5, 2019 11:42:59 AM CET Quentin Perret wrote:
> > > +static void intel_pstate_update_max_freq(unsigned int cpu)
> > > +{
> > > +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > > +	struct cpufreq_policy new_policy;
> > > +	struct cpudata *cpudata;
> > > +
> > > +	if (!policy)
> > > +		return;
> > > +
> > > +	down_write(&policy->rwsem);
> > > +
> > > +	if (policy_is_inactive(policy))
> > > +		goto unlock;
> > > +
> > > +	cpudata = all_cpu_data[cpu];
> > > +	policy->cpuinfo.max_freq = global.turbo_disabled_upd ?
> > > +			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
> > > +
> > > +	memcpy(&new_policy, policy, sizeof(*policy));
> > > +	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
> > > +	new_policy.min = min(policy->user_policy.min, new_policy.max);
> > > +
> > > +	cpufreq_set_policy(policy, &new_policy);
> > 
> > Do you want to force-restart the governor here ?
> 
> cpufreq_set_policy() is expected to take care of the governor.
> If it doesn't, there is a bug somewhere.

Yes, it does something when there is a governor change, but that's not
the case here IIUC.

> > Schedutil caches cpuinfo.max_freq for the iowait stuff in sugov_start() [1].
> 
> If it does so, it should update the cached value in sugov_limits().
> 
> I guess I can add a patch updating it to this series.

Right, I think we've been under the assumption that unlike policy->max,
cpuinfo.max_freq should be constant, so there was no need to update the
value at run time. But if that assumption doesn't hold any more, then
yeah we'll need something more dynamic I guess.

> 
> > I'm not sure about the other governors.
> 
> They don't do that AFAICS.

OK

> > And just removing sg_cpu->iowait_boost_max to use the cpuinfo struct
> > instead will conflict with [2], I think.
> 
> Thanks for pointing this out.

N/p :-)

Thanks,
Quentin
