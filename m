Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE64DC4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0775208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAZlux2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbfIVWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:34:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45429 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbfIVWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:34:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id r134so8603466lff.12;
        Sun, 22 Sep 2019 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4f2RiUEyYcYFcBgFz1k/UjSfnNL+xowf1XmECwoKC/g=;
        b=jAZlux2Hoov1RqCJlqmmKxwXdFHaETUdjVWCvrTUJKfUh7+paUI6OOEL1lgtjm+JIL
         PUo6LZEbQzjG00Tai8rqwzLIfnYE60LtT6hICVHY6Qdbn5JpZGpxmtKUvrT2oveXCa3n
         rdGFNoK0VKKXUq9RB2uFCQOXCRfFYx1pglz0YCbZHErkS+MgcOkSMhHmfrdh5u5BRDkh
         ujMcz7en92dWnFc2NTnAQpwAGEQOskUY9zr0qRMPoL9av0Wkp2pL+dNpgGtiE0OCIMWj
         X8Q1NMgBYK3j5wPkeGcZ8KiJNsEtOjkOKqSCTuliZekdA98/r0T7SWueV0BdabtYQVaS
         O1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4f2RiUEyYcYFcBgFz1k/UjSfnNL+xowf1XmECwoKC/g=;
        b=B7qU0rRsgPZYRztzxdN+71UKRUpQicEZZduHp/T8b+FG223Rbc4fdJskQ6kPbG8MUF
         HMFTjxX6fgVZuVhKVF69qcb/qxxW3vaZjcNrkWrMF8x2ihx7BCBRmuhKPOBmA/Lrw2Ex
         FKThCLNG1c9o/ob7TEaMxNoZo+vgZxEpPMgXiMNyLXQc2rChWmPkxKgxWHvciu//6hj/
         zSq2U1a8XXFTCO6rEvvd9z6GY/7ZJSshcEezpr/Xmh8Vin3072b/4mBem6frD3rS1Rsf
         rx4PSPUKdxhIbPZu4f6vtdxngf/uImIty2GuwUXxRlMoRXPotk20hgShibyWf1w+H6w9
         wukg==
X-Gm-Message-State: APjAAAUS1CM/A5FwhoAk3wC4Mu1cUprLECfwvAXEB0CUNdVmZsqOUtwC
        W4Ku2v2LAcdnM6UYzYxbKZUWhNfz
X-Google-Smtp-Source: APXvYqxlv/fN1SmtNQdjOMr9+/0vIXBnud7NxJw3/5p3jHE3sHP0gedjudM2e9Kj2tEoRt3WJyuCtw==
X-Received: by 2002:a19:6455:: with SMTP id b21mr15210702lfj.167.1569188842740;
        Sun, 22 Sep 2019 14:47:22 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id e7sm1798725lfn.12.2019.09.22.14.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 14:47:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] clk: tegra: divider: Add missing check for
 enable-bit on rate's recalculation
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190723025245.27754-1-digetx@gmail.com>
Message-ID: <4f2695ce-f683-2e4b-34b9-8937feee5e1b@gmail.com>
Date:   Mon, 23 Sep 2019 00:47:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723025245.27754-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.07.2019 5:52, Dmitry Osipenko пишет:
> Unset "enable" bit means that divider is in bypass mode, hence it doesn't
> have any effect in that case. Please note that there are no known bugs
> caused by the missing check.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: Changed the commit's description from 'Fix' to 'Add' in response to the
>     Stephen's Boyd question about the need to backport the patch into stable
>     kernels. The backporting is not really needed.
> 
>  drivers/clk/tegra/clk-divider.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> index e76731fb7d69..f33c19045386 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -40,8 +40,13 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
>  	int div, mul;
>  	u64 rate = parent_rate;
>  
> -	reg = readl_relaxed(divider->reg) >> divider->shift;
> -	div = reg & div_mask(divider);
> +	reg = readl_relaxed(divider->reg);
> +
> +	if ((divider->flags & TEGRA_DIVIDER_UART) &&
> +	    !(reg & PERIPH_CLK_UART_DIV_ENB))
> +		return rate;
> +
> +	div = (reg >> divider->shift) & div_mask(divider);
>  
>  	mul = get_mul(divider);
>  	div += mul;
> 

Hello Peter,

ACK?
