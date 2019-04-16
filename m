Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093F6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3A7206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZvlWKmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfDPRXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:23:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40188 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDPRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:23:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so26663075wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uG4weFkpAqO5ZljcdLSZQOdiEbgnP+Em6FwXZ5QFtl8=;
        b=wZvlWKmxDSAVZh4ZOYgMXEE0GyclhXG9AR9XxEuUXdsgz6pgW1onZGiGDg4gzmzMkq
         Jd+778y8DYV54xNsOT7nofj/zD1T8U1IfKLKLdy/O0sBv1uTQcV35JSDmCi/OPZhwxtt
         5sKP1+bw6EmLKvfe7Y8mAwEsJ16mpTyJWY6ZDDXmRSmw2Y9edMqaqC2fRJHvpjvpZPCF
         ekijL0etoOKiifYN4VDObCFsMxa9q4TU2i8mgQIKhv5KbMNZ0YHYTiaBm4IxPXHF6gsP
         UsyaC/vwEPtnGSZwKUI+w7aq1G9EvoCMUyaCP2Qy4j0JRUMM2nfq9lSSoUM9WqnPIPSk
         OvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uG4weFkpAqO5ZljcdLSZQOdiEbgnP+Em6FwXZ5QFtl8=;
        b=AZgfMdjV6zWzfdi6mAIeoTX1rQKdlC8B3GJM0p1IK/FRi0DiL8rOv3DoWdP8moALv4
         p/Hw/ll0ie7xDFbWrDCBNSu91If4XqYFq94Vy5qddT1Et9gZjr9rwR7HBC8iX3EclUZJ
         qZzQZpUm7NV2euFhR5SlLNIb1xk6UEs2b7YNIjFT9KZp9a+pd8mQ8hB5MEcf5FAnzWlU
         Oq5fv7RxHvZO5rYQRzIMH5TI6yQJvDiGcTihFaRCrq4xQ4F8BdneZJTevCzb/xBG7WNV
         sK7zwxCYDvnvz8T2Ytsdt3zRpvp/BG9wOgDcq8Q65YZdAcdGxDd4GZHgMnw8/x40CQhB
         4GLQ==
X-Gm-Message-State: APjAAAWE803KNzS/4MpPR7w4alNVv+7ftO7pR9qCS0VTyfcCSPxT0mcB
        m3JxZU2Mfk/CtmpGh85dIXPk1tsZ0lE=
X-Google-Smtp-Source: APXvYqyMgF0ek7GadqBFM/O73FdiNZzfFP46WcCodaYko3A1ugKssnNmkZLnp8J8wwyfq16azoWA+A==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr26297973wma.53.1555435421500;
        Tue, 16 Apr 2019 10:23:41 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id z7sm54467728wrt.10.2019.04.16.10.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:23:40 -0700 (PDT)
Subject: Re: [PATCH v4 04/12] thermal: qoriq: Drop per-sensor data
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-5-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <230a8f04-0d1a-8b3e-2ddc-c1bb0d06bfb1@linaro.org>
Date:   Tue, 16 Apr 2019 19:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-5-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Now that driver is converted to use get_temp_id() instead of
> get_temp() we no longer need per sensor data. Drop all of the code
> related to it.

Rui, Eduardo,

I just want to point out this patch is depending on:

"[PATCH] thermal/drivers/of: Add a get_temp_id callback function"


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
>  drivers/thermal/qoriq_thermal.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index c041d1ae3500..3500e238fe3e 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -59,20 +59,9 @@ struct qoriq_tmu_regs {
>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>  };
>  
> -struct qoriq_tmu_data;
> -
> -/*
> - * Thermal zone data
> - */
> -struct qoriq_sensor {
> -	struct qoriq_tmu_data		*qdata;
> -	int				id;
> -};
> -
>  struct qoriq_tmu_data {
>  	struct qoriq_tmu_regs __iomem *regs;
>  	bool little_endian;
> -	struct qoriq_sensor	*sensor[SITES_MAX];
>  };
>  
>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
> @@ -93,8 +82,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
>  
>  static int tmu_get_temp(int id, void *p, int *temp)
>  {
> -	struct qoriq_sensor *qsensor = p;
> -	struct qoriq_tmu_data *qdata = qsensor->qdata;
> +	struct qoriq_tmu_data *qdata = p;
>  	u32 val;
>  
>  	val = tmu_read(qdata, &qdata->regs->site[id].tritsr);
> @@ -115,17 +103,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
>  
> -		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> -				sizeof(struct qoriq_sensor), GFP_KERNEL);
> -		if (!qdata->sensor[id])
> -			return -ENOMEM;
> -
> -		qdata->sensor[id]->id = id;
> -		qdata->sensor[id]->qdata = qdata;
> -
>  		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> -							   qdata->sensor[id],
> -							   &tmu_tz_ops);
> +							   qdata, &tmu_tz_ops);
>  		if (IS_ERR(tzd)) {
>  			if (PTR_ERR(tzd) == -ENODEV)
>  				continue;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

