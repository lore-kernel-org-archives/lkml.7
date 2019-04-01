Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC874C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC36208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfDAQqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:46:22 -0400
Received: from muru.com ([72.249.23.125]:43756 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDAQqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:46:22 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EBA5180C0;
        Mon,  1 Apr 2019 16:46:34 +0000 (UTC)
Date:   Mon, 1 Apr 2019 09:46:17 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a
 regression that unhides a broken legacy handler, which makes the gta04
 display inoperable
Message-ID: <20190401164617.GH49658@atomide.com>
References: <cover.1554026842.git.hns@goldelico.com>
 <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns@goldelico.com> [190331 10:08]:
> This is an ugly workaround for a regression introduced into v5.1-rc1 by
> 
> <c1c04cea13dc234ce9a4504879ddd36ea524d880>

You should standardized commit references like this instead:

c1c04cea13dc ("gpio: of: Fix logic inversion")

Then please also include a proper Fixes tag.

You can configure an alias for it to make things easier:

git log --abbrev=12 --pretty=format:"%h (\"%s\")"

> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -114,6 +114,7 @@
>  		gpio-miso = <&gpio1 18 GPIO_ACTIVE_HIGH>;
>  		gpio-mosi = <&gpio1 20 GPIO_ACTIVE_HIGH>;
>  		cs-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +		spi-cs-high;	/* make the legacy handler in gpiolib not intervene */
>  		num-chipselects = <1>;
>  
>  		/* lcd panel */
> @@ -123,6 +124,7 @@
>  			spi-max-frequency = <100000>;
>  			spi-cpol;
>  			spi-cpha;
> +			spi-cs-high;	/* here is where it should be but this is ignored by a bug in the gpiolib handler */
>  
>  			backlight= <&backlight>;
>  			label = "lcd";

So what's the plan with this fix? Add this for v5.2-rc cycle,
then revert it later? I'd probably go directly for the proper
fix if possible.

Regards,

Tony
