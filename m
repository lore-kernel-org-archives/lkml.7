Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55FFA3732
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C90214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUKqTmqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408362AbfJQItp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:49:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44389 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfJQIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:49:44 -0400
Received: by mail-ua1-f66.google.com with SMTP id n2so405438ual.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaflTEVqXP6LU9FxmV75EoYog54RQTLQQw4v75TOTAw=;
        b=IUKqTmqFFzQ2b4BQBIsKoTrBhfiYGq2mYaYO3/uCdCMjrl4wpVxrmQfx8pVtDqIZpK
         NQrxGlPVsbCAj4p6LTHTMKZp+Ynp0nZqjZqqz8d7hS+M2SyTMiBtsBZ9I9cA7K8gpn4e
         p+tCRmc9my6VCQP17s5svfH33t3aGfqF+KZ2kHlVc9HLq7RkBfNzL3Ml5f+h/nRL+tc8
         dk0t7Stwhrz75oF+hUVOaOj9oJvjCfYVWwW8fByApBNkikgsEOt1ZK3fjsIOKfgp3Zgw
         vl5bM0cY6bi49vB1Yg1kxFnxLQ3u2D/eLY/etKWIv9rCMBFa6PiXGzoZ7yJhv84gSgCd
         lg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaflTEVqXP6LU9FxmV75EoYog54RQTLQQw4v75TOTAw=;
        b=RzbP1Zdaaox/TA1Ykw853hNaCdQvDuzUhVIN9gLH3C1S/Tko6HEVEuWjgX15haQJOa
         WK1mheP99bK1h8Fg6TDPs1WD4S9jjUcPGTpJJRBwGx/hiF5QYoqpD8h5jOhFNsV2vxda
         EaYxjgRZUFlzdy5D38xRW7Gjxhl4S7Kgk/xoF+sU1bOmd/RQLkBPaYcJX6D1jVzUebpT
         iLcj0I28sPwssSlAbEG/mNLQHjTz602+f+U7FXzZ5ESOu4BpqeKF4cjeFc7TkT68vZ1S
         J8EHkEXSGdnPY2rsGWm08AQlJQ8H/03WraPnrdaaPtDBEiPmoXDUiZVFsSVNw36kC56r
         OnIg==
X-Gm-Message-State: APjAAAWtBF34Ti7TqezjZ+FLux0x4HPC19xe1QNLkOK/BozHBIHNeQtC
        pd3ClAic3dG+WuUQV+COQZxYbdvyhxbtNKqVunMAQg==
X-Google-Smtp-Source: APXvYqxdmCYgFKPRO+7PXjW4nJXM3EioJGdjGXSK++d7xB9AYzs/OlNUFWCIT2GRX6CHidVWOeQ/XzB9ieDFL1zhXlE=
X-Received: by 2002:ab0:331a:: with SMTP id r26mr1618970uao.104.1571302183129;
 Thu, 17 Oct 2019 01:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org> <1571254641-13626-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1571254641-13626-2-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Oct 2019 10:49:07 +0200
Message-ID: <CAPDyKFr76VHypqGxYL-1HS3uu3_KYeO+dGJ7q1Nj=uXiQgY98A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] PM/Domains: Add support for retrieving genpd
 performance states information
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Add two new APIs in the genpd framework,
> dev_pm_genpd_get_performance_state to return the current performance
> state of a power domain and dev_pm_genpd_performance_state_count to
> return the total number of performance states supported by a
> power domain. Since the genpd framework does not maintain
> a count of number of performance states supported by a power domain,
> introduce a new callback(.get_performance_state_count) that can be used
> to retrieve this information from power domain drivers.
>
> These APIs are added to aid the implementation of a power domain as
> a warming device. Linux kernel cooling device framework(into which
> warming device can be plugged in) requires during initialization to be
> provided with the maximum number of states that can be supported. When
> a power domain acts as a warming device, the max state is the max number
> of perfomrance states supported by the power domain. The cooling
> device framework implements API to retrieve the current state of the
> cooling device. This in turn translates to the current performance
> state of the power domain.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/domain.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 13 +++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cc85e87..507e530 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -408,6 +408,43 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>
> +int dev_pm_genpd_get_performance_state(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +       unsigned int state;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (IS_ERR(genpd))
> +               return -ENODEV;
> +
> +       genpd_lock(genpd);
> +       state = genpd->performance_state;
> +       genpd_unlock(genpd);
> +
> +       return state;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_performance_state);
> +
> +int dev_pm_genpd_performance_state_count(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +       int count;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (IS_ERR(genpd))
> +               return -ENODEV;
> +
> +       if (unlikely(!genpd->get_performance_state_count))
> +               return -EINVAL;
> +
> +       genpd_lock(genpd);
> +       count = genpd->get_performance_state_count(genpd);
> +       genpd_unlock(genpd);
> +
> +       return count;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_performance_state_count);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index baf02ff..e88e57f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -117,6 +117,7 @@ struct generic_pm_domain {
>                                                  struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
> +       int (*get_performance_state_count)(struct generic_pm_domain *genpd);
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         bool max_off_time_changed;
> @@ -204,6 +205,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                   struct dev_power_governor *gov, bool is_off);
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
> +int dev_pm_genpd_get_performance_state(struct device *dev);
> +int dev_pm_genpd_performance_state_count(struct device *dev);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -251,6 +254,16 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>         return -ENOTSUPP;
>  }
>
> +static inline int dev_pm_genpd_get_performance_state(struct device *dev)
> +{
> +       return -ENOTSUPP;
> +}
> +
> +static inline int dev_pm_genpd_performance_state_count(struct device *dev)
> +{
> +       return -ENOTSUPP;
> +}
> +
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> 2.1.4
>
