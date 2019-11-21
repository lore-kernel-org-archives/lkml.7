Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE3E20672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oN3wZvC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKUU5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:57:24 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41365 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfKUU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:57:24 -0500
Received: by mail-qv1-f68.google.com with SMTP id g18so2009356qvp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sQ8Qhu5I7Yu+t8z9NI1yRkhgiVWdzL96yBPPh8PD1oo=;
        b=oN3wZvC1R6G5/Jf3gq0qoDYMfS/8AQUj7eJjlx0h/BtHfjkdRhs994GeewnMwU06WA
         QH0wrZXmsuVvpMMcHemlFtpq0jv0LBKDE/kVPPk5O0IZZHXvkR69cMAA84MqGHqqjaMr
         GN1eYiQ2Vjj5r5fXMQiM+V5pmp6TRkffh70XILZIZsW3pm+lneowgk8+Z//hlT+6J2vO
         9HliYPfAbK6tJ1fMNOyIbbhsmVHoryv7X7Wu2EFP4mWf06g+3k9nF2qyYneHnhPHw+yq
         3v4g/XBQsmGDelHXqJAtDqkdGImDuqC8cPLfg6zDRZGqP8ewc4aCsBjk6COkmYtJeqXF
         26/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sQ8Qhu5I7Yu+t8z9NI1yRkhgiVWdzL96yBPPh8PD1oo=;
        b=GokJiLMlQJ9Gda9A/9oyqbnXW4YgcikPUKTHDN8qOPHVRWhK6GIL1cItLLW9SHXvwM
         Gblg4LG7BS0cuX0kCkSDR7ZD6EYJcyVBjvszUV1lxdv5g5IdSaRnqIkX+bHL8QKYPCmm
         /V+LkJKcsHTUKG+tPeqOvFZ7Ye5wVzjDUGwagJp5T8I1EdCFoPA/D1OmXiPDHNLSOo6D
         5zX1b9DqFNezZaGtuLhwNaMOPfPDc7JN94vhPzXjMUFVF1GBdc9ufTIWmrsYSTMoL8oA
         GGMn1frasz/BSUFhcogrqE+N1XcoXYIOtZEwAtVZpoqThwNcExOoDr3eqhq5/RIA0cbN
         L3Ag==
X-Gm-Message-State: APjAAAVIpsReIHciiniWv7e/Ne78SgN729ZLkxgPXXdGT8XuD+NR0mkP
        KmO6XB6enafb2TeHBDm0lFVKig==
X-Google-Smtp-Source: APXvYqwjAkXBpg5htqYU978h+VtAKuq77kT0b2WXFTCFGyw+usd4elChK5PukSEkKw1SYmyPk3ZqoQ==
X-Received: by 2002:ad4:55cc:: with SMTP id bt12mr10044192qvb.58.1574369841267;
        Thu, 21 Nov 2019 12:57:21 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id l12sm888494qtf.93.2019.11.21.12.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 12:57:20 -0800 (PST)
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
Message-ID: <5DD6FA2E.9010704@linaro.org>
Date:   Thu, 21 Nov 2019 15:57:18 -0500
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

Hi Amit,

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

There is no need to remove throttle = false here. You are setting it to
false later down.

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

throttle value is not final here. Why is the debug print and the setting
of throttle reversed ? Idea is to print the final value of
throttle.

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

I think this requires more comment here on why there is a check for
old_target != THERMAL_NO_TARGET. Basically to ensure that the hysteresis
is considered only when temperature is dropping.

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


-- 
Warm Regards
Thara
