Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79674C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DC92082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rB1F5GsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDDDVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:21:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46619 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDDDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:21:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so471053pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ndQikP4SjrFvV/oZQZ3QyYMV6WkPxz0DiWPRCMGs5D0=;
        b=rB1F5GsGU/vxmhDeBZkYprSYLfZl/7g7lBGPrYjX2Z+GpIQUNRvbScnu5lZg5eHXyR
         RgQ171oN8Y7Lf7u0hnvhvrrWyzwqtxbpKWPgd+9WnFmQzD3xBHBy2HtMQEE0omBgmkbK
         PRjmF7XfWEyZ9UIprbCoTvlUkCXL+zbjbHNMkMEDLfEEc12/PtF0b+7bfOql7Vo1bLR4
         6oXOSNm4rYmc1Rbqvrt2jifahfgsqV8ycIrfBZxmUrQTNsMry5v8ZXm4NRtH4mHsNEbk
         7i5gsLmKADSIAjGEbajUIDUrodMZU0ekRZqCmjMpvZPqlMTMumsd4r7HOsIMxZQ3Jf6+
         FRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ndQikP4SjrFvV/oZQZ3QyYMV6WkPxz0DiWPRCMGs5D0=;
        b=YBitLX9RD5/4zffxa0HxE86DM5DVIeSjOBbbRVLSdt61YLye/O6jxO5PyQ9j0MJsQY
         EgCQgwpGLzQzelG78vNo8wsMPivNF4UJu4I0fex9T3O4ZMoYKP+NHJXpK12Aclc26lx9
         yNZBh1JA1sYML8oSqGrsvWS5WCqFgtgWKsOk7o/NvsJ/xUo28to7ew8X5pqZWTDXXKYu
         1we76/geU8hIDSOxiU8NLIWCDaRMNWwYCPIljvYmT8cl5KQa7lArasQiMjKamt4Pb2Mc
         iBgDC6+xHCmmL0wcq1kYqxHUFf6ZNfExNs/5+zVsSMOjCnuEqUqTc2rg2HI0pbeO8aOQ
         /ISw==
X-Gm-Message-State: APjAAAV0fEg8eJLofdw+U+Ihixf5OupiTRXeh3xPPTAvFLcLdNO34Eu3
        KzCoCUHaoGBb/k4cgkJW3xiZdVP0j/KX/Q==
X-Google-Smtp-Source: APXvYqxdPzeZi+u9mUwmfYh6O0K8TFsiGYcfkzWgPFRnymX5qW6UPdl9+s8Sktru1BJaDhmJUn4/Ow==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr3228074pgg.12.1554348081166;
        Wed, 03 Apr 2019 20:21:21 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id d75sm39023880pga.66.2019.04.03.20.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:21:20 -0700 (PDT)
Subject: Re: [PATCH v3 01/13] thermal: qoriq: Remove unnecessary DT node is
 NULL check
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-2-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <22f0c6d4-842e-bb91-a684-6edb6345e036@linaro.org>
Date:   Thu, 4 Apr 2019 05:21:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401041418.5999-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> This driver is meant to be used with Device Tree and there's no
> use-case where device's DT node is going to be NULL. Remove code
> protecting against that.

May be elaborate why is never going to be NULL?

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
>  drivers/thermal/qoriq_thermal.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 3b5f5b3fb1bc..7b364933bfb1 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	struct qoriq_tmu_data *data;
>  	struct device_node *np = pdev->dev.of_node;
>  
> -	if (!np) {
> -		dev_err(&pdev->dev, "Device OF-Node is NULL");
> -		return -ENODEV;
> -	}
> -
>  	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
>  			    GFP_KERNEL);
>  	if (!data)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

