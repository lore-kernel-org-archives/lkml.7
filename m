Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F83BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15057213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553028931;
	bh=oQ6b+nGg0MqfibMDpAzO0qnQiO6lO9WBK++p5214PeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xC7yd4FNw2OTBzArT0e4zUywMhGWnHxfGCuDLcgBlChQ82zaOe5AKqkLfbtzqNEOt
	 w5enGCTkaFvBKZjt+JfRxG1rtr8c7HPsMYs2B3UydwmMaHm6nklQ6W33BFTW2NE5jT
	 fLM7OOtWs6gH2ex/f5zir1qnDq49UOTtLoTxs20Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfCSUza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:55:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42163 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCSUz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:55:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so364868wrr.9;
        Tue, 19 Mar 2019 13:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UDhb9lm5yrN9gV6XK/Qb+R/McNZzo8h+ZzlntotooCY=;
        b=DYRjlKeVy3PKvjLXV+vJXCHzmBA391755stsMU0/I+EHACRzr/w0Y3Czx70nLjkY/Y
         DWXijpzYvg8Fxb29cbWTUWMWSul1GuiluliEXJLfHbo7/Cpb4wDDl9zXSb5n1B8RwjlC
         V6I5+409Q981R+73kzd54m3Y8HT33LiDs2OKzjE+eHjBnSCgYzGtDoOcVm1zJNiK3lRt
         La3NGDWp/NeHGadeFpvCFYqSvRCCynvW+tZp6EMzq16suUBwxvuaYIukjWu+vCIymtN/
         qXXMuB+jKJZ6x54+Nk5fY8PNkqFPif5kASPACZ6EyG3ZV/DrWilQhEpE74eHKmDjpIxU
         xOkw==
X-Gm-Message-State: APjAAAVw9EtMvMPcDklRcfX9SsP5RRVwoERoOoELDCvezDcTYDQ6RE0V
        znJuU6wOE6j0T9eBjEEm4WI=
X-Google-Smtp-Source: APXvYqxzdnziO3rp2PqLM3fdnCpNSnpXaWpszfrYZTlpWj99MsPvw6Ri5l5pSo3Wcj8QbL0sHJAiZg==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr13208308wrn.164.1553028925205;
        Tue, 19 Mar 2019 13:55:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id b4sm129945wmj.3.2019.03.19.13.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 13:55:24 -0700 (PDT)
Date:   Tue, 19 Mar 2019 21:55:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Fix audio (microphone) routing on
 Odroid XU3
Message-ID: <20190319205522.GD16150@kozik-lap>
References: <CGME20190311155023epcas2p428a025925f6442554b50e14e328a6d04@epcas2p4.samsung.com>
 <20190311155012.15797-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311155012.15797-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:50:12PM +0100, Sylwester Nawrocki wrote:
> The name of CODEC input widget to which microphone is connected through
> the "Headphone" jack is "IN12" not "IN1". This fixes microphone support
> on Odroid XU3.
> 
> Cc: <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

This does not apply on my next/dt nor on v5.1-rc1 branch.  Probably
because of 885b005d232c ("ARM: dts: exynos: Add support for secondary
DAI to Odroid XU3"). Can you rebase?

Best regards,
Krzysztof


> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
> index e84544b220b9..b90cea8b7368 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
> @@ -22,7 +22,7 @@
>  			"Headphone Jack", "HPL",
>  			"Headphone Jack", "HPR",
>  			"Headphone Jack", "MICBIAS",
> -			"IN1", "Headphone Jack",
> +			"IN12", "Headphone Jack",
>  			"Speakers", "SPKL",
>  			"Speakers", "SPKR";
>  
> -- 
> 2.17.1
> 
