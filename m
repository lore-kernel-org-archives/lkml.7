Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A626CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70565206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551394623;
	bh=0xGCQmLekdN16fDGUN/dV7pLZwARg8WAvilA2Qut8d4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z4Ju3zTrA/yBgpVoOr5IA5Wo9eWmwyHB2oSlKx1UNtLOdGoRrLlzqORVLSYlWkd8G
	 BinR5PSJwYKvEyWV6VMsJC8xbsjzQ3rakLdBFS2zs4kMtUGeNzETI9IcUxLXqHtRuL
	 RqpmvZirGfnUhTiMHZRNio9qAUmago0cLAwJvzIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbfB1W5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:57:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46914 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfB1W5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:57:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id c18so19239635otl.13;
        Thu, 28 Feb 2019 14:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRJsSnyF/XTs3NecXPZWkb0YNUZklytRPh8uab7VC1g=;
        b=FfbrW2pFMY9mSC7fnOQPrrV2l3kyBAPHgQ+E0sfjnp5lhGk96hlazg4YSTnt0Ivb7R
         /gOh8aHqJSoLg9en5xjhNH3cOxq0l6eSxBkaJJULoOffnrlpxDcs71Hln/h1fG4RL53Z
         YfdbXYRPSwdgRF5KORNl3GPqhjbz0bRjf4LV+wMGT2G8h8AatopvOobCzUOoAlm3aO5Z
         j2y9JEXnOGPzpvxweliCde6IvGpNLTbwuEiGiiXmLupfoMH1KqHPVmQ8w0PHq3ZeInYr
         O9q+6KwW7I0me5PrLGvKQvjukFa1LmLsr3aUJnohVVKaGN7qc0l8UdGBz2MP5RY7O763
         E+Ow==
X-Gm-Message-State: APjAAAX4P+qLXNkERweHFO6kiUf2JHkikKMhqCFOZIHwoEhxwCerf+KY
        X7cUl4WXN5WQHjHRsIxzBdjBmcMHQEdMdmpYSHY=
X-Google-Smtp-Source: APXvYqzxbNhesdcsjooXdprohaBMaMze6H6r5jXmM9pfKxUB0LBnIgJaymJDTkQJSSsirl5PMDfUspRS9CbPSvb3F0w=
X-Received: by 2002:a9d:7cd3:: with SMTP id r19mr1443384otn.139.1551394619852;
 Thu, 28 Feb 2019 14:56:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551375162.git.yu.c.chen@intel.com> <bd3c5e04e882e5a4c977211a8d268440b36276a4.1551375162.git.yu.c.chen@intel.com>
In-Reply-To: <bd3c5e04e882e5a4c977211a8d268440b36276a4.1551375162.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Feb 2019 23:56:48 +0100
Message-ID: <CAJZ5v0g4CGfAMH0pM-wWSt6pXZrw3ckqBbbUzNwjqScwRjrK3g@mail.gmail.com>
Subject: Re: [PATCH 2/2][RFC v2] ACPI: Update cpuinfo.max after bootup if necessary
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Chen <yu.chen.surf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 6:59 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Dell Inc. XPS13 9333, the BIOS changes the value of
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> the power source changes), the maximum frequency of the
> CPU is not updated accordingly. This is due to the policy's
> cpuinfo.max is not updated when _PPC notifier fires.
>
> Fix this problem by updating the policy's cpuinfo.max when
> necessary.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c      |  2 ++
>  drivers/cpufreq/intel_pstate.c | 15 +++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..95e08816b512 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>
>         policy->min = new_policy->min;
>         policy->max = new_policy->max;
> +       policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> +       policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
>         trace_cpu_frequency_limits(policy);
>
>         policy->cached_target_freq = UINT_MAX;
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index dd66decf2087..841c74f69f66 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2081,11 +2081,17 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
>
>  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
>  {
> +       int max_freq;
>         struct cpudata *cpu = all_cpu_data[policy->cpu];
>
>         update_turbo_state();
> +       max_freq = intel_pstate_get_max_freq(cpu);
> +
> +       if (acpi_ppc && max_freq != policy->cpuinfo.max_freq)
> +               policy->cpuinfo.max_freq = policy->max = max_freq;

Updating cpuinfo.max_freq here only causes the current limit to be
reported via sysfs, because intel_pstate doesn't actually use
cpuinfo.max_freq for anything and the core doesn't enforce it as a
limit.

All of the computations in the active mode in the driver actually use
the current limit anyway AFAICS.

> +
>         cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -                                    intel_pstate_get_max_freq(cpu));
> +                                    max_freq);
>
>         if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
>             policy->policy != CPUFREQ_POLICY_PERFORMANCE)
> @@ -2192,11 +2198,16 @@ static struct cpufreq_driver intel_pstate = {
>
>  static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
>  {
> +       int max_freq;
>         struct cpudata *cpu = all_cpu_data[policy->cpu];
>
>         update_turbo_state();
> +       max_freq = intel_pstate_get_max_freq(cpu);
> +
> +       if (acpi_ppc && max_freq != policy->cpuinfo.max_freq)
> +               policy->cpuinfo.max_freq = policy->max = max_freq;

In this case (passive mode) updating cpuinfo.max_freq will actually
cause governors to use the new value in computations, so the P-state
selection will work somewhat differently, but that isn't really
consistent with what acpi-cpufreq does and with setting no_turbo in
the intel_pstate sysfs to 1 without this patch.

With acpi-cpufreq cpuinfo.max_freq is always the max frequency in the
_PSS table regardless of what the _PSS limit is.  Also setting
no_turbo to 1 in intel_pstate without this patch doesn't cause
cpuinfo.max_freq to change and I don't really think that it should.

I would be tempted to always initialize cpuinfo.max_freq to the max
turbo frequency, but there is a concern about systems in which
MSR_IA32_MISC_ENABLE_TURBO_DISABLE is never set on the fly (just in
the BIOS setup as it should be) and where it doesn't make sense to
consider turbo frequencies at all.

>         cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -                                    intel_pstate_get_max_freq(cpu));
> +                                    max_freq);
>
>         intel_pstate_adjust_policy_max(policy, cpu);
>
> --

It looks like I need to think about this a bit more.
