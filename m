Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9883BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC57214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="s46XGN4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfDWKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:33:19 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38428 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:33:18 -0400
Received: by mail-ua1-f68.google.com with SMTP id t15so4585017uao.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EN7b47l9AXGCegvc+vwoon7lU6XqLVRNBOk0Rd9mZeY=;
        b=s46XGN4Tnya/swm6HYAd8RurtcfDX1g/CpUhcnTTdDWF1AvSGYJuD28wg7bZGp0NHZ
         qWXLZOBkuiUHPbRGsknH3n6OKNHP1o6MSW+J9O+sutuLbtmIqerzWlxJOf98J6PUN5dt
         IgaQcu5oelyjwWR/7h7OGxB46gi9BAl5uqhfT0FuVujjnQmIQK2gDP4dAQ9raJTLVopW
         /lpQCnYiCJkCBnj2vEpZIZFdjCthHmBdO5b1yzeCmprKiJR7fcIqWCE/Es/3Hnn8uN1B
         2SXGzzUtwLWlR9ULSgN1QDJhcFQFIkURGTt5wAa6l8++g8ia28iaDZMWlGiIp9jxAIDR
         gxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EN7b47l9AXGCegvc+vwoon7lU6XqLVRNBOk0Rd9mZeY=;
        b=Kj12HS05s+vwvp9/uHxQoXVNYXXSwhWCKPsVnkr2nVHxjLaWgMnPdJwjo/l+5hi64+
         BwBVXiPe4kQai895Y7eOiZkqvUuiUyWKRTEmbAc1oiEYm9qhG07xrXFdU0fyDRQQJ29V
         az7EFTosX5DccuxfrAqAOQ4z2aRO4un0DUgnygXmywXA99NHI8SRhWp5FH67611jlCil
         xPJC0YUvXJJKGD5+g8pYU77IkzGArm9NlaaJPQXXxKmhyU0Os1XCi0+kYtwTeQOWeCY8
         Lh9NEcz/Tqv+vkOV/q++MVCiouRZOqKOi+ahBPV5tolAjxjXBMZ/coB91JfuA2LL8/8e
         +3Zw==
X-Gm-Message-State: APjAAAX/0NzWJ+us1kqNP0FZbFUQqnvY8ntqNOiPl7wt53J/PuJi4E+9
        vBo8oXybDHA7f17aVoGX7oXhGlI5PA19aa4Iu0S47Q==
X-Google-Smtp-Source: APXvYqxZJSHE7XmSf6U0W0HfcV44z4oO8rHzv9QG4ggUbP2sgh/IpB3c1GA6BR1u12ec9Dvo4h9iI6VSq7vKWUpoQpg=
X-Received: by 2002:ab0:7686:: with SMTP id v6mr11580115uaq.77.1556015597525;
 Tue, 23 Apr 2019 03:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190402161256.11044-1-daniel.lezcano@linaro.org> <20190402161256.11044-4-daniel.lezcano@linaro.org>
In-Reply-To: <20190402161256.11044-4-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 23 Apr 2019 16:03:06 +0530
Message-ID: <CAHLCerONOh9prVzn4SJ8WEPdVmh4WwvLHyuWJycVah9kcg7wpg@mail.gmail.com>
Subject: Re: [PATCH 4/7] thermal/drivers/core: Use governor table to initialize
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 9:43 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Now that the governor table is in place and the macro allows to browse the
> table, declare the governor so the entry is added in the governor table
> in the init section.
>
> The [un]register_thermal_governors function does no longer need to use the
> exported [un]register thermal governor's specific function which in turn
> call the [un]register_thermal_governor. The governors are fully
> self-encapsulated.
>
> The cyclic dependency is no longer needed, remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/fair_share.c      | 12 +-------
>  drivers/thermal/gov_bang_bang.c   | 11 +------
>  drivers/thermal/power_allocator.c | 11 +------
>  drivers/thermal/step_wise.c       | 11 +------
>  drivers/thermal/thermal_core.c    | 51 +++++++++++++++++--------------
>  drivers/thermal/thermal_core.h    | 40 ------------------------
>  drivers/thermal/user_space.c      | 12 +-------
>  7 files changed, 33 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> index d3469fbc5207..bda2afc63471 100644
> --- a/drivers/thermal/fair_share.c
> +++ b/drivers/thermal/fair_share.c
> @@ -129,14 +129,4 @@ static struct thermal_governor thermal_gov_fair_share = {
>         .name           = "fair_share",
>         .throttle       = fair_share_throttle,
>  };
> -
> -int thermal_gov_fair_share_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_fair_share);
> -}
> -
> -void thermal_gov_fair_share_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_fair_share);
> -}
> -
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_fair_share);
> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
> index fc5e5057f0de..c5e19c7d63da 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -126,13 +126,4 @@ static struct thermal_governor thermal_gov_bang_bang = {
>         .name           = "bang_bang",
>         .throttle       = bang_bang_control,
>  };
> -
> -int thermal_gov_bang_bang_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_bang_bang);
> -}
> -
> -void thermal_gov_bang_bang_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_bang_bang);
> -}
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> index 3055f9a12a17..44636475b2a3 100644
> --- a/drivers/thermal/power_allocator.c
> +++ b/drivers/thermal/power_allocator.c
> @@ -651,13 +651,4 @@ static struct thermal_governor thermal_gov_power_allocator = {
>         .unbind_from_tz = power_allocator_unbind,
>         .throttle       = power_allocator_throttle,
>  };
> -
> -int thermal_gov_power_allocator_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_power_allocator);
> -}
> -
> -void thermal_gov_power_allocator_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_power_allocator);
> -}
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index ee047ca43084..6cd251ab56fc 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -218,13 +218,4 @@ static struct thermal_governor thermal_gov_step_wise = {
>         .name           = "step_wise",
>         .throttle       = step_wise_throttle,
>  };
> -
> -int thermal_gov_step_wise_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_step_wise);
> -}
> -
> -void thermal_gov_step_wise_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_step_wise);
> -}
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_step_wise);
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 28f7ece0e8fe..50c88682a848 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -243,36 +243,41 @@ int thermal_build_list_of_policies(char *buf)
>         return count;
>  }
>
> -static int __init thermal_register_governors(void)
> +static void __init thermal_unregister_governors(void)
>  {
> -       int result;
> +       struct thermal_governor **governor;
>
> -       result = thermal_gov_step_wise_register();
> -       if (result)
> -               return result;
> +       for_each_governor_table(governor)
> +               thermal_unregister_governor(*governor);

As a result of this function moving to __init, can't
thermal_unregister_governor also become __init now?

Nice cleanup.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> +}
>
> -       result = thermal_gov_fair_share_register();
> -       if (result)
> -               return result;
> +static int __init thermal_register_governors(void)
> +{
> +       int ret = 0;
> +       struct thermal_governor **governor;
>
> -       result = thermal_gov_bang_bang_register();
> -       if (result)
> -               return result;
> +       for_each_governor_table(governor) {
> +               ret = thermal_register_governor(*governor);
> +               if (ret) {
> +                       pr_err("Failed to register governor: '%s'",
> +                              (*governor)->name);
> +                       break;
> +               }
>
> -       result = thermal_gov_user_space_register();
> -       if (result)
> -               return result;
> +               pr_info("Registered thermal governor '%s'",
> +                       (*governor)->name);
> +       }
>
> -       return thermal_gov_power_allocator_register();
> -}
> +       if (ret) {
> +               struct thermal_governor **gov;
> +               for_each_governor_table(gov) {
> +                       if (gov == governor)
> +                               break;
> +                       thermal_unregister_governor(*gov);
> +               }
> +       }
>
> -static void __init thermal_unregister_governors(void)
> -{
> -       thermal_gov_step_wise_unregister();
> -       thermal_gov_fair_share_unregister();
> -       thermal_gov_bang_bang_unregister();
> -       thermal_gov_user_space_unregister();
> -       thermal_gov_power_allocator_unregister();
> +       return ret;
>  }
>
>  /*
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 28d18083e969..a3c555b48eb3 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -90,46 +90,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>                                     unsigned long new_state) {}
>  #endif /* CONFIG_THERMAL_STATISTICS */
>
> -#ifdef CONFIG_THERMAL_GOV_STEP_WISE
> -int thermal_gov_step_wise_register(void);
> -void thermal_gov_step_wise_unregister(void);
> -#else
> -static inline int thermal_gov_step_wise_register(void) { return 0; }
> -static inline void thermal_gov_step_wise_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_STEP_WISE */
> -
> -#ifdef CONFIG_THERMAL_GOV_FAIR_SHARE
> -int thermal_gov_fair_share_register(void);
> -void thermal_gov_fair_share_unregister(void);
> -#else
> -static inline int thermal_gov_fair_share_register(void) { return 0; }
> -static inline void thermal_gov_fair_share_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_FAIR_SHARE */
> -
> -#ifdef CONFIG_THERMAL_GOV_BANG_BANG
> -int thermal_gov_bang_bang_register(void);
> -void thermal_gov_bang_bang_unregister(void);
> -#else
> -static inline int thermal_gov_bang_bang_register(void) { return 0; }
> -static inline void thermal_gov_bang_bang_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_BANG_BANG */
> -
> -#ifdef CONFIG_THERMAL_GOV_USER_SPACE
> -int thermal_gov_user_space_register(void);
> -void thermal_gov_user_space_unregister(void);
> -#else
> -static inline int thermal_gov_user_space_register(void) { return 0; }
> -static inline void thermal_gov_user_space_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_USER_SPACE */
> -
> -#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> -int thermal_gov_power_allocator_register(void);
> -void thermal_gov_power_allocator_unregister(void);
> -#else
> -static inline int thermal_gov_power_allocator_register(void) { return 0; }
> -static inline void thermal_gov_power_allocator_unregister(void) {}
> -#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
> -
>  /* device tree support */
>  #ifdef CONFIG_THERMAL_OF
>  int of_parse_thermal_zones(void);
> diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
> index 8e92a06ef48a..5fac99e5221d 100644
> --- a/drivers/thermal/user_space.c
> +++ b/drivers/thermal/user_space.c
> @@ -56,14 +56,4 @@ static struct thermal_governor thermal_gov_user_space = {
>         .name           = "user_space",
>         .throttle       = notify_user_space,
>  };
> -
> -int thermal_gov_user_space_register(void)
> -{
> -       return thermal_register_governor(&thermal_gov_user_space);
> -}
> -
> -void thermal_gov_user_space_unregister(void)
> -{
> -       thermal_unregister_governor(&thermal_gov_user_space);
> -}
> -
> +THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
> --
> 2.17.1
>
