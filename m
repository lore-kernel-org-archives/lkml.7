Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7CBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FE52084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dle22erI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfDBSwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:52:09 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39716 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfDBSwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:52:09 -0400
Received: by mail-vs1-f68.google.com with SMTP id g127so8436351vsd.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccqQVWs9UmM1DuuncUdXIZRnO3KXuTehxFueK3afzzM=;
        b=dle22erIUt0oCm1Y1eogd9pIoKhA/1JFjchAiekYcJtrfN/TfSHOLI+cSwHohp6DWn
         3GE5Ax+dczeX+soUJOjcR4alqK9S5G2DcmrCYMsOtGCDq+Lq6YID7onN/oCfMSBMb1wd
         a1Onr1p1n3YtxGaYaTZNy2ZoTvCziNjgcxWnV1EIFBkX+4FCxHiB22+kfwNhG6rP2tLA
         recXIjtEhhagsjSACyYytWLNqFN6Y5kQszVbWn/fMA0JAmHNkMgcVCkUWKXDAqLUqxIW
         BMODazs4mC65bEiwiED2MpihoGj0MUVCN0ukxCuGH9g7rL2FGuXwMXk+esDDn+q/nmpk
         eyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccqQVWs9UmM1DuuncUdXIZRnO3KXuTehxFueK3afzzM=;
        b=nNSK2nHm6fbawVi95fqvueSKSFviiEhZjmmGYRk7pCmrYdkf+6jcM61rrUyGBWcsgu
         KUkvQCRFzRvxjg7TqyvNhfxGq5MwQYsUHIE0KWiBWTrVwuAh4A5MpQfnmLfDnUHCRHka
         ktQVkmtYKlo9W/MU5giLMEVvgNAvIYwF81NRgXSJkXLEl6DoVScsX47yRhWjRDHF+U66
         FnOEtAbCh0EgrPVCFMt5jwwHu0Wf8kj3/u8DO6CxqwWNmIVFc11CiLj16dHUNtEG8AXZ
         XV3YfV8hsGHGvpmkQSgmWSEZsNAe8jL4P3iXmL4/qt2s7ori7WcENyqTna18TVycpfJr
         Vf6A==
X-Gm-Message-State: APjAAAUVhe8VqlPbIMIgp5OYtyZWs7xTEziGMo0J59D72SbJhA205bMW
        OrrgtG3xBMvf5098SsCyXeRImfy8/2GtvnE3hoppYQ==
X-Google-Smtp-Source: APXvYqxzauAJa+W0c9pwoC8sw9k+vn15l2VpNdgZa29vWVu8YP+8XRDjems3EK1PNKmxt0Iun9mQFpqQEu9Q34qjBrM=
X-Received: by 2002:a67:f693:: with SMTP id n19mr6203815vso.89.1554231127921;
 Tue, 02 Apr 2019 11:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190402161256.11044-1-daniel.lezcano@linaro.org> <20190402161256.11044-5-daniel.lezcano@linaro.org>
In-Reply-To: <20190402161256.11044-5-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 3 Apr 2019 01:51:55 +0700
Message-ID: <CAHLCerNvp9Bb0TwCcO91ecrbzKGe7epCHFk=fx4RGJgHDE_BRA@mail.gmail.com>
Subject: Re: [PATCH 5/7] thermal/drivers/core: Remove depends on THERMAL in Kconfig
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 11:14 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The dependency on the THERMAL option to be set is already there implicitly
> by the "if THERMAL" conditionnal option. The sub Kconfigs do not have to
> check against the THERMAL option as they are called from a Kconfig block
> which is enabled by the conditionnal option.
>
> Remove the useless "depends on THERMAL" in the Kconfigs.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig       | 2 --
>  drivers/thermal/intel/Kconfig | 1 -
>  drivers/thermal/qcom/Kconfig  | 1 -
>  3 files changed, 4 deletions(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index ccf5b9408d7a..d8aa7fac8c56 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -24,7 +24,6 @@ config THERMAL_STATISTICS
>
>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>         int "Emergency poweroff delay in milli-seconds"
> -       depends on THERMAL
>         default 0
>         help
>           Thermal subsystem will issue a graceful shutdown when
> @@ -152,7 +151,6 @@ config CPU_THERMAL
>         bool "generic cpu cooling support"
>         depends on CPU_FREQ
>         depends on THERMAL_OF
> -       depends on THERMAL=y

This will break the intention of afa1f2ab43d48d0e1. At the moment, we
need THERMAL=y if we want cpu_cooling.

>         help
>           This implements the generic cpu cooling mechanism through frequency
>           reduction. An ACPI version of this already exists
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index 2e013eeb4a1d..2c727a820759 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -1,6 +1,5 @@
>  config INTEL_POWERCLAMP
>         tristate "Intel PowerClamp idle injection driver"
> -       depends on THERMAL
>         depends on X86
>         depends on CPU_SUP_INTEL
>         help
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index cdb455ffd575..3ce20fec86a2 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -1,6 +1,5 @@
>  config QCOM_TSENS
>         tristate "Qualcomm TSENS Temperature Alarm"
> -       depends on THERMAL
>         depends on QCOM_QFPROM
>         depends on ARCH_QCOM || COMPILE_TEST
>         help
> --
> 2.17.1
>
