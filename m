Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D57D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554111123;
	bh=0sX0W/BpVAUDuqhGRD7xBaYiCf+GuBPawkIZ80JxB80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VIx4qHkDuwiS9WuZXtoM2g/PC7MwZP5s/M093Z0GVzf9fwL9y/koC2HXSqN2STiqQ
	 Cms6cSVGIv+O1+ab0JjdrDL3333jEAGFPD4mNqkMGa7sQ6Lc2NTLbhMEs+f4Ws0Th0
	 4dkROa6sAgMrqWHKbkDJfkG5Hx85+/Q5oZ8okBm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDAJcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:32:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33094 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDAJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:32:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id e5so6700250oii.0;
        Mon, 01 Apr 2019 02:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t31L03I7BjDyeqK9NAkTvlRk8RHmZJvcPHLVlnyctNY=;
        b=ZlWS6+91T0EePPsqYtke02FLNTYfq/cgIU3aorZgchOISHfUq2R3/B/uVkqDduLAlp
         1Kv2auH1ZGjCurv7IcUIYgNnxLNHCIeB7YR49+dYhbQvRKWT17+glAmozedPi6QrQSBx
         tymd14GyaKrUL8JG7TfPsDmb88qE1iZto4LprjVH5qeE8l+zUkXAafdeW64wJQMHJRxk
         6BLVNbbWB9b5lhUxMkHnRgrz9QW1M4ZEnaAjuIU7f7VT1srG1cMQ13cxbexCBftfsOK8
         6eP7Sk3/ALXgFkIlYUcaf593wB9dxyQo5TDdt5E8uawnndmX9ZUsh/j7oosV+MdUXO9u
         s8Gw==
X-Gm-Message-State: APjAAAUf270WB6vuQtRwsR8Z9bpg7D3U2nn3Eu1Mv0tfoaAnuLv1raJJ
        8kofK53nDbrwH7eTIdzBye1Eb/Gg5jAWagpUZDI=
X-Google-Smtp-Source: APXvYqwa822xcbziZofw3FZhHcGxE2qGleqWXgKrxjm4zDJH2VdcFkerfQMEnhgTMDw+4+yBvT88kzsKnuzfNRuh4RM=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr12261856oii.76.1554111120714;
 Mon, 01 Apr 2019 02:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190330112022.28888-1-bp@alien8.de> <20190330112022.28888-6-bp@alien8.de>
In-Reply-To: <20190330112022.28888-6-bp@alien8.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Apr 2019 11:31:49 +0200
Message-ID: <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
Subject: Re: [PATCH 5/5] drivers/cpufreq: Convert some slow-path
 static_cpu_has() callers to boot_cpu_has()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:20 PM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Using static_cpu_has() is pointless on those paths, convert them to the
> boot_cpu_has() variant.
>
> No functional changes.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpufreq/amd_freq_sensitivity.c |  2 +-
>  drivers/cpufreq/intel_pstate.c         | 18 +++++++++---------
>  drivers/cpufreq/powernow-k8.c          |  2 +-
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
> index 4ac7c3cf34be..6927a8c0e748 100644
> --- a/drivers/cpufreq/amd_freq_sensitivity.c
> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> @@ -124,7 +124,7 @@ static int __init amd_freq_sensitivity_init(void)
>                         PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
>
>         if (!pcidev) {
> -               if (!static_cpu_has(X86_FEATURE_PROC_FEEDBACK))
> +               if (!boot_cpu_has(X86_FEATURE_PROC_FEEDBACK))
>                         return -ENODEV;
>         }
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index e22f0dbaebb1..ea62e3f02d56 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -522,7 +522,7 @@ static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
>         u64 epb;
>         int ret;
>
> -       if (!static_cpu_has(X86_FEATURE_EPB))
> +       if (!boot_cpu_has(X86_FEATURE_EPB))
>                 return -ENXIO;
>
>         ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> @@ -536,7 +536,7 @@ static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
>  {
>         s16 epp;
>
> -       if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
> +       if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>                 /*
>                  * When hwp_req_data is 0, means that caller didn't read
>                  * MSR_HWP_REQUEST, so need to read and get EPP.
> @@ -561,7 +561,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
>         u64 epb;
>         int ret;
>
> -       if (!static_cpu_has(X86_FEATURE_EPB))
> +       if (!boot_cpu_has(X86_FEATURE_EPB))
>                 return -ENXIO;
>
>         ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> @@ -609,7 +609,7 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
>         if (epp < 0)
>                 return epp;
>
> -       if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
> +       if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>                 if (epp == HWP_EPP_PERFORMANCE)
>                         return 1;
>                 if (epp <= HWP_EPP_BALANCE_PERFORMANCE)
> @@ -618,7 +618,7 @@ static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
>                         return 3;
>                 else
>                         return 4;
> -       } else if (static_cpu_has(X86_FEATURE_EPB)) {
> +       } else if (boot_cpu_has(X86_FEATURE_EPB)) {
>                 /*
>                  * Range:
>                  *      0x00-0x03       :       Performance
> @@ -646,7 +646,7 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
>
>         mutex_lock(&intel_pstate_limits_lock);
>
> -       if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
> +       if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>                 u64 value;
>
>                 ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &value);
> @@ -821,7 +821,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>                 epp = cpu_data->epp_powersave;
>         }
>  update_epp:
> -       if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
> +       if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>                 value &= ~GENMASK_ULL(31, 24);
>                 value |= (u64)epp << 24;
>         } else {
> @@ -846,7 +846,7 @@ static void intel_pstate_hwp_force_min_perf(int cpu)
>         value |= HWP_MIN_PERF(min_perf);
>
>         /* Set EPP/EPB to min */
> -       if (static_cpu_has(X86_FEATURE_HWP_EPP))
> +       if (boot_cpu_has(X86_FEATURE_HWP_EPP))
>                 value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
>         else
>                 intel_pstate_set_epb(cpu, HWP_EPP_BALANCE_POWERSAVE);
> @@ -1194,7 +1194,7 @@ static void __init intel_pstate_sysfs_expose_params(void)
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  {
>         /* First disable HWP notification interrupt as we don't process them */
> -       if (static_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +       if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
>                 wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
>
>         wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index fb77b39a4ce3..3c12e03fa343 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1178,7 +1178,7 @@ static int powernowk8_init(void)
>         unsigned int i, supported_cpus = 0;
>         int ret;
>
> -       if (static_cpu_has(X86_FEATURE_HW_PSTATE)) {
> +       if (boot_cpu_has(X86_FEATURE_HW_PSTATE)) {
>                 __request_acpi_cpufreq();
>                 return -ENODEV;
>         }
> --
> 2.21.0
>
