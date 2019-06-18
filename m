Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEAC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4692054F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BVMiVSqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfFRQcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:32:15 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1421 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:32:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09120d0000>; Tue, 18 Jun 2019 09:32:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 09:32:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 09:32:14 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 16:32:12 +0000
Subject: Re: [PATCH v3 3/8] clocksource/drivers/tegra: Set and use timer's
 period
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Peter De Schrijver" <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-4-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <16c20c1b-d106-cb1e-6d67-bdd402ecf57f@nvidia.com>
Date:   Tue, 18 Jun 2019 17:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618140358.13148-4-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560875533; bh=MnFHiZd1UoFfIdJPVOXa0vz62Mm7qjOcpYLqilqAA8Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BVMiVSqUkNPUItmwR0+lO1I4FyeD1HBzAJMkyQc3qq9/Eeip26fkqSfnY8gpFVnyr
         eksOd3CKZf9MTo/YAEV9nqV0yA8o3czzAemf4BS7CQdGuHfljG0wfnd/v1vKZQ7dgU
         XlxgltkBxgp1didTRHWrPj+cVxw0UppWw1YXY0nQ5GayJdR2ZFtJflbnSGfRcz0Oob
         9CBELE2OLYFPIN95nzT/60PefAKGWlO16nnxYNnmyHom0tfJDFxIwU9wiCzTNxzFkp
         JgUXUcFw4aYSZwJl/dZAgd/ZzyRdMSzwoYZ1Oeof7v0qpjrgN5tYqJ/g5jXutjtZwb
         VPyhzxrUgb0Qw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/2019 15:03, Dmitry Osipenko wrote:
> The of_clk structure has a period field that is set up initially by
> timer_of_clk_init(), that period value need to be adjusted for a case of
> TIMER1-9 that are running at a fixed rate that doesn't match the clock's
> rate. Note that the period value is currently used only by some of the
> clocksource drivers internally and hence this is just a minor cleanup
> change that doesn't fix anything.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index ff5a4ccb5d52..e6221e070499 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
>  static int tegra_timer_set_periodic(struct clock_event_device *evt)
>  {
>  	void __iomem *reg_base = timer_of_base(to_timer_of(evt)); 
> +	unsigned long period = timer_of_period(to_timer_of(evt));
>  
> -	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
> -		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
> +	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
>  		       reg_base + TIMER_PTV);
>  
>  	return 0;
> @@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  		cpu_to->clkevt.rating = rating;
>  		cpu_to->clkevt.cpumask = cpumask_of(cpu);
>  		cpu_to->of_base.base = timer_reg_base + base;
> +		cpu_to->of_clk.period = rate / HZ;
>  		cpu_to->of_clk.rate = rate;
>  
>  		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
