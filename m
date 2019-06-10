Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FF5C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C942082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mP86zpa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfFJILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:11:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38612 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbfFJILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:11:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so8156222wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xqTjft69CxSIHkVtNgFVRZKuKKxogiXAplAKbQKO8k4=;
        b=mP86zpa7qBBQ+cO1517Cu9yNQ2uOrdhcTqZWIt6+6u3n/x03korwlS86QR1Erzx8jR
         1W1Lo66/jMAQLwrmvGs437nVLodzk4p+SuTpZth8NZUMMsDog9wlidFwLGzpvGgWOJXM
         3kXbrpyJSXNCm1E621+6GrvowxGYnl3o10DfrAHZG6atjX0Gh/Chcveigvl5kUgfTWEO
         iDxmymXF69rkobJghYyCPt6vvuIaSJRCr8H9Nb3DVCcebn3nWGsCBEgdZ7V4+UVSmEqz
         nCbdEQ3rslwFVaDVh9giBdMl+BtGl3O4bVMdnKwLuty4UvGMh9cb4kIt6ZRL+jbuhOP7
         sfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xqTjft69CxSIHkVtNgFVRZKuKKxogiXAplAKbQKO8k4=;
        b=la2O7NYP26mXtCtrccExC+xOdjEToHD4i0Gel6KoPddw9RtnXob/GxG47fs4hW2e++
         CDAywKnHeVk7Vr8Ihll3wRpNcmTRpwDYHTA7cvdvYpxOcNss37SDiLzYt6tSUUaYTGSi
         VGbgFmzH2hbmbDgR1vEZ2aLdanobqanma1E/K6MfirGs4QRwRYj0Po/6+hZcBOShwai1
         qsDg8hUwBb4wz9l6AJEPA5RLsEMb3ZRx29Ol3mgpD2tLsERBbVE9QFF2sJnK36QjZGCB
         dlUMydeDouwhRqZ1NQMhlr1e9gjJsTD32L6GwcHU8+yo4eqXqt/mxJ41C3QCk9DeESdb
         SNnQ==
X-Gm-Message-State: APjAAAWoAuTEyYbMgQx8B2MaqARPcd59NhU/261Vi8TUh/y1SlqixYOm
        2lNX5BFIpA0IndrKpI1mIPcQ+O+lQlY=
X-Google-Smtp-Source: APXvYqxQvfC5Ih+9ei+kGD1ilEYKD7wqPOf21PLaTwKmxPmk6UdfeZfYExrHtCK27tIZhK1yRtrg8w==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr18548373wrr.167.1560154276575;
        Mon, 10 Jun 2019 01:11:16 -0700 (PDT)
Received: from [192.168.0.41] (229.84.95.92.rev.sfr.net. [92.95.84.229])
        by smtp.googlemail.com with ESMTPSA id l19sm7540453wmj.33.2019.06.10.01.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:11:15 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] clocksource/drivers/tegra: Remove duplicated use
 of per_cpu_ptr
To:     Dmitry Osipenko <digetx@gmail.com>, Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190609192730.29459-1-digetx@gmail.com>
 <20190609192730.29459-2-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4e1f1389-afde-3994-2ccc-4e57e9ad78d1@linaro.org>
Date:   Mon, 10 Jun 2019 10:11:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609192730.29459-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dmitry,


On 09/06/2019 21:27, Dmitry Osipenko wrote:
> It was left unnoticed by accident, which means that the code could be
> cleaned up a tad more.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 40 +++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index 9406855781ff..6da169de47f9 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -216,6 +216,19 @@ static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20)
>  	return TIMER10_IRQ_IDX + cpu;
>  }
>  
> +static inline unsigned long tegra_rate_for_timer(struct timer_of *to,
> +						 bool tegra20)
> +{
> +	/*
> +	 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
> +	 * parent clock.
> +	 */
> +	if (tegra20)
> +		return 1000000;

Mind to take the opportunity to convert the literal value to a constant?

> +
> +	return to->of_clk.rate;
> +}
> +
>  static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  				   int rating)
>  {
> @@ -268,30 +281,27 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  
>  	for_each_possible_cpu(cpu) {
>  		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
> +		unsigned long flags = IRQF_TIMER | IRQF_NOBALANCING;
> +		unsigned long rate = tegra_rate_for_timer(&tegra_to, tegra20);
>  		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
>  		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
> +		unsigned int irq = irq_of_parse_and_map(np, idx);
>  
> -		/*
> -		 * TIMER1-9 are fixed to 1MHz, TIMER10-13 are running off the
> -		 * parent clock.
> -		 */
> -		if (tegra20)
> -			cpu_to->of_clk.rate = 1000000;
> -
> -		cpu_to = per_cpu_ptr(&tegra_to, cpu);
> -		cpu_to->of_base.base = timer_reg_base + base;
> -		cpu_to->clkevt.rating = rating;
> -		cpu_to->clkevt.cpumask = cpumask_of(cpu);
> -		cpu_to->clkevt.irq = irq_of_parse_and_map(np, idx);
> -		if (!cpu_to->clkevt.irq) {
> +		if (!irq) {
>  			pr_err("failed to map irq for cpu%d\n", cpu);
>  			ret = -EINVAL;
>  			goto out_irq;
>  		}
>  
> +		cpu_to->clkevt.irq = irq;
> +		cpu_to->clkevt.rating = rating;
> +		cpu_to->clkevt.cpumask = cpumask_of(cpu);
> +		cpu_to->of_base.base = timer_reg_base + base;
> +		cpu_to->of_clk.rate = rate;
> +
>  		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
> -		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
> -				  IRQF_TIMER | IRQF_NOBALANCING,
> +
> +		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr, flags,
>  				  cpu_to->clkevt.name, &cpu_to->clkevt);
>  		if (ret) {
>  			pr_err("failed to set up irq for cpu%d: %d\n",
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

