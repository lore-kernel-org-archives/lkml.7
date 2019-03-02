Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FF6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D892083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCBKJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:09:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:19120 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfCBKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:09:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2019 02:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,431,1544515200"; 
   d="scan'208";a="122061993"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2019 02:07:42 -0800
Date:   Sat, 2 Mar 2019 18:16:34 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 1/2][RFC v2] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC
Message-ID: <20190302101634.GB7044@chenyu-office.sh.intel.com>
References: <cover.1551375162.git.yu.c.chen@intel.com>
 <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
 <CAJZ5v0iw=THw4Cr7asFoNdUaAu7tG0nz0S4NWzqxGEDvyS11ng@mail.gmail.com>
 <CAJZ5v0gW_KW9J2q=s3PqjY8C4otP51NuEPkTQKvYvr=ce6556g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gW_KW9J2q=s3PqjY8C4otP51NuEPkTQKvYvr=ce6556g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:34:46AM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 28, 2019 at 11:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Feb 28, 2019 at 6:59 PM Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > On some problematic platforms, the _PPC notifier is
> > > only delivered to one CPU, which might cause information
> > > inconsistent between CPUs within the package. Thus introduce a boot up parameter to broadcast this _PPC notifier onto all
> > > online CPUs.
> > >
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > > index a303fd0e108c..737dbf5aa7f7 100644
> > > --- a/drivers/acpi/processor_perflib.c
> > > +++ b/drivers/acpi/processor_perflib.c
> > > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> > >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> > >                  "limited by BIOS, this should help");
> > >
> > > +static int broadcast_ppc;
> > > +module_param(broadcast_ppc, int, 0644);
> > > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > > +
> > >  #define PPC_REGISTERED   1
> > >  #define PPC_IN_USE       2
> > >
> > > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> > >                 else
> > >                         acpi_processor_ppc_ost(pr->handle, 0);
> > >         }
> > > -       if (ret >= 0)
> > > -               cpufreq_update_policy(pr->id);
> > > +       if (ret >= 0) {
> > > +               if (broadcast_ppc) {
> > > +                       int cpu;
> > > +
> > > +                       for_each_possible_cpu(cpu)
> > > +                               cpufreq_update_policy(cpu);
> >
> > This doesn't actually help AFAICS, because it only causes
> > acpi_processor_ppc_notifier() to be called for all policies, but
> > pr->performance_platform_limit is re-computed for the target CPU only
> > anyway, so the limit will only be applied to that one.
> >
> > What happens in the BZ is that invoking cpufreq_update_policy() for
> > all CPUs causes ->verify() to run on all of them which triggers
> > update_turbo_state() and cpuinfo.max_freq update, because
> > global.turbo_disabled has changed.
> >
> > That is rather less than straightforward and intel_pstate really
> > doesn't need any _PPC change notifications to notice that the
> > MSR_IA32_MISC_ENABLE_TURBO_DISABLE bit has changed as it checks that
> > bit on every P-state update.
> 
> Which admittedly may not be necessary if notifications are delivered.
> 
> I still don't think that updating all policies from
> acpi_processor_ppc_has_changed() is a good idea, but yes, there is a
> problem that if MSR_IA32_MISC_ENABLE_TURBO_DISABLE goes from set to
> unset, all policies need to be updated to update policy->max
> accordingly, 
Agree. policy->max might needed to be updated otherwise we might
not get correct cpufreq limit range. According to the report log
from bugzilla, if the system boots without AC and then plug the AC
after boot up, the max_perf_ratio would be incorrect because policy->max
is not updated.

# Plug the AC:

[   52.158810] CPU 0: _PPC is 6 - frequency  limited
[   52.158822] intel_pstate: set_policy cpuinfo.max 1700000 policy->max 1700000
[   52.158825] intel_pstate: cpu:0 max_state 30 min_policy_perf:8 max_policy_perf:17
[   52.158827] intel_pstate: cpu:0 global_min:8 global_max:30
[   52.158829] intel_pstate: cpu:0 max_perf_ratio:17 min_perf_ratio:8

Thanks,
Yu
> so looking at MSR_IA32_MISC_ENABLE_TURBO_DISABLE from
> within the driver without triggering a policy update is not
> sufficient.
