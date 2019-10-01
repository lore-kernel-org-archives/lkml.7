Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E17ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434A921855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbfJAO1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:27:38 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57941 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388931AbfJAO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:27:38 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 37DFE240008;
        Tue,  1 Oct 2019 14:27:35 +0000 (UTC)
Date:   Tue, 1 Oct 2019 16:27:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
Message-ID: <20191001142734.GD4106@piout.net>
References: <20191001142116.1172290-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001142116.1172290-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/10/2019 16:20:55+0200, Arnd Bergmann wrote:
> The ssc audio driver can call into both pdc and dma backends.  With the
> latest rework, the logic to do this in a safe way avoiding link errors
> was removed, bringing back link errors that were fixed long ago in commit
> 061981ff8cc8 ("ASoC: atmel: properly select dma driver state") such as
> 
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> atmel_ssc_dai.c:(.text+0xac): undefined reference to `atmel_pcm_pdc_platform_register'
> 
> Fix it this time using Makefile hacks and a comment to prevent this
> from accidentally getting removed again rather than Kconfig hacks.
> 
> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/atmel/Kconfig  |  4 ++--
>  sound/soc/atmel/Makefile | 10 ++++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index f118c229ed82..25c31bf64936 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -10,11 +10,11 @@ config SND_ATMEL_SOC
>  if SND_ATMEL_SOC
>  
>  config SND_ATMEL_SOC_PDC
> -	tristate
> +	bool
>  	depends on HAS_DMA
>  
>  config SND_ATMEL_SOC_DMA
> -	tristate
> +	bool
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  
>  config SND_ATMEL_SOC_SSC
> diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
> index 1f6890ed3738..c7d2989791be 100644
> --- a/sound/soc/atmel/Makefile
> +++ b/sound/soc/atmel/Makefile
> @@ -6,8 +6,14 @@ snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
>  snd-soc-atmel-i2s-objs := atmel-i2s.o
>  snd-soc-mchp-i2s-mcc-objs := mchp-i2s-mcc.o
>  
> -obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
> -obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
> +# pdc and dma need to both be built-in if any user of
> +# ssc is built-in.
> +ifdef CONFIG_SND_ATMEL_SOC_PDC
> +obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel-pcm-pdc.o
> +endif
> +ifdef CONFIG_SND_ATMEL_SOC_DMA
> +obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel-pcm-dma.o
> +endif

Doesn't that prevent them to be built as a module at all?
I'm not sure there is a use case though.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
