Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD02C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E63214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JV9Xb4IM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfFKKyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:54:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43828 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbfFKKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:54:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so6754788pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IvQb/Ypyh9gRJDotT8x3V0sz3ecSdE5KFnzXB7OO8I8=;
        b=JV9Xb4IMUkhC6FXUs6jMr31zgd5bbZUP53i9LQXtxqqKDsyOstCFNthzz9ysHVltrG
         LQPzsJTYpuYoEjJUqF27NWTUxY00GzCfMVw2AwdBa/l+uVsVwIIfUvY/Na/9hqRyC4hm
         qA8IVyqs6a3XSSW7Mbzi0CcMh3MoLKRWZYJ/M6fAEOrHH3ZNmuDxJz+TI/1yAMW9n4tL
         g/utQBXLMp0f+tyzFpzt4ZdUlGRG6eDxQZo5tUvxsgYparDAbG+sfgL5NAnQWDFtiptC
         +hcShtjhUExJXJrKOnj0jx3m/sCaDSZxE7ayO+ffbwGhcKmSTG2S7S3CsidSQ3kx0fQA
         CJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IvQb/Ypyh9gRJDotT8x3V0sz3ecSdE5KFnzXB7OO8I8=;
        b=U4xAQ2XQkqIQK+Xh7odIircqDaCwP+DnEFfLLfbZr1P4n3cm4AwXdy6hFqyg2qxGM8
         ocqFCGvz5lPYqshlpRTq8DV70ZsCc80yVTOhecAN1/Vhb1qtTNaLfFNmNxoRUVMULVSQ
         NRA9HnOD1Ttw91ML5RUGRgInLh5dB4KYpjf7er8cLu987pX/J/NRDjOV8qj4i2kWcRL0
         F5RTtkZODJKzfm51984/5HmSkZuiYVtlyuVUmsKNyfYDy3MpGmrr+F/PaF2fYcmQz2ta
         MBkMkdpEqNqNVNh7RID/S40j/JyPF/KtGT/4wIdpLjMHyoNiGICfuTROvINh6jxWI9eZ
         u/rA==
X-Gm-Message-State: APjAAAVpswUztD4xunCK3t7UyTI3sIOUaGztElBZmqvu6ajOckvJ/DYM
        ybjZIOp9NV9wPZE7SZoai6ySDg==
X-Google-Smtp-Source: APXvYqzpXvOcmG+jSmbuKUuB+pvnFdrAODCioPv9t90lRkGIWZkV0igtmbVR7Z0PzCmHelNYhJaqfA==
X-Received: by 2002:a62:bd11:: with SMTP id a17mr5606101pff.126.1560250476041;
        Tue, 11 Jun 2019 03:54:36 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id j72sm2231266pje.12.2019.06.11.03.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:54:34 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:24:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Message-ID: <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320094918.20234-2-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-19, 15:19, Rajendra Nayak wrote:
> From: Stephen Boyd <swboyd@chromium.org>
> 
> Doing this allows us to call this API with any rate requested and have
> it not need to match in the OPP table. Instead, we'll round the rate up
> to the nearest OPP that we see so that we can get the voltage or level
> that's required for that OPP. This supports users of OPP that want to
> specify the 'fmax' tables of a device instead of every single frequency
> that they need. And for devices that required the exact frequency, we
> can rely on the clk framework to round the rate to the nearest supported
> frequency instead of the OPP framework to do so.
> 
> Note that this may affect drivers that don't want the clk framework to
> do rounding, but instead want the OPP table to do the rounding for them.
> Do we have that case? Should we add some flag to the OPP table to
> indicate this and then not have that flag set when there isn't an OPP
> table for the device and also introduce a property like 'opp-use-clk' to
> tell the table that it should use the clk APIs to round rates instead of
> OPP?
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0420f7e8ad5b..bc9a7762dd4c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -703,7 +703,7 @@ static int _set_required_opps(struct device *dev,
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>  	struct opp_table *opp_table;
> -	unsigned long freq, old_freq;
> +	unsigned long freq, opp_freq, old_freq, old_opp_freq;
>  	struct dev_pm_opp *old_opp, *opp;
>  	struct clk *clk;
>  	int ret;
> @@ -742,13 +742,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		goto put_opp_table;
>  	}
>  
> -	old_opp = _find_freq_ceil(opp_table, &old_freq);
> +	old_opp_freq = old_freq;
> +	old_opp = _find_freq_ceil(opp_table, &old_opp_freq);
>  	if (IS_ERR(old_opp)) {
>  		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
>  			__func__, old_freq, PTR_ERR(old_opp));
>  	}
>  
> -	opp = _find_freq_ceil(opp_table, &freq);
> +	opp_freq = freq;
> +	opp = _find_freq_ceil(opp_table, &opp_freq);
>  	if (IS_ERR(opp)) {
>  		ret = PTR_ERR(opp);
>  		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",

I see a logical problem with this patch.

Suppose the clock driver supports following frequencies: 500M, 800M,
1G, 1.2G and the OPP table contains following list: 500M, 1G, 1.2G
(i.e. missing 800M).

Now 800M should never get programmed as it isn't part of the OPP
table. But if you pass 600M to opp-set-rate, then it will end up
selecting 800M as clock driver will round up to the closest value.

Even if no one is doing this right now, it is a sensible usecase,
specially during testing of patches and I don't think we should avoid
it.

What exactly is the use case for which we need this patch ? What kind
of driver ? Some detail can be helpful to find another solution that
fixes this problem.

-- 
viresh
