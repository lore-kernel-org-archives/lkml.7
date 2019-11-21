Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E40C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3164B206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+3g4JXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUOKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:10:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44818 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:10:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id o11so3759685qtr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ndBghIAW5jexbjstvssowNgkv48SOm6LHbFBASVDuQI=;
        b=E+3g4JXDHhaV3nv6Jnkpf/uAYDpBcirtfCOtykviPuf8+8JadmxlqRxUSn/i/KNfi/
         xeXN6tcZhDjIGC/IeUgOCPvR0gwQu7VKBYj3LMVUGRRgG7McU7A58hCxswbVh0DNGp0U
         Ryi8oflhf2IrzM7D3mrt04WStpLx8hISOn9RxKB4pWAlNcOOXNoeBlUZ24X2pl/JSdUG
         4IB7uxRMijM70jcRyRe5pBrJrUn1n/2ZyWYg7UADvp8p73bxZTUo4OF3kx/XH+TNPyBs
         P5Ouep2zfOJTWEVPZcMj50GwwOoUBL3LA3L1ThGjNckQ7kDrEaLvuRIKWcd7rz90/czD
         fhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ndBghIAW5jexbjstvssowNgkv48SOm6LHbFBASVDuQI=;
        b=Zr+lOjgZHmmefujHVTw8tYHEzpZ2tsjpjPCFQuDslckNzNRCAGE+dOiAzQMqK/Jj0c
         eEzqAx72HF5z6Ojov7MsmIfbWTTOG+lwP1i/tD/kxJHZoRS2DXphGkT+kMGXx/gNYhmC
         NoaBIw8NrRO6DAP7fi7l2yrPPesIr/yScmDTWhPFbwlHLppQQH0NB33ANtVHyvX/LA2Z
         kO5W3hjW4UUWUkDNJ4JyriBl3F1LyvvY9xdMz9TEZUsTf+LgW5Q/pgRjQv+sMlx2gBt9
         IcJTP+uZMG3gOybargcCMkof7uH/VKHboQZ9dDJI/uPnGt2HfeUwl9u+QH1BMmkvjMjU
         fTYw==
X-Gm-Message-State: APjAAAWnjVkBo/pYJ0uBi2BFKqSLNhI44auuMUKSPEqDa3j0azrNKBPu
        RXUdbbkSLHWAAJOmaic4LllYhA==
X-Google-Smtp-Source: APXvYqwlIPVfLC7kmWQrv11Ie25ynbnCuwb33CgLllClg/M3PxJvJL6TKoWz3JyuO+mxbbwsZKZ0CA==
X-Received: by 2002:ac8:7454:: with SMTP id h20mr8866546qtr.146.1574345402032;
        Thu, 21 Nov 2019 06:10:02 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id o53sm1557251qtj.91.2019.11.21.06.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 06:10:00 -0800 (PST)
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org, j-keerthy@ti.com,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
Cc:     Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DD69AB7.3060307@linaro.org>
Date:   Thu, 21 Nov 2019 09:09:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2019 12:50 AM, Amit Kucheria wrote:
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
Hi Amit,

Can this not lead to ping-pong around the hysteresis temperature?
If the idea is to minimize ping-pong isn't average a better method?

Warm Regards
Thara

> 
> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> [Rebased patch from downstream]
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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
> -	int trip_temp;
> +	int trip_temp, hyst_temp;
>  	enum thermal_trip_type trip_type;
>  	enum thermal_trend trend;
>  	struct thermal_instance *instance;
> -	bool throttle = false;
> +	bool throttle;
>  	int old_target;
>  
>  	if (trip == THERMAL_TRIPS_NONE) {
> -		trip_temp = tz->forced_passive;
> +		hyst_temp = trip_temp = tz->forced_passive;
>  		trip_type = THERMAL_TRIPS_NONE;
>  	} else {
>  		tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +		hyst_temp = trip_temp;
> +		if (tz->ops->get_trip_hyst) {
> +			tz->ops->get_trip_hyst(tz, trip, &hyst_temp);
> +			hyst_temp = trip_temp - hyst_temp;
> +		}
>  		tz->ops->get_trip_type(tz, trip, &trip_type);
>  	}
>  
>  	trend = get_tz_trend(tz, trip);
>  
> -	if (tz->temperature >= trip_temp) {
> -		throttle = true;
> -		trace_thermal_zone_trip(tz, trip, trip_type);
> -	}
> -
> -	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
> -				trip, trip_type, trip_temp, trend, throttle);
> +	dev_dbg(&tz->device,
> +		"Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%d\n",
> +		trip, trip_type, trip_temp, hyst_temp, trend, throttle);
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -147,6 +148,18 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  			continue;
>  
>  		old_target = instance->target;
> +		throttle = false;
> +		/*
> +		 * Lower the mitigation only if the temperature
> +		 * goes below the hysteresis temperature.
> +		 */
> +		if (tz->temperature >= trip_temp ||
> +		    (tz->temperature >= hyst_temp &&
> +		     old_target != THERMAL_NO_TARGET)) {
> +			throttle = true;
> +			trace_thermal_zone_trip(tz, trip, trip_type);
> +		}
> +
>  		instance->target = get_target_state(instance, trend, throttle);
>  		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
>  					old_target, (int)instance->target);
> 
