Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B36C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B11206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfJHQfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:35:14 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:52102 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:35:13 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23991911AbfJHQfJd4fX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:35:09 +0200
Date:   Tue, 8 Oct 2019 18:35:08 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, m.felsch@pengutronix.de,
        alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        piotrs@opensource.cirrus.com, andradanciu1997@gmail.com,
        lgirdwood@gmail.com, paul@crapouillou.net,
        Hulk Robot <hulkci@huawei.com>, shifu0704@thundersoft.com,
        enric.balletbo@collabora.com, srinivas.kandagatla@linaro.org,
        tiwai@suse.com, mirq-linux@rere.qmqm.pl,
        rf@opensource.wolfsonmicro.com
Subject: Re: [alsa-devel] Applied "ASoc: tas2770: Fix build error without
 GPIOLIB" to the asoc tree
Message-ID: <20191008163508.GA16283@lenoch>
References: <20191006104631.60608-1-yuehaibing@huawei.com>
 <20191007130309.EAEBE2741EF0@ypsilon.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007130309.EAEBE2741EF0@ypsilon.sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing & Mark,

On Mon, Oct 07, 2019 at 02:03:09PM +0100, Mark Brown wrote:
> The patch
> 
>    ASoc: tas2770: Fix build error without GPIOLIB
> 
> has been applied to the asoc tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

Hmm, too late it seems...
Patch should actually remove <linux/gpio.h> as this is legacy one (see comment
on the top and also Documentation/driver-api/gpio/consumer.rst)

And that brings a question. Given this is -next only is it actually possible
to squash fixes into 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
just to make bisect a bit more happy?

	l.

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> >From 03fe492e8346d3da59b6eb7ea306d46ebf22e9d5 Mon Sep 17 00:00:00 2001
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Sun, 6 Oct 2019 18:46:31 +0800
> Subject: [PATCH] ASoc: tas2770: Fix build error without GPIOLIB
> 
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
> Suggested-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Link: https://lore.kernel.org/r/20191006104631.60608-1-yuehaibing@huawei.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/tas2770.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
> index dbbb21fe0548..15f6fcc6d87e 100644
> --- a/sound/soc/codecs/tas2770.c
> +++ b/sound/soc/codecs/tas2770.c
> @@ -15,6 +15,7 @@
>  #include <linux/pm.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/firmware.h>
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
