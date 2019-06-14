Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311B52173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ovcS0/5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFNPsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:48:54 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15155 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfFNPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:48:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03c1e20000>; Fri, 14 Jun 2019 08:48:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 08:48:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 08:48:50 -0700
Received: from [10.26.11.12] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 15:48:47 +0000
Subject: Re: [PATCH v2 6/6] clocksource/drivers/tegra: Restore base address
 before cleanup
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-7-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b2eeb477-2e08-eaf5-6355-4a05cec5a9b7@nvidia.com>
Date:   Fri, 14 Jun 2019 16:48:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610164400.11830-7-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560527330; bh=9k+h83QDqVPiDqnxwLk+IzdrFW33J4CWSkp9+TU9VY0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ovcS0/5EK1oAwvYQnT2mnEhYUMsLXbwrtSLrP7omEhS9QfV6VckujhSjKqj4I5ut/
         n7lSvNr5XiJ5w+EneNJP/Sh1D3KO+nRfyjq0GrHBqKE0S5siZaoKdQ4Y7xh9G6fss+
         vuJX/Tim4I4k/aKn3uZYjQPVRS6WZwBhG3wmD+dbEM8Va011efT63ev9P4s2wjlgr4
         O6MYJ4H6+EO0SgZbgcLaoubI/hafiPPnGw/9CrR9MKfPzFpLtg9dH4WkYUxAr1+cLL
         xjWFk5qAgvprErFDUNpuxXELQBP7A/qr0H8WHOo6hpvsr96Ctd40ODu6Q8m519Od2Y
         /szA0K1AsJxog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/2019 17:44, Dmitry Osipenko wrote:
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
> index 2a428fdf702f..7be91db98bd7 100644
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

So what you are saying is that because we don't know which CPU executes
the tegra_init_timer() function, then it is necessary to restore the
base. IOW if it is not CPU0, then the base will be updated and hence,
need to be restored. Correct?

Jon

-- 
nvpublic
