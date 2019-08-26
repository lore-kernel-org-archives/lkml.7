Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B7C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997582173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfHZOXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:23:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60799 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfHZOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:23:42 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3C75C1BF205;
        Mon, 26 Aug 2019 14:23:38 +0000 (UTC)
Date:   Mon, 26 Aug 2019 16:23:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh-dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA
 in Kconfig
Message-ID: <20190826142337.GE21713@piout.net>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
 <233d5461f4448df151755de7b69a0cd3ad310d5c.1566677788.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <233d5461f4448df151755de7b69a0cd3ad310d5c.1566677788.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2019 22:26:52+0200, Michał Mirosław wrote:
> Allow SSC to be used on platforms described using audio-graph-card
> in Device Tree.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> 
> ---
>  v2: extended to PDC mode
>      reworked and fixed Kconfig option dependencies
> 
> ---
>  sound/soc/atmel/Kconfig | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index 06c1d5ce642c..f118c229ed82 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -12,25 +12,31 @@ if SND_ATMEL_SOC
>  config SND_ATMEL_SOC_PDC
>  	tristate
>  	depends on HAS_DMA
> -	default m if SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=m
> -	default y if SND_ATMEL_SOC_SSC_PDC=y || (SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=y)
> -
> -config SND_ATMEL_SOC_SSC_PDC
> -	tristate
>  
>  config SND_ATMEL_SOC_DMA
>  	tristate
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
> -	default m if SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=m
> -	default y if SND_ATMEL_SOC_SSC_DMA=y || (SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=y)
> -
> -config SND_ATMEL_SOC_SSC_DMA
> -	tristate
>  
>  config SND_ATMEL_SOC_SSC
>  	tristate
> -	default y if SND_ATMEL_SOC_SSC_DMA=y || SND_ATMEL_SOC_SSC_PDC=y
> -	default m if SND_ATMEL_SOC_SSC_DMA=m || SND_ATMEL_SOC_SSC_PDC=m
> +
> +config SND_ATMEL_SOC_SSC_PDC
> +	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
> +	depends on ATMEL_SSC
> +	select SND_ATMEL_SOC_PDC
> +	select SND_ATMEL_SOC_SSC
> +	help
> +	  Say Y or M if you want to add support for Atmel SSC interface
> +	  in PDC mode configured using audio-graph-card in device-tree.
> +
> +config SND_ATMEL_SOC_SSC_DMA
> +	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
> +	depends on ATMEL_SSC
> +	select SND_ATMEL_SOC_DMA
> +	select SND_ATMEL_SOC_SSC
> +	help
> +	  Say Y or M if you want to add support for Atmel SSC interface
> +	  in DMA mode configured using audio-graph-card in device-tree.
>  
>  config SND_AT91_SOC_SAM9G20_WM8731
>  	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
