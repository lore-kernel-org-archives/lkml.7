Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF76C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5203218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbfB1Rnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:43:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:12733 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732473AbfB1Rnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:43:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 09:43:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="322958335"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2019 09:43:37 -0800
Date:   Fri, 1 Mar 2019 01:52:30 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast  _PPC to all online CPUs
Message-ID: <20190228175230.GA31788@chenyu-office.sh.intel.com>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
 <20190211103307.rccddkso3f5s3yko@vireshk-i7>
 <20190213165538.GB30385@chenyu-office.sh.intel.com>
 <20190214070648.pvsavc46iivub4hy@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214070648.pvsavc46iivub4hy@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:36:48PM +0530, Viresh Kumar wrote:
> On 14-02-19, 00:55, Yu Chen wrote:
> > Hi Viresh,
> > On Mon, Feb 11, 2019 at 04:03:07PM +0530, Viresh Kumar wrote:
> > > On 09-02-19, 20:02, Chen Yu wrote:
> > > > On Dell Inc. XPS13 9333, the BIOS changes the value of
> > > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> > > > the power source changes), the maximum frequency of the
> > > > CPU is not updated accordingly. This is due to the policy's
> > > > cpuinfo.max is not updated when _PPC notifier fires.
> > > > 
> > > > Fix this problem by updating the policy's cpuinfo.max
> > > > and broadcast the _PPC notifier to all online CPUs.
> > > > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > > > Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > > > Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > ---
> > > >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> > > >  drivers/cpufreq/cpufreq.c        |  2 ++
> > > >  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
> > > >  3 files changed, 30 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > > > index a303fd0e108c..737dbf5aa7f7 100644
> > > > --- a/drivers/acpi/processor_perflib.c
> > > > +++ b/drivers/acpi/processor_perflib.c
> > > > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> > > >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> > > >  		 "limited by BIOS, this should help");
> > > >  
> > > > +static int broadcast_ppc;
> > > > +module_param(broadcast_ppc, int, 0644);
> > > > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > > > +
> > > >  #define PPC_REGISTERED   1
> > > >  #define PPC_IN_USE       2
> > > >  
> > > > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> > > >  		else
> > > >  			acpi_processor_ppc_ost(pr->handle, 0);
> > > >  	}
> > > > -	if (ret >= 0)
> > > > -		cpufreq_update_policy(pr->id);
> > > > +	if (ret >= 0) {
> > > > +		if (broadcast_ppc) {
> > > > +			int cpu;
> > > > +
> > > > +			for_each_possible_cpu(cpu)
> > > > +				cpufreq_update_policy(cpu);
> > > > +		} else {
> > > > +			cpufreq_update_policy(pr->id);
> > > > +		}
> > > > +	}
> > > >  }
> > > >  
> > > >  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index e35a886e00bc..95e08816b512 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > > >  
> > > >  	policy->min = new_policy->min;
> > > >  	policy->max = new_policy->max;
> > > > +	policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > > > +	policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> > > >  	trace_cpu_frequency_limits(policy);
> > > >  
> > > >  	policy->cached_target_freq = UINT_MAX;
> > > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > > index dd66decf2087..e1881313c396 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> > > >  
> > > >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> > > >  {
> > > > +	int max_freq;
> > > >  	struct cpudata *cpu = all_cpu_data[policy->cpu];
> > > >  
> > > >  	update_turbo_state();
> > > > +	max_freq = intel_pstate_get_max_freq(cpu);
> > > > +
> > > > +	if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> > > 
> > > Why do have this check for policy->max here ?
> > >
> > Thanks for looking at this change, I've replied to another email in detail of
> > the scenario that, this is due to corner case that if the system boots
> > with battery and plug the AC after boot up, the cpufreq max limit will not
> > increase even the turbo has been enabled after the AC plugged.
> 
> Yeah, but I asked a different question I believe, why is this
> comparison necessary ?
>
Sorry for late response, I was caught in another issue.

The reason for why checking if policy->max equals to policy->cpuinfo.max_freq
is to bypass unnecessary assignment(it turns out to be a hacky
logic here):

Say, if the system boots up with AC attached, after bootup the cpuinfo.max
is always the highest, and there is no need to reassign the cpuinfo.max.

However if the system boots up with AC deattached, then the cpuinfo.max
will not scale up if the AC is attached after bootup.

Thus in former case, the cpuinfo.max does not equals to policy.max, and
we don't need to update cpuinfo.max. While in latter case, the cpuinfo.max
might equal to policy.max, and in this situation we need to update the
cpuinfo.max.


Case 1: Boot up AC attached, cpuinfo.max does not equal to policy.max

# Unplug

[   25.775643] CPU 0: _PPC is 6 - frequency  limited
[   25.775660] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 1700000
[   25.775666] intel_pstate: cpu:0 max_state 17 min_policy_perf:8 max_policy_perf:17
[   25.775670] intel_pstate: cpu:0 global_min:8 global_max:30
[   25.775674] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8

"REDUCED FREQUENCY ABOVE AFTER UNPLUG"


# Re-plug

[   36.979264] CPU 0: _PPC is 6 - frequency  limited
[   36.979276] intel_pstate: policy->max > max non turbo frequency
[   36.979280] intel_pstate: set_policy cpuinfo.max 3000000 policy->max 3000000
[   36.979283] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:30
[   36.979286] intel_pstate: cpu:0 global_min:8 global_max:30
[   36.979289] intel_pstate: cpu:0 max_perf_ratio:30 min_perf_ratio:8


Case 2: boot up without AC attached, cpuinfo.max equals to policy.max:


# Plug

[   52.158810] CPU 0: _PPC is 6 - frequency  limited
[   52.158822] intel_pstate: set_policy cpuinfo.max 1700000 policy->max 1700000
[   52.158825] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:17
[   52.158827] intel_pstate: cpu:0 global_min:8 global_max:30
[   52.158829] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8


As we see, the check is a little hacky, because it does not do with the logic
on how to check if the system's cpuinfo.max is abnormal. In v2 version, I've
removed this check to make the code easier to be understood.


Best,
Yu

> policy->max == policy->cpuinfo.max_freq
> 
> -- 
> viresh
