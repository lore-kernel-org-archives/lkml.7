Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F54C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AB1206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOUAjkMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfC0NAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:00:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42610 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfC0NAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:00:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so14977434wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0f62MwzkvbJXe3m2mt+kRe6ApZxxearKpjSEARZe42s=;
        b=hOUAjkMJOFcWXOXv1TP56LEU29Kvxj/aHa4u+wdnH5evb3qUTzbHaEGiEmWRCpUOEI
         eGB+7pHoQqyyAvUOrg9SY6zpcL3P6zw9B2r0kMVsbwugdm5wpkKEKuwBHY/LPpDjlpQN
         dLasVIrDddmqqGQ/jTzW+Sks2p85/gavq+7FZGVcOLPpFvKB0jiwR5ZR0FELMOTi7KvA
         fjIgai8FFakFmk3aRqJs+ALZyznNKpH/Esu88fgkQdRRXaTi5xwH6r7DI/0ziU6SJfXu
         O9KEBxPMhEp1oMBz2FF8EZz5VSrj1rxUXRXfXVD6XBBYsnCbqF6qzqfc0FiuN94BCnwf
         qc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0f62MwzkvbJXe3m2mt+kRe6ApZxxearKpjSEARZe42s=;
        b=s++EyGrYtekk3OllkxDKKylkXMPsiKc59fBHueYK4IlpvwZ3sTeYy1WrB5uLkZAZ3V
         oMjBNjquWfzsXqRBk67M39Nv4Ib0uYWcucOWp1ClNynHDMbKwFFimZjW4nKyJMNb+5U2
         HNse5PfUV6CrqDY3DElDtBjnomAPSkj/9epR8C2FV4M5geOpGXoiN81GjWjDDqzopaGQ
         3Z4lSZ+JYz7zzav+ymw/PgzvHV8hDIEIq1y3QiWENVSJ1+j7C4MbRpPfIWmMvaW2xLte
         nIBjMVWeqsDoL29fyZbLu1p1mPuEi3SFqxq6aSBdDFMk0d+kkiT6Kod11rRhwZbz24wJ
         ufjw==
X-Gm-Message-State: APjAAAXvo591dqA6bX+bCLSm/FAK9R9Z9RCJvO+bL7H6QFSYyK28klKR
        0RC59mauF2Q4rETePZSaAfeimg==
X-Google-Smtp-Source: APXvYqxePL8Og09EZluCZQJMe6JAS+jNjBOWZVLPhjaliqQcf5iIiraPoAkMci4f3+IC06pvV6KY5Q==
X-Received: by 2002:a5d:544a:: with SMTP id w10mr2322135wrv.276.1553691616116;
        Wed, 27 Mar 2019 06:00:16 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id k9sm26349119wru.55.2019.03.27.06.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 06:00:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] thermal: stm32: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20190319163635.30891-1-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <62d8b5a6-ed22-b0ec-ff3e-b545840b1210@linaro.org>
Date:   Wed, 27 Mar 2019 14:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319163635.30891-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 17:36, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/st/stm_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index bbd73c5a4a4e..cf9ddc52f30e 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -570,8 +570,7 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  static int stm_thermal_suspend(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_sensor_off(sensor);
>  	if (ret)
> @@ -585,8 +584,7 @@ static int stm_thermal_suspend(struct device *dev)
>  static int stm_thermal_resume(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_prepare(sensor);
>  	if (ret)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

