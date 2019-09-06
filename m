Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958B1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E420820
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLxnr0JE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391898AbfIFB3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 21:29:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40683 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbfIFB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:29:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so2490282pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 18:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sEoTtCVr37b7oXmy+gvoKkzJJnuSTqH0meQQ6053Wm4=;
        b=LLxnr0JE4Z4CWrSnhcqlNRIC2d8xEpNueechntqus1WAPdfNrw5vi3KN8zSMRtZ9E7
         aiTRmWCIcAcaTcaXfN4XbZ6EZrXp4zlDDTiWQOjZsQweSHyJzpkHAi+Ao2GvyXunQbN1
         Kk7/QAmX0s5sR0H7znd19wpx1vXZb8JaMW/juvG7WTA9XhpCY3FUMDvzizXjkmq0kPuc
         Hkpd7MNdtnidTUxu9nttF4wZB3fIbKAqGk2eKY47VYtYOwXkiM+vPA3kglKUjcDWiM2j
         mw7Iy+MOWOwIGrpmJGXgafZE/6w+xV2uwWRS4azhU2JRux5BwJd4zwmAgpdydGabvwbq
         1u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEoTtCVr37b7oXmy+gvoKkzJJnuSTqH0meQQ6053Wm4=;
        b=pnZLKpeHINzNt55CiGPt1fooXImSVdrv0DYJwXRetIGwWHx7paJhu8otR9rlzTt9e5
         VI43QY9d9u+FnnGjYymvJP6MC1T6k+YZmjSa7rmfK4Cn8W6C65X/B7Wu1/3nBWFdvH96
         HJuLuhE1GBYASsfKN2Njrie8x5wE+7EqTpKf4ob0YjqdLECF0S9DYjcSEHygiGHO/ySz
         vJ6T+b06GUkM5il1ln0UAMJpBPRx35f64ZgWL8WdgPHDpiln+bRif9TKmKRSscz0f/Yu
         Pw+rEakVCivoVFm7Gczk4PYGg1OrnunNv3ksBnlvypE9id3XlVlZgPZC+IccgxZXB/66
         fY7w==
X-Gm-Message-State: APjAAAU0GtfNCjlUTLcOxAoqYDbA+UTEGj8ibPHzt0KCWDSQ6uIafQA1
        6cW1iMpFVqYrm4kOUWsPqX4=
X-Google-Smtp-Source: APXvYqw34ECxlJhxS5GuecE+kJ5qkdhUN9hFocOlgPUycAu8bVz6ItjUepFxEW3gN0sCDl/W01/hOA==
X-Received: by 2002:a17:90a:3acf:: with SMTP id b73mr6434716pjc.88.1567733373322;
        Thu, 05 Sep 2019 18:29:33 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f188sm3327847pfa.170.2019.09.05.18.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 18:29:32 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:29:39 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, festevam@gmail.com, shengjiu.wang@nxp.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio
Message-ID: <20190906012938.GB17926@Asurada-Nvidia.nvidia.com>
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

Just a quick thought of mine: slot_width and slots could be
set via set_dai_tdm_slot() actually, while set_bclk_ratio()
would override that one with your change. I'm not sure which
one could be more important...so would you mind elaborating
your use case?

Thanks
Nicolin


> 
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
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
