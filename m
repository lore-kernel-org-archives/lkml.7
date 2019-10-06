Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7848AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5731920867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfJFJ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:57:30 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:42912 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfJFJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:57:30 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990413AbfJFJ51AhgUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:57:27 +0200
Date:   Sun, 6 Oct 2019 11:57:20 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.wolfsonmicro.com, piotrs@opensource.cirrus.com,
        enric.balletbo@collabora.com, paul@crapouillou.net,
        srinivas.kandagatla@linaro.org, andradanciu1997@gmail.com,
        mirq-linux@rere.qmqm.pl, kuninori.morimoto.gx@renesas.com,
        m.felsch@pengutronix.de, shifu0704@thundersoft.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH -next] ASoc: tas2770: Fix build error
 without GPIOLIB
Message-ID: <20191006095720.GA13261@lenoch>
References: <20191006072241.56808-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006072241.56808-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear YueHaibing,

On Sun, Oct 06, 2019 at 03:22:41PM +0800, YueHaibing wrote:
> If GPIOLIB is not set, building fails:
> 
> sound/soc/codecs/tas2770.c: In function tas2770_reset:
> sound/soc/codecs/tas2770.c:38:3: error: implicit declaration of function gpiod_set_value_cansleep; did you mean gpio_set_value_cansleep? [-Werror=implicit-function-declaration]
>    gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
>    ^~~~~~~~~~~~~~~~~~~~~~~~
>    gpio_set_value_cansleep
> sound/soc/codecs/tas2770.c: In function tas2770_i2c_probe:
> sound/soc/codecs/tas2770.c:749:24: error: implicit declaration of function devm_gpiod_get_optional; did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
>   tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
>                         ^~~~~~~~~~~~~~~~~~~~~~~
>                         devm_regulator_get_optional
> sound/soc/codecs/tas2770.c:751:13: error: GPIOD_OUT_HIGH undeclared (first use in this function); did you mean GPIOF_INIT_HIGH?
>              GPIOD_OUT_HIGH);
>              ^~~~~~~~~~~~~~
>              GPIOF_INIT_HIGH
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/codecs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index bcac957..d639f17 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1108,6 +1108,7 @@ config SND_SOC_TAS2552
>  config SND_SOC_TAS2770
>  	tristate "Texas Instruments TAS2770 speaker amplifier"
>  	depends on I2C
> +	select GPIOLIB

GPIOLIB API is working perfectly fine even if GPIOLIB is not selected
and gpiod_* functions will merely return -ENOSYS in this case.
Please see <linux/gpio/consumer.h> and fix your patch accordingly.

>  config SND_SOC_TAS5086
>  	tristate "Texas Instruments TAS5086 speaker amplifier"
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
