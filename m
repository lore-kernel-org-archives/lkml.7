Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2929DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB57214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOkY2mEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfHGBRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:17:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39035 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfHGBRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:17:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so38483777pfn.6;
        Tue, 06 Aug 2019 18:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GV9JQ2WNxKL1bjWx+vcWnlZmSRoCTmSS+egaYnjbX4o=;
        b=OOkY2mECq07ay0Xkn5jKnjidQD7Y8rAbUg9yszwJK3KpW6U4gotRh9fOqwSowU5+w3
         JcKu2uOfiRVZU8AUaC25yzBkfW3T0nn0j43EDVl8MOnataHeQdj5vcF8HtYZM/82gsB1
         70bJuVf2VmFVX7KGZmLx4zx6CuDjpfDVMHaZfPzSuUBjAjXN2LlVLQ76C9PmPyIAF9JA
         fVfBlvx6TRx0j8TxbxthDg8nBHDi9khm2aqPPHODo10L5pGFFyCAM3umhlnFchlJxyi3
         Ycmnf72zDRGCVYXHcttAeOiovnJ2bnf+d3qRP1t29a4pnYk9br6LQ85uAFa4t986slHW
         ZnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GV9JQ2WNxKL1bjWx+vcWnlZmSRoCTmSS+egaYnjbX4o=;
        b=B8b4dl6Lj3+XWlUlNQ2aMR5ld1/looZJm0BjLnySIQZV5XD/yM/DFpOb3ksm6CHJ/9
         Y8n+4wlJffZ4jCky8Rr2xP5RU21sbZB95LWLvLx9QPzTIjIlI7ly7r+V1rlvCPXAfdFk
         dA9tBi0u/Zys8JqUBr3qClvel/Fv4CjWtPMYQqY73DLABMvvU/4q0lfIleRm7HRCyt0x
         2Y6FrhVcIMxu5j446V3Gb05pVlnULnZPJUmVJNwLrG5nAtydZGXNCjBC+wb7EaWsjpee
         tQouNNn/EQpBV0cSY2TuyZZfkwK24DuBb1tzCOe22H3dtwqX/LfRzjjsLyWnb0XceT6C
         ujhw==
X-Gm-Message-State: APjAAAWr3gaiXOsA2HUEZfxLyakRdZVBvbaftyWMsVuT4Av3u78rxtqQ
        R1s8u2nyxUD50DNnxpvACHg=
X-Google-Smtp-Source: APXvYqzHxmD8/7fJHI1GyT8D5iX+ET4Lx7na0hWQTte/JA6UCTeTD/qIcg8V0R6hoOtkUu8aYGy1Ig==
X-Received: by 2002:a63:5765:: with SMTP id h37mr5358736pgm.183.1565140624218;
        Tue, 06 Aug 2019 18:17:04 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n5sm94563063pfn.38.2019.08.06.18.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:17:03 -0700 (PDT)
Date:   Tue, 6 Aug 2019 18:17:59 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, timur@kernel.org,
        shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v3 2/5] ASoC: fsl_sai: Update Tx/Rx channel enable mask
Message-ID: <20190807011758.GE8938@Asurada-Nvidia.nvidia.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
 <20190806151214.6783-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806151214.6783-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:12:11PM +0300, Daniel Baluta wrote:
> Tx channel enable (TCE) / Rx channel enable (RCE) bits
> enable corresponding data channel for Tx/Rx operation.
> 
> Because SAI supports up the 8 channels TCE/RCE occupy
> up the 8 bits inside TCR3/RCR3 registers we need to extend
> the mask to reflect this.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 6 ++++--
>  sound/soc/fsl/fsl_sai.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 17b0aff4ee8b..637b1d12a575 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -599,7 +599,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	int ret;
>  
> -	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
> +	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> +			   FSL_SAI_CR3_TRCE_MASK,
>  			   FSL_SAI_CR3_TRCE);
>  
>  	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> @@ -614,7 +615,8 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  
> -	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> +	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> +			   FSL_SAI_CR3_TRCE_MASK, 0);
>  }
>  
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 4bb478041d67..20c5b9b1e8bc 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -110,6 +110,7 @@
>  
>  /* SAI Transmit and Receive Configuration 3 Register */
>  #define FSL_SAI_CR3_TRCE	BIT(16)
> +#define FSL_SAI_CR3_TRCE_MASK	GENMASK(23, 16)
>  #define FSL_SAI_CR3_WDFL(x)	(x)
>  #define FSL_SAI_CR3_WDFL_MASK	0x1f
>  
> -- 
> 2.17.1
> 
