Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027BC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE24B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfLJNYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:24:13 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57637 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfLJNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:24:12 -0500
X-Originating-IP: 90.182.112.136
Received: from localhost (136.112.broadband15.iol.cz [90.182.112.136])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 52D7960018;
        Tue, 10 Dec 2019 13:24:06 +0000 (UTC)
Date:   Tue, 10 Dec 2019 14:24:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 13/16] rtc: bd70528 add BD71828 support
Message-ID: <20191210132402.GK1463890@piout.net>
References: <cover.1574059625.git.matti.vaittinen@fi.rohmeurope.com>
 <648d09ab52fb125cab8d26dd13ef71dd4fd5f778.1574059625.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648d09ab52fb125cab8d26dd13ef71dd4fd5f778.1574059625.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/11/2019 09:00:47+0200, Matti Vaittinen wrote:
> @@ -468,26 +596,35 @@ static int bd70528_probe(struct platform_device *pdev)
>  	 *  leave them enabled as irq-controller should disable irqs
>  	 *  from sub-registers when IRQ is disabled or freed.
>  	 */
> -	ret = regmap_update_bits(mfd->regmap,
> +	if (enable_main_irq) {
> +		ret = regmap_update_bits(mfd->regmap,
>  				 BD70528_REG_INT_MAIN_MASK,
>  				 BD70528_INT_RTC_MASK, 0);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to enable RTC interrupts\n");
> -		return ret;
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to enable RTC interrupts\n");
> +			return ret;
> +		}
>  	}
>  
>  	return rtc_register_device(rtc);
>  }

Missing blank line here.

> +static const struct platform_device_id bd718x7_rtc_id[] = {
> +	{ "bd70528-rtc", ROHM_CHIP_TYPE_BD70528 },
> +	{ "bd71828-rtc", ROHM_CHIP_TYPE_BD71828 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, bd718x7_rtc_id);
>  

Else, Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
