Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E0AC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2AB20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 06:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="OJg6/Xiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLJGva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:51:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46768 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLJGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:51:29 -0500
Received: by mail-vs1-f68.google.com with SMTP id t12so12248166vso.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 22:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThCXORbwGE9xbug2jutD7MWlrN+Auf/XeZZe6HyXDCI=;
        b=OJg6/Xiqa76NbusYSxC5X8GD57DM0I7MkUk0t1esPlgDll9GffgM7UtFmfWwrMrHxK
         qNrl6lSYHJlSAdRr9EapLQs9zMBpxgefxGInziD7WYREkKd9QEmha5KZOrzhQPukdYzq
         e/IetOsEfK5XeuGJ/rssXcoQDmDEvvmOvfYezBlb9CvcFsoZcGqR1I8PxKJvXWpmpuEk
         /6MgT5UtEv56Ss3H91seuqI1JrXZgQ6kTtS66kNDo+0VLQNCnyaVhtxGzpmTlOuUNHmA
         9Hjx1+eWTpXpixd1u33XZ+/FYkua1n1Q0Nlioz5xJ9oYdbn5xuJDq71iRxH4BfFRpur+
         muYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThCXORbwGE9xbug2jutD7MWlrN+Auf/XeZZe6HyXDCI=;
        b=mCja+wjf1BSbzROWN/pzzzb/ns/MKEXY66PIlCNEBk0OfauX99M3OmWTfF618Rg8If
         MIEL9R7V84LXt+/PqZTXSa92cOjtI5V5YMIci562pX2yTNTlhEO9sV0vy3PLuhkgHR7N
         Y4ch87qHoWy9/+2FDyv7anZfaWz1Fx1m+4Sq+LYLbn5T8BqcP7Lh+fKjvYQWPILDg7YL
         7ymaBRPPG1yaIi7Jio3EUcn7baXS7kFfHjBNNnY67fo7KdbpnVQQmAask5nJCQ4v6i9k
         znRqqCImOdKmaV8aMMbSgSEGDScs2IHJ8Fs+E77gdX+fxE1HipDg6J3HcJodJSxLn/eU
         GcGA==
X-Gm-Message-State: APjAAAVWGn6rpBusqlD4mQCqxeV8MvXAGYEOxHicv5jmMaMdnoYsG77b
        nClKW09DntoV908taCW5GvuOoRbadX1bLs8bv2jcxi+4YFU=
X-Google-Smtp-Source: APXvYqwt/03vbKh2kfOs7ZHlFMp8YyR7qTrK2AXkCFkwS7Go5jnB8eSUieA6uPorGuWDG8/HS/r+AvBK94IUj0iUnFM=
X-Received: by 2002:a67:7acd:: with SMTP id v196mr22065831vsc.95.1575960688036;
 Mon, 09 Dec 2019 22:51:28 -0800 (PST)
MIME-Version: 1.0
References: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
In-Reply-To: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 10 Dec 2019 12:21:17 +0530
Message-ID: <CAHLCerOxHq4DYn9xV6JEDkbxZxmKkzC0mY70RiFkhCAbpovFrg@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, Keerthy <j-keerthy@ti.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:21 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>
> Currently, step wise governor increases the mitigation when the
> temperature goes above a threshold and decreases the mitigation when the
> temperature goes below the threshold. If there is a case where the
> temperature is wavering around the threshold, the mitigation will be
> applied and removed every iteration, which is not very efficient.
>
> The use of hysteresis temperature could avoid this ping-pong of
> mitigation by relaxing the mitigation to happen only when the
> temperature goes below this lower hysteresis value.
>
> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> [Rebased patch from downstream]
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Daniel, Rui: ping.

Keerthy: This works for you, right?

> ---
>  drivers/thermal/step_wise.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 6e051cbd824ff..2c8a34a7cf959 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -24,7 +24,7 @@
>   *       for this trip point
>   *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
>   *       for this trip point
> - * If the temperature is lower than a trip point,
> + * If the temperature is lower than a hysteresis temperature,
>   *    a. if the trend is THERMAL_TREND_RAISING, do nothing
>   *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>   *       state for this trip point, if the cooling state already
> @@ -115,30 +115,31 @@ static void update_passive_instance(struct thermal_zone_device *tz,
>
>  static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  {
> -       int trip_temp;
> +       int trip_temp, hyst_temp;
>         enum thermal_trip_type trip_type;
>         enum thermal_trend trend;
>         struct thermal_instance *instance;
> -       bool throttle = false;
> +       bool throttle;
>         int old_target;
>
>         if (trip == THERMAL_TRIPS_NONE) {
> -               trip_temp = tz->forced_passive;
> +               hyst_temp = trip_temp = tz->forced_passive;
>                 trip_type = THERMAL_TRIPS_NONE;
>         } else {
>                 tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +               hyst_temp = trip_temp;
> +               if (tz->ops->get_trip_hyst) {
> +                       tz->ops->get_trip_hyst(tz, trip, &hyst_temp);
> +                       hyst_temp = trip_temp - hyst_temp;
> +               }
>                 tz->ops->get_trip_type(tz, trip, &trip_type);
>         }
>
>         trend = get_tz_trend(tz, trip);
>
> -       if (tz->temperature >= trip_temp) {
> -               throttle = true;
> -               trace_thermal_zone_trip(tz, trip, trip_type);
> -       }
> -
> -       dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
> -                               trip, trip_type, trip_temp, trend, throttle);
> +       dev_dbg(&tz->device,
> +               "Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%d\n",
> +               trip, trip_type, trip_temp, hyst_temp, trend, throttle);
>
>         mutex_lock(&tz->lock);
>
> @@ -147,6 +148,18 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>                         continue;
>
>                 old_target = instance->target;
> +               throttle = false;
> +               /*
> +                * Lower the mitigation only if the temperature
> +                * goes below the hysteresis temperature.
> +                */
> +               if (tz->temperature >= trip_temp ||
> +                   (tz->temperature >= hyst_temp &&
> +                    old_target != THERMAL_NO_TARGET)) {
> +                       throttle = true;
> +                       trace_thermal_zone_trip(tz, trip, trip_type);
> +               }
> +
>                 instance->target = get_target_state(instance, trend, throttle);
>                 dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
>                                         old_target, (int)instance->target);
> --
> 2.17.1
>
