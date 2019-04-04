Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986F4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B13206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpHMBwTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfDDIJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:09:25 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39823 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:09:24 -0400
Received: by mail-it1-f193.google.com with SMTP id 139so2263823ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0U9b81O2zP1gsld8bP0KEM1gVj+s6mItuAkqOhr/31I=;
        b=UpHMBwTJz4KeNFhsv/Y9yArtvl1ZrLfyvrQuz5+iLGO3zEnPHMFu1SZ+EJGIaCpt70
         jTdBaoeAaizZuURlz+BXUE1fqnzqYMrV3eHHJn3/UrHNt1LJiNMD2DIc6BynIhH2t37E
         e9Sfxc5UdlbQ6L/E6FMvgn0eweG/ju2eDjFfq3A+KYIsZD1PWFUVFw6+EN28Y6IqBip2
         3AZjFuQ3QaXrV0B3eVSfqbeDHqGKEZKwu2k93QTa63v5ZrberoP+++njfZT9ZPQ1kW+g
         ghdCekRqWMmlZx89gcYz5r+VSSGG/XNFLXA1OLsEHOU1t8sp4nSbtziaZJMI4e1lOk6Q
         Zmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0U9b81O2zP1gsld8bP0KEM1gVj+s6mItuAkqOhr/31I=;
        b=HL6gS96Utv/Kbfp6dikWeBaB4lHXx3rSP+GcFzDqmyyKv7HXVtpO3ZpP+jk/mDBB3s
         GXBQ8O0qpSAJUw0wn2knqIaWbm6YaRl+xUp9+pHx1lWtWPVxSmRAemIrggN2Q58rtgCE
         YdrSdMO5hv1+EKTha1rpdS4Xsry6OPZ85okkWjSC+MLTVj6+Ev4ndy3PKV30VjhJ1LAT
         oHE2qWjvxY/AylcIscl4Lj2dVriYohaJLR3iIOGWjXTWMUML5E9/WzdgEoGPoU2PwTJv
         pc3sj2BqyAB4EEmLZfKYPx9f/1URYbp9GQOQr9jHqizgjYXr52UZ1jINEj/Qf4jM8r2d
         XSfA==
X-Gm-Message-State: APjAAAVLY9O/RwTHifDlHzMi15qqsbn6dO6grVTtoJPwLyxfsLsvADht
        NjqSu+Wup3NTCXfJ/w4vu1klni3ilP9BmQ==
X-Google-Smtp-Source: APXvYqzvcY5OFJ4+04wYGjm9vDbN3/CtuCdgL2ZK0fF0cR/oSMCsnTFv5R7FsHqnYh/mx69O/4IhaQ==
X-Received: by 2002:a24:5751:: with SMTP id u78mr240822ita.135.1554365363205;
        Thu, 04 Apr 2019 01:09:23 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id i26sm7496377ioj.86.2019.04.04.01.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:09:22 -0700 (PDT)
Subject: Re: [PATCH v3 06/13] thermal: qoriq: Pass data to
 qoriq_tmu_register_tmu_zone() directly
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-7-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3015d0db-5e22-3c56-b6bc-78f836ff51dd@linaro.org>
Date:   Thu, 4 Apr 2019 10:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-7-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
> instead of passing a paltform device and then deriving it. This is
> done as a first step to simplify resource deallocation code.
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
>  drivers/thermal/qoriq_thermal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index deb5cb6a0baf..24a2a57f61c9 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -109,9 +109,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>  	.get_temp = tmu_get_temp,
>  };
>  
> -static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
> +static int qoriq_tmu_register_tmu_zone(struct device *dev,
> +				       struct qoriq_tmu_data *qdata)
>  {
> -	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
>  	int id, sites = 0;
>  
>  	for (id = 0; id < SITES_MAX; id++) {
> @@ -120,7 +120,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  		s->id = id;
>  
> -		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> +		tzd = devm_thermal_zone_of_sensor_register(dev, id,
>  							   s, &tmu_tz_ops);
>  		if (IS_ERR(tzd)) {
>  			if (PTR_ERR(tzd) == -ENODEV)
> @@ -215,7 +215,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_tmu;
>  
> -	ret = qoriq_tmu_register_tmu_zone(pdev);
> +	ret = qoriq_tmu_register_tmu_zone(dev, data);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register sensors\n");
>  		ret = -ENODEV;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

