Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0293DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57542133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eD0tjBoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDDD24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:28:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDD24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:28:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so604156pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VFJ2wER6EQKUZL0dXpjVrQRv+8SzbIa0hZCCKCls6uc=;
        b=eD0tjBoW6hsIYZKLAivX5T3fC3B0NgKd2iL88VLK8cCKdamgx22yzfhnqcEuHjNLTJ
         9f993jHHYeDbEDptrVdHO/08yJQOXyrNzSIsFJ+N74XTsmToXEx2CMpaFcQuFyseFVLY
         nl7JJLPqV4Gs62oqOyK9A53iropLTc54pkrb3LhCIWK7Aq0hmVe4Xx2KcyhF84i2wqu0
         cVZSLRgVzmab13ZchZvYWRIDhVrej4yL+ur1mNSIREA2ItLO2FepbeHNXHDIeV013yh0
         jvXuibSNSPQqQGv+VyOYY66DjGhGIoNs2zYVPyRFfjcSgDX+z/MNh7X8jJM1p9yAZ+8m
         j9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFJ2wER6EQKUZL0dXpjVrQRv+8SzbIa0hZCCKCls6uc=;
        b=GvQmvEjiKABPUIBne4PTu8Ee3OWpRqMhIn35UqWsZoSLlmVNP2Axs+Ux4Eaz3NaJwQ
         xh06+d5spnLy5lbkF3aOuiRKzdWeMhr8FnAYSR+ojCCZrp4yIpzlkvF6iXx9gpIe0mzi
         XhRUx0B3UMb0vUEx9Io/K8y5o7kMEoxdKwmfuaOY4X8Y1rNVkdj3Xo6088jg0/3CeR6l
         xm0h+FbblrKLy1jAmM6iiZuX4eW5+4NYIp02Fx/foxQim1dZaOkLlsiidHtd1A77ORWo
         W4e2NPn50BUleGDGDGvKG5KtjmJLy3Dk2eXUHMdO8wldPQ+yus+/14mqVkshSuMQ8/YQ
         3ajQ==
X-Gm-Message-State: APjAAAV5AclZPF6lDHM3svmfTKMq5Bq+GNNpUSeZtXP0cRCFcVkPKQ3Y
        IusfHEXkLZc31HR0JAd0GmfJcyq3lj5xQQ==
X-Google-Smtp-Source: APXvYqw50DXFCo1nIyIMANDfA4+Fr5ECKHZkbhypwyZ50F37Ko62glZybeveqUZBCDOc/zwmmaXgHQ==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr3441149pgh.263.1554348535036;
        Wed, 03 Apr 2019 20:28:55 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id r87sm18201915pfa.71.2019.04.03.20.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:28:54 -0700 (PDT)
Subject: Re: [PATCH v3 04/13] thermal: qoriq: Add local struct qoriq_sensor
 pointer
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-5-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <02822a7c-ae86-8c00-093e-665b603b1430@linaro.org>
Date:   Thu, 4 Apr 2019 05:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-5-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Add local struct qoriq_sensor pointer in qoriq_tmu_register_tmu_zone()
> for brevity.
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
>  drivers/thermal/qoriq_thermal.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 6d40b9788266..e281bdcfa11f 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -114,18 +114,18 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
> +		struct qoriq_sensor *s;
>  
> -		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> +		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>  				sizeof(struct qoriq_sensor), GFP_KERNEL);

I would not recommend this, especially if you use a variable helper for
clarity. Keep using the 's' variable and then assign qdata->sensor[id] =
s at the end when everything is ok. May be rename it 'sensor'?

>  		if (!qdata->sensor[id])
>  			return -ENOMEM;
>  
> -		qdata->sensor[id]->id = id;
> -		qdata->sensor[id]->qdata = qdata;
> +		s->id = id;
> +		s->qdata = qdata;
>  
>  		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> -							   qdata->sensor[id],
> -							   &tmu_tz_ops);
> +							   s, &tmu_tz_ops);
>  		if (IS_ERR(tzd)) {
>  			if (PTR_ERR(tzd) == -ENODEV)
>  				continue;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

