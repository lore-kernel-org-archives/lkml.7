Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77858C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFAC218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/ZfuxG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfDWPoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:44:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35387 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfDWPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:44:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so7820834pgf.2;
        Tue, 23 Apr 2019 08:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UHKhNGF9h6UnRkG1fb5S0yRAer4+UyZQ8Isf84BVwlc=;
        b=I/ZfuxG4emX1qFeKLWISK6/79zfkCARgP4ZSgnvjXKqP6YbYDE7vO2Z6Rb7bxpLujP
         wghU3+u88ssKhf6mLMcTDUNu4MJIRcPoToVRsK4RWqMJThO3uFNwG/SG8mVc7sYxNsoi
         jTuvhc+txnqXi5qMk/Y5tP1T3J7AD9ALqrFKHD8rC/bMJdjlTQlAtJDRVi2BvcDGFYYq
         N/Bi6gDF5Vms7KSymsgexaN684iDBLPfzbki0s5cXdu+ks7/e8beiWJpVkQbMnUTHKmB
         YfKWRzddej7uL+KC/JYbEqpSRjeK4RVCmDlyrjLk9tZvgOMHvCsBgqAJnZLk7MXVxOd2
         7scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UHKhNGF9h6UnRkG1fb5S0yRAer4+UyZQ8Isf84BVwlc=;
        b=Xu5LMYsiVfD+RO9Y101cK+UdSgIT0+HraRr2A5TaisSrwyB0ytomb6VIcPSez8v9MO
         QD8/BNkbIuKX0djTPaLnqY1m+9itcELT1ka4Lsq5dqumKiHIrzEoGjX0ZPLldgiRvklj
         YR4XP7epHov1ixTMClqnnm3hztjyxoJV8EXqWBtgToGVAcxz95qtSsQmH81Rt+OgA0kR
         uW07krEfgQn1EqIyJEsNxF9Nhey1kWQUnxkdLxbSqUEV7oIN5Cde66i3p54Sb20+Hj2C
         u7qUTiBrW/oSthBTEbwbnr4PLBoWpTAS4JclGJj77YAHnXgqBa8c6gC3kQ1AvAmlveIO
         pywg==
X-Gm-Message-State: APjAAAVkwPDSR1xWnTXA54mpFQjbM91XEHLYrRpChhwgIOgk8PSwMbCY
        pikpcw4AKWkFgMK1sDx9+r4=
X-Google-Smtp-Source: APXvYqxWonr93z+lwNSb0O4bPtLM6S1Q0OOVr8pt+0Qrmm2vVwgFNowIc8Qn/ZlknlLfNE1SDu26gA==
X-Received: by 2002:a62:62c2:: with SMTP id w185mr3739702pfb.237.1556034274772;
        Tue, 23 Apr 2019 08:44:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id m131sm41015465pga.3.2019.04.23.08.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 08:44:33 -0700 (PDT)
Date:   Tue, 23 Apr 2019 08:44:31 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, andrew.smirnov@gmail.com
Subject: Re: [PATCH] thermal/drivers/of: Add a get_temp_id callback function
Message-ID: <20190423154430.GA16014@localhost.localdomain>
References: <20190416172203.4679-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416172203.4679-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 16, 2019 at 07:22:03PM +0200, Daniel Lezcano wrote:
> Currently when we register a sensor, we specify the sensor id and a data
> pointer to be passed when the get_temp function is called. However the
> sensor_id is not passed to the get_temp callback forcing the driver to
> do extra allocation and adding back pointer to find out from the sensor
> information the driver data and then back to the sensor id.
> 
> Add a new callback get_temp_id() which will be called if set. It will
> call the get_temp_id() with the sensor id.
> 
> That will be more consistent with the registering function.

I still do not understand why we need to have a get_id callback.
The use cases I have seen so far, which I have been intentionally rejecting, are
mainly solvable by creating other compatible entries. And really, if you
have, say a bandgap, chip that supports multiple sensors, but on
SoC version A it has 5 sensors, and on SoC version B it has only 4,
or on SoC version C, it has 5 but they are either logially located
in different places (gpu vs iva regions), these are all cases in which
you want a different compatible!

Do you mind sharing why you need a get sensor id callback?

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/thermal/of-thermal.c | 19 +++++++++++++------
>  include/linux/thermal.h      |  1 +
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 2df059cc07e2..787d1cbe13f3 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -78,6 +78,8 @@ struct __thermal_zone {
>  
>  	/* sensor interface */
>  	void *sensor_data;
> +	int sensor_id;
> +
>  	const struct thermal_zone_of_device_ops *ops;
>  };
>  
> @@ -88,10 +90,14 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
>  {
>  	struct __thermal_zone *data = tz->devdata;
>  
> -	if (!data->ops->get_temp)
> -		return -EINVAL;
> +	if (data->ops->get_temp)
> +		return data->ops->get_temp(data->sensor_data, temp);
>  
> -	return data->ops->get_temp(data->sensor_data, temp);
> +	if (data->ops->get_temp_id)
> +		return data->ops->get_temp_id(data->sensor_id,
> +					      data->sensor_data, temp);
> +
> +	return -EINVAL;
>  }
>  
>  static int of_thermal_set_trips(struct thermal_zone_device *tz,
> @@ -407,8 +413,8 @@ static struct thermal_zone_device_ops of_thermal_ops = {
>  /***   sensor API   ***/
>  
>  static struct thermal_zone_device *
> -thermal_zone_of_add_sensor(struct device_node *zone,
> -			   struct device_node *sensor, void *data,
> +thermal_zone_of_add_sensor(struct device_node *zone, struct device_node *sensor,
> +			   int sensor_id, void *data,
>  			   const struct thermal_zone_of_device_ops *ops)
>  {
>  	struct thermal_zone_device *tzd;
> @@ -426,6 +432,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>  	mutex_lock(&tzd->lock);
>  	tz->ops = ops;
>  	tz->sensor_data = data;
> +	tz->sensor_id = sensor_id;
>  
>  	tzd->ops->get_temp = of_thermal_get_temp;
>  	tzd->ops->get_trend = of_thermal_get_trend;
> @@ -516,7 +523,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>  		}
>  
>  		if (sensor_specs.np == sensor_np && id == sensor_id) {
> -			tzd = thermal_zone_of_add_sensor(child, sensor_np,
> +			tzd = thermal_zone_of_add_sensor(child, sensor_np, sensor_id,
>  							 data, ops);
>  			if (!IS_ERR(tzd))
>  				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5f4705f46c2f..2762d7e6dd86 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -351,6 +351,7 @@ struct thermal_genl_event {
>   *		   hardware.
>   */
>  struct thermal_zone_of_device_ops {
> +	int (*get_temp_id)(int, void *, int *);
>  	int (*get_temp)(void *, int *);
>  	int (*get_trend)(void *, int, enum thermal_trend *);
>  	int (*set_trips)(void *, int, int);
> -- 
> 2.17.1
> 
