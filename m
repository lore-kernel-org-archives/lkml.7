Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B0FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1493820684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mx7XlUdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCGNYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:24:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57728 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfCGNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:24:06 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x27DMeYV048190;
        Thu, 7 Mar 2019 07:22:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551964960;
        bh=u42WJRfo5YL0CrCs9ib22CvfRFH52TZ2opipYR82VPM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Mx7XlUdfLfZcTtMtb1HspBILCBCkSPvmP3ay77AA/tpSZ+ib2SBzvH67cgRAO3ZzZ
         CgmUvczArODNlnkQNfaulJjtzwuTkRcixfneaS5Xmf6ZphMcdFAq7U41MFwk5j8Pj/
         G1XXSPHSorpPFly8H8bd1okdNCMkMAqcdq7ZN5YA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x27DMerl129106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 07:22:40 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Mar 2019 07:22:37 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Mar 2019 07:22:37 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x27DMYW3031505;
        Thu, 7 Mar 2019 07:22:35 -0600
Subject: Re: [PATCH 2/3] ASoC: ti: remove compat dma probing
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Tony Lindgren <tony@atomide.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20190304203114.1894822-1-arnd@arndb.de>
 <20190304203114.1894822-2-arnd@arndb.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <865ffc6e-c6f7-a30a-1c0c-14194b3458ef@ti.com>
Date:   Thu, 7 Mar 2019 15:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190304203114.1894822-2-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 04/03/2019 22.30, Arnd Bergmann wrote:
> After running into a link error:
> 
> sound/soc/ti/edma-pcm.o:(.rodata+0x18): undefined reference to `edma_filter_fn'
> 
> I checked all users of this, and they have new-style 'dma_slave_map' tables,
> so none of them should still need it. Removing the associated lines
> simplifies the code and avoids the build-time dependency on the
> respective dmaengine drivers.

Thank you for the patch!

Yes, I believe I have covered all possible legacy uses for both edma and
sdma with dma_slave_map

With the two comments addressed:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/ti/edma-pcm.c | 4 +---
>  sound/soc/ti/sdma-pcm.c | 8 +++-----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/ti/edma-pcm.c b/sound/soc/ti/edma-pcm.c
> index 59e588abe54b..5b9e341309f0 100644
> --- a/sound/soc/ti/edma-pcm.c
> +++ b/sound/soc/ti/edma-pcm.c
> @@ -43,14 +43,12 @@ static const struct snd_pcm_hardware edma_pcm_hardware = {
>  static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
>  	.pcm_hardware = &edma_pcm_hardware,
>  	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> -	.compat_filter_fn = edma_filter_fn,

We can also remove the
#include <linux/edma.h>

as it is no longer needed.

>  	.prealloc_buffer_size = 128 * 1024,
>  };
>  
>  int edma_pcm_platform_register(struct device *dev)
>  {
> -	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config,
> -					SND_DMAENGINE_PCM_FLAG_COMPAT);
> +	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config, 0);
>  }
>  EXPORT_SYMBOL_GPL(edma_pcm_platform_register);
>  
> diff --git a/sound/soc/ti/sdma-pcm.c b/sound/soc/ti/sdma-pcm.c
> index 21a9c2499d48..3e83a3920dc7 100644
> --- a/sound/soc/ti/sdma-pcm.c
> +++ b/sound/soc/ti/sdma-pcm.c
> @@ -31,7 +31,6 @@ static const struct snd_pcm_hardware sdma_pcm_hardware = {
>  static const struct snd_dmaengine_pcm_config sdma_dmaengine_pcm_config = {
>  	.pcm_hardware = &sdma_pcm_hardware,
>  	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> -	.compat_filter_fn = omap_dma_filter_fn,

Here we can remove the
#include <linux/omap-dmaengine.h>

>  	.prealloc_buffer_size = 128 * 1024,
>  };
>  
> @@ -39,13 +38,12 @@ int sdma_pcm_platform_register(struct device *dev,
>  			       char *txdmachan, char *rxdmachan)
>  {
>  	struct snd_dmaengine_pcm_config *config;
> -	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
> +	unsigned int flags = 0;
>  
>  	/* Standard names for the directions: 'tx' and 'rx' */
>  	if (!txdmachan && !rxdmachan)
>  		return devm_snd_dmaengine_pcm_register(dev,
> -						&sdma_dmaengine_pcm_config,
> -						flags);
> +						&sdma_dmaengine_pcm_config, 0);
>  
>  	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
>  	if (!config)
> @@ -65,7 +63,7 @@ int sdma_pcm_platform_register(struct device *dev,
>  	config->chan_names[0] = txdmachan;
>  	config->chan_names[1] = rxdmachan;
>  
> -	return devm_snd_dmaengine_pcm_register(dev, config, flags);
> +	return devm_snd_dmaengine_pcm_register(dev, config, 0);
>  }
>  EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
