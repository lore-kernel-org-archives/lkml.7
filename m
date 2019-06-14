Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA7BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749A32173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FYfbiYiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFNPsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:48:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14453 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:48:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03c1c30000>; Fri, 14 Jun 2019 08:48:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 08:48:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 08:48:19 -0700
Received: from [10.26.11.12] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 15:48:16 +0000
Subject: Re: [PATCH v2 2/6] clocksource/drivers/tegra: Remove duplicated use
 of per_cpu_ptr
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-3-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1aea7e18-fd5a-5ec7-4ae3-fb19826495bb@nvidia.com>
Date:   Fri, 14 Jun 2019 16:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610164400.11830-3-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560527299; bh=d0CqwZtrd3MjNIrGnFs7ZW/50hIL3KZX0LJnt3QZFBM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FYfbiYiy2n6VZ3OqRUnig6QIZ78kdfaNUInMVVyZilKpl1UKW8yC68JnrIdGKjptd
         mToHNHrtdI9PBXeEJfUdqM5rM4MsQiu7eoD2f39i58S7q9PJWHfhYJm+D14UOpnqs9
         9w1UlaYe8S5KqNxnaM2Off3ohwNQ6CK2FetEXJv/oqymHuNPZKcdfPYTAWW0LUPo05
         6XMg6LTr9AOXsfwnIPF4O0ruz+v87aPKaWEBAYXRcqDlxzbqxgKSwC+5LSIsn22poB
         Xs7WPexzN4hrScT2dmCe1i/3icXZeeQP72CCD0y4twcw2M9ChiM7x5KDkylH6zwe4j
         2s+r5Kjkl2esA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/2019 17:43, Dmitry Osipenko wrote:
> It was left unnoticed by accident, which means that the code could be
> cleaned up a tad more.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 42 ++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index 830c66e2d927..810b4e7435cf 100644
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
> +
> +	return timer_of_rate(to);
> +}
> +
>  static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  				   int rating)
>  {
> @@ -268,32 +281,27 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  
>  	for_each_possible_cpu(cpu) {
>  		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
> +		unsigned long flags = IRQF_TIMER | IRQF_NOBALANCING;
> +		unsigned long rate = tegra_rate_for_timer(to, tegra20);
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
> -		else
> -			cpu_to->of_clk.rate = timer_of_rate(to);
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

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
