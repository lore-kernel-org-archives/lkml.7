Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4895C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EC42087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfJLK0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 06:26:34 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40131 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfJLKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 06:24:34 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4955D20007;
        Sat, 12 Oct 2019 10:24:30 +0000 (UTC)
Date:   Sat, 12 Oct 2019 12:24:29 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        mirq-linux@rere.qmqm.pl, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: atmel: select SND_ATMEL_SOC_DMA for
 SND_ATMEL_SOC_SSC
Message-ID: <20191012102429.GH3125@piout.net>
References: <20191012024230.159371-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012024230.159371-1-maowenan@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2019 10:42:30+0800, Mao Wenan wrote:
> If SND_ATMEL_SOC_SSC_PDC=y and SND_ATMEL_SOC_SSC_DMA=m,
> below errors can be found:
> sound/soc/atmel/atmel_ssc_dai.o: In function
> `atmel_ssc_set_audio':
> atmel_ssc_dai.c:(.text+0x6fe): undefined reference to
> `atmel_pcm_dma_platform_register'
> make: *** [vmlinux] Error 1
> 
> After commit 18291410557f ("ASoC: atmel: enable
> SOC_SSC_PDC and SOC_SSC_DMA in Kconfig"), SND_ATMEL_SOC_DMA
> and SND_ATMEL_SOC_SSC are selected by SND_ATMEL_SOC_SSC_DMA,
> SND_ATMEL_SOC_SSC is also selected by SND_ATMEL_SOC_SSC_PDC,
> the results are SND_ATMEL_SOC_DMA=m but SND_ATMEL_SOC_SSC=y,
> so the errors happen.
> 
> This patch make SND_ATMEL_SOC_SSC select SND_ATMEL_SOC_DMA.
> 
> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  sound/soc/atmel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index f118c22..2938f6b 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -19,6 +19,7 @@ config SND_ATMEL_SOC_DMA
>  
>  config SND_ATMEL_SOC_SSC
>  	tristate
> +	select SND_ATMEL_SOC_DMA
>  

This is not the solution because this doesn't allow to compile out DMA
and use only PDC. I think Arnd already submitted a proper patch.

>  config SND_ATMEL_SOC_SSC_PDC
>  	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
