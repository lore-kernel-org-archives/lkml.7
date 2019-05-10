Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06EAC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1321479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfEJNQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:16:04 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36169 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfEJNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:16:04 -0400
X-Originating-IP: 109.213.220.252
Received: from localhost (alyon-652-1-77-252.w109-213.abo.wanadoo.fr [109.213.220.252])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 67C50240017;
        Fri, 10 May 2019 13:15:59 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH] ARM: dts: lpc32xx: Revert set default clock rate of HCLK PLL
In-Reply-To: <20190510130855.4263-1-alexandre.belloni@bootlin.com>
References: <20190510130855.4263-1-alexandre.belloni@bootlin.com>
Date:   Fri, 10 May 2019 15:15:58 +0200
Message-ID: <877eay30xd.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

> This reverts commit c17e9377aa81664d94b4f2102559fcf2a01ec8e7.
>
> The lpc32xx clock driver is not able to actually change the PLL rate as
> this would require reparenting ARM_CLK, DDRAM_CLK, PERIPH_CLK to SYSCLK,
> then stop the PLL, update the register, restart the PLL and wait for the
> PLL to lock and finally reparent ARM_CLK, DDRAM_CLK, PERIPH_CLK to HCLK
> PLL.
>
> Currently, the HCLK driver simply updates the registers but this has no
> real effect and all the clock rate calculation end up being wrong. This is
> especially annoying for the peripheral (e.g. UARTs, I2C, SPI).
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>


Gregory

> ---
>  arch/arm/boot/dts/lpc32xx.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index 20b38f4ade37..a49c97e5a38a 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -323,9 +323,6 @@
>  
>  					clocks = <&xtal_32k>, <&xtal>;
>  					clock-names = "xtal_32k", "xtal";
> -
> -					assigned-clocks = <&clk LPC32XX_CLK_HCLK_PLL>;
> -					assigned-clock-rates = <208000000>;
>  				};
>  			};
>  
> -- 
> 2.21.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
