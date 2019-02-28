Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52453C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287FF218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbfB1R43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:56:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:49281 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfB1R42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:56:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 09:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="278643336"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2019 09:55:55 -0800
Date:   Fri, 1 Mar 2019 02:04:48 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC to all online CPUs
Message-ID: <20190228180448.GB31788@chenyu-office.sh.intel.com>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
 <CAJZ5v0ggyrn7XJmoDP8Z8F_VJ67K0D4GCLJa7xWcX4gursOB5Q@mail.gmail.com>
 <20190213165242.GA30385@chenyu-office.sh.intel.com>
 <CAJZ5v0j229PGxxwkhbVYfk+aPrTx=9LvTnMp8r3V3k+LfPkV1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j229PGxxwkhbVYfk+aPrTx=9LvTnMp8r3V3k+LfPkV1Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:21:13AM +0100, Rafael J. Wysocki wrote:
>  On Wed, Feb 13, 2019 at 5:44 PM Yu Chen <yu.c.chen@intel.com> wrote:
> >
> > Hi Rafael,
> > On Mon, Feb 11, 2019 at 11:41:26AM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Feb 9, 2019 at 12:54 PM Chen Yu <yu.c.chen@intel.com> wrote:
> > > >
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
> > > >                  "limited by BIOS, this should help");
> > > >
> > > > +static int broadcast_ppc;
> > > > +module_param(broadcast_ppc, int, 0644);
> > > > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > > > +
> > > >  #define PPC_REGISTERED   1
> > > >  #define PPC_IN_USE       2
> > > >
> > > > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> > > >                 else
> > > >                         acpi_processor_ppc_ost(pr->handle, 0);
> > > >         }
> > > > -       if (ret >= 0)
> > > > -               cpufreq_update_policy(pr->id);
> > > > +       if (ret >= 0) {
> > > > +               if (broadcast_ppc) {
> > > > +                       int cpu;
> > > > +
> > > > +                       for_each_possible_cpu(cpu)
> > > > +                               cpufreq_update_policy(cpu);
> > > > +               } else {
> > > > +                       cpufreq_update_policy(pr->id);
> > > > +               }
> > > > +       }
> > > >  }
> > > >
> > > >  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index e35a886e00bc..95e08816b512 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > > >
> > > >         policy->min = new_policy->min;
> > > >         policy->max = new_policy->max;
> > > > +       policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > > > +       policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> > > >         trace_cpu_frequency_limits(policy);
> > > >
> > > >         policy->cached_target_freq = UINT_MAX;
> > > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > > index dd66decf2087..e1881313c396 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> > > >
> > > >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> > > >  {
> > > > +       int max_freq;
> > > >         struct cpudata *cpu = all_cpu_data[policy->cpu];
> > > >
> > > >         update_turbo_state();
> > >
> > > Well, update_turbo_state() should handle the case at hand already.
> > >
> > > That's what it's for actually: It checks if
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE is set and sets
> > > global.turbo_disabled is that's the case.
> > >
> > > Why isn't that sufficient?
> > >
> > update_turbo_state() changes the flag of global.turbo_diabled but we
> > need to also leverage it to adjust the policy.max accordingly. This is why
> > we add intel_pstate_get_max_freq() to get the updated max freq in
> > intel_pstate_verify_policy().
> 
> Yes, that's why intel_pstate_verify_policy() passes the return value
> of intel_pstate_get_max_freq() as the second arg
> cpufreq_verify_within_limits(), so really my question was about why
> cpuinfo.max_freq needed to be updated (below).
>
Ok.
> > > > +       max_freq = intel_pstate_get_max_freq(cpu);
> > > > +
> > > > +       if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> > > > +           max_freq != policy->cpuinfo.max_freq) {
> > > > +               /*
> > > > +                * System was not running under any constraints, but the
> > > > +                * current max possible frequency is changed. So reset
> > > > +                * policy limits.
> > > > +                */
> > > > +               policy->cpuinfo.max_freq = policy->max = max_freq;
> > > > +       }
> > >
> > > Why does policy->cpuinfo.max_freq need to be updated?
> > >
> > This is my understanding:
> > There's a corner case that, if the system boots with battery,
> > the max cpu frequency will not scale up if we plug the AC later.
> 
> I see.  The *initial* cpuinfo.max_freq may be too low.  This part is
> missing from your patch changelog.
> 
> The driver is not expected to update cpuinfo.max_freq after init.
> That may not actually break anything, even though it is racy in
> principle, but if it is done, it needs to be done in the "passive"
> mode too and that may be more problematic.
> 
Do you mean updating it for "passive" mode might not be suitable?
> Anyway, this is more fundamental than you seem to be thinking.
> 
> > According to the log provided by Gabriele Mazzotta,  if the system
> > boot up with battery, then plug the AC after boot up, the max perf ratio
> > and policy->cpuinfo.max will remain 17 rather than increasing to
> > 30(when AC plugged thus turbo enabled):
> >
> > [   52.158810] CPU 0: _PPC is 6 - frequency  limited
> > [   52.158822] intel_pstate: set_policy cpuinfo.max 1700000 policy->max 1700000
> > [   52.158825] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:17
> > [   52.158827] intel_pstate: cpu:0 global_min:8 global_max:30
> > [   52.158829] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8
> >
> > This is caused by:
> > In current intel_pstate, there's only one chance for policy.cpuinfo.max to get updated
> > which is during boot up in __intel_pstate_cpu_init(). If the turbo status changes,
> > we might need to also update the policy->cpuinfo.max to tell user that the hardware
> > status has changed.
> >
> > So we give it a chance to adjust the policy.cpuinfo.max and policy.max in
> > cpufreq_driver->verify()  according to turbo status, this is what this patch mainly
> > aims to do.
> >
> > Besides, since on this platform there's only one _PPC notification for one CPU, it is
> > necessary to broadcast the notification to all CPUs on this package. And this patch
> > broadcast it to all online CPUs to make the change simpler.
> 
> You're trying to make two substantial changes in one go, broadcasting
> _PPC and updating cpuinfo.max_freq.  Don't do that, they need to be
> separate changes.
Ok, I'll send version 2 out which is composed of two modifications to
address different problems.
> 
> Moreover, we may want to address the initial cpuinfo.max_freq issue in
> a different way.
Adjust the cpuinfo.max_freq in .verify() seems to be a proper place since
this callback is invoked at a very early stage for both active and passive
mode, and I did not see race condition for them. (Could not quite catch
what we talked last time on this, if you have proposed another suggestion
on how to update the cpuinfo.max_freq) :)


Thanks,
Ryan(Yu)

> 
> Thanks,
> Rafael
