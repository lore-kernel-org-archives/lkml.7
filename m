Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F46CC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E3F215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Nj72iYc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbfI3QBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:01:25 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:33706 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfI3QBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:01:25 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46hnCM37HJz2J;
        Mon, 30 Sep 2019 17:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1569859167; bh=UhfU17aR0sNYys0oVRGSuAA/hFA3bzjaPoMdvXhHiSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj72iYc/z5oBFvfSO6J2VcevkkHNftUuYSYYNlPVIFN10KCwA1SZB0EqQB6y2wV24
         ZQE0AuUJ3IRTvd//lcqlav5r0/bt8Oo4inE1oUcLwcVleeYKI5gxmJzxJ/FZFBTikf
         zIf3ellGpjWo/FAO4/ejQHvGJMZs4/vKYZFuibQLdE0Odv23S5Qrd1It0rkozCyhcs
         4ynhVaSIBYql+ybi81PttthYd2oiZhByYXXVQIojI9OzRFFtu1jz/v3J9SPmYoD3QA
         /GUmo9+K7B4DkDSwiNbw1tGdJcw5nmXgfHhiKBNQ0LdqpbE3jTJx+FMtv3c+KF9tNu
         LS6q0sL72okdQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 30 Sep 2019 18:01:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: atmel: Fix build error
Message-ID: <20190930160120.GB32237@qmqm.qmqm.pl>
References: <20190928081641.44232-1-yuehaibing@huawei.com>
 <20190930155818.GA32237@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190930155818.GA32237@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 05:58:18PM +0200, Micha³ Miros³aw wrote:
> On Sat, Sep 28, 2019 at 04:16:41PM +0800, YueHaibing wrote:
> > when do randbuilding, I got this error:
> > 
> > sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> > (.text+0x12f6): undefined reference to `atmel_pcm_pdc_platform_register'
> > 
> > This is because SND_ATMEL_SOC_SSC_DMA=y, SND_ATMEL_SOC_SSC=y,
> > but SND_ATMEL_SOC_SSC_PDC=m. Fix it bt reintroducing the default Kconfig.
> 
> Defaults won't forbid the invalid configuration. Can you try following:

Ah, no. This won't fix it - the dependency is the other way around:
SOC_SSC should depend on _PDC / _DMA.

> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index f118c229ed82..461f023c5635 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -12,10 +12,12 @@ if SND_ATMEL_SOC
>  config SND_ATMEL_SOC_PDC
>  	tristate
>  	depends on HAS_DMA
> +	select SND_ATMEL_SOC_SSC
>  
>  config SND_ATMEL_SOC_DMA
>  	tristate
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
> +	select SND_ATMEL_SOC_SSC
>  
>  config SND_ATMEL_SOC_SSC
>  	tristate
> @@ -24,7 +26,6 @@ config SND_ATMEL_SOC_SSC_PDC
>  	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
>  	depends on ATMEL_SSC
>  	select SND_ATMEL_SOC_PDC
> -	select SND_ATMEL_SOC_SSC
>  	help
>  	  Say Y or M if you want to add support for Atmel SSC interface
>  	  in PDC mode configured using audio-graph-card in device-tree.
> @@ -33,7 +34,6 @@ config SND_ATMEL_SOC_SSC_DMA
>  	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
>  	depends on ATMEL_SSC
>  	select SND_ATMEL_SOC_DMA
> -	select SND_ATMEL_SOC_SSC
>  	help
>  	  Say Y or M if you want to add support for Atmel SSC interface
>  	  in DMA mode configured using audio-graph-card in device-tree.
