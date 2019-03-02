Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47521C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1615020836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 09:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCBJzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 04:55:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:46221 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfCBJzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 04:55:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2019 01:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,431,1544515200"; 
   d="scan'208";a="119031766"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2019 01:55:29 -0800
Date:   Sat, 2 Mar 2019 18:04:20 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 2/2][RFC v2] ACPI: Update cpuinfo.max after bootup if
 necessary
Message-ID: <20190302100420.GA7044@chenyu-office.sh.intel.com>
References: <cover.1551375162.git.yu.c.chen@intel.com>
 <bd3c5e04e882e5a4c977211a8d268440b36276a4.1551375162.git.yu.c.chen@intel.com>
 <CAJZ5v0g4CGfAMH0pM-wWSt6pXZrw3ckqBbbUzNwjqScwRjrK3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4CGfAMH0pM-wWSt6pXZrw3ckqBbbUzNwjqScwRjrK3g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:56:48PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 28, 2019 at 6:59 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On Dell Inc. XPS13 9333, the BIOS changes the value of
> > MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> > the power source changes), the maximum frequency of the
> > CPU is not updated accordingly. This is due to the policy's
> > cpuinfo.max is not updated when _PPC notifier fires.
> >
> > Fix this problem by updating the policy's cpuinfo.max when
> > necessary.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c      |  2 ++
> >  drivers/cpufreq/intel_pstate.c | 15 +++++++++++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..95e08816b512 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >
> >         policy->min = new_policy->min;
> >         policy->max = new_policy->max;
> > +       policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > +       policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> >         trace_cpu_frequency_limits(policy);
> >
> >         policy->cached_target_freq = UINT_MAX;
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index dd66decf2087..841c74f69f66 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2081,11 +2081,17 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> >
> >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> >  {
> > +       int max_freq;
> >         struct cpudata *cpu = all_cpu_data[policy->cpu];
> >
> >         update_turbo_state();
> > +       max_freq = intel_pstate_get_max_freq(cpu);
> > +
> > +       if (acpi_ppc && max_freq != policy->cpuinfo.max_freq)
> > +               policy->cpuinfo.max_freq = policy->max = max_freq;
> 
> Updating cpuinfo.max_freq here only causes the current limit to be
> reported via sysfs, because intel_pstate doesn't actually use
> cpuinfo.max_freq for anything and the core doesn't enforce it as a
> limit.
> 
> All of the computations in the active mode in the driver actually use
> the current limit anyway AFAICS.
>
Yes, but it looks like we should also take care of the cpuinfo.max
if it changes, I searched the code, it seems that other components
might use the policy's cpuinfo.max for some purpose. They might use
cpufreq_cpu_get() to get the policy, and use the cpuinfo.max_freq
directly, no matter what the mode intel_pstate is in. Such as kvm
might use it as the max tsc khz if the tsc is not constant. And i915
might consider the cpuinfo.max_freq to adjust the IA frequency on
gen6 platforms. So changing cpuinfo.max might also impact not only
cpufreq but also other components too.
> > +
> >         cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> > -                                    intel_pstate_get_max_freq(cpu));
> > +                                    max_freq);
> >
> >         if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
> >             policy->policy != CPUFREQ_POLICY_PERFORMANCE)
> > @@ -2192,11 +2198,16 @@ static struct cpufreq_driver intel_pstate = {
> >
> >  static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
> >  {
> > +       int max_freq;
> >         struct cpudata *cpu = all_cpu_data[policy->cpu];
> >
> >         update_turbo_state();
> > +       max_freq = intel_pstate_get_max_freq(cpu);
> > +
> > +       if (acpi_ppc && max_freq != policy->cpuinfo.max_freq)
> > +               policy->cpuinfo.max_freq = policy->max = max_freq;
> 
> In this case (passive mode) updating cpuinfo.max_freq will actually
> cause governors to use the new value in computations, so the P-state
> selection will work somewhat differently, but that isn't really
> consistent with what acpi-cpufreq does and with setting no_turbo in
> the intel_pstate sysfs to 1 without this patch.
> 
> With acpi-cpufreq cpuinfo.max_freq is always the max frequency in the
> _PSS table regardless of what the _PSS limit is.  Also setting
> no_turbo to 1 in intel_pstate without this patch doesn't cause
> cpuinfo.max_freq to change and I don't really think that it should.
> 
> I would be tempted to always initialize cpuinfo.max_freq to the max
> turbo frequency, but there is a concern about systems in which
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE is never set on the fly (just in
> the BIOS setup as it should be) and where it doesn't make sense to
> consider turbo frequencies at all.
Ok, maybe we can check the bit during boot(consider BIOS's setting)?
> 
> >         cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> > -                                    intel_pstate_get_max_freq(cpu));
> > +                                    max_freq);
> >
> >         intel_pstate_adjust_policy_max(policy, cpu);
> >
> > --
> 
> It looks like I need to think about this a bit more.
Ok, I'll test the patch you sent out.

Thanks,
Yu
