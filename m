Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0EC2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSREO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:04:14 -0500
Received: from muru.com ([72.249.23.125]:49176 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSREN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:04:13 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 635D98030;
        Thu, 19 Dec 2019 17:04:52 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:04:09 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] mfd: motorola-cpcap: Do not hardcode SPI mode flags
Message-ID: <20191219170409.GH35479@atomide.com>
References: <20191204231931.21378-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204231931.21378-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

* Linus Walleij <linus.walleij@linaro.org> [700101 00:00]:
> The current use of mode flags to us SPI_MODE_0 and
> SPI_CS_HIGH is fragile: it overwrites anything already
> assigned by the SPI core. Change it thusly:
> 
> - Just |= the SPI_MODE_0 so we keep other flags
> - Assign ^= SPI_CS_HIGH since we might be active high
>   already, and that is usually the case with GPIOs used
>   for chip select, even if they are in practice active low.
> 
> Add a comment clarifying why ^= SPI_CS_HIGH is the right
> choice here.

Looks like this breaks booting for droid4 with a cpcap
PMIC, probably as regulators won't work. There's no GPIO
controller involved in this case for the chip select, the
pins are directly controlled by the spi-omap2-mcspi.c
driver.

From the pin muxing setup we see there's a pull-down on
mcspi1_cs0 pin meaning it's active high:

/* 0x4a100138 mcspi1_cs0.mcspi1_cs0 ae23 */
OMAP4_IOPAD(0x138, PIN_INPUT_PULLDOWN | MUX_MODE0)

My guess a similar issue is with similar patches for
all non-gpio spi controllers?

Let me know if you want me to test some other changes,
or if this patch depends on some other changes.

Regards,

Tony


> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/motorola-cpcap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> index 52f38e57cdc1..a3bc61b8008c 100644
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -279,7 +279,13 @@ static int cpcap_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, cpcap);
>  
>  	spi->bits_per_word = 16;
> -	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
> +	spi->mode |= SPI_MODE_0;
> +	/*
> +	 * Active high should be defined as "inverse polarity" as GPIO-based
> +	 * chip selects can be logically active high but inverted by the GPIO
> +	 * library.
> +	 */
> +	spi->mode ^= SPI_CS_HIGH;
>  
>  	ret = spi_setup(spi);
>  	if (ret)
> -- 
> 2.23.0
> 
