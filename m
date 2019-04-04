Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C409C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1F12082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGGp2lTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDDDXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:23:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33715 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDDDXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:23:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so504691pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KzLdTsBLN+fGzMeLE/k+ArhXzs8cLLdKTDrLfR25ZaM=;
        b=wGGp2lTLc8uS/Gg9jFxwCRd5qBfe8L2crBnb0UA6Rvp2AvObn9lsSyjBsoD2Nz7QSI
         JfdzutuzEdvolzdgWbkbgJzcGDuinzNwNBQk7/a0ryWogW47FQ5K9TgJKPXM2ZAgOr2B
         2J0beME/+tOFFTbTYuPdZxxPpVLcRpgAcLXHx6RaO/zkk/+BKihXal7YbV/RsIKSfWle
         Yw7FY0P8Zq3S8L66jviqEB6ivFMeY93KWhyCuHpIS9AXil23RY8BHxBe35ilud6C6+sr
         fgTPSKdcZ1+dKXvnocRdfm5E0Hc6/CesdqJEXMtKM8W2oxabJWsEbEnsf5qZk1PfBpXq
         UNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KzLdTsBLN+fGzMeLE/k+ArhXzs8cLLdKTDrLfR25ZaM=;
        b=V0mBYyJDnaB1zjtpZ2hiXoKguNME+Wot+GIcbL3v3PLK9yufpeHmUCFsIyhtbBDOU/
         jZiSzJxN/XTBzZIF9PxqWesY7laawNMG2PDNKNjEyoMlVK9w7D4kVVbCeyXxfMsWdA83
         FmO/7uBYpiNm+833P4t8p4utUzgkOC4w+8S71zoSoQxfzKBn3vhC6/2Cz9UehAvTOq6l
         b5ObvMa3x/TBkbDGbkOYOWlTuqsUIz66wSb2OYTP6awTZAXyLLkU+05GYgmuTs7HBzUf
         mhGLq2A9lN0tbLxPVWXpWG7s3vsnaj8N8jxmgiIUW4ob2USR2YZvHCeIn4zYC8CLKDvG
         +FFw==
X-Gm-Message-State: APjAAAVZu2yqSTUUT9DNVdC41vvNB1Y9fNv4PONn4jezZ0dLZqtr20dI
        exiHhtyCpB4nCHYNI8AhwfOwf2BCjsRLXw==
X-Google-Smtp-Source: APXvYqxjgFNDM1FjpbEZvTHQo70iyudVOOY1hmq2FP2WB6puKV16tYGF5bMk6pLw9JPzXf/Sf4WzGw==
X-Received: by 2002:a62:5582:: with SMTP id j124mr3311526pfb.53.1554348223301;
        Wed, 03 Apr 2019 20:23:43 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id a9sm24947698pfo.17.2019.04.03.20.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:23:42 -0700 (PDT)
Subject: Re: [PATCH v3 03/13] thermal: qoriq: Don't store struct
 thermal_zone_device reference
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-4-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <af50ccd1-1fad-4400-2404-cc5de475b43f@linaro.org>
Date:   Thu, 4 Apr 2019 05:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-4-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Struct thermal_zone_device reference stored as sensor's private data
> isn't really used anywhere in the code. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/qoriq_thermal.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 91f9f49d2776..6d40b9788266 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -65,7 +65,6 @@ struct qoriq_tmu_data;
>   * Thermal zone data
>   */
>  struct qoriq_sensor {
> -	struct thermal_zone_device	*tzd;
>  	struct qoriq_tmu_data		*qdata;
>  	int				id;
>  };
> @@ -114,6 +113,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  	int id, sites = 0;
>  
>  	for (id = 0; id < SITES_MAX; id++) {
> +		struct thermal_zone_device *tzd;
> +
>  		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>  				sizeof(struct qoriq_sensor), GFP_KERNEL);
>  		if (!qdata->sensor[id])
> @@ -121,13 +122,15 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  		qdata->sensor[id]->id = id;
>  		qdata->sensor[id]->qdata = qdata;
> -		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
> -				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
> -		if (IS_ERR(qdata->sensor[id]->tzd)) {
> -			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
> +
> +		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> +							   qdata->sensor[id],
> +							   &tmu_tz_ops);
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV)
>  				continue;
>  			else
> -				return PTR_ERR(qdata->sensor[id]->tzd);
> +				return PTR_ERR(tzd);
>  		}
>  
>  		sites |= 0x1 << (15 - id);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

