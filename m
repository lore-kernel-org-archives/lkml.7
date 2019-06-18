Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB78C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80AA205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WPss+ILI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfFRRwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:52:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7700 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFRRwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:52:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0924c30000>; Tue, 18 Jun 2019 10:52:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 10:52:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 10:52:03 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 17:52:01 +0000
Subject: Re: [PATCH v3 7/8] clocksource/drivers/tegra: Cycles can't be 0
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Peter De Schrijver" <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-8-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d93f2367-b14e-2a98-eb52-098883ba8b19@nvidia.com>
Date:   Tue, 18 Jun 2019 18:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618140358.13148-8-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560880323; bh=y8cHnW0F5AVgjyIhHme0/nvQy8pM3x0oDRs+oR+XB5Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WPss+ILIh0XpnTFINwQnKIECbbgUdJNpFVOUN1UcM5iet6igwnTjJ+8b+5VPGOm+1
         SNBq5LVrzGvNtKFtSkxH90MVGDysm3d6Hno5qXoPbKYK3Oy3VTwpUHBwrpIra+Qygi
         sM0wj++52jf+XLHeCDgkwZw+hoSQBbgREf2XnmTdx5ix2f1vGeUT263O2h3eLyC7uo
         t40xQcZzCWqEHzn1B3U0D849BViFbJbQ8sfs4k0Bo4Nva9HZXMz5phjg5dfUTaxnRc
         McKas0CvqGVrcac1WgakL72Rx+GxKF+SZZFlS5SpgmYmJpOQbqqhNTs4VhitwsJzGl
         HyFITguua3tVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/2019 15:03, Dmitry Osipenko wrote:
> Tegra's timer uses n+1 scheme for the counter, i.e. timer will fire after
> one tick if 0 is loaded. The minimum and maximum numbers of oneshot ticks
> are defined by clockevents_config_and_register(min, max) invocation and
> the min value is set to 1 tick. Hence "cycles" value can't ever be 0,
> unless it's a bug in clocksource core.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index 2673b6e0caa8..b84324288749 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -54,9 +54,16 @@ static int tegra_timer_set_next_event(unsigned long cycles,
>  {
>  	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>  
> -	writel_relaxed(TIMER_PTV_EN |
> -		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
> -		       reg_base + TIMER_PTV);
> +	/*
> +	 * Tegra's timer uses n+1 scheme for the counter, i.e. timer will
> +	 * fire after one tick if 0 is loaded.
> +	 *
> +	 * The minimum and maximum numbers of oneshot ticks are defined
> +	 * by clockevents_config_and_register(1, 0x1fffffff + 1) invocation
> +	 * below in the code. Hence the cycles (ticks) can't be outside of
> +	 * a range supportable by hardware.
> +	 */
> +	writel_relaxed(TIMER_PTV_EN | (cycles - 1), reg_base + TIMER_PTV);
>  
>  	return 0;
>  }
> 


Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
