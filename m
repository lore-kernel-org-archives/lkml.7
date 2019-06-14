Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5995AC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279372173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iKQ+6/wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfFNPsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:48:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15144 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfFNPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:48:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03c1d50000>; Fri, 14 Jun 2019 08:48:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 08:48:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 08:48:36 -0700
Received: from [10.26.11.12] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 15:48:34 +0000
Subject: Re: [PATCH v2 3/6] clocksource/drivers/tegra: Set and use timer's
 period
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-4-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ac8a1da8-9b82-3d5a-5fa6-0c1cc7f627f1@nvidia.com>
Date:   Fri, 14 Jun 2019 16:48:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610164400.11830-4-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560527317; bh=Bn+OrDlK10lU41cmYkBNsaNzGmMuXosDnVEjTHJjPfU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iKQ+6/wWGTTALde12y8oK8QDMtKjBSkKLEIYjwL3uhj9tFrszQLwWOLxlUmoS1tXD
         hEwsS2DIIsKrss5XI3OIg5IwYsStm3eJBvj075cxAhl1RcNfbCQw/HlcZM/FfKCMzC
         wDwozJGdRuCa90HolHEpBAY3krQQOk9cvhWa7WZewGsDUd+QFqRV+VAXSzt5k93wCt
         yAWfSjdnYrgFP1RolQeOfwCFNPocs1gMSkDM5E2Osaj+425eFqoM8Jk2XcRG91wjJw
         v2dWVfRUGW1ek88Um8wWHczOXxiWKfVWklgNRZfCTFpraNKB+nYtuFLuAPicyxlBlm
         bNnhdXU5fdNrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/2019 17:43, Dmitry Osipenko wrote:
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
> index 810b4e7435cf..646b3530c2d2 100644
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
> +		cpu_to->of_clk.period = DIV_ROUND_UP(rate, HZ);

Any reason you made this a round-up?

Jon

-- 
nvpublic
