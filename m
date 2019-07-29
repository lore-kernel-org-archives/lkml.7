Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB52C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB4720679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2bEtTKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfG2UVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:21:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46595 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfG2UVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:21:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so5446564pfa.13;
        Mon, 29 Jul 2019 13:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6re2IOy9UuGPutWHpeGmXvl/6Yqi6FxHUujTvDV/BjQ=;
        b=V2bEtTKvIsIZP7A1vJKuVqPpf7homhWyKeJgc0gsY5Z3kXNvZlP58HtatQ2APTHTQL
         w/yt1hQJSg5pQ8g7O8I+F5FjAHS+wqDRDwU9COzkhvC72JlHa8fTfT+GuFGPm4JCenk+
         YIA6hQJykR5s4FxUuMqNlbBI6QxKAhY93l2iHCHqYlXQwUn6IrYjlmFNWIF1bw/g6Pwc
         15OsgbiVs+8hC61RgeXG5KfunptQicwUnYVKZKQ1iSdD8P6X7MMT+r5xyGhnkvZjE60I
         gFFkwH4Lmojxh4FbeDcEL3/ZaumoV+Ue1iQmfQObzj4OGWcwlNY5c8w3ZNdOABpWWPwf
         4L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6re2IOy9UuGPutWHpeGmXvl/6Yqi6FxHUujTvDV/BjQ=;
        b=AX7X0OD+ElxjMiweQO3Fu8gFJBeoMzcK+BxEShOSj7bzOE4T/GlcvM4gbIDQ0QtQEo
         mf8NuhqU+4bvEYpa913EDc2+on6vH/zrWgFuxrni5BimxyAs+Gob/jjUYCD1JNQ8Eyk0
         3VAWtzc+zVuAbKaXPdzefSvEyXhAqREKu86ub2xtV/QsrBKBerXoSPwUBxcNmxK9Mvh2
         g7M0dPubZWuL31puvzZa7V+2OhDLlsT6Z6xF80ZkuVTfM0Hq2WNMfQO2HsJOWtDBHcBu
         wuZ+qhYZAGhAeU607go51bwwJ8j1et4CGZdx6+6yiQtf9/PPNY0Db24NYYoZC6WbtdB0
         lcGw==
X-Gm-Message-State: APjAAAV8kRDdEfKWcYKKEIPKh7KUQyvLjmf0/dP3C+Db7XFj8mT0GFXi
        HJug3yFy1aJbwVLchEtk7rM=
X-Google-Smtp-Source: APXvYqyWLQm4Cgt5unABdbXidAVUUD4LbAvUUcL7RPKc8STUBXVR75FNm4vHlTcuIbVnqszh/IXkPg==
X-Received: by 2002:a65:6846:: with SMTP id q6mr67264436pgt.150.1564431666039;
        Mon, 29 Jul 2019 13:21:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d129sm67610834pfc.168.2019.07.29.13.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 13:21:05 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:21:54 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 3/7] ASoC: fsl_sai: Add support to enable multiple
 data lines
Message-ID: <20190729202154.GC20594@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-4-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-4-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:24:25PM +0300, Daniel Baluta wrote:
> SAI supports up to 8 Rx/Tx data lines which can be enabled
> using TCE/RCE bits of TCR3/RCR3 registers.
> 
> Data lines to be enabled are read from DT fsl,dl-mask property.
> By default (if no DT entry is provided) only data line 0 is enabled.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 11 ++++++++++-
>  sound/soc/fsl/fsl_sai.h |  4 +++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 637b1d12a575..5e7cb7fd29f5 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  
>  	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
>  			   FSL_SAI_CR3_TRCE_MASK,
> -			   FSL_SAI_CR3_TRCE);
> +			   FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
>  
>  	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
>  			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
> @@ -888,6 +888,15 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * active data lines mask for TX/RX, defaults to 1 (only the first
> +	 * data line is enabled
> +	 */
> +	sai->dl_mask[RX] = 1;
> +	sai->dl_mask[TX] = 1;
> +	of_property_read_u32_index(np, "fsl,dl-mask", RX, &sai->dl_mask[RX]);
> +	of_property_read_u32_index(np, "fsl,dl-mask", TX, &sai->dl_mask[TX]);

Just curious what if we enable 8 data lines through DT bindings
while an audio file only has 1 or 2 channels. Will TRCE bits be
okay to stay with 8 data channels configurations? Btw, how does
DMA work for the data registers? ESAI has one entry at a fixed
address for all data channels while SAI seems to have different
data registers.
