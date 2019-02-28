Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169D72133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uxf6n/uY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfB1Om7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:42:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52752 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbfB1Om6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:42:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so9528333wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HEKavsr7Wivp3v6OO/OCHNUie7WSq3IqNLQ25tj7Z7g=;
        b=Uxf6n/uYkVdlTWsS9ydzYR1d3zD+Q25w9qSnP7tJtbhT3NXh5o+OoCczcE39yaTEO9
         q47kMRWP2iw0urXokWdFXLsyOG1WhmDsQRybIOc/XVIOAktFJ6XoO0Mo64Vnbjtw4FS5
         aOoMy2/3oon2UwXUEUoepyc2pnywYlFi8F/GIKhRmgACNFUE4NhPUOQ5Pk7jw0MZoB9/
         7YU5fJVekdKHF+ZW2VCU9mUlxHLoDfdWz07ML5kX1E6nieFsLfQT2Uzp5N0q6aeQGwok
         BPzL/zQRHzFvFNNT8O6OYCbNmuR0+L+JsyI0lediF8h2I+K8OhJKhn+bNLfI5g6PMR5M
         YMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HEKavsr7Wivp3v6OO/OCHNUie7WSq3IqNLQ25tj7Z7g=;
        b=AhQr3ZnMFOFmZ2ZgAr2VoPl049VlOLLir2XuJRvfQiD9716Ij++CHwpqPz3HJ3JjkM
         7EZr425tLxDAfnbaTPiJ9Poky1WFwlaXqhH3bfHH97l7EZzbnCISpRPfzYbIq0LeQqA5
         nNgeuTQf5bsHYlsGremMHPM6Jto/1gpTCa+9K6xMSMw2m9HlpRRQeFJsncBxgVL1lOCP
         /CDG1lAGffXyr1did71xCKfhX+/9bNGpyZ9XA0TJP8v8k4r63O5ia5+eYmbrvMJvgJ73
         ENBy7M/iRi9/1Z2WJ8kbjyY3cGbX1XfP7fiKmMuRdILX/5eiu3ctPrrdoWI9eRg3nkR/
         9L+Q==
X-Gm-Message-State: AHQUAuZBaXz4SwwyUqxlswC9h+28zXvLXM6TwdkZJQWfzVBprcqNUSD9
        X9KWnmOfQaS8DP0rnJhzJTveu7yM1xw=
X-Google-Smtp-Source: APXvYqys7tuozFVrXcNNqbe1Q8uhy8U9QSMzMXm4VDWBgXNK1kLI7BrHQuQWPM/msTfxOcs8FwI7Mw==
X-Received: by 2002:a1c:4155:: with SMTP id o82mr33038wma.122.1551364975703;
        Thu, 28 Feb 2019 06:42:55 -0800 (PST)
Received: from [192.168.0.41] (244.150.136.77.rev.sfr.net. [77.136.150.244])
        by smtp.googlemail.com with ESMTPSA id v6sm9179108wme.24.2019.02.28.06.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:42:54 -0800 (PST)
Subject: Re: [PATCH 3/7] drivers: firmware: psci: Split
 psci_dt_cpu_init_idle()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-4-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <02a96f2c-dde1-73be-683d-b51d8c6b1b03@linaro.org>
Date:   Thu, 28 Feb 2019 15:42:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228135919.3747-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> Let's split the psci_dt_cpu_init_idle() function into two functions. This
> makes the code clearer and provides better re-usability.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

but one question below.


> ---
>  drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index c80ec1d03274..9788bfc1cf8b 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
>  #ifdef CONFIG_CPU_IDLE
>  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
>  
> +static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> +{
> +	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> +
> +	if (err) {
> +		pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
> +		return err;
> +	}
> +
> +	if (!psci_power_state_is_valid(*state)) {
> +		pr_warn("Invalid PSCI power state %#x\n", *state);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  {
> -	int i, ret, count = 0;
> +	int i, ret = 0, count = 0;

Why do you need to intialize the ret variable? If the count is zero we
go directly to return 0, otherwise we enter in the loop and ret is
affected with the new function call.

>  	u32 *psci_states;
>  	struct device_node *state_node;
>  
> @@ -291,29 +308,16 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < count; i++) {
> -		u32 state;
> -
>  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
> +		of_node_put(state_node);
>  
> -		ret = of_property_read_u32(state_node,
> -					   "arm,psci-suspend-param",
> -					   &state);
> -		if (ret) {
> -			pr_warn(" * %pOF missing arm,psci-suspend-param property\n",
> -				state_node);
> -			of_node_put(state_node);
> +		if (ret)
>  			goto free_mem;
> -		}
>  
> -		of_node_put(state_node);
> -		pr_debug("psci-power-state %#x index %d\n", state, i);
> -		if (!psci_power_state_is_valid(state)) {
> -			pr_warn("Invalid PSCI power state %#x\n", state);
> -			ret = -EINVAL;
> -			goto free_mem;
> -		}
> -		psci_states[i] = state;
> +		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
>  	}
> +
>  	/* Idle states parsed correctly, initialize per-cpu pointer */
>  	per_cpu(psci_power_state, cpu) = psci_states;
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

