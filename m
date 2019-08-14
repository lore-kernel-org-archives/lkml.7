Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CB5C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F6E20679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf1bbFYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfHNBiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:38:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45703 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfHNBiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:38:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so52194978pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E9r2CKaxmujb7ntSffi+Z+EeKWCGq3B69sAfi5aF5qg=;
        b=mf1bbFYLx3M6P0kgQW6J6zV8FhHUY21KRmfmz2T5veeQ+8Lh4Tb632DNtV5PzizqEG
         d0UidxYQG1k3hb78mZNwvPt8+TM+L0SYrCPHRRbos4vNqOvdTMFN0pA2uMP1Gb3IHH0J
         LQzSnIisUgufPRAYjBAB9sp3lkbIVmlNY1O2jaLPUrXBpwitIOtH6mWwLgIXBew3tz8/
         /YH1jwNfphKKk1pT4yfoVz/NR1nvXpGTsECIzLOG6bNIZM2jj7k5EchUFudwdg8wXcn5
         M2eLcPL3C5Kciz2V/jrNSXmzo4PppvvcDgQML7nxL5at7quJ9VfXBjN9c6LUm2RCBW0n
         6zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E9r2CKaxmujb7ntSffi+Z+EeKWCGq3B69sAfi5aF5qg=;
        b=CZ8o1Zf9gJp5yh+V7vl5upm+S3T29OpIygNR+NuefvUq3oVgA+CevLBOa+3OAYd332
         Vgc5Ig+uKqj/CjNC9cJFtLW/depovGemofhKNEQ0oNv0VIGcaRqwDU827hvh6ouCkA8J
         yAK+6qmdG9Q2Es/XqvlyBj6vOxrMIkuExVDnWYL55hORafQAUbvlkdCNoSMG+BuyHffE
         MMAAydOxdKsa0DILUSgcXMqCKT6mcSmNJh7CWescmA7/PK9Px2M7bCXMrOr1NtORHDCH
         5zzhJmqOEGcu/BPbM/fZXHI4WJTr3DCMv597kD7MO8PsVltX/T33T4/Vms2yZQO6cNt3
         yPng==
X-Gm-Message-State: APjAAAUAahaqoNeqPK6bh7713ZmwEZBwOmFu8jR6NiIR9vTsAyUlfyO0
        UxdPWrApeNLoyzQL1uGM9Fg=
X-Google-Smtp-Source: APXvYqzXKOsatok399OUXkjXNqZajIPiVhATh4HYHbxZWpGXyxq/JKE1DQo26W2cxGqXsNk1FnA2wQ==
X-Received: by 2002:a17:90a:8a84:: with SMTP id x4mr4738103pjn.105.1565746695820;
        Tue, 13 Aug 2019 18:38:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c5sm9140567pfo.175.2019.08.13.18.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 18:38:15 -0700 (PDT)
Date:   Tue, 13 Aug 2019 18:39:16 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        festevam@gmail.com
Subject: Re: [RFC PATCH] ASoC: fsl_sai: Enable data lines based on input
 channels
Message-ID: <20190814013916.GB13398@Asurada-Nvidia.nvidia.com>
References: <20190811195545.32606-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811195545.32606-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 10:55:45PM +0300, Daniel Baluta wrote:
> An audio data frame consists of a number of slots one for each
> channel. In the case of I2S there are 2 data slots / frame.
> 
> The maximum number of SAI slots / frame is configurable at
> IP integration time. This affects the width of Mask Register.
> SAI supports up to 32 slots per frame.
> 
> The number of datalines is also configurable (up to 8 datalines)
> and affects TCE/RCE and the number of data/FIFO registers.
> 
> The number of needed data lines (pins) is computed as follows:
> 
> * pins = channels / slots.
> 
> This can be computed in hw_params function so lets move TRCE bits
> seting from startup to hw_params.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 34 +++++++++++++---------------------
>  sound/soc/fsl/fsl_sai.h |  2 +-
>  2 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 69cf3678c859..b70032c82fe2 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c

> @@ -480,13 +483,17 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,

> -	regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << channels) - 1));
> +	regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << slots) - 1));

Would this break mono channel audio?

>  static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)

> @@ -881,6 +872,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	sai->pdev = pdev;
> +

Seemly unnecessary
