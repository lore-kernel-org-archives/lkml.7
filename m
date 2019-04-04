Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AD0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B296205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knBp0BVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfDDJIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33672 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732701AbfDDJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so1054707pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AV9AAmAxl4ECqZo+F3+Rx0UmUSXL0DvXuScJicekYg0=;
        b=knBp0BVDoVyU3AlFdQ+AJuiSWgPJSuufwB0RUCv+KLwU+JhX7D77/erMpWaBjUDJON
         aNv1TQf7zEjAl8A+XErUzW7EdkjzFiMfuObaoDgCUCedeEO+0K34dVZQVPp9EAGpbDBX
         FzSsq0wF0h9+IB7S7r+gMM9eGQZhvnNZMT09rLeezNs7bQQxqJdcNeg5OXwa4HGu2TdJ
         TmiaZ4Yzc8FGIKJC0z7jiMKPlNmjPZ5dkh9dRkMUFJEaOfK7FVJFlNFmpfM3dvJ68bgf
         HYtjkckqYlW73qonbEVFH6CgB70D1dHt8/vvB5vbE/l5kyAav5NsasCbm4g2OxxvmaTo
         /KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AV9AAmAxl4ECqZo+F3+Rx0UmUSXL0DvXuScJicekYg0=;
        b=k1djuTPis0xHRhwrxGvRgxrj3A8/DfkYVY0jrcehTlweCLDmpSHFNBNw27lG4XNnWB
         l6TuKaIifLcqn8g5cIbwTDi4jtBr8Hi4oc5YOe/HV1GawQMLISw/593amreFg3uz83vj
         M1ud6FLjEfULYEQTDacNwRP0gp/jTK62ijhLnbsIr7A9TyLR2uxXGMQAdBvqSza+4+Zi
         4IaFfh2HPLAQdMryUZUN043eboYit5OqOlgxkOLfhMFzZPUbCoZarVCNIqYoc4ic9+kQ
         W1pyukoO9Yqw2h+y+Yhx2ArpXYAcvJUS8kLh2Bv8GeD8x6X4S9yxbeEHpXgtSsmhv5hA
         2rPg==
X-Gm-Message-State: APjAAAULDjHUMhTxyBic9RI4EG+DYAfWwN6obqp1qcIEF1N/fJxFDIOP
        fLG1QZG5WUIgZwnEFOiHouhEXSwLUM8xPA==
X-Google-Smtp-Source: APXvYqz0Q2/bsuu0bJt8QcLywupc1yhqaEpGQXlSYYQKOT32DNQSZATZ80KaKJphvyqpGnV8v3D+SQ==
X-Received: by 2002:a63:9dc4:: with SMTP id i187mr4369626pgd.259.1554368924613;
        Thu, 04 Apr 2019 02:08:44 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id f3sm31143021pfn.100.2019.04.04.02.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 02:08:43 -0700 (PDT)
Subject: Re: [PATCH v3 10/13] thermal: qoriq: Enable all sensors before
 registering them
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-11-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f970350b-5d5f-adf1-6be3-5ce35ff8b9c3@linaro.org>
Date:   Thu, 4 Apr 2019 11:08:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-11-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Tmu_get_temp will get called as a part of sensor registration via
> devm_thermal_zone_of_sensor_register(). To prevent it from retruning
> bogus data we need to enable sensor monitoring before that. Looking at
> the datasheet (i.MX8MQ RM) there doesn't seem to be any harm in
> enabling them all, so, for the sake of simplicity, change the code to
> do just that.
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
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index a909acee4354..7ff93dfcd68b 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -23,6 +23,7 @@
>  #define TMR_DISABLE	0x0
>  #define TMR_ME		0x80000000
>  #define TMR_ALPF	0x0c000000
> +#define TMR_MSITE_ALL	GENMASK(15, 0)
>  
>  #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
>  #define TMTMIR_DEFAULT	0x0000000f
> @@ -75,7 +76,10 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>  static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  				       struct qoriq_tmu_data *qdata)
>  {
> -	int id, sites = 0;
> +	int id, ret;
> +
> +	regmap_write(qdata->regmap, REGS_TMR,
> +		     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
>  
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
> @@ -85,21 +89,18 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  
>  		tzd = devm_thermal_zone_of_sensor_register(dev, id,
>  							   s, &tmu_tz_ops);
> -		if (IS_ERR(tzd)) {
> -			if (PTR_ERR(tzd) == -ENODEV)
> -				continue;
> -			else
> -				return PTR_ERR(tzd);
> +		ret = PTR_ERR_OR_ZERO(tzd);
> +		switch (ret) {
> +		case -ENODEV:
> +			continue;
> +		case 0:
> +			break;
> +		default:
> +			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
> +			return ret;
>  		}
> -
> -		sites |= 0x1 << (15 - id);
>  	}
>  
> -	/* Enable monitoring */
> -	if (sites != 0)
> -		regmap_write(qdata->regmap, REGS_TMR,
> -			     sites | TMR_ME | TMR_ALPF);
> -
>  	return 0;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

