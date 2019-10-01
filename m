Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31807C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F8D2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcHZ5SL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfJAJ7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:59:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40580 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:59:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so14684009wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H6cw40bjr93UCpoh3Do3Kf35YqQ3oo81uvRbEJ9472w=;
        b=xcHZ5SL4713A3EyMTIixe6/yC73jL+WfHaRcDANdxXBx93UTv13ECs5I4RB6eZHTl4
         77RhLlEy9uezstXuY4eX+cCPCJ2geYLI1zEzt69kJo9V1U7GLV5sJjhQ9LboTBHfSwTK
         8O5A/zKh/t0ht1pT+GbiBUiRgGDgCWUd97WNsWoSnjTzy0s2dlLGxGQcHYFld72LSS1T
         nQciw1D2/rMeTZAw3FaEt2hReed087DfGzXs8tKqBfn4dnMpqydbOvnI8o9eP5dbg36B
         wZC2XVjmTH3uoBRPBiXZ3Iol1e0lu8WN9rivxnPbEpgb1xmZPZEDFb7TPwTkyjhPaYQW
         wFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H6cw40bjr93UCpoh3Do3Kf35YqQ3oo81uvRbEJ9472w=;
        b=i5KqOJzCIHiz3Rc2rIYZJwB0fyGTe9nrQamKlHAHTdX4No/0nHvy0qsyNZM0BWqVm0
         MFeh9NEe6pu0DzNJ2dpM1hPKdkkZnZfdoNZUxM0BODtfCsqxN8xyRjtQJMw/400D0/xk
         Y0O5371reFCOSBhZ3fTs1f7H/B+amNSPL4+ozMEE3e6FhcABoDXodNFOjkoX4k+e62ft
         8bwQ1oWTfccGvZg+cotyClOPhC5ypmmIVGtCb6K3j4Ph0L3kP6/Yoszhj7le4X4pXIJb
         BThEn9g6vUImIJ0ABS0TsrKDM9gU07mwoln6u7fISQtLLPI969PgqPTBi1fM3Lqo4yjL
         G8pQ==
X-Gm-Message-State: APjAAAWhCvbZQa51OJq/tc9WXTnh4VyMwEGxDULLxrIihkprPmCFewEd
        ktC1Syel1gs+KHBJzPM0gPoKNbChdSA=
X-Google-Smtp-Source: APXvYqwizk9nhaStRvBRetXOtY0+/aZmboK5qRDfqhBuZ7sY9IqqIlTxx3spkJJv18yVHQT84McA1A==
X-Received: by 2002:adf:f709:: with SMTP id r9mr16801917wrp.228.1569923975338;
        Tue, 01 Oct 2019 02:59:35 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h17sm4734761wme.6.2019.10.01.02.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 02:59:34 -0700 (PDT)
Subject: Re: [PATCH] nvmem: sc27xx: Change to use
 devm_hwspin_lock_request_specific() to request one hwlock
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, freeman.liu@unisoc.com,
        linux-kernel@vger.kernel.org
References: <b2ad55edbb1185c52dc73622ddccbdb7c1b52efd.1569552692.git.baolin.wang@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <57bbc15f-85dc-2557-4b0b-be6fa8fe1ed0@linaro.org>
Date:   Tue, 1 Oct 2019 10:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b2ad55edbb1185c52dc73622ddccbdb7c1b52efd.1569552692.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2019 04:12, Baolin Wang wrote:
> Change to use devm_hwspin_lock_request_specific() to help to simplify the
> cleanup code for drivers requesting one hwlock. Thus we can remove the
> redundant sc27xx_efuse_remove() and platform_set_drvdata().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>   drivers/nvmem/sc27xx-efuse.c |   13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)


Applied thanks,

srini

> 
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> index c6ee210..ab5e7e0 100644
> --- a/drivers/nvmem/sc27xx-efuse.c
> +++ b/drivers/nvmem/sc27xx-efuse.c
> @@ -211,7 +211,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	efuse->hwlock = hwspin_lock_request_specific(ret);
> +	efuse->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
>   	if (!efuse->hwlock) {
>   		dev_err(&pdev->dev, "failed to request hwspinlock\n");
>   		return -ENXIO;
> @@ -219,7 +219,6 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>   
>   	mutex_init(&efuse->mutex);
>   	efuse->dev = &pdev->dev;
> -	platform_set_drvdata(pdev, efuse);
>   
>   	econfig.stride = 1;
>   	econfig.word_size = 1;
> @@ -232,21 +231,12 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
>   	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
>   	if (IS_ERR(nvmem)) {
>   		dev_err(&pdev->dev, "failed to register nvmem config\n");
> -		hwspin_lock_free(efuse->hwlock);
>   		return PTR_ERR(nvmem);
>   	}
>   
>   	return 0;
>   }
>   
> -static int sc27xx_efuse_remove(struct platform_device *pdev)
> -{
> -	struct sc27xx_efuse *efuse = platform_get_drvdata(pdev);
> -
> -	hwspin_lock_free(efuse->hwlock);
> -	return 0;
> -}
> -
>   static const struct of_device_id sc27xx_efuse_of_match[] = {
>   	{ .compatible = "sprd,sc2731-efuse" },
>   	{ }
> @@ -254,7 +244,6 @@ static int sc27xx_efuse_remove(struct platform_device *pdev)
>   
>   static struct platform_driver sc27xx_efuse_driver = {
>   	.probe = sc27xx_efuse_probe,
> -	.remove = sc27xx_efuse_remove,
>   	.driver = {
>   		.name = "sc27xx-efuse",
>   		.of_match_table = sc27xx_efuse_of_match,
> 
