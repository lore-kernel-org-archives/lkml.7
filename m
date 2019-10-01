Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A963C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E30721D79
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="JsQ1F1kX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfJAO5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:57:05 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:27152 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389535AbfJAO5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:57:03 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46jMkZ2SSrz4G;
        Tue,  1 Oct 2019 16:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1569941704; bh=/oFjgNLU/ZvSelC6tLjw91cHQa877YduGYa+snzVYRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsQ1F1kX3wGRrlY1a9hWTLA2LaalbBEahiTlqlZOGsDZXb+SyXUwzKD4rbke0EmXG
         x7N82fQJUZm074OdjoaLeJbSdMG/B3bF3Y+uWGhTlrenGAtWt3MMrBkxoPn3XT0f1v
         ZYxlbloRZzLwqC97uSfDNoEDk0Yhu006mYNLkwnJtid/YXtL8s7NeBwDWKf2yIH9tk
         brd/t5cuqt8mnC01f850RppQzimpW7PEbWF1Z5ZrE8uY+2lVF17M9PdYc7BIglHjxm
         ZiM2Lzi3u2RaucgE3dU7OMpp60GXXQsanht7Z/0Ho1o/zDnV8d5fPbjPMTazBU7wW0
         JuWnKzqAZOu9g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 1 Oct 2019 16:56:56 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
Message-ID: <20191001145656.GB6905@qmqm.qmqm.pl>
References: <20191001142116.1172290-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001142116.1172290-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:20:55PM +0200, Arnd Bergmann wrote:
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
>  obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
>  obj-$(CONFIG_SND_ATMEL_SOC_I2S) += snd-soc-atmel-i2s.o
>  obj-$(CONFIG_SND_MCHP_SOC_I2S_MCC) += snd-soc-mchp-i2s-mcc.o

I was just exploring similar solution, using $(if X,Y) instead, but your
fix will work just as well.

Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

Best Regards,
Micha³ Miros³aw
