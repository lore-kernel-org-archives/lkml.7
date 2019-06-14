Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF0EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4618B2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IcBrn2Ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfFNPsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:48:45 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7903 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfFNPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:48:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03c1d80000>; Fri, 14 Jun 2019 08:48:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 08:48:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 08:48:40 -0700
Received: from [10.26.11.12] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 15:48:38 +0000
Subject: Re: [PATCH v2 4/6] clocksource/drivers/tegra: Drop unneeded
 typecasting in one place
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-5-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2bea2303-42bb-a306-72ec-be60b00e2b23@nvidia.com>
Date:   Fri, 14 Jun 2019 16:48:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610164400.11830-5-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560527320; bh=qqFCsTbLnbXGAwdf+gOzklHxTJ/H1R22gcikOiKKLQs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IcBrn2YsQtpxsPqaKB5Ma3bulre+MaYssQ07cLUQ862DVeHKZquVi7xXQG+ZNAuuB
         4ldewxi440XXSo4KLvmbTKP5jvWXyxvaoY+FGPL86I545RHoHJrqQO/f3kuRVLPqnM
         CyUQCJbPJ07poTk+DMNTl5x1LrAjlLOhtlTW05+rFmH5onSRqHlc9cY1Mo0U+jwmvY
         N/jNwfwT4x2E9NT2NxBZgcakRvype1KlSNZmDL4VQpYNEuIDlu83uvmOfd+7o2sQXm
         bxaKf5dnKnWCTjIZv/KKV0VbpBBWloQNIyCNZLpkEcpgNk7+iY6OwZ/zaAJb9qLm55
         ETVHrMy9W7OKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/06/2019 17:43, Dmitry Osipenko wrote:
> There is no need to cast void because kernel allows to do that without
> a warning message from a compiler.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
> index 646b3530c2d2..a7fa12488066 100644
> --- a/drivers/clocksource/timer-tegra.c
> +++ b/drivers/clocksource/timer-tegra.c
> @@ -81,7 +81,7 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
>  
>  static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
>  {
> -	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> +	struct clock_event_device *evt = dev_id;
>  	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>  
>  	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
