Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4340BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09492206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Caqvmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfIPXC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:02:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43711 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfIPXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:02:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so826196pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zVZMG9z5pOOWsp+4vryQ3AVq4ZgEgRNgNwh9Yk2ZT+4=;
        b=P4CaqvmfTJiHNJO9wvGMONhYF8QCRruZiUbvOv7eD+OsZAkrSPW3Wj95W2ejCOZ17Z
         DeJmyZCx3s8319SlQznas6nij08GI5050re9gEXIX2B5/ceNAcKTWUIUTrDOE9MvPyGK
         6LB1K/SF6KvdufDR8JzZb2mVWHZPk5tZmR6/p7Y2dsQsnueP1644ZKP7q4MYTGP6pnyY
         zTnF3zxBKoFiMf6Kw+muoffaix9BJfc0H8OAUiHT4HPgzg8TZkelODeMIEQwI3a0z+X5
         41BjnYXj73Xx5Z50fdIf8ygkFEskWPvHmzFKpE6Mm/IfrjOmQ2VoLCPcQFuzl2crFtl2
         HJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVZMG9z5pOOWsp+4vryQ3AVq4ZgEgRNgNwh9Yk2ZT+4=;
        b=SBZBZ2OCsNOnXpyGCDZTPNyCarlJ2PQ2X1uivZhaasDOjVuY7i0Mk6xAT2SW2V0lEL
         lkpIPdjI4XOW/x3CSIUEd+8qtmK7LJWgeCrF8Vo0w2WledGJBRXVwCef84jEiXzT6zrm
         AB2ApRNs+j1X/Dj3BfFuXounozUOkrB+fLhvxx0u41W01OGrg1/iBfkFxDRgmrK2itHU
         rpsW3o43aLeB8wnRzOZnpyc6/zLZJZKDTZwOUMZBnBVG3LmDNOLqLiNFUlNHGd1oh1h1
         kMGXtwUpjIV/V20VzYd1Txk0dyXIeN9GlA0/25NPIDPskWs/3I2IQFJKUWmr5dlgLJUl
         uD1w==
X-Gm-Message-State: APjAAAXU/iaPxHj4eA47ZVVmxp4cN28lv2iEQFxmvfAqZqq/rCzSclR5
        3ufe9pGUFZRaOZeablSksV4=
X-Google-Smtp-Source: APXvYqyI+GrdW76zWGlfFpAovO27klH6xywoh8iOMh5248anIQ+h5SBGw7socHr707LnWWs6a1Cz5A==
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr1707964pja.73.1568674944944;
        Mon, 16 Sep 2019 16:02:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r187sm173925pfc.105.2019.09.16.16.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 16:02:24 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:02:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 2/3] ASoC: fsl_sai: Fix xMR setting in synchronous mode
Message-ID: <20190916230205.GC12789@Asurada-Nvidia.nvidia.com>
References: <20190913192807.8423-1-daniel.baluta@nxp.com>
 <20190913192807.8423-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913192807.8423-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 10:28:06PM +0300, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> When Tx is synchronous with receiver the RMR should not be changed.
> When Rx is synchronous with transmitter the TMR should not be changed.

Would you please explain why and what bug this patch fixes?
We might want to Cc stable kernel too if it's a useful fix.

Thank you.
 
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
> * new patch
> 
>  sound/soc/fsl/fsl_sai.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b517e4bc1b87..6598a1ae0a2d 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -482,8 +482,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  			regmap_update_bits(sai->regmap, FSL_SAI_TCR5(ofs),
>  				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
>  				FSL_SAI_CR5_FBT_MASK, val_cr5);
> -			regmap_write(sai->regmap, FSL_SAI_TMR,
> -				~0UL - ((1 << channels) - 1));
>  		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
>  			regmap_update_bits(sai->regmap, FSL_SAI_RCR4(ofs),
>  				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
> @@ -491,8 +489,6 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  			regmap_update_bits(sai->regmap, FSL_SAI_RCR5(ofs),
>  				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
>  				FSL_SAI_CR5_FBT_MASK, val_cr5);
> -			regmap_write(sai->regmap, FSL_SAI_RMR,
> -				~0UL - ((1 << channels) - 1));
>  		}
>  	}
>  
> -- 
> 2.17.1
> 
