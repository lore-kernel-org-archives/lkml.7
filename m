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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9985C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFEB20820
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MseIdCPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbfIFBYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 21:24:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46360 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbfIFBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:24:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so3139624pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVF2xhHbHg2j29LblU1CgBEDCkpvcBZ4AEHewXas5gw=;
        b=MseIdCPTJrTQJXOW2UzidBAhUmOeTrXnBtOR+3fZX0Z7OI2kykLR9y//15fPmkKV9a
         jR/BczxeqD7rUjgQQtjkNUcxys3QOUJc7m8djl78qIGtAVV9LZ6bm9aWXdUCqLgInU6o
         i9r57ZkOn4/OhHPgZ5D3aGFe0fmySrPPszYeYdqfpbD/SDAyfBbzX/yXBFHXcpGU0IKo
         GfLNTt5RHSp9N+2sNsG4vC44jSkL6ecF30cXzAYX5XPTNB2vJC2ShzAre40QKDu+lAKf
         fvN95tMY86KO3LdrIPbdYE/dMaKSziOm04axHBWu3fD3UGgRb4ouDRgQ4KIgNpgnrbRg
         H4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVF2xhHbHg2j29LblU1CgBEDCkpvcBZ4AEHewXas5gw=;
        b=JrgpTKGj1LkewhhJYg+Ky/9HLUKl2xdZW9iIRQj2b42GVDBKBtFum+sr9UozOylGQY
         NFIu9kbozFJcwSI4S8BcVPKsl56VzcAkECoeWRTJQE0Qc5X/M9lSlm2nidt5/uniev/B
         0uQlr43Xqca8DrMOs6ZPKrDWwJ672r4DiPwVwT146DFe5H4GiW2GSnT7msgT1a7PRzox
         pQt0APZ7umxlt9UNjEDKH8beUNP4FdTqkTSCZvQIYRmZbNJ89kJJOufIr9wa/mBLNj7o
         Gz6/X0VGA7u/kVEf/VRxntsjiW9PyQPk6GEZ+Df115H3gGWrdQ20aoE+0hxUA+1kDPQb
         AGzw==
X-Gm-Message-State: APjAAAUmfv03+Sy3rtxKAosoKz9+q/kv+Fej00QmL4/qWwQYsbyzV5MK
        bqvXdIjrbToCzANYA5BYLEs=
X-Google-Smtp-Source: APXvYqwqglByW+NsVpmNz31XHRSPZh2xUQuRAXEuUO67Oz/RsBaNjU+V97Dds8Akz3dZzec4uAhMGg==
X-Received: by 2002:a62:26c4:: with SMTP id m187mr7721569pfm.49.1567733075155;
        Thu, 05 Sep 2019 18:24:35 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r18sm3222688pfc.3.2019.09.05.18.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 18:24:34 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:24:39 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, festevam@gmail.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        mihai.serban@gmail.com, Mihai Serban <mihai.serban@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix noise when using EDMA
Message-ID: <20190906012438.GA17926@Asurada-Nvidia.nvidia.com>
References: <20190830200900.19668-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830200900.19668-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:09:00PM +0300, Daniel Baluta wrote:
> From: Mihai Serban <mihai.serban@nxp.com>
> 
> EDMA requires the period size to be multiple of maxburst. Otherwise the
> remaining bytes are not transferred and thus noise is produced.
> 
> We can handle this issue by adding a constraint on
> SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.
> 
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
>  sound/soc/fsl/fsl_sai.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 728307acab90..fe126029f4e3 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -612,6 +612,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  			   FSL_SAI_CR3_TRCE_MASK,
>  			   FSL_SAI_CR3_TRCE);
>  
> +	/*
> +	 * some DMA controllers need period size to be a multiple of
> +	 * tx/rx maxburst
> +	 */
> +	if (sai->soc_data->use_constraint_period_size)
> +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> +					   tx ? sai->dma_params_tx.maxburst :
> +					   sai->dma_params_rx.maxburst);

I feel that PERIOD_SIZE could be used for some other cases than
being related to maxburst....
  
>  static const struct of_device_id fsl_sai_ids[] = {
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index b89b0ca26053..3a3f6f8e5595 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -157,6 +157,7 @@
>  
>  struct fsl_sai_soc_data {
>  	bool use_imx_pcm;
> +	bool use_constraint_period_size;

....so maybe the soc specific flag here could be something like
	bool use_edma;

What do you think?
