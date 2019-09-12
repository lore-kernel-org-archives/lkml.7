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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DDDC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A3E20840
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGMLqA+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfILXzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:55:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44044 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfILXzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:55:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so14269171pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T7BSUypNwre1fAFwesmjDN9junQB0DZurUQ7dcfihpM=;
        b=KGMLqA+9S193uykKYP1g338SZWE6VX2GBpIzq0AkInh392UupWvTerKl+5SlUdyTzz
         XwOJLT2M0xyMpTXXdAzTKpgqDKSmkzD67ZrQ3LiAg4yc7HfBaw/fky0gLGdxJqDG72Q1
         fR4iWcxFtGyBpGpw7t/gFBFB0S3JrCq4j+06fT58EFEU9okyUNCQwDAPNr3+YoWBsfz1
         SyHz4g3mxIoEIOZIZDgQrEIlbJoSxEV3iZfe0GZQn4HncFDnRhepSLHN6xs2ogB5hdaO
         3nCtNZnSDfVSWBTvaj8NWO5d9iQdxZwki1KLVo4TfkAQD2VBCQ+zTBT9043nV4na3/Tu
         /uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7BSUypNwre1fAFwesmjDN9junQB0DZurUQ7dcfihpM=;
        b=Jq6mgcup9xEWE2afdGeriPGZAkyu6q6wkba8OKYdL7s2CSYm8QYnOPKYV7K4rvS/OX
         aHfnlWyNmCoGdMQI6cwEbeV9tyja8RiIAAzEX7l8WNGrfsaBZw2jXsBYw5seGMA31JM6
         NfQ4iSpDOx/rqgUlADvbtFC1hu8+pOMpFJ0XF2ce7yArQbYOQLIV3yUpVjkNHiYUpRFX
         r0alpRLWLgB5Y0mwEzPWes7rpEhnzQkN4NBem4+wbWAMNQ19ttArRxnDO0O8Ni5J9P1u
         I/D9NJcIGgYJM/IaRlH4gvItm7VOFOGtAvOa6b7G6xWdSZ1WNhlRgmmI+3UyLhz54AtF
         CWLA==
X-Gm-Message-State: APjAAAW3O6vQU4dnL2Cg51O/GfNKUjc1qzCO5BqFCTHgTEDK8x+GE7cj
        RqG5VrB476l3BK5cK82xBdA=
X-Google-Smtp-Source: APXvYqxd3HfuYstwynQJibP1ASKMlPK6lONo6c3uSBbgYJAkuEQve5IJTEE5AetFeHQiNVnFYyMTrQ==
X-Received: by 2002:a17:90a:a6e:: with SMTP id o101mr1548500pjo.71.1568332513966;
        Thu, 12 Sep 2019 16:55:13 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j128sm35672488pfg.51.2019.09.12.16.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 16:55:13 -0700 (PDT)
Date:   Thu, 12 Sep 2019 16:54:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, festevam@gmail.com, shengjiu.wang@nxp.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio
Message-ID: <20190912235451.GF24937@Asurada-Nvidia.nvidia.com>
References: <20190830215910.31590-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830215910.31590-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 12:59:10AM +0300, Daniel Baluta wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> This is to allow machine drivers to set a certain bitclk rate
> which might not be exactly rate * frame size.
> 
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 21 +++++++++++++++++++--
>  sound/soc/fsl/fsl_sai.h |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index fe126029f4e3..e896b577b1f7 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -137,6 +137,16 @@ static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
>  	return 0;
>  }
>  
> +static int fsl_sai_set_dai_bclk_ratio(struct snd_soc_dai *dai,
> +				      unsigned int ratio)
> +{
> +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
> +
> +	sai->bclk_ratio = ratio;
> +
> +	return 0;
> +}
> +
>  static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
>  		int clk_id, unsigned int freq, int fsl_dir)
>  {
> @@ -423,8 +433,14 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  		slot_width = sai->slot_width;
>  
>  	if (!sai->is_slave_mode) {
> -		ret = fsl_sai_set_bclk(cpu_dai, tx,
> -				slots * slot_width * params_rate(params));
> +		if (sai->bclk_ratio)
> +			ret = fsl_sai_set_bclk(cpu_dai, tx,
> +					       sai->bclk_ratio *
> +					       params_rate(params));
> +		else
> +			ret = fsl_sai_set_bclk(cpu_dai, tx,
> +					       slots * slot_width *
> +					       params_rate(params));
>  		if (ret)
>  			return ret;
>  
> @@ -640,6 +656,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>  }
>  
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> +	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
>  	.set_sysclk	= fsl_sai_set_dai_sysclk,
>  	.set_fmt	= fsl_sai_set_dai_fmt,
>  	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 3a3f6f8e5595..f96f8d97489d 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -177,6 +177,7 @@ struct fsl_sai {
>  	unsigned int mclk_streams;
>  	unsigned int slots;
>  	unsigned int slot_width;
> +	unsigned int bclk_ratio;
>  
>  	const struct fsl_sai_soc_data *soc_data;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
> -- 
> 2.17.1
> 
