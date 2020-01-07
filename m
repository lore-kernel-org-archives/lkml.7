Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EF4C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0FD2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgAGH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:27:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51499 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgAGH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:27:04 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iojGI-0000qU-CN; Tue, 07 Jan 2020 08:26:46 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iojGH-00029v-Ic; Tue, 07 Jan 2020 08:26:45 +0100
Date:   Tue, 7 Jan 2020 08:26:45 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Message-ID: <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230172113.17222-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Mon, Dec 30, 2019 at 06:21:13PM +0100, Krzysztof Kozlowski wrote:
> Some of the PWM drivers can be compile tested to increase build
> coverage.
> 
> The Meson PWM driver requires COMMON_CLK dependency.

I'm surprised that there are not more that need this. Is HAVE_CLK not
enough?

Also HAS_IOMEM is a typical requirement, but I tested with an ARCH=um
config (which does't have HAS_IOMEM) and they all compile fine.

> @@ -318,7 +319,7 @@ config PWM_MEDIATEK
>  
>  config PWM_MXS
>  	tristate "Freescale MXS PWM support"
> -	depends on ARCH_MXS && OF
> +	depends on (ARCH_MXS && OF) || COMPILE_TEST
>  	select STMP_DEVICE
>  	help
>  	  Generic PWM framework driver for Freescale MXS.
> @@ -328,7 +329,8 @@ config PWM_MXS
>  
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
> -	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
> +	depends on (ARCH_OMAP && OMAP_DM_TIMER) || COMPILE_TEST
> +	depends on OF

I'm surprised that OF isn't required for PWM_MXS but is is for
PWM_OMAP_DMTIMER. pwm-mxs compiles without CONFIG_OF, didn't test
pwm-omap-dmtimer.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |    | https://www.pengutronix.de/ |
