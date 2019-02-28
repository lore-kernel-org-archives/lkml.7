Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700CBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A52205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551392334;
	bh=E3W0KdqcKhB4dprnomioCONPe5/IHeyxzHd+Gkjc9JE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NmX85hLEVxsnT7GsfEN2gfIjDjJS1317x8lGp2fz/2FZwINP1fIABzjIuSe0DK77l
	 ZJZgzeSCrvGpUxudugPVxg6Gmcv7IJTDcqUyJXHC7gPKYo44YDaV10Dbexn/52DJgy
	 dlHicDihRpsBXXYi4Ncl7z+CLUx6GVcqOiLhW/CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfB1WSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:18:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34543 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfB1WSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:18:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so19255617oty.1;
        Thu, 28 Feb 2019 14:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ji3mmE4+UtF9krUdy/zdGVH41oTqTHXFLEm6pMEOivc=;
        b=NyzqxHIG0lu6wDBA8OtZVudS/dlmkRuU5QQIbdhR5KeYAFhDSMJzwdmBrgRq5e7rMV
         AsjwHO4irKjl0hBgLGRnm50X2GAEyLvKXFdJN7vkeSCFmRJ30JelEHwG0yvTwaxedUKF
         tIlA6kNihow7G8o6cXEEeqB7J3Mizt/cw1P7iaC2UqbIncUH/Y4B8XUbvSVttuAwPFxe
         bzZkam4erOyOPwgIX6fEKd07QE/LJt9UzKJnlZrxvov9ziovlopBDVJEzyR1kU/c8qZa
         QzX2KNHALXhrdas10OUklwU/n6X80sh/m/aUni6/Mzh6PlU6gDtayvOsTU10l8sBTPpM
         OzWg==
X-Gm-Message-State: APjAAAXUeq09VLdQ+dXQ4rpX2wbLI1CgTitLTfRynBuyHuc7U1JQp65i
        zTkHqDHvfh2vQStXNMEDj2BXhFXTbgdn8ynzEoI=
X-Google-Smtp-Source: APXvYqxXSw1Qui4ZYPO6iSzmteYd7OfkgJRg6kRdGl9ikhj0FTCqSbv6u9qjPM8c3JHnliGj1YDB7yN2obMLcRdYSfc=
X-Received: by 2002:a9d:7547:: with SMTP id b7mr1285722otl.244.1551392331152;
 Thu, 28 Feb 2019 14:18:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551375162.git.yu.c.chen@intel.com> <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
In-Reply-To: <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Feb 2019 23:18:39 +0100
Message-ID: <CAJZ5v0iw=THw4Cr7asFoNdUaAu7tG0nz0S4NWzqxGEDvyS11ng@mail.gmail.com>
Subject: Re: [PATCH 1/2][RFC v2] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC
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
> On some problematic platforms, the _PPC notifier is
> only delivered to one CPU, which might cause information
> inconsistent between CPUs within the package. Thus introduce a boot up parameter to broadcast this _PPC notifier onto all
> online CPUs.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index a303fd0e108c..737dbf5aa7f7 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
>  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
>                  "limited by BIOS, this should help");
>
> +static int broadcast_ppc;
> +module_param(broadcast_ppc, int, 0644);
> +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> +
>  #define PPC_REGISTERED   1
>  #define PPC_IN_USE       2
>
> @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
>                 else
>                         acpi_processor_ppc_ost(pr->handle, 0);
>         }
> -       if (ret >= 0)
> -               cpufreq_update_policy(pr->id);
> +       if (ret >= 0) {
> +               if (broadcast_ppc) {
> +                       int cpu;
> +
> +                       for_each_possible_cpu(cpu)
> +                               cpufreq_update_policy(cpu);

This doesn't actually help AFAICS, because it only causes
acpi_processor_ppc_notifier() to be called for all policies, but
pr->performance_platform_limit is re-computed for the target CPU only
anyway, so the limit will only be applied to that one.

What happens in the BZ is that invoking cpufreq_update_policy() for
all CPUs causes ->verify() to run on all of them which triggers
update_turbo_state() and cpuinfo.max_freq update, because
global.turbo_disabled has changed.

That is rather less than straightforward and intel_pstate really
doesn't need any _PPC change notifications to notice that the
MSR_IA32_MISC_ENABLE_TURBO_DISABLE bit has changed as it checks that
bit on every P-state update.

So no, we are not going to do this to fix the particular issue at hand.

> +               } else {
> +                       cpufreq_update_policy(pr->id);
> +               }
> +       }
>  }
>
>  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> --
> 2.17.1
>
