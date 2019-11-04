Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008C3CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF97222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ77MhLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfKDGUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:20:45 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35918 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKDGUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:20:45 -0500
Received: by mail-ua1-f65.google.com with SMTP id z9so851735uan.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 22:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqnI11jDeJSRHyM2MOO2KtRFnVVeWq77J5QgehQH3Yk=;
        b=RQ77MhLt9LdQKzG8hK4rrW7/sLslhIyUun4obwjXSY8v+ddub1GYwP7mKrIytVSomD
         AyBiXExGnjQazPg432Kk6TX5UPWdJYEyPT5BnUki2NoqwQrRr5MgD+vcop6+TrQfnVDk
         FvZl1H5NEt2b+WN+pSK7UkjDEG/hJHD/eCzHUNPQM7qPscT8HVsW6tv4POQvAvA1Ly0C
         6kZ9rTzyjlpYkodbaHgBNOJU3XSRji7HgTpK6N3qb0RTpONp3gBoVjVPC5JIBcZP1Sxz
         pSPxik2Iq4tobtxHWAqsQtBiZCr9K2/Xuv8nCJsxeoy07Y4yE3o6RoBM5mlnJRJyYwmE
         R94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqnI11jDeJSRHyM2MOO2KtRFnVVeWq77J5QgehQH3Yk=;
        b=EVOMhlG8TpW1O8hz4rkwTHp/DxTqb/GN2D/WDFxgQfR4pUM2jB8qlwfj5IPx2Ldcad
         OClYn0bS2jJy5fEWfa3IE4YAZwZNZ16n+zJ30BKvjT2bVTz0IW63+HCpuwaU7KJW+/Vu
         8bJ2l22CGVDpDXrTn+Dh/TCEiCqJdddFPOQniPBGf7ghmBGzsaz69v5f2V8LKZ6s3p/7
         voCUtIKuuRw8KkSPACyv+z2XMeMIa6A7d2yNA66S2gNfp5cGA/lOK6suh53Dc826SdA7
         8VA4ds3xGAhozVDZO1K4/UxdtszVpNco496FqUbjMlYdytNVCXMelJZUuys1ZkrHvmjt
         5EJA==
X-Gm-Message-State: APjAAAVvFgZjb23vJdXBctL+uZEJP/fGFQT0wk9wiZfVP1l1SGEVV/WO
        vhj51GsIP+vYdhVsA+DbkYwh6XWNphipga1HRpPkfg==
X-Google-Smtp-Source: APXvYqxlZTvTRT9fl86YSwTGq/owe82EV9UaCl8rLTJBP4ewdVMeR8z4+fwiV/M1M3nj2QmOh2vFx8Uh/B5Tv2mRgVE=
X-Received: by 2002:a9f:364c:: with SMTP id s12mr10774138uad.77.1572848444328;
 Sun, 03 Nov 2019 22:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20191030091038.678-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191030091038.678-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 4 Nov 2019 11:50:33 +0530
Message-ID: <CAHLCerO+FRV1m73_TuAgMVgbe8PCyUZbO1Ym3LNS6S1dcCrafw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cpu_cooling: Remove pointless dependency on CONFIG_OF
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 2:41 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The option CONFIG_CPU_THERMAL depends on CONFIG_OF in the Kconfig.
>
> It it pointless to check if CONFIG_OF is set in the header file as
> this is always true if CONFIG_CPU_THERMAL is true. Remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/cpu_cooling.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index bae54bb7c048..72d1c9c5e538 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -47,7 +47,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  }
>  #endif /* CONFIG_CPU_THERMAL */
>
> -#if defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL)
> +#ifdef CONFIG_CPU_THERMAL
>  /**
>   * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
>   * @policy: cpufreq policy.
> @@ -60,6 +60,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>         return NULL;
>  }
> -#endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
> +#endif /* CONFIG_CPU_THERMAL */
>
>  #endif /* __CPU_COOLING_H__ */
> --
> 2.17.1
>
