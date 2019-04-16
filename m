Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598920872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1rqsS9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfDPRJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:09:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39438 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfDPRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:09:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so28117263wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4SCxJa/5NTMjkNG3rHMCaM9fV7ELq7eu748ZMidYjUw=;
        b=j1rqsS9Brfd5ot2FyCxlemamhgXsQNWGk2xNAoLZiJYl2dyY8mxvdCoQ1dRuPExLaP
         wRnhwMf/NZnmfbtGiCnQoDDMgMsoD/fw6mFQFCdXpBZjJwqhbWgxQtMQRE7fPhAHNVdD
         XxQVhlIie3PkUdstzygzv7zHrePQRiG3ZY/t7wh+Rc4EuGp8hoOhfzuYS2d1qk/xKOr1
         PLVf8jDKnZqBSXy+02y+nvbLRFEDfnC+stYjj0yvWBxrSbAfJvpgH0IUy2berCpeJIiL
         CnuIausK31g4FjMrqSNce0KLTze4YzalSfgAq5JcJpsZmP7EkdEgyUlBy+l01BJfLGC1
         x0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4SCxJa/5NTMjkNG3rHMCaM9fV7ELq7eu748ZMidYjUw=;
        b=nk8d76EX4181mZtd3uh7DgKxZdA5sN3MRa/gSAy4E9WOYbByMP3kTLnZFYFmkTXKqV
         JFb228IFAzUtIfBsbv7wERhzDHW9jJnVazGCP269r7ESSRJlCUzl6mT74RzNlyvZKoXu
         bP/xpolUmj+RiJ2iha+n57OZIv6tEDCbyCe8JS5vak3oePfZ0RpQSEdi3fGb8Sk8p4af
         coR5djn+AYLli+2tBRO/b4k/5G97zpki1W8+yk0/x+aGI1Le22Sd/cjM7MgpjnR5UnQq
         Ye/MnhnW8hjdCQnIvevpBn6c8L6UfAoGuPaD/gNMoBBEK7lBfkYEcpMKrtA0xX8DWLsN
         yidQ==
X-Gm-Message-State: APjAAAWJN0FVJEPpREb9REVUX/BHLfrCzsQBXSxZ1QLc75jsmFCwffzN
        QoeViOf/Z556P0Gx9awcTSt2OhMNL7o=
X-Google-Smtp-Source: APXvYqxjY/59bAe3mo+amZQUX7RcRwEB1/aS+mIQrE9OSB3sUb5lAblRA/5d0rzFU434+L3+YNcoNw==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr34665812wrq.280.1555434572715;
        Tue, 16 Apr 2019 10:09:32 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id x205sm1300wmg.9.2019.04.16.10.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:09:32 -0700 (PDT)
Subject: Re: [PATCH v4 09/12] thermal: qoriq: Enable all sensors before
 registering them
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-10-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8233019b-988b-05d5-6b7c-55652da8b3cd@linaro.org>
Date:   Tue, 16 Apr 2019 19:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-10-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
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
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 9774323a17bf..abbbfe88422e 100644
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
> @@ -61,28 +62,28 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
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
>  
>  		tzd = devm_thermal_zone_of_sensor_register(dev, id,
>  							   qdata, &tmu_tz_ops);
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

Why not simply:

	if (!IS_ERR(tzd) || PTR_ERR(tzd) == -ENODEV)
		continue;

	regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);

	return PTR_ERR(tzd);

?

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

