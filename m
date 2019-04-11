Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAEBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B332184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bek5m09f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDKNXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:23:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40425 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKNXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:23:34 -0400
Received: by mail-vs1-f66.google.com with SMTP id f22so3437723vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2d1yd/JBbe6hgn9kQns+hXImOPS17dZugPzl5GzS5d8=;
        b=bek5m09fqEHc7m66H3PWXmTfiVG22rZqE4nQ54xPf8NtGXrP4iYE6COMhPPxPb+i4r
         A3Pqj3F34BH+2MMGlr5npQNeG5xX3XVhGThz2f4BcGFGQ+z6OysVXKtPL7reXOxbL+Cp
         Tm/8IjZJsqUTSKra5oOaDd5Lc7j2d38aoJ2O4gI5LTWRz5zdjpUcm6M4Otp76iLhdwJ1
         NAdzAo6x8fUiqiLrEwHN5aYXUy7+0gQwt42QQK1yWs+D60zp5pH/uY/qZvThc/t7ViyX
         S8KM/DmwznFlfyKJO48l2NzwlURJE1i7cPkEPa4bBi+Nr1uBJ8gPBtwayLhN0xt4nW4+
         hNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2d1yd/JBbe6hgn9kQns+hXImOPS17dZugPzl5GzS5d8=;
        b=CoUZFLD2E9PrsIbJ5EZ4SCGPFbk+TP3Hb21sJ6aWfoxrHPw77fTccsAT0slStXlL+r
         ZQ5ix0ZtYSbzV0dlLUhUWdm9fOQoe+op91tU1K5YRWBQohpXwgF428eGCBtkDWUNiAkR
         xeTZyVyXAqoHPrjSevdXGlETBxl8LUSjxN/oUiuO2qoSu1NTdCbiap1lx98tmACjSwYH
         xj1vBQstXMBDWRCbuEvCjD5R4eGWGK+tY9a4fn3WiJwesP+WKo5BaDtsnCzHcdyZsTRC
         B5WUR5jwqg5+bKR3sAMap8qHAlZleCWL6jj3fpE8rCc9xod8/VW6mwNcs2ukcGSgJWIG
         v5hw==
X-Gm-Message-State: APjAAAXipFK4hReUyuFhvKmDPby5bfxg5V0L8fUGaefAIIvalcOie1VT
        xhR53kxuvyeZVHlNxCMZ/8KkJX/QTb5KWq2qKMZmmw==
X-Google-Smtp-Source: APXvYqwZYYxtFF1gHO8/JaPGrrxDAajcSNNOp9x/BOG7VMqHZnXfNKUlQu+aH53P4XmI82NZt49t/XatMiPEMr35EjM=
X-Received: by 2002:a67:fa95:: with SMTP id f21mr27327807vsq.180.1554989012413;
 Thu, 11 Apr 2019 06:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411124739.5542-1-cai@lca.pw>
In-Reply-To: <20190411124739.5542-1-cai@lca.pw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 15:22:56 +0200
Message-ID: <CAPDyKFqmP3pORhufTsCg1nuqSPGz8hEQNTpZgr24fFqk13hM3w@mail.gmail.com>
Subject: Re: [PATCH -next] power/domain_governor: fix a compilation error
To:     Qian Cai <cai@lca.pw>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Lina Iyer <lina.iyer@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 14:48, Qian Cai <cai@lca.pw> wrote:
>
> The commit 50899f7d5078 ("PM / Domains: Add genpd governor for CPUs")
> introduced a compilation error on arm64 with CONFIG_CPU_IDLE=n because
> cpuidle_devices is undefined there.
>
> drivers/base/power/domain_governor.o: In function `cpu_power_down_ok':
> drivers/base/power/domain_governor.c:263: undefined reference to
> 'cpuidle_devices' ld: drivers/base/power/domain_governor.o: relocation
> R_AARCH64_ADR_PREL_PG_HI21 against symbol 'cpuidle_devices' which may
> bind externally can not be used when making a shared object; recompile
> with -fPIC
> drivers/base/power/domain_governor.c:263:(.text+0x638): dangerous
> relocation: unsupported relocation
> drivers/base/power/domain_governor.c:263: undefined reference to
> 'cpuidle_devices'
> make: *** [Makefile:1047: vmlinux] Error 1
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Qian, thanks for you patch!

> ---
>  drivers/base/power/domain_governor.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 39c8a699cb53..252d88fcf760 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -270,11 +270,13 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>          */
>         domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
>         for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> -               dev = per_cpu(cpuidle_devices, cpu);
> -               if (dev) {
> -                       next_hrtimer = READ_ONCE(dev->next_hrtimer);
> -                       if (ktime_before(next_hrtimer, domain_wakeup))
> -                               domain_wakeup = next_hrtimer;
> +               if (IS_ENABLED(CONFIG_CPU_IDLE)) {
> +                       dev = per_cpu(cpuidle_devices, cpu);
> +                       if (dev) {
> +                               next_hrtimer = READ_ONCE(dev->next_hrtimer);
> +                               if (ktime_before(next_hrtimer, domain_wakeup))
> +                                       domain_wakeup = next_hrtimer;
> +                       }

This works as quick fix, but I think there is two possible options
that is probably better in long run.

1) Extend the cpuidle interface with a new function:

struct cpuidle_device *cpuidle_get_cpu_device(unsigned int cpu)

Then when CONFIG_CPU_IDLE is unset, we can just have a stub function
returning NULL.

2) Have the struct dev_power_governor pm_domain_cpu_gov to be defined
(and the corresponding functionality), but only when CONFIG_CPU_IDLE
is set and when CONFIG_PM_GENERIC_DOMAINS is set.

Kind regards
Uffe
