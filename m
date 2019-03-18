Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A4A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552909767;
	bh=JL1IcqxkxU+NWYSxLuh49drWFgA9F7DOVQ0dnkASs9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p8u0p4Qc7U1klX4G7bNe/AMlEu8UiCoHBIHVjOqJzmPm4CG1AZ9ca4D9kOClfRVYY
	 x0Ba/yvXhOelrBUyeggxEcWbgNm+rYZMIDd9+kUSLUbxQNLg+3ee6wSDTukonLtJp4
	 bCRG3aHptcCh4MCmdGhMcH6FWju1BabhOwKT2MiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCRLt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:49:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44279 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfCRLtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:49:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so338886otl.11;
        Mon, 18 Mar 2019 04:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlUW/qR/H3uh4EzFlw3Ofj1Y4cEh9+ckYCx5uTGax54=;
        b=g2wNIjHOFLzSxVgpybgalmXTgjgFSwRmdoDSl23necNOnDhdp8KjuKlMDi86cfPnBK
         7ZSu4W74EQQSVeJnSFTnhSRMu87Pb3GLblYyxv+Wdr7V/P3xM+3+yy6eGw/xlyF1g1ZJ
         IbkpcIShgf9d08lU3clMYYP085pfRB+++PMd0phL+9Y6dIswFrK08TnlTZpocR0iRDUF
         6sZLAsJ/+1kVSJyOL7Fvug8fpoXBW2w4inU24dovSppy5v3mCsOWtZo5+iPHvHZiSFJ4
         SbuE8kKNm+bcLBizGqKF3kc2DLrO+9J0YlbL6EnJFuEqyDE+XtdgfjxX2fSP9GkDKpNN
         TF5g==
X-Gm-Message-State: APjAAAXNMugBJ96pufDYKUfh4acq3LD7YnwsbespTQwDtzfG5yR2hu7X
        OtBibsXH2tOA7euJVSaZzkqRUusaa9SUbn2vySc=
X-Google-Smtp-Source: APXvYqy3kV9XeFAHAnnBwmnOXV3Cci5VIZDqokAe8XfJPKfbkHfTKfvd/isF0axrhqaTQ8eoDaDiiI1p2yX0J0G2/rM=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr10750083otl.343.1552909764463;
 Mon, 18 Mar 2019 04:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
In-Reply-To: <e2b56be446eeb67f1905d2ac6f8d82dd4389d0c5.1552640968.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Mar 2019 12:49:13 +0100
Message-ID: <CAJZ5v0jr-XJ6VbNf3ipYQuycah-GNZKLgGe5wGknkWF7bKSY2w@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: Call transition notifier only once for each policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Currently we call these notifiers once for each CPU of the policy->cpus
> cpumask. It would be more optimal if the notifier can be called only
> once and all the relevant information be provided to it. Out of the 24
> drivers that register for the transition notifiers today, only 5 of them
> do per-cpu updates and the callback for the rest can be called only once
> for the policy without any impact.
>
> This would also avoid multiple function calls to the notifier callbacks
> and reduce multiple iterations of notifier core's code (which does
> locking as well).
>
> This patch adds pointer to the cpufreq policy to the struct
> cpufreq_freqs, so the notifier callback has all the information
> available to it with a single call. The five drivers which perform
> per-cpu updates are updated to use the cpufreq policy. The freqs->cpu
> field is redundant now and is removed.
>
> Acked-by: David S. Miller <davem@davemloft.net> (sparc)
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Add cpufreq policy instead of cpus in struct cpufreq_freqs.
> - Use policy->cpus instead of related_cpus everywhere in order not to
>   change the existing behavior.
> - Merged all 7 patches into a single patch.
> - Updated changlog and included Ack from David.
>
>  arch/arm/kernel/smp.c       | 24 +++++++++++++++---------
>  arch/arm/kernel/smp_twd.c   |  9 ++++++---
>  arch/sparc/kernel/time_64.c | 28 ++++++++++++++++------------
>  arch/x86/kernel/tsc.c       | 32 +++++++++++++++++++++-----------
>  arch/x86/kvm/x86.c          | 31 ++++++++++++++++++++-----------
>  drivers/cpufreq/cpufreq.c   | 19 ++++++++++---------
>  include/linux/cpufreq.h     | 14 +++++++-------
>  7 files changed, 95 insertions(+), 62 deletions(-)
>
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 1d6f5ea522f4..6f6b981fecda 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -758,15 +758,20 @@ static int cpufreq_callback(struct notifier_block *nb,
>                                         unsigned long val, void *data)
>  {
>         struct cpufreq_freqs *freq = data;
> -       int cpu = freq->cpu;
> +       struct cpumask *cpus = freq->policy->cpus;
> +       int cpu, first = cpumask_first(cpus);
> +       unsigned int lpj;
>
>         if (freq->flags & CPUFREQ_CONST_LOOPS)
>                 return NOTIFY_OK;
>
> -       if (!per_cpu(l_p_j_ref, cpu)) {
> -               per_cpu(l_p_j_ref, cpu) =
> -                       per_cpu(cpu_data, cpu).loops_per_jiffy;
> -               per_cpu(l_p_j_ref_freq, cpu) = freq->old;
> +       if (!per_cpu(l_p_j_ref, first)) {
> +               for_each_cpu(cpu, cpus) {
> +                       per_cpu(l_p_j_ref, cpu) =
> +                               per_cpu(cpu_data, cpu).loops_per_jiffy;
> +                       per_cpu(l_p_j_ref_freq, cpu) = freq->old;
> +               }
> +
>                 if (!global_l_p_j_ref) {
>                         global_l_p_j_ref = loops_per_jiffy;
>                         global_l_p_j_ref_freq = freq->old;
> @@ -778,10 +783,11 @@ static int cpufreq_callback(struct notifier_block *nb,
>                 loops_per_jiffy = cpufreq_scale(global_l_p_j_ref,
>                                                 global_l_p_j_ref_freq,
>                                                 freq->new);
> -               per_cpu(cpu_data, cpu).loops_per_jiffy =
> -                       cpufreq_scale(per_cpu(l_p_j_ref, cpu),
> -                                       per_cpu(l_p_j_ref_freq, cpu),
> -                                       freq->new);
> +
> +               lpj = cpufreq_scale(per_cpu(l_p_j_ref, first),
> +                                   per_cpu(l_p_j_ref_freq, first), freq->new);
> +               for_each_cpu(cpu, cpus)
> +                       per_cpu(cpu_data, cpu).loops_per_jiffy = lpj;
>         }
>         return NOTIFY_OK;
>  }
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index b30eafeef096..495cc7282096 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -162,15 +162,18 @@ static int twd_cpufreq_transition(struct notifier_block *nb,
>         unsigned long state, void *data)
>  {
>         struct cpufreq_freqs *freqs = data;
> +       int cpu;
>
>         /*
>          * The twd clock events must be reprogrammed to account for the new
>          * frequency.  The timer is local to a cpu, so cross-call to the
>          * changing cpu.
>          */
> -       if (state == CPUFREQ_POSTCHANGE)
> -               smp_call_function_single(freqs->cpu, twd_update_frequency,
> -                       NULL, 1);
> +       if (state != CPUFREQ_POSTCHANGE)
> +               return NOTIFY_OK;
> +
> +       for_each_cpu(cpu, freqs->policy->cpus)
> +               smp_call_function_single(cpu, twd_update_frequency, NULL, 1);
>
>         return NOTIFY_OK;
>  }
> diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
> index 3eb77943ce12..89fb05f90609 100644
> --- a/arch/sparc/kernel/time_64.c
> +++ b/arch/sparc/kernel/time_64.c
> @@ -653,19 +653,23 @@ static int sparc64_cpufreq_notifier(struct notifier_block *nb, unsigned long val
>                                     void *data)
>  {
>         struct cpufreq_freqs *freq = data;
> -       unsigned int cpu = freq->cpu;
> -       struct freq_table *ft = &per_cpu(sparc64_freq_table, cpu);
> +       unsigned int cpu;
> +       struct freq_table *ft;
>
> -       if (!ft->ref_freq) {
> -               ft->ref_freq = freq->old;
> -               ft->clock_tick_ref = cpu_data(cpu).clock_tick;
> -       }
> -       if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> -           (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> -               cpu_data(cpu).clock_tick =
> -                       cpufreq_scale(ft->clock_tick_ref,
> -                                     ft->ref_freq,
> -                                     freq->new);
> +       for_each_cpu(cpu, freq->policy->cpus) {
> +               ft = &per_cpu(sparc64_freq_table, cpu);
> +
> +               if (!ft->ref_freq) {
> +                       ft->ref_freq = freq->old;
> +                       ft->clock_tick_ref = cpu_data(cpu).clock_tick;
> +               }
> +
> +               if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
> +                   (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> +                       cpu_data(cpu).clock_tick =
> +                               cpufreq_scale(ft->clock_tick_ref, ft->ref_freq,
> +                                             freq->new);
> +               }
>         }
>
>         return 0;
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3fae23834069..cff8779fc0d2 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -956,28 +956,38 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
>                                 void *data)
>  {
>         struct cpufreq_freqs *freq = data;
> -       unsigned long *lpj;
> -
> -       lpj = &boot_cpu_data.loops_per_jiffy;
> -#ifdef CONFIG_SMP
> -       if (!(freq->flags & CPUFREQ_CONST_LOOPS))
> -               lpj = &cpu_data(freq->cpu).loops_per_jiffy;
> -#endif
> +       struct cpumask *cpus = freq->policy->cpus;
> +       bool boot_cpu = !IS_ENABLED(CONFIG_SMP) || freq->flags & CPUFREQ_CONST_LOOPS;
> +       unsigned long lpj;
> +       int cpu;
>
>         if (!ref_freq) {
>                 ref_freq = freq->old;
> -               loops_per_jiffy_ref = *lpj;
>                 tsc_khz_ref = tsc_khz;
> +
> +               if (boot_cpu)
> +                       loops_per_jiffy_ref = boot_cpu_data.loops_per_jiffy;
> +               else
> +                       loops_per_jiffy_ref = cpu_data(cpumask_first(cpus)).loops_per_jiffy;
>         }
> +
>         if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
>                         (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
> -               *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
> -
> +               lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
>                 tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
> +
>                 if (!(freq->flags & CPUFREQ_CONST_LOOPS))
>                         mark_tsc_unstable("cpufreq changes");
>
> -               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> +               if (boot_cpu) {
> +                       boot_cpu_data.loops_per_jiffy = lpj;
> +               } else {
> +                       for_each_cpu(cpu, cpus)
> +                               cpu_data(cpu).loops_per_jiffy = lpj;
> +               }
> +
> +               for_each_cpu(cpu, cpus)
> +                       set_cyc2ns_scale(tsc_khz, cpu, rdtsc());

To summarize, I think that it would be sufficient to do this just for
policy->cpu and, as Peter said, warn once if there are more CPUs in
the policy or policy->cpu is not the CPU running this code.  And mark
the TSC as unstable in both of these cases.
