Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08676C4740C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1C121670
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shhRrPrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfIJBwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:52:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33286 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfIJBwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:52:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so7684206plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qfJzXboXCRBNelkZrAt1/0iVQ/ZKJddQGja1BPXvviM=;
        b=shhRrPrhXyTGuEalYtMpzidF6Xec5xOUTNWtJZ8Aw9uAAWIAQzY+cVEcanTfT+K/7u
         4jPUgRAvrc7wBB/b/a/T25241nVrKuEmf3imAKfhq37779giWrBIH+aQ2Q7z+kpUtbu2
         ZmNynhByaa33d+K8JjQH3AhWwv55nS/MItOSJl0CGlaYtgycsCu7TbykdbDRYCcPcYSZ
         jWkZr1qAh/Y+VAs/oe5HhV4xjc0yKHTifQFFC5CXWW1G1TOS94Kr6fTKVDGgNG49aqJu
         4K3L/z9FH/1pyHqv9gFTjxMSgCna/iMDh99gcUv9dprDXwoaiTO+9AjXWe8XWgUDJCYz
         YdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qfJzXboXCRBNelkZrAt1/0iVQ/ZKJddQGja1BPXvviM=;
        b=ft62cOq8dRJ4/u03cr280cEPVp6n2RMoEK2mc3zm2oa/pSxHcu3u7W0VwOuiMOU732
         rymdgCdNKP41QxMr0t+6Gy1Cc+OVfGnN0Cu2e12h071WIrqkZI0/koKuwI32QQ9QSXHc
         cdLpXmunakdfWnqXDhcXkITbhoqcmwvM21iZWFG0H2kFgANmldbSNZnf2rrnGNjZEkFT
         Pu4POJ53tmmGmzI+uNS+IHPGXmIXx2X2hzUSplallZmIo1tNG7gPrMpRkhiVN9t8t6uu
         IuuCrAh5f24mPRvvECCMncDsmRnUSVCySoinvt2L5h3wMWe3A2GjAUxiTI5oM8zWST7N
         afTg==
X-Gm-Message-State: APjAAAVQ9Lp4Yjc2n4INPmWFQcp7sn0fcOcHZFxSNGwolZ+xeEfLEwXU
        5f8IlMLFLp4AIDG60YK9UpA=
X-Google-Smtp-Source: APXvYqysAsbMGI3zdULC6/X/imQskDG3HnEoqSyFcHk5MkIVU7u1IpRc4H845OVvdTppQVmg1Rq9Pg==
X-Received: by 2002:a17:902:5c3:: with SMTP id f61mr26049403plf.98.1568080359475;
        Mon, 09 Sep 2019 18:52:39 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 19sm714031pjc.25.2019.09.09.18.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Sep 2019 18:52:39 -0700 (PDT)
Date:   Mon, 9 Sep 2019 18:52:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190910015212.GA16760@Asurada-Nvidia.nvidia.com>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
 <2b6e028ca27b8569da4ab7868d7b90ff8c3225d0.1568025083.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6e028ca27b8569da4ab7868d7b90ff8c3225d0.1568025083.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:33:21PM -0400, Shengjiu Wang wrote:
> There is error "aplay: pcm_write:2023: write error: Input/output error"
> on i.MX8QM/i.MX8QXP platform for S24_3LE format.
> 
> In i.MX8QM/i.MX8QXP, the DMA is EDMA, which don't support 24bit
> sample, but we didn't add any constraint, that cause issues.
> 
> So we need to query the caps of dma, then update the hw parameters
> according to the caps.

> @@ -285,8 +293,81 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
>  
>  	runtime->private_data = pair;
>  
> -	snd_pcm_hw_constraint_integer(substream->runtime,
> -				      SNDRV_PCM_HW_PARAM_PERIODS);
> +	ret = snd_pcm_hw_constraint_integer(substream->runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set pcm hw params periods\n");
> +		return ret;
> +	}
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +
> +	/* Request a temp pair, which is release in the end */
> +	fsl_asrc_request_pair(1, pair);

Not sure if it'd be practical, but a pair request could fail. Will
probably need to check return value.

And a quick feeling is that below code is mostly identical to what
is in the soc-generic-dmaengine-pcm.c file. So I'm wondering if we
could abstract a helper function somewhere in the ASoC core: Mark?

Thanks
Nicolin

> +	tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
> +	if (!tmp_chan) {
> +		dev_err(dev, "can't get dma channel\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = dma_get_slave_caps(tmp_chan, &dma_caps);
> +	if (ret == 0) {
> +		if (dma_caps.cmd_pause)
> +			snd_imx_hardware.info |= SNDRV_PCM_INFO_PAUSE |
> +						 SNDRV_PCM_INFO_RESUME;
> +		if (dma_caps.residue_granularity <=
> +			DMA_RESIDUE_GRANULARITY_SEGMENT)
> +			snd_imx_hardware.info |= SNDRV_PCM_INFO_BATCH;
> +
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			addr_widths = dma_caps.dst_addr_widths;
> +		else
> +			addr_widths = dma_caps.src_addr_widths;
> +	}
> +
> +	/*
> +	 * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
> +	 * hw.formats set to 0, meaning no restrictions are in place.
> +	 * In this case it's the responsibility of the DAI driver to
> +	 * provide the supported format information.
> +	 */
> +	if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
> +		/*
> +		 * Prepare formats mask for valid/allowed sample types. If the
> +		 * dma does not have support for the given physical word size,
> +		 * it needs to be masked out so user space can not use the
> +		 * format which produces corrupted audio.
> +		 * In case the dma driver does not implement the slave_caps the
> +		 * default assumption is that it supports 1, 2 and 4 bytes
> +		 * widths.
> +		 */
> +		for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
> +			int bits = snd_pcm_format_physical_width(i);
> +
> +			/*
> +			 * Enable only samples with DMA supported physical
> +			 * widths
> +			 */
> +			switch (bits) {
> +			case 8:
> +			case 16:
> +			case 24:
> +			case 32:
> +			case 64:
> +				if (addr_widths & (1 << (bits / 8)))
> +					snd_imx_hardware.formats |= (1LL << i);
> +				break;
> +			default:
> +				/* Unsupported types */
> +				break;
> +			}
> +		}
> +
> +	if (tmp_chan)
> +		dma_release_channel(tmp_chan);
> +	fsl_asrc_release_pair(pair);
> +
>  	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
>  
>  	return 0;
> -- 
> 2.21.0
> 
