Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8F4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECE2206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfCEKwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:52:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58763 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:52:36 -0500
Received: from 79.184.253.110.ipv4.supernova.orange.pl (79.184.253.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id e740de4550c3cde6; Tue, 5 Mar 2019 11:52:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        peterz@infradead.org
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU frequency on global turbo changes
Date:   Tue, 05 Mar 2019 11:50:56 +0100
Message-ID: <2336151.IZk3Z8DVvP@aspire.rjw.lan>
In-Reply-To: <20190305104256.7kvedlttuovmptpc@queper01-lin>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <3017597.CVkTxgYgAs@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 5, 2019 11:42:59 AM CET Quentin Perret wrote:
> Hi Rafael,
> 
> +CC Peter since we were talking about cpuinfo.*_freq recently.
> 
> On Friday 01 Mar 2019 at 13:57:06 (+0100), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > While the cpuinfo.max_freq value doesn't really matter for
> > intel_pstate in the active mode, in the passive mode it is used by
> > governors as the maximum physical frequency of the CPU and the
> > results of governor computations generally depend on it. Also it
> > is made available to user space via sysfs and it should match the
> > current HW configuration.
> > 
> > For this reason, make intel_pstate update cpuinfo.max_freq for all
> > CPUs if it detects a global change of turbo frequency settings from
> > "disable" to "enable" or the other way associated with a _PPC change
> > notification from the platform firmware.
> > 
> > Note that policy_is_inactive() and cpufreq_set_policy() need to be
> > made available to it for this purpose.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Update, because the patch sent previously doesn't build, due to an extra
> > arg declared for intel_pstate_update_max_freq().
> > 
> > ---
> >  drivers/cpufreq/cpufreq.c      |   12 ++----------
> >  drivers/cpufreq/intel_pstate.c |   33 ++++++++++++++++++++++++++++++++-
> >  include/linux/cpufreq.h        |    7 +++++++
> >  3 files changed, 41 insertions(+), 11 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -897,6 +897,36 @@ static void intel_pstate_update_policies
> >  		cpufreq_update_policy(cpu);
> >  }
> >  
> > +static void intel_pstate_update_max_freq(unsigned int cpu)
> > +{
> > +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +	struct cpufreq_policy new_policy;
> > +	struct cpudata *cpudata;
> > +
> > +	if (!policy)
> > +		return;
> > +
> > +	down_write(&policy->rwsem);
> > +
> > +	if (policy_is_inactive(policy))
> > +		goto unlock;
> > +
> > +	cpudata = all_cpu_data[cpu];
> > +	policy->cpuinfo.max_freq = global.turbo_disabled_upd ?
> > +			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
> > +
> > +	memcpy(&new_policy, policy, sizeof(*policy));
> > +	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
> > +	new_policy.min = min(policy->user_policy.min, new_policy.max);
> > +
> > +	cpufreq_set_policy(policy, &new_policy);
> 
> Do you want to force-restart the governor here ?

cpufreq_set_policy() is expected to take care of the governor.
If it doesn't, there is a bug somewhere.

> Schedutil caches cpuinfo.max_freq for the iowait stuff in sugov_start() [1].

If it does so, it should update the cached value in sugov_limits().

I guess I can add a patch updating it to this series.

> I'm not sure about the other governors.

They don't do that AFAICS.

> And just removing sg_cpu->iowait_boost_max to use the cpuinfo struct
> instead will conflict with [2], I think.

Thanks for pointing this out.

Cheers,
Rafael

