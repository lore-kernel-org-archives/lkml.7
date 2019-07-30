Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F6C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCB3206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQnc3HvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfG3Clv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:41:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46196 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfG3Clv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:41:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so5867088pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1tuCSroln1sKVEDl7Uz0luKkd7K+d2sop8UYdCF/zYY=;
        b=IQnc3HvKS1AsZ44Uc7vJY8Yoc6tijURNF659ep/dp58zJ8fE/AmA9TswmEyJ0oXqxR
         NoLJlABA1c1Ao64rG+GGvglsYT52yqNozLXyo1/5mqKhQB3hjSmVUmwQLUoRAOooL54v
         a9DEvLlYAgcpe1xEmEJXDtSEXn97bEBJ46+55MUDD+f6rV5xt8cOc8GlcQBrqsm9G9zN
         08IP2LGq67MhwZmQrugWYPNFhsOZnNI9tqDlW7DlgZrl9hX/c5zI/mkzm4waRHb/ChoW
         SWWV8bknVIVIzrqfufaS3A0sMn1yTgfSovqumUhphpLvVYGnooP7MR6WFC2VXhr4JdyZ
         s2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1tuCSroln1sKVEDl7Uz0luKkd7K+d2sop8UYdCF/zYY=;
        b=kz+4Xx/ujl6u3c0SZqwT2E31sRre6QMGarjrv3uCKoro8q8wc7BhcrFigmBN9epMMn
         tXDqSQxKSHw2mjsoptJwhkuNbqKxJ113lFgunKyEy9HvwCibOP9a2teU3a5eh3z6vhMp
         BcQAlBjTaO+6FMOklmN5AYA4vMcRntjmVM+upmZsLXH5nqERN8T7CSAEwrT/Vu60cfzh
         EWpJdJ3LjrttYtGS4N7d2C9yqvSokFIJ8lNS+7VNw045/UHtVLUA+QOPiOrjENJI8qR7
         4hpAtR8aBIF5oBx3qZvTEDMkigLTtV9s+j4/ZhTgtFUFr5JQDLVvfNOAYxdJSqVza7ys
         wttA==
X-Gm-Message-State: APjAAAWxV89Bk0qZc8owo3rw7yqZVleTlAKWG5I38+zrY3Yp5x06DyDx
        jQnOId9tmuRAdi85IP5Xc9p89w==
X-Google-Smtp-Source: APXvYqx0Fa+EaxN9mX1U8i4V7Dv4in3falhkaYUARqtPdbrvGfhz0ywhR8B2CjcMPHxNgT9FgEAmaw==
X-Received: by 2002:aa7:8b10:: with SMTP id f16mr40191079pfd.44.1564454510323;
        Mon, 29 Jul 2019 19:41:50 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i198sm61607713pgd.44.2019.07.29.19.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 19:41:49 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:11:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Mark expected switch fall-through
Message-ID: <20190730024146.46cqoyzxg6mjjc7k@vireshk-i7>
References: <20190729224933.GA23686@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729224933.GA23686@embeddedor>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-19, 17:49, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: arm):
> 
> drivers/cpufreq/ti-cpufreq.c: In function ‘dra7_efuse_xlate’:
> drivers/cpufreq/ti-cpufreq.c:79:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
> drivers/cpufreq/ti-cpufreq.c:80:2: note: here
>   case DRA7_EFUSE_HAS_OD_MPU_OPP:
>   ^~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 2ad1ae17932d..aeaa883a8c9d 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -77,6 +77,7 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
>  	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
>  	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
>  		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
> +		/* Fall through */
>  	case DRA7_EFUSE_HAS_OD_MPU_OPP:
>  		calculated_efuse |= DRA7_EFUSE_OD_MPU_OPP;
>  	}

Applied. Thanks.

-- 
viresh
