Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37835C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0481F205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NO2SAA+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfLKQM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:12:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbfLKPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:09:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so24394017wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rZVVfmcA7nilm43qu1vr0G4ih2DRvgI2LIwxMX3GmZM=;
        b=NO2SAA+c5VVCLzfy9pyhAEiNINNX3kHFsCX/sL90lCqw2Ck0btb7CvhIKfc6Ac8gfg
         Wg0/aq6TV+ODVHYQjkgxBJbh5PjEPXh2jhc3RzDAudrx/+1arQJrouTGtbU4hs9J81ZP
         9KgyRAlCeg4ZzSlRYq8GKNGnJ+A+44y6Iu2cq5THKFUJtri5msXBupEeaxE2rH6zfmQd
         TDExPqREaHpgeUw0t7fdo8svQF0ytEUhIY9NOgxB+BAxsdKDlzHHKB+xB44m3AwwAy5T
         X1w6GBSy3Pt+RMb8k3HkWVqzRfUKu0PgYJkEGEdL5S+QAPEefpZ6HktLh8UoIThRlAMR
         k6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rZVVfmcA7nilm43qu1vr0G4ih2DRvgI2LIwxMX3GmZM=;
        b=iREKcEgoIrRVXUdNuL9UOt5nqne50tnH509zXvpDS8mJ7CCDfolhbleGxkahqPA9ef
         DIy+Atb25ZiQDWg/QS9nt66kRKiv6AldOtSpJ2dgON2hldVfg2CfD5aee9JrdSY6UDkK
         a9k17mFfU4rNR34T7S5sqA698AwuO7DLyAnOei4iioKXlJY0h43x0kEqypH1adTcQzTA
         wULBlIGIPCGWJCkzT+fG1EMInsK1rPMjBg5XWPdxbsDP+q9uuh69zfoDHjvRuk5XBHe2
         PLct3nwYZnmTz+6YPyyyw40ebRXp3kGoN30PO1jb1GAdwedk1+bproO6niH6zEf03WpH
         FQ/w==
X-Gm-Message-State: APjAAAU75z6kiNSUKvP/Hdf2D4FFZd6VH1U8Ghk5B7qO2nSqFMw4u4bW
        3qR0MTzf3PNrclR7P6K8r2F9Yg==
X-Google-Smtp-Source: APXvYqyd6vy+iUwCdrH8Too6eymccRguXlFfkclccjZT8vLOZpaoM9yZcOuXHxYXlg7OvsWu6BqZsw==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr288441wrv.364.1576076970624;
        Wed, 11 Dec 2019 07:09:30 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:e505:be10:23e:110d? ([2a01:e34:ed2f:f020:e505:be10:23e:110d])
        by smtp.googlemail.com with ESMTPSA id l17sm2549108wro.77.2019.12.11.07.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 07:09:30 -0800 (PST)
Subject: Re: [PATCH] drivers: thermal: tsens: Work with old DTBs
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org, swboyd@chromium.org,
        stephan@gerhold.net, olof@lixom.net
Cc:     linux-pm@vger.kernel.org
References: <cover.1576058136.git.amit.kucheria@linaro.org>
 <39d6b8e4b2cc5836839cfae7cdf0ee3470653b64.1576058136.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aa9174c2-c851-4769-0f9c-5541047a7901@linaro.org>
Date:   Wed, 11 Dec 2019 16:09:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <39d6b8e4b2cc5836839cfae7cdf0ee3470653b64.1576058136.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 10:58, Amit Kucheria wrote:
> In order for the old DTBs to continue working, the new interrupt code
> must not return an error if interrupts are not defined.
> 
> Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 015e7d2015985..d8f51067ed411 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -109,7 +109,7 @@ static int tsens_register(struct tsens_priv *priv)
>  
>  	irq = platform_get_irq_byname(pdev, "uplow");
>  	if (irq < 0) {
> -		ret = irq;

'ret' remains uninitialized here.

> +		dev_warn(&pdev->dev, "Missing uplow irq in DT\n");
>  		goto err_put_device;
>  	}
>  
> @@ -118,7 +118,8 @@ static int tsens_register(struct tsens_priv *priv)
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>  					dev_name(&pdev->dev), priv);
>  	if (ret) {
> -		dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
> +		dev_warn(&pdev->dev, "%s: failed to get uplow irq\n", __func__);
> +		ret = 0;
>  		goto err_put_device;
>  	}

The code now is unable to make a distinction between an error in the DT
and the old DT :/

Why not version the DT?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

