Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8351B2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552555998;
	bh=bI5bboCbmNae0iMN5Iqf0O0HqbHQrQfoAIZTTAanZsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r/aEG7S6U0YTziZ4MSijuciU3C2qIGr33hUnaqZHFIzBSLravW/DV54no830ZJqbk
	 skfhJZRzzBxR1M0lgPMIJiKH/tTCrx4KdIrNVR3+WKAWT9gZmDPkfedwPCGeo187ML
	 NdAo8NWDxUPue8H1jaYCk3Rfcu5OGUH5+/Z26duk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfCNJdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:33:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34416 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:33:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id u12so898657oiv.1;
        Thu, 14 Mar 2019 02:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUqF8OjUje8fftoypgBqXO2tKnfm7ri8h2HDvV+nxb8=;
        b=EX9cyABCsW1UJ3LhZLcuYUF6gjEkIEV+qO/lQC7i2i4W3n9sRaDU4ADlpyGnwMIwwh
         6ElnTD5gyJjUhevtdbi6vq4d8MfDkUvj2qoNIAFrOuWb78afOoSFT9mU5Zb1Mzf2qw5F
         xNEvaq/RTI2kSXDPKhyqpqYletcDxAhWLiLE8eBTMlDsa0BPpcAQ+xW1csWgo6VNgcBE
         Yg/aqc2u+fRtai88q4AtH8YbM7Jh413PEHjS2AFFEom2i8kfzgwBaqic4sbw8RB8dIPj
         y2cAqH7K1kygP+yRpU359ybEXPqNdGY40BN6TH1Eprz0eg5TWkvGQwQ5hy7dp2PP6ROm
         WVVQ==
X-Gm-Message-State: APjAAAWdG5HAuwHAHywX8ctCSVDGIwCQcrosLFLQdHN5sFaval1VYgUu
        gBr20BWLsIM8iYEZ0NXJ5avtS4rvVPHaluQL6Ho=
X-Google-Smtp-Source: APXvYqzFYxFqOYtOjYFZ+SNG2fbFHL4RymJaghPsDPuaOmjXFIU859Hk6i/Cmo+77qlHo/q0goeTWgV4kGogu5k2jJw=
X-Received: by 2002:aca:88b:: with SMTP id 133mr1522470oii.95.1552555995434;
 Thu, 14 Mar 2019 02:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552545525.git.viresh.kumar@linaro.org> <8a27342332bc467242f6ccdb4d4bd4d10f8aa552.1552545525.git.viresh.kumar@linaro.org>
In-Reply-To: <8a27342332bc467242f6ccdb4d4bd4d10f8aa552.1552545525.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Mar 2019 10:33:04 +0100
Message-ID: <CAJZ5v0i=QoToW0WCaL50t0qe5sKSe6J3W+EnFTvYuVCp6MvZDA@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86/tsc: Update cpufreq transition notifier to handle
 multiple CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq core currently calls the cpufreq transition notifier
> callback once for each affected CPU. This is going to change soon and
> the cpufreq core will call the callback only once for each cpufreq
> policy. The callback must look at the newly added field in struct
> cpufreq_freqs, "cpus", which contains policy->related_cpus (both
> online/offline CPUs) and perform per-cpu actions for them if any.
>
> This patch updates time_cpufreq_notifier() to use the new "cpus" field,
> update per-cpu data for all the related CPUs and call set_cyc2ns_scale()
> for all online related_cpus.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/x86/kernel/tsc.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 3fae23834069..587a6aa72f38 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -956,28 +956,37 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
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
> +                       loops_per_jiffy_ref = cpu_data(cpumask_first(freq->cpus)).loops_per_jiffy;
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
> +                       for_each_cpu(cpu, freq->cpus)

This needs to iterate over policy->cpus or you change the behavior.

Not that it will matter a lot (x86 in one CPU per policy anyway in the
vast majority of cases), but it is a change nevertheless.  Moreover,
I'm not even sure if doing that for offline CPUs makes sense.

> +                               cpu_data(cpu).loops_per_jiffy = lpj;
> +               }
> +
> +               for_each_cpu_and(cpu, freq->cpus, cpu_online_mask)
> +                       set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
>         }
>
>         return 0;
> --
