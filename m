Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C2C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB94205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J0EkuFyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfFRRvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:51:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7683 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFRRvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:51:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09249b0000>; Tue, 18 Jun 2019 10:51:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 10:51:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 10:51:23 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 17:51:21 +0000
Subject: Re: [PATCH v3 6/8] clocksource/drivers/tegra: Restore base address
 before cleanup
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Peter De Schrijver" <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-7-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6d167fee-7cf6-ba16-1f86-e90a72f0f18c@nvidia.com>
Date:   Tue, 18 Jun 2019 18:51:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618140358.13148-7-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880283; bh=l0t5Bc70KR4JXspIq7jhMCEWOGwN8mHBZC9PVJNdibE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=J0EkuFyQ17oo0kiAioWr0Kx3O7E1BZNuLZVAbBMTbY+6DLvIT7/aVHRG7sZNDKkFV
         fr0tZNxkbkxWbFo7VQC8/iGnLsiS5sdcuwPOyt9BECn8PPQhWXqVvmGCWSclX9OwAa
         D7llY0KR2oa/xvzEw5z95/1N0gzG27X9hXn3KGJVximRVNpXkAPnN+BEIwaQ9PeRiC
         I3z/3LjeYS5/85KXbuTKBSLn/IpS9LalIlgiohx5DxiQZh2khIWlR+Xo/fx0pOeSH6
         EbVzosYShGe827ChS6FYXu5RTQtsU07Ux9GkZ/O79xgSeBuLycQ0/9hYZOeTYxXtS7
         nk2Cou6aWbJ0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/2019 15:03, Dmitry Osipenko wrote:
> We're adjusting the timer's base for each per-CPU timer to point to the
> actual start of the timer since device-tree defines a compound registers
> range that includes all of the timers. In this case the original base
> need to be restore before calling iounmap to unmap the proper address.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index ddf5531c48a9..2673b6e0caa8 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -345,6 +345,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>  			irq_dispose_mapping(cpu_to->clkevt.irq);
>  		}
>  	}
> +
> +	to->of_base.base = timer_reg_base;
>  out:
>  	timer_of_cleanup(to);


Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
