Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB64C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306022086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KYeUjfQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437104AbfFLIaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:30:08 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12217 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405127AbfFLIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:30:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00b80f0001>; Wed, 12 Jun 2019 01:30:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 01:30:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Jun 2019 01:30:07 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 08:30:04 +0000
Subject: Re: [PATCH v2 1/6] clocksource/drivers/tegra: Restore timer rate on
 Tegra210
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-2-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <17eac2c4-41fa-a616-83e9-fa18a9e1483d@nvidia.com>
Date:   Wed, 12 Jun 2019 09:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610164400.11830-2-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560328208; bh=qOuZdVqQoD7M68KhzitblLcmWzDZCGt4MzV/a//dz1M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KYeUjfQk3U8nyEos2/HHdJUpBo4c26qZS7WO6W3tSj6mtlrJU1sidpCaL5EiVWSWA
         hWIOLtWVXVNbIl8+QDNpnhUiXplDLgW9UB0477iJMsFC9K2Ay6Y3pqbkcmTVc0RDM7
         8jDcq2U5whcxx9RIZ9I72s4r+cm4/CLp989Z9GQhmBTLHhZDgv3Ny9jfa5ss4aTK6b
         rI1jbj1wlWDknVf5kf7LAViJ3iBmyhzbsTE8X553XK7uJeoLPz8z2ELxKtp8VX3jh9
         P0ux6q0kp3Y9TT5FAlsT0K1nR6e5Vtz5q2oyHVQAO7TluJVGHALMgXoENhrNmHvX36
         JsWmUk6AO30Kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/2019 17:43, Dmitry Osipenko wrote:
> The clocksource rate is initialized only for the first per-CPU clocksource
> and then that rate shall be replicated for the rest of clocksource's
> because they are initialized manually in the code.
> 
> Fixes: 3be2a85a0b61 ("Support per-CPU timers on all Tegra's")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index 9406855781ff..830c66e2d927 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -277,6 +277,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  		 */
>  		if (tegra20)
>  			cpu_to->of_clk.rate = 1000000;
> +		else
> +			cpu_to->of_clk.rate = timer_of_rate(to);
>  
>  		cpu_to = per_cpu_ptr(&tegra_to, cpu);
>  		cpu_to->of_base.base = timer_reg_base + base;

Thanks. This fixes a boot regression we are seeing on -next with
Tegra210 (introduced by the commit referenced above). So ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
