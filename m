Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9E4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383C720855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJPeUf9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDDH52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:57:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38216 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDDH51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:57:27 -0400
Received: by mail-it1-f193.google.com with SMTP id f22so2229939ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UhHdbjx9omJoqlSbjHbHfjM36YmcW7tw6u66gIt9h0c=;
        b=ZJPeUf9+HnNdGzZTeN18bF+3dpXsW8+zyL9qcXXMMS1hkBhkeTK6ufMfNjcM4+lJKC
         exhaBegVyJKXeZUBnb22NXHnvSahHDVpG9yqCj3DUFF8nQnhYBbUT/2/62UUMaFMUY7e
         lU8mSgM74LmioxvHfcBLDjVfnlEeWRpesFVdqpx64qWO3hCecgqTwoxfcX7Uj9l8+NDS
         Iq2cH2Sra5yo7/Y106f1q/O6ozlzNVVF73KCdAkdnAcqDVpwDkTlPS4mQdku8Zo4ZLdr
         ohIx0R8mm6vol9J8FJh9HrTgWfI981hIDPdEo4w3jZKPa3oR6l1nXccIgUG4Ia9t8GYI
         Mf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhHdbjx9omJoqlSbjHbHfjM36YmcW7tw6u66gIt9h0c=;
        b=aL3gT2D8f7SPR0hTzlmrToPGHSw1DiAxUou7XtEjEZ4wvQ9IlO88Ul20eIaldACr9v
         JLWJguNCmPnPuezJCi6mdP8XPoS2MT//5HRy242uyMxbrMR7FiqIlKi3XEPS4UHK45fl
         mfW0onoxIF0Pr0XJDqbHCVloSrDjSaHDh/a1Q64/u06UOry0vXPK7iUtVrGunYXyer16
         pUsGlTJjqNDVW6ohuBScImDdYcpJsU6ef6XCAZsY/+cQ4RzhB96KdeHtfCtoJWuOHgsj
         jDAXsfrHPyopiFSS6YgCgR/q573H5RCgEwLwJBFpTGfzYblFzKPD4PAbbPwmGRHJliDp
         Fmgg==
X-Gm-Message-State: APjAAAWEQ6W5+ZYz3eAlPPRRMNRWZXCpbiMG/OdUaYNQNUDJHME9HJmF
        tPiOZA/zNNCihuuxfCtw+ccn8g4Ts5nLTQ==
X-Google-Smtp-Source: APXvYqx0uAs5rI4uU1p4kePXPbCgDnz70G/32wLiJR+mjIcFWMV3qNIoFgXWzTMG0+0Fxq6m5Qy/YA==
X-Received: by 2002:a24:70d3:: with SMTP id f202mr36723itc.54.1554364645600;
        Thu, 04 Apr 2019 00:57:25 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id z25sm7111030ioh.43.2019.04.04.00.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 00:57:24 -0700 (PDT)
Subject: Re: [PATCH v3 05/13] thermal: qoriq: Embed per-sensor data into
 struct qoriq_tmu_data
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-6-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
Date:   Thu, 4 Apr 2019 09:57:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-6-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Embed per-sensor data into struct qoriq_tmu_data so we can drop the
> code allocating it. This also allows us to get rid of per-sensor back
> reference to struct qoriq_tmu_data since now its address can be
> caluclated using container_of().

This seems to be a repeating pattern, drivers are forced to put a back
pointer in the thermal sensor structure to regain access to the
container structure in the get_temp callback.

It would make sense to pass the sensor id to the get_temp callback as we
register with the sensor id.

One comment below.

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
>  drivers/thermal/qoriq_thermal.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index e281bdcfa11f..deb5cb6a0baf 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -59,22 +59,24 @@ struct qoriq_tmu_regs {
>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>  };
>  
> -struct qoriq_tmu_data;
> -
>  /*
>   * Thermal zone data
>   */
>  struct qoriq_sensor {
> -	struct qoriq_tmu_data		*qdata;
>  	int				id;
>  };>
>  struct qoriq_tmu_data {
>  	struct qoriq_tmu_regs __iomem *regs;
>  	bool little_endian;

Why not replace the little_endian boolean by a couple of callback
read/write and assign them to ioread32|ioread32be at init time.

That will kill the tmu_read and tmu_write functions and from there you
can figure out how to remove the qdata backpointer. In addition, it will
save a few instructions to test the boolean.

> -	struct qoriq_sensor	*sensor[SITES_MAX];
> +	struct qoriq_sensor	sensor[SITES_MAX];
>
>  };
>  
> +static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
> +{
> +	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
> +}
> +
>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
>  {
>  	if (p->little_endian)
> @@ -94,7 +96,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
>  static int tmu_get_temp(void *p, int *temp)
>  {
>  	struct qoriq_sensor *qsensor = p;
> -	struct qoriq_tmu_data *qdata = qsensor->qdata;
> +	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
>  	u32 val;
>  
>  	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
> @@ -114,15 +116,9 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
> -		struct qoriq_sensor *s;
> -
> -		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> -				sizeof(struct qoriq_sensor), GFP_KERNEL);
> -		if (!qdata->sensor[id])
> -			return -ENOMEM;
> +		struct qoriq_sensor *s = &qdata->sensor[id];
>  
>  		s->id = id;
> -		s->qdata = qdata;
>  
>  		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
>  							   s, &tmu_tz_ops);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

