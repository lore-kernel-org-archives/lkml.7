Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9C5C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651CF21670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYTlY74K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfIPWtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:49:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44887 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfIPWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:49:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so803875pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kENGSqKmUqPPdpHJ6m4GwChtS1EbaBEMgzUsVpqeX1U=;
        b=KYTlY74KGSWbho4hQT1Kz82jdfOZ08vd1IhAQfCPuEcB4xZTP3z/C9rAnkmFp1JoAo
         gedBCFiDQTnXsZgbXrBCiGGdkSJFfPq+XWVE54HBL8CTVR0AEkyFd/QTUPKZVNXBe9Fd
         QcFCPfmbvXIuaqCeeDI/lnLsMwthaUuTCxCLyK+MoF8FOWi0NgdgQtB9UJ9rzf9SBd8p
         Zl8rVKIOO7ORISi5P5uJ/ZtceGBrc7H8r7zT2AwfU2IgYkhh59k19jRWxDduIOeZJmyu
         v/pqhBQ1+LnLnNNNo4JhWPg/zHc+OBwamLbmzEuVnMjQNwp/xio4ydA3yBFeSRplafn8
         6YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kENGSqKmUqPPdpHJ6m4GwChtS1EbaBEMgzUsVpqeX1U=;
        b=TDjad5mHjY4ceZpZDkSCNY1fsIbJ9NDQ+P6FlTtU5nBLHLQHzAYfP1QUH/FzWY0aqK
         lDXOmQeFmQxGDi6tawgIbdl+oxe9/EOx8yuSDJC33sVZarpDG1Mn4bUpAm+EaDZkcPpi
         W+7WaGn7aeLU+B1mtfAj2rnfxSYD1sJjV2TpBqdbDxqIkd82qDC5d3YiMB8s1Hac6nsi
         BuSZMcqYTV7+HMJS1v9+XEiwaTO34ZSp0qCW+jLdP7NpdZvr/gssC3Fy3YrMChJtvH/d
         i8ok0dtoQXVM3rVit3GOSbtH9Tuts07SNN0Thwv42kr12txWL2trgbZIUJqG14fIH/J5
         wQPg==
X-Gm-Message-State: APjAAAUXwrPJAXHhNkY7Yl3xusFfY8rHoiZ84vKmnad8mhgLTuN0XSXp
        0an7q54vDXkq86Xt8gXQ7BE=
X-Google-Smtp-Source: APXvYqwXeCRM152vISeSYObMSYFrVO5M8aKoHJ+Xbpqr49/LWf0mNi7lZ+lzTGlj/FuHFzmkelX9vA==
X-Received: by 2002:a62:1b85:: with SMTP id b127mr813216pfb.56.1568674164260;
        Mon, 16 Sep 2019 15:49:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l23sm118212pgj.53.2019.09.16.15.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 15:49:24 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:49:05 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mihai Serban <mihai.serban@nxp.com>
Subject: Re: [PATCH v2 1/3] ASoC: fsl_sai: Fix noise when using EDMA
Message-ID: <20190916224905.GB12789@Asurada-Nvidia.nvidia.com>
References: <20190913192807.8423-1-daniel.baluta@nxp.com>
 <20190913192807.8423-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913192807.8423-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 10:28:05PM +0300, Daniel Baluta wrote:
> From: Mihai Serban <mihai.serban@nxp.com>
> 
> EDMA requires the period size to be multiple of maxburst. Otherwise the
> remaining bytes are not transferred and thus noise is produced.
> 
> We can handle this issue by adding a constraint on
> SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.
> 
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
> Changes since v1:
> * rename variable to use_edma as per Nicolin's suggestion.
> 
>  sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
>  sound/soc/fsl/fsl_sai.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index ef0b74693093..b517e4bc1b87 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -628,6 +628,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  			   FSL_SAI_CR3_TRCE_MASK,
>  			   FSL_SAI_CR3_TRCE);
>  
> +	/*
> +	 * EDMA controller needs period size to be a multiple of
> +	 * tx/rx maxburst
> +	 */
> +	if (sai->soc_data->use_edma)
> +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> +					   tx ? sai->dma_params_tx.maxburst :
> +					   sai->dma_params_rx.maxburst);
> +
>  	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
>  			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
>  
> @@ -1026,30 +1036,35 @@ static int fsl_sai_remove(struct platform_device *pdev)
>  
>  static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
>  	.use_imx_pcm = false,
> +	.use_edma = false,
>  	.fifo_depth = 32,
>  	.reg_offset = 0,
>  };
>  
>  static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
>  	.use_imx_pcm = true,
> +	.use_edma = false,
>  	.fifo_depth = 32,
>  	.reg_offset = 0,
>  };
>  
>  static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
>  	.use_imx_pcm = true,
> +	.use_edma = false,
>  	.fifo_depth = 16,
>  	.reg_offset = 8,
>  };
>  
>  static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
>  	.use_imx_pcm = true,
> +	.use_edma = false,
>  	.fifo_depth = 128,
>  	.reg_offset = 8,
>  };
>  
>  static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
>  	.use_imx_pcm = true,
> +	.use_edma = true,
>  	.fifo_depth = 64,
>  	.reg_offset = 0,
>  };
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index b12cb578f6d0..76b15deea80c 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -157,6 +157,7 @@
>  
>  struct fsl_sai_soc_data {
>  	bool use_imx_pcm;
> +	bool use_edma;
>  	unsigned int fifo_depth;
>  	unsigned int reg_offset;
>  };
> -- 
> 2.17.1
> 
