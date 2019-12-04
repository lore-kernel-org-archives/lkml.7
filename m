Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F86C432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C27207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXSAnLTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLDE1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:27:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41167 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDE1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:27:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id v2so6391080qtv.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 20:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwP2ToJTS4J2TzYWipClu/L0CAKef8tO56V4CCWEYew=;
        b=SXSAnLTVrMNt22bhHtoU1H/5SxjHFy0oi/0iPlGdwHuelKMWgNx7L/4tWdIgHzAln9
         7zs9qh+gQg90ybz7BTTzr6CN6vpb3KbBj1B7eSp72Xs3JXUCsUGXc2dPaktTaA2HDMY9
         c9OQNUwVjPyN1N3uaMvNAJbSF+i58AZURG+Up/O50wgK9L+prFe4iFlO9z6KmAfXSo6k
         0wSH6mK1H+q98fIpjkl5NT4KPd3KG5TJmpg1RKxrA9wZrJI+v4atN9bTV3hoMOqHCjqt
         K0kJKEZoMRM2FSPJVfIrmDy1JVKnQ4hRfQ4Lqxd12DhH+Dg1HBpGm4Mv+/5ujGV1eKMP
         Lm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwP2ToJTS4J2TzYWipClu/L0CAKef8tO56V4CCWEYew=;
        b=AXKQi28cbzrFuS03OtoYn+mLA9poAFBwVWb2exc9J5foPzZ0B7HkzkuQMhTBQVlu9p
         aBM6t6lLx2R9BdbLHF0FiH/aKi2E8Iy1hc+g3dYOq2+MXXXQFunHxgVDvSbVTCbDPuuC
         cOdyZhFJvpzLK1o/6EAE35KppxYmZhvL8F45uqnNkPROoJFw8vLst4npIKe8sdXfs7kP
         j1pmVL7Jd1hmNAOpEilo4o6egrYHWg0r3zN5IOfv36ZCdobsxVUSR4dhO/5AB58eqT8x
         R7tE5+Hmot9tOEv8mvizviR/6PCpK/a8g7T65cDxUSdqAF3rzGJA1E4OO3srqfP4dx7d
         FZag==
X-Gm-Message-State: APjAAAUj8PltW88x+1mGnyFIXouSXNJzAjHFlV7mc6jhymBeyorNdEF5
        RiDv8dX+3PE3y2yS/kafHI2o3zGMNPJdldlUJ9Fz7nItvzDyvQ==
X-Google-Smtp-Source: APXvYqxozzLMXL5vXfOLXiMcxDHpzsFRULymqZ+Iv3Dv3NOfJ+Qss2mr6k7tJ072UBZOv1cp9qQFRLbEdq1lsXnlmDw=
X-Received: by 2002:ac8:5346:: with SMTP id d6mr1024433qto.49.1575433651718;
 Tue, 03 Dec 2019 20:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20191203093704.7037-1-daniel.lezcano@linaro.org> <20191203093704.7037-4-daniel.lezcano@linaro.org>
In-Reply-To: <20191203093704.7037-4-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 4 Dec 2019 09:57:20 +0530
Message-ID: <CAP245DW9HyCeP6ceMz74=y1p8f1a-kJ8HW+qCYbijsSu98x9CQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 3:07 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> As we introduced the idle injection cooling device called
> cpuidle_cooling, let's be consistent and rename the cpu_cooling to
> cpufreq_cooling as this one mitigates with OPPs changes.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>   V3:
>     - Fix missing name conversion (Viresh Kumar)
> ---
>  Documentation/driver-api/thermal/exynos_thermal.rst  | 2 +-
>  MAINTAINERS                                          | 2 +-
>  drivers/thermal/Makefile                             | 2 +-
>  drivers/thermal/clock_cooling.c                      | 2 +-
>  drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} | 6 +++---
>  include/linux/clock_cooling.h                        | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>  rename drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} (99%)
>
> diff --git a/Documentation/driver-api/thermal/exynos_thermal.rst b/Documentation/driver-api/thermal/exynos_thermal.rst
> index 5bd556566c70..d4e4a5b75805 100644
> --- a/Documentation/driver-api/thermal/exynos_thermal.rst
> +++ b/Documentation/driver-api/thermal/exynos_thermal.rst
> @@ -67,7 +67,7 @@ TMU driver description:
>  The exynos thermal driver is structured as::
>
>                                         Kernel Core thermal framework
> -                               (thermal_core.c, step_wise.c, cpu_cooling.c)
> +                               (thermal_core.c, step_wise.c, cpufreq_cooling.c)
>                                                                 ^
>                                                                 |
>                                                                 |
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2e92a0360f2..26e4be914765 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16194,7 +16194,7 @@ L:      linux-pm@vger.kernel.org
>  S:     Supported
>  F:     Documentation/driver-api/thermal/cpu-cooling-api.rst
>  F:     Documentation/driver-api/thermal/cpu-idle-cooling.rst
> -F:     drivers/thermal/cpu_cooling.c
> +F:     drivers/thermal/cpufreq_cooling.c
>  F:     drivers/thermal/cpuidle_cooling.c
>  F:     include/linux/cpu_cooling.h
>
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 9c8aa2d4bd28..5c98472ffd8b 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)  += user_space.o
>  thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)      += power_allocator.o
>
>  # cpufreq cooling
> -thermal_sys-$(CONFIG_CPU_FREQ_THERMAL) += cpu_cooling.o
> +thermal_sys-$(CONFIG_CPU_FREQ_THERMAL) += cpufreq_cooling.o
>  thermal_sys-$(CONFIG_CPU_IDLE_THERMAL) += cpuidle_cooling.o
>
>  # clock cooling
> diff --git a/drivers/thermal/clock_cooling.c b/drivers/thermal/clock_cooling.c
> index 3ad3256c48fd..7cb3ae4b44ee 100644
> --- a/drivers/thermal/clock_cooling.c
> +++ b/drivers/thermal/clock_cooling.c
> @@ -7,7 +7,7 @@
>   *  Copyright (C) 2013 Texas Instruments Inc.
>   *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
>   *
> - *  Highly based on cpu_cooling.c.
> + *  Highly based on cpufreq_cooling.c.
>   *  Copyright (C) 2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
>   *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   */
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpufreq_cooling.c
> similarity index 99%
> rename from drivers/thermal/cpu_cooling.c
> rename to drivers/thermal/cpufreq_cooling.c
> index 6b9865c786ba..3a3f9cf94b6d 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *  linux/drivers/thermal/cpu_cooling.c
> + *  linux/drivers/thermal/cpufreq_cooling.c
>   *
>   *  Copyright (C) 2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
>   *
> @@ -694,7 +694,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>         u32 capacitance = 0;
>
>         if (!np) {
> -               pr_err("cpu_cooling: OF node not available for cpu%d\n",
> +               pr_err("cpufreq_cooling: OF node not available for cpu%d\n",
>                        policy->cpu);
>                 return NULL;
>         }
> @@ -705,7 +705,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>
>                 cdev = __cpufreq_cooling_register(np, policy, capacitance);
>                 if (IS_ERR(cdev)) {
> -                       pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
> +                       pr_err("cpufreq_cooling: cpu%d failed to register as cooling device: %ld\n",
>                                policy->cpu, PTR_ERR(cdev));
>                         cdev = NULL;
>                 }
> diff --git a/include/linux/clock_cooling.h b/include/linux/clock_cooling.h
> index b5cebf766e02..4b0a69863656 100644
> --- a/include/linux/clock_cooling.h
> +++ b/include/linux/clock_cooling.h
> @@ -7,7 +7,7 @@
>   *  Copyright (C) 2013 Texas Instruments Inc.
>   *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
>   *
> - *  Highly based on cpu_cooling.c.
> + *  Highly based on cpufreq_cooling.c.
>   *  Copyright (C) 2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
>   *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>   */
> --
> 2.17.1
>
