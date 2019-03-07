Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE46C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBAB20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zOl2YEiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCGNZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:25:07 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60672 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfCGNZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:25:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x27DOjaA060156;
        Thu, 7 Mar 2019 07:24:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551965085;
        bh=wx9S9FneAAtyOWo7cyEpGImpazPzronaKuzmYxTQO7U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zOl2YEiO6XReaWoTcnK+C5CzQkl3x516UiVhMt8po7Yij+KD7eGTXRVQHopK9pHhY
         8U8IMZj/8XR1K826nMqtUAElj+jJ6kvsI0ljUoobFGYY4lOIKM6+Iws2bh3n0pk1Wq
         yKDLP5RBJtkJDRLaa7/fGVXhA9mtKgLNlBQZgmpo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x27DOjP0044342
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 07:24:45 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Mar 2019 07:24:45 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Mar 2019 07:24:45 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x27DOhvZ001540;
        Thu, 7 Mar 2019 07:24:43 -0600
Subject: Re: [PATCH 1/3] ASoC: ti: fix davinci_mcasp_probe dependencies
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20190304203114.1894822-1-arnd@arndb.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8e98c10d-cf71-296d-eeae-97a8ffc2b9d7@ti.com>
Date:   Thu, 7 Mar 2019 15:25:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190304203114.1894822-1-arnd@arndb.de>
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
> The SND_SOC_DAVINCI_MCASP driver can use either edma or sdma as
> a back-end, and it takes the presence of the respective dma engine
> drivers in the configuration as an indication to which ones should be
> built. However, this is flawed in multiple ways:
> 
> - With CONFIG_TI_EDMA=m and CONFIG_SND_SOC_DAVINCI_MCASP=y,
>   is enabled as =m, and we get a link error:
>   sound/soc/ti/davinci-mcasp.o: In function `davinci_mcasp_probe':
>   davinci-mcasp.c:(.text+0x930): undefined reference to `edma_pcm_platform_register'

In non randconfig case both edma and sdma DMAengine driver would be
built in so I did missed this for sure.

> - When CONFIG_SND_SOC_DAVINCI_MCASP=m has already been selected by
>   another driver, the same link error appears even if CONFIG_TI_EDMA
>   is disabled
> 
> There are possibly other issues here, but it seems that the only reasonable
> solution is to always build both SND_SOC_TI_EDMA_PCM and
> SND_SOC_TI_SDMA_PCM as a dependency here. Both are fairly small and
> do not have any other compile-time dependencies, so the cost is
> very small, and makes the configuration stage much more consistent.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Fixes: f2055e145f29 ("ASoC: ti: Merge davinci and omap directories")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/ti/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
> index 4bf3c15d4e51..ee7c202c69b7 100644
> --- a/sound/soc/ti/Kconfig
> +++ b/sound/soc/ti/Kconfig
> @@ -21,8 +21,8 @@ config SND_SOC_DAVINCI_ASP
>  
>  config SND_SOC_DAVINCI_MCASP
>  	tristate "Multichannel Audio Serial Port (McASP) support"
> -	select SND_SOC_TI_EDMA_PCM if TI_EDMA
> -	select SND_SOC_TI_SDMA_PCM if DMA_OMAP
> +	select SND_SOC_TI_EDMA_PCM
> +	select SND_SOC_TI_SDMA_PCM
>  	help
>  	  Say Y or M here if you want to have support for McASP IP found in
>  	  various Texas Instruments SoCs like:
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
