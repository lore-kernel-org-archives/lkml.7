Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F81C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F752089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbfIMKMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 06:12:45 -0400
Received: from foss.arm.com ([217.140.110.172]:41410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388066AbfIMKMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:12:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC85A28;
        Fri, 13 Sep 2019 03:12:43 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5D83F59C;
        Fri, 13 Sep 2019 03:12:41 -0700 (PDT)
Date:   Fri, 13 Sep 2019 11:12:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/4] arm64: Kconfig: Fix VEXPRESS driver dependencies
Message-ID: <20190913101239.GB2559@bogus>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
 <8f539b28c25d22b8f515c131cd6b24c309f7ca90.1568239378.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f539b28c25d22b8f515c131cd6b24c309f7ca90.1568239378.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 03:48:47AM +0530, Amit Kucheria wrote:
> Push various VEXPRESS drivers behind ARCH_VEXPRESS dependency so that it
> doesn't get enabled by default on other platforms.
>

I couldn't understand the motivation for these changes from the cover letter.

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/bus/Kconfig           | 2 +-
>  drivers/clk/versatile/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index d80e8d70bf10..b2b1beee9953 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -166,7 +166,7 @@ config UNIPHIER_SYSTEM_BUS
>  
>  config VEXPRESS_CONFIG
>  	bool "Versatile Express configuration bus"
> -	default y if ARCH_VEXPRESS
> +	depends on ARCH_VEXPRESS
>  	depends on ARM || ARM64
>  	depends on OF
>  	select REGMAP
> diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
> index ac766855ba16..826750292c1e 100644
> --- a/drivers/clk/versatile/Kconfig
> +++ b/drivers/clk/versatile/Kconfig
> @@ -5,8 +5,8 @@ config ICST
>  config COMMON_CLK_VERSATILE
>  	bool "Clock driver for ARM Reference designs"
>  	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
> -		ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
> -		COMPILE_TEST
> +		ARCH_VERSATILE || ARCH_VEXPRESS || COMPILE_TEST
> +	depends on ARM64

This will break 32-bit platforms.

--
Regards,
Sudeep
