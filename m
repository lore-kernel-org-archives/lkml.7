Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F74CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D48D2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbjMmZWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfB1PkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:40:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33271 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfB1PkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:40:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so22531021wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IqqUWAg6Q51oqcIUPC3G+Pzsb8x3yMERw9dQ6GNhKL8=;
        b=pbjMmZWr6KQSk0Z8xdfPNu2km/jv79utdn1uKyNqc/Ajy9SHXFFlyl4wJ2+ClLlF/N
         qcqVwvwce0d82fDu17cJYoZQV9F9Q3NkK5lInODueRKfnh0l4WOQsEqBgYkV2miAkVuX
         tfYljIE3Wt/RzpeJcQJPhm4XN8YiQL1vvezzcTNpcj9xvOa5w7ssrhjp+/qnCl5BSOsw
         f/XA0hw6zJqpPJwLgtYrilDAP8feFzNjWfYSnxPBLtHKrquECaeRzHzKlx9tgRKxk1MM
         PrIpM62o4azdWee6uU9fW6UBzZC2Bi1jMbBugcykWHlk3P5ou1CZW3VWKsCWFyQoyIss
         xK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IqqUWAg6Q51oqcIUPC3G+Pzsb8x3yMERw9dQ6GNhKL8=;
        b=kpXNoSSUdK26riNDLzgswjqJDtsT7WLzASGkeSLi3nD43cCxlsSjt21B1KBrkVkSCO
         abdoS/EDPql0/5FLHSc07wb7tBumYVt6zItNaWAkPCdkn/OUsT7arhL4ozqnwznIVdVP
         yfo0LKIdNBtbsK7PEIApjAdZgq3ZgZTtwx26LPSXLQNWqm5tXQex7sK1SMj9/sJdOJYG
         Fyq8h9Aqd0Ae2+RZct3PhT1nJCj49QYUy2B5DI6OH+Je520HR4/Mhyj91AgeTSULTHLV
         yv1rpkxPbwkSQDqDPtjIkEZ/w/umr01YN7KA8ek5Wkxf1npsyJ/2ds12bQ3q73BijqNr
         ijCg==
X-Gm-Message-State: APjAAAXL328K5QrPsw6idHBu2mLJ7RYh8LQSKZc9++MO4qMMXj9edWxS
        gyaUPY94OPfevBvgcE6zJBF5khU0tIo=
X-Google-Smtp-Source: APXvYqzU87enZBPHOoFK9IRlwo0XC38mZ5PK7VPcmkvNI1IVMN9jT7bmGqs/3+jdjK7hvknhD1bmcg==
X-Received: by 2002:adf:9cc3:: with SMTP id h3mr6568558wre.47.1551368407020;
        Thu, 28 Feb 2019 07:40:07 -0800 (PST)
Received: from [192.168.0.41] (244.150.136.77.rev.sfr.net. [77.136.150.244])
        by smtp.googlemail.com with ESMTPSA id z15sm4766390wmi.46.2019.02.28.07.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:40:06 -0800 (PST)
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a66689f2-51ba-6358-f161-66778daa1f09@linaro.org>
Date:   Thu, 28 Feb 2019 16:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228135919.3747-6-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> Instead of iterating through all the state nodes in DT, to find out how
> many states that needs to be allocated, let's use the number already known
> by the cpuidle driver. In this way we can drop the iteration altogether.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index d50b46a0528f..cbfc936d251c 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  			struct device_node *cpu_node, int cpu)
>  {
> -	int i, ret = 0, count = 0;
> +	int i, ret = 0, num_state_nodes = drv->state_count - 1;

why -1 ?

>  	u32 *psci_states;
>  	struct device_node *state_node;
>  
> -	/* Count idle states */
> -	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -					      count))) {
> -		count++;
> -		of_node_put(state_node);
> -	}
> -
> -	if (!count)
> -		return -ENODEV;
> -
> -	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> +	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
> +			GFP_KERNEL);
>  	if (!psci_states)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < num_state_nodes; i++) {
>  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		if (!state_node)
> +			break;
> +
>  		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
>  		of_node_put(state_node);
>  
> @@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
>  	}
>  
> +	if (i != num_state_nodes) {
> +		ret = -ENODEV;
> +		goto free_mem;
> +	}
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

