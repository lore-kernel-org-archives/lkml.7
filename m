Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6087C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84150216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="W5XI/oK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfI3P60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:58:26 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:4456 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731919AbfI3P6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:58:25 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46hn7s5yWPz2J;
        Mon, 30 Sep 2019 17:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1569858988; bh=SM910taOzVBeIz8sDiWoqtsSpZFNnnEfHCLXVlJL+OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5XI/oK4TO+8usSOpDLLwIUD8EOfNsMD0XE8ds9ESj4IQs+D9zTxF9VT7DVuPZHVl
         9/AEZ4r7OVtdbseLYth+b7RMiIuY4oF0124m2klhObq/VnGS+5a7s4aYffBd2yL0Vb
         kdRZbmtDylWd8qGQpAsWP3LHRweacre6kmH+RX5Pt6+N3noLu+Vxv5Ti+Z0vPoKllq
         SB3g/Dlvj0Hm1X5luO32G8DQcoAGN+pkecnMYSBCY/vEpq+Z/YL7COPcPcBE5+nLW0
         z5Ljz3xu91ZoG3GdWQHa1K5LIdHE9xNwaqmAImLvdCdKAu08yv516uMZdQJxmh2vzb
         sBzrIyWPZ1LmA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 30 Sep 2019 17:58:19 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: atmel: Fix build error
Message-ID: <20190930155818.GA32237@qmqm.qmqm.pl>
References: <20190928081641.44232-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928081641.44232-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 04:16:41PM +0800, YueHaibing wrote:
> when do randbuilding, I got this error:
> 
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> (.text+0x12f6): undefined reference to `atmel_pcm_pdc_platform_register'
> 
> This is because SND_ATMEL_SOC_SSC_DMA=y, SND_ATMEL_SOC_SSC=y,
> but SND_ATMEL_SOC_SSC_PDC=m. Fix it bt reintroducing the default Kconfig.

Defaults won't forbid the invalid configuration. Can you try following:

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index f118c229ed82..461f023c5635 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -12,10 +12,12 @@ if SND_ATMEL_SOC
 config SND_ATMEL_SOC_PDC
 	tristate
 	depends on HAS_DMA
+	select SND_ATMEL_SOC_SSC
 
 config SND_ATMEL_SOC_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select SND_ATMEL_SOC_SSC
 
 config SND_ATMEL_SOC_SSC
 	tristate
@@ -24,7 +26,6 @@ config SND_ATMEL_SOC_SSC_PDC
 	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
 	depends on ATMEL_SSC
 	select SND_ATMEL_SOC_PDC
-	select SND_ATMEL_SOC_SSC
 	help
 	  Say Y or M if you want to add support for Atmel SSC interface
 	  in PDC mode configured using audio-graph-card in device-tree.
@@ -33,7 +34,6 @@ config SND_ATMEL_SOC_SSC_DMA
 	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
 	depends on ATMEL_SSC
 	select SND_ATMEL_SOC_DMA
-	select SND_ATMEL_SOC_SSC
 	help
 	  Say Y or M if you want to add support for Atmel SSC interface
 	  in DMA mode configured using audio-graph-card in device-tree.
