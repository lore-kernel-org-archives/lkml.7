Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B532190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X4oF7pT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfCUKZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:25:51 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47826 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfCUKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:25:51 -0400
Received: from pendragon.ideasonboard.com (30.net042126252.t-com.ne.jp [42.126.252.30])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F08BF23A;
        Thu, 21 Mar 2019 11:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553163948;
        bh=hortb+fLPxm48q4oN7adARz9wJcUzEYac3LLowmBhpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4oF7pT9mGAzemS1c6b5XxA5CS7hSnRxS9etWNtB5QJn+9Xlz9NnBVIKAzWY4WKaY
         Diif70Nv2U1xjgRopqug256O3SodUUDvGF0D3n4gulf5yQiykr8X2Hi+UqzXiYGA+Q
         nOkri1XzI2ctJRUwzY922eOcAEb6+Qf6l8Tx/dpo=
Date:   Thu, 21 Mar 2019 12:25:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up
 is enabled
Message-ID: <20190321102537.GR4615@pendragon.ideasonboard.com>
References: <20190320103927.21227-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320103927.21227-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Mar 20, 2019 at 11:39:27AM +0100, Geert Uytterhoeven wrote:
> If a device is part of the wake-up path, it should indicate this by
> setting its power.wakeup_path field.  This allows the genpd core code to
> keep the device enabled during system suspend when needed.
> 
> As regulators powering devices are not handled by genpd, the driver
> handles these itself, and thus must skip regulator control when the
> device is part of the wake-up path.

It would be nice for this to be handled automatically...

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Note that I don't really need this on the Renesas Ebisu-4D board, as
> there is no regulator or PM Domain controlling power to the GPIO
> expander on that board.  I did want to have all wake-up path processing
> implemented in the driver for completeness, and did test its behavior
> with gpio-keys configured as a wake-up source.
> 
> However, while this approach is known to work fine on other boards, with
> other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> device suspend ordering.
> 
> The proper ordering is:
>   1. When gpio-keys is suspended, its suspend handler calls
>      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
>      pca953x_chip.wakeup_path to be incremented,
>   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
>      and marks the device to be part of the wake-up path.
> 
> However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> scheme :-(
> 
> So depending on topology, this may work, or not...

Could device links help there ?

> ---
>  drivers/gpio/gpio-pca953x.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 88c94d155e218535..349d0ccb5285a6c4 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -153,6 +153,7 @@ struct pca953x_chip {
>  	u8 irq_trig_fall[MAX_BANK];
>  	struct irq_chip irq_chip;
>  #endif
> +	atomic_t wakeup_path;
>  
>  	struct i2c_client *client;
>  	struct gpio_chip gpio_chip;
> @@ -581,6 +582,11 @@ static int pca953x_irq_set_wake(struct irq_data *d, unsigned int on)
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct pca953x_chip *chip = gpiochip_get_data(gc);
>  
> +	if (on)
> +		atomic_inc(&chip->wakeup_path);
> +	else
> +		atomic_dec(&chip->wakeup_path);
> +
>  	return irq_set_irq_wake(chip->client->irq, on);
>  }
>  
> @@ -1100,7 +1106,10 @@ static int pca953x_suspend(struct device *dev)
>  
>  	regcache_cache_only(chip->regmap, true);
>  
> -	regulator_disable(chip->regulator);
> +	if (atomic_read(&chip->wakeup_path))
> +		device_set_wakeup_path(dev);
> +	else
> +		regulator_disable(chip->regulator);
>  
>  	return 0;
>  }
> @@ -1110,10 +1119,12 @@ static int pca953x_resume(struct device *dev)
>  	struct pca953x_chip *chip = dev_get_drvdata(dev);
>  	int ret;
>  
> -	ret = regulator_enable(chip->regulator);
> -	if (ret != 0) {
> -		dev_err(dev, "Failed to enable regulator: %d\n", ret);
> -		return 0;
> +	if (!atomic_read(&chip->wakeup_path)) {
> +		ret = regulator_enable(chip->regulator);
> +		if (ret != 0) {
> +			dev_err(dev, "Failed to enable regulator: %d\n", ret);
> +			return 0;
> +		}
>  	}
>  
>  	regcache_cache_only(chip->regmap, false);

-- 
Regards,

Laurent Pinchart
