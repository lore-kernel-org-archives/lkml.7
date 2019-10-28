Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318FBCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A279217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbfJ1VIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:08:34 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:49338 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfJ1VId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:08:33 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K98W2100G5TFNlm0398XDJ; Mon, 28 Oct 2019 22:08:31 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 22:08:31 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 21/46] ARM: pxa: spitz: use gpio descriptors for audio
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-21-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 22:08:30 +0100
In-Reply-To: <20191018154201.1276638-21-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:41:36 +0200")
Message-ID: <87o8y0lgs1.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/spitz.c                    | 33 ++++++++++-
>  arch/arm/mach-pxa/{include/mach => }/spitz.h |  2 +-
>  arch/arm/mach-pxa/spitz_pm.c                 |  2 +-
>  sound/soc/pxa/spitz.c                        | 58 ++++++++------------
>  4 files changed, 57 insertions(+), 38 deletions(-)
>  rename arch/arm/mach-pxa/{include/mach => }/spitz.h (99%)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index a4fdc399d152..6028fd83c44d 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -44,7 +44,7 @@
>  #include <linux/platform_data/mmc-pxamci.h>
>  #include <linux/platform_data/usb-ohci-pxa27x.h>
>  #include <linux/platform_data/video-pxafb.h>
> -#include <mach/spitz.h>
> +#include "spitz.h"
>  #include "sharpsl_pm.h"
>  #include <mach/smemc.h>
>  
> @@ -948,11 +948,42 @@ static void __init spitz_i2c_init(void)
>  static inline void spitz_i2c_init(void) {}
>  #endif
>  
> +static struct gpiod_lookup_table spitz_audio_gpio_table = {
> +	.dev_id = "spitz-audio",
> +	.table = {
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
> +			    "mute-l", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
> +			    "mute-r", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("sharp-scoop.1", SPITZ_GPIO_MIC_BIAS - SPITZ_SCP2_GPIO_BASE,
> +			    "mic", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
> +static struct gpiod_lookup_table akita_audio_gpio_table = {
> +	.dev_id = "spitz-audio",
> +	.table = {
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
> +			    "mute-l", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
> +			    "mute-r", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_MIC_BIAS - AKITA_IOEXP_GPIO_BASE,
> +			    "mic", GPIO_ACTIVE_HIGH),
This last one looks a bit dubious, as it looks like a gpio on a gpio expander,
could you cross-check that "gpio-pxa" shouldn't be an I2C expander gpio please ?

Cheers.

--
Robert
