Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46852085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="La1MNho7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfFRRwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:52:39 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8237 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfFRRwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:52:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0924e50000>; Tue, 18 Jun 2019 10:52:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 10:52:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 10:52:37 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 17:52:36 +0000
Subject: Re: [PATCH v3 8/8] clocksource/drivers/tegra: Set up maximum-ticks
 limit properly
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Peter De Schrijver" <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-9-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d7886053-ea59-b431-32ef-ff274c36adb5@nvidia.com>
Date:   Tue, 18 Jun 2019 18:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618140358.13148-9-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880357; bh=ApieX7VXDwCOrZQ81Jbq9eZuL60Vh2ruYmDXsMnL8Ow=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=La1MNho78M+DAYF1CayGQe/pOXM6zLTzsxz5k6HYOt+MwUY6PpzbOFJpdCW/bBDNA
         fCSJVuVTBSILd4XSuOpydWJK+SbVm8YLfT1ijWoo7YJ3t4SgajQzfoVufLQ/Xrzxex
         xmPlieBfF+VltCnHmuBqK8B92MLsxng5sarU6dxXl8hoaT4TP6h8WsUy8XcxrMbv6R
         WWGxgaQOst6c6gbZeyBnKo8pwugPAGTI9x8pvP0mkBn2yOfcwJjLCyrUu1q1RVZ3It
         6d5FvA+TzIoO5U7I0+8X0y5fiE0RudOhhA5ws19/2z+4f9/Tb8sCrJjPGRz+W97T5J
         oqCgiCKJIGsJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/2019 15:03, Dmitry Osipenko wrote:
> Tegra's timer has 29 bits for the counter and for the "load" register
> which sets counter to a load-value. The counter's value is lower than
> the actual value by 1 because it starts to decrement after one tick,
> hence the maximum number of ticks that hardware can handle equals to
> 29 bits + 1.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index b84324288749..355b29ff6362 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -137,9 +137,17 @@ static int tegra_timer_setup(unsigned int cpu)
>  	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
>  	enable_irq(to->clkevt.irq);
>  
> +	/*
> +	 * Tegra's timer uses n+1 scheme for the counter, i.e. timer will
> +	 * fire after one tick if 0 is loaded and thus minimum number of
> +	 * ticks is 1. In result both of the clocksource's tick limits are
> +	 * higher than a minimum and maximum that hardware register can
> +	 * take by 1, this is then taken into account by set_next_event
> +	 * callback.
> +	 */
>  	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
>  					1, /* min */
> -					0x1fffffff); /* 29 bits */
> +					0x1fffffff + 1); /* max 29 bits + 1 */
>  
>  	return 0;
>  }
> 


Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
