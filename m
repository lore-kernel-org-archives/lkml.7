Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3469AC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DFF20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONE2qNZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfILXVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:21:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33386 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:21:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so14275737pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cfuHGRLy8MAHGaooaO76at7ZU9RjLSy1/AcY20LrGz4=;
        b=ONE2qNZwg1741FDo5uEQ6I8c64u77O4PBT6nDWoToKFs6XNpmkauOrIGsen+NFNWKV
         jnR3QuBhnGS5ogeZOBXO3uWj3PKtpde7DFGXDS/gy45S0MkhYg2ZuZ9tv47GxHKEI7Lm
         QLla4db4MBry4fMHaZZMlkvF0xn1ZZuwm6y9BBwMsE9lUfdgzhnKGA2vsvmMM6NkIgf4
         +ShG8+gSO1V0hQ05HgVVq8DvxRSgxHt/4hovXdKNTn/jlkN68suNPxf1HU5OqtaQp7Lu
         Eb9d59lkxDWy37PUJEsfFg3NJ9jo02AgM95Uf+Vlm0ycnPx9idp4tkBe/+ceowtOg3tn
         URIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfuHGRLy8MAHGaooaO76at7ZU9RjLSy1/AcY20LrGz4=;
        b=qBFWL3sQJ6SZgRj5YVSnKhw2YMZuB9ZbLuIJPTdqCavKzzr+rZXV6zhJbkph7lbVkR
         cp6fBzEB7lr0mvc11SjChbYKOZ/ENQZSQ3uVcR3PRhSz4pgVhx5yHKXQM+THDk8bhPDc
         cMx78N4rPm2TvQmKaQ6zhULUJ1d1Dq/WZ9C/VvS4qz4uLl6O+yoIzQwOFCFqO+Mt4u/l
         D+UrMzyE6noqdTgQD88N9XU82+1m0AzDSLLmcDOixYBOmP3s4O9YFlX7SU3u9u9GatGS
         z2OtdJ7+VYM2iGKAcIiRva42eReaevQ4tUVnHcziYj147wBjlOuAThGgYnq4/DZjjmoQ
         8MhA==
X-Gm-Message-State: APjAAAVc/FyDYVkuFOPh16pbN+4WkVULiCRN0GftXCGtzCdqUG3ae3Gi
        irb2vksyfxP0ckrYapxJvsw=
X-Google-Smtp-Source: APXvYqzZIQm+h/0QNu9dg8DnY8zWPNl00lnNgKtEEAubibhAR2pxRqBWHKTo9/jS0PgzYsyCyzRRkQ==
X-Received: by 2002:a63:4824:: with SMTP id v36mr13497605pga.385.1568330502215;
        Thu, 12 Sep 2019 16:21:42 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id l62sm42479694pfl.167.2019.09.12.16.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 16:21:41 -0700 (PDT)
Date:   Thu, 12 Sep 2019 16:21:20 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: fsl_asrc: Use in(out)put_format instead of
 in(out)put_word_width
Message-ID: <20190912232119.GB24937@Asurada-Nvidia.nvidia.com>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
 <65e96ca15afd4a282b122f3ea8b13642cf4614c7.1568025083.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e96ca15afd4a282b122f3ea8b13642cf4614c7.1568025083.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:33:19PM -0400, Shengjiu Wang wrote:
> snd_pcm_format_t is more formal than enum asrc_word_width, which has
> two property, width and physical width, which is more accurate than
> enum asrc_word_width. So it is better to use in(out)put_format
> instead of in(out)put_word_width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c | 56 +++++++++++++++++++++++++++-------------
>  sound/soc/fsl/fsl_asrc.h |  4 +--
>  2 files changed, 40 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index cfa40ef6b1ca..4d3804a1ea55 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -265,6 +265,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	struct asrc_config *config = pair->config;
>  	struct fsl_asrc *asrc_priv = pair->asrc_priv;
>  	enum asrc_pair_index index = pair->index;
> +	enum asrc_word_width input_word_width;
> +	enum asrc_word_width output_word_width;
>  	u32 inrate, outrate, indiv, outdiv;
>  	u32 clk_index[2], div[2];
>  	int in, out, channels;
> @@ -283,9 +285,32 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> -	/* Validate output width */
> -	if (config->output_word_width == ASRC_WIDTH_8_BIT) {
> -		pair_err("does not support 8bit width output\n");
> +	switch (snd_pcm_format_width(config->input_format)) {
> +	case 8:
> +		input_word_width = ASRC_WIDTH_8_BIT;
> +		break;
> +	case 16:
> +		input_word_width = ASRC_WIDTH_16_BIT;
> +		break;
> +	case 24:
> +		input_word_width = ASRC_WIDTH_24_BIT;
> +		break;
> +	default:
> +		pair_err("does not support this input format, %d\n",
> +			 config->input_format);
> +		return -EINVAL;
> +	}
> +
> +	switch (snd_pcm_format_width(config->output_format)) {
> +	case 16:
> +		output_word_width = ASRC_WIDTH_16_BIT;
> +		break;
> +	case 24:
> +		output_word_width = ASRC_WIDTH_24_BIT;
> +		break;
> +	default:
> +		pair_err("does not support this output format, %d\n",
> +			 config->output_format);
>  		return -EINVAL;
>  	}
>  
> @@ -383,8 +408,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	/* Implement word_width configurations */
>  	regmap_update_bits(asrc_priv->regmap, REG_ASRMCR1(index),
>  			   ASRMCR1i_OW16_MASK | ASRMCR1i_IWD_MASK,
> -			   ASRMCR1i_OW16(config->output_word_width) |
> -			   ASRMCR1i_IWD(config->input_word_width));
> +			   ASRMCR1i_OW16(output_word_width) |
> +			   ASRMCR1i_IWD(input_word_width));
>  
>  	/* Enable BUFFER STALL */
>  	regmap_update_bits(asrc_priv->regmap, REG_ASRMCR(index),
> @@ -497,13 +522,13 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
>  				  struct snd_soc_dai *dai)
>  {
>  	struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
> -	int width = params_width(params);
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct fsl_asrc_pair *pair = runtime->private_data;
>  	unsigned int channels = params_channels(params);
>  	unsigned int rate = params_rate(params);
>  	struct asrc_config config;
> -	int word_width, ret;
> +	snd_pcm_format_t format;
> +	int ret;
>  
>  	ret = fsl_asrc_request_pair(channels, pair);
>  	if (ret) {
> @@ -513,15 +538,10 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
>  
>  	pair->config = &config;
>  
> -	if (width == 16)
> -		width = ASRC_WIDTH_16_BIT;
> -	else
> -		width = ASRC_WIDTH_24_BIT;
> -
>  	if (asrc_priv->asrc_width == 16)
> -		word_width = ASRC_WIDTH_16_BIT;
> +		format = SNDRV_PCM_FORMAT_S16_LE;
>  	else
> -		word_width = ASRC_WIDTH_24_BIT;
> +		format = SNDRV_PCM_FORMAT_S24_LE;
>  
>  	config.pair = pair->index;
>  	config.channel_num = channels;
> @@ -529,13 +549,13 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
>  	config.outclk = OUTCLK_ASRCK1_CLK;
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		config.input_word_width   = width;
> -		config.output_word_width  = word_width;
> +		config.input_format   = params_format(params);
> +		config.output_format  = format;
>  		config.input_sample_rate  = rate;
>  		config.output_sample_rate = asrc_priv->asrc_rate;
>  	} else {
> -		config.input_word_width   = word_width;
> -		config.output_word_width  = width;
> +		config.input_format   = format;
> +		config.output_format  = params_format(params);
>  		config.input_sample_rate  = asrc_priv->asrc_rate;
>  		config.output_sample_rate = rate;
>  	}
> diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
> index c60075112570..38af485bdd22 100644
> --- a/sound/soc/fsl/fsl_asrc.h
> +++ b/sound/soc/fsl/fsl_asrc.h
> @@ -342,8 +342,8 @@ struct asrc_config {
>  	unsigned int dma_buffer_size;
>  	unsigned int input_sample_rate;
>  	unsigned int output_sample_rate;
> -	enum asrc_word_width input_word_width;
> -	enum asrc_word_width output_word_width;
> +	snd_pcm_format_t input_format;
> +	snd_pcm_format_t output_format;
>  	enum asrc_inclk inclk;
>  	enum asrc_outclk outclk;
>  };
> -- 
> 2.21.0
> 
