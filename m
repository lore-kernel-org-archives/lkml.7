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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB0EC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDF7206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0JrRL8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfHNBBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:01:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37551 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHNBBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:01:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so19344880pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 18:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NlE3r34RdoAVkEFP5Qhq0Z6vIQcskLB+6Ufwy9SSFTI=;
        b=j0JrRL8hUVa8eSrWSd015kpUe5PnEgpSdofsQeNyBnm5Y5CvJ1+Y9TonRPe3X16nIP
         Ht9o5VyuaIJ70Tq0slcqVnNfawSj9nVbjaxyT34apHEniHberD68us9KLKInA3396QkH
         L1W2GX4/pv5gelAE125H78NI1KqoVWabWuO0p9uJwmZGcJBgUjfFcgURSIDNl4/SaWuc
         kfmWz4JluAP/yxgopVTC9QTewX5OJtQ1sZd7jiRxviyS6rLljc3djHMU66sUg8imQBxL
         fVwSYGotTNCgEJcqokBDwewTlY9WBArfirzWjFBqAUQr11Mq+1wvheIgEo7C6TnydriM
         9nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NlE3r34RdoAVkEFP5Qhq0Z6vIQcskLB+6Ufwy9SSFTI=;
        b=IqlQVu7Ug+OK+wSijVUC+wkePAoMbXC3fa/ZjcKVD7grGQ8e4C55gTv9l6U9yA3qaZ
         vun0ko4M/xSo0BBfhPnwnQIE+/LWB3IBku8xUYwxI73QfZ3OWtYpBv9cRZomMYEGXoFQ
         MMVyfUYUO6tdO/NjDowWXyuYBdLOWRjuFzNS2xCiwbAUuCqaxDgXrdlmrW0mdEcgx1IJ
         SRiTXWwoQFSL1vzyHX/6zaYAnw4gbIx1Jz/bjOnVIY3uLlIhlHvK5R6sBR/oUmkLv+7R
         ODZpCIeneyw7TBjozjbVduRXdLpmZaSLGlz7bo1YqDuILjFmD0nLwSkj4oB8NefgFxU0
         1KZg==
X-Gm-Message-State: APjAAAU3qW+e5RcOYwNtHJPViaj+6KZySRGlxgkS4EWJ3IJFegoeH2gk
        vYumfTgLAWklo+jLaMAcy9W3fU7w
X-Google-Smtp-Source: APXvYqzwfcjX+A+jDK0pw8ha0TvDPFYa5JXWs5wev6iBxZ44rRGrF2DtI/VKTBQtAxYn6lFDxzxsIg==
X-Received: by 2002:a63:a35e:: with SMTP id v30mr35393993pgn.129.1565744476044;
        Tue, 13 Aug 2019 18:01:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h9sm120983074pgk.10.2019.08.13.18.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 18:01:15 -0700 (PDT)
Date:   Tue, 13 Aug 2019 18:02:15 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Handle slave mode per TX/RX direction
Message-ID: <20190814010215.GA13398@Asurada-Nvidia.nvidia.com>
References: <20190811194517.19314-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811194517.19314-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 10:45:17PM +0300, Daniel Baluta wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> The SAI interface can be a clock supplier or consumer
> as a function of stream direction. e.g SAI can be master
> for Tx and slave for Rx.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 18 +++++++++---------
>  sound/soc/fsl/fsl_sai.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 4a346fcb5630..69cf3678c859 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -273,18 +273,18 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,

This function is called for both TX and RX at the same time from
fsl_sai_set_dai_fmt() so I don't actually see how it can operate
in two opposite directions from this change alone. Anything that
I have missed?

Thanks
Nicolin

>  	case SND_SOC_DAIFMT_CBS_CFS:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> -		sai->is_slave_mode = false;
> +		sai->is_slave_mode[tx] = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFM:
> -		sai->is_slave_mode = true;
> +		sai->is_slave_mode[tx] = true;
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFM:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
> -		sai->is_slave_mode = false;
> +		sai->is_slave_mode[tx] = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFS:
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> -		sai->is_slave_mode = true;
> +		sai->is_slave_mode[tx] = true;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -326,7 +326,7 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
>  	int ret = 0;
>  
>  	/* Don't apply to slave mode */
> -	if (sai->is_slave_mode)
> +	if (sai->is_slave_mode[tx])
>  		return 0;
>  
>  	for (id = 0; id < FSL_SAI_MCLK_MAX; id++) {
> @@ -422,7 +422,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	if (sai->slot_width)
>  		slot_width = sai->slot_width;
>  
> -	if (!sai->is_slave_mode) {
> +	if (!sai->is_slave_mode[tx]) {
>  		ret = fsl_sai_set_bclk(cpu_dai, tx,
>  				slots * slot_width * params_rate(params));
>  		if (ret)
> @@ -458,7 +458,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	 * error.
>  	 */
>  
> -	if (!sai->is_slave_mode) {
> +	if (!sai->is_slave_mode[tx]) {
>  		if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
>  			regmap_update_bits(sai->regmap, FSL_SAI_TCR4(ofs),
>  				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
> @@ -497,7 +497,7 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
>  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  
> -	if (!sai->is_slave_mode &&
> +	if (!sai->is_slave_mode[tx] &&
>  			sai->mclk_streams & BIT(substream->stream)) {
>  		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
>  		sai->mclk_streams &= ~BIT(substream->stream);
> @@ -581,7 +581,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
>  			 * This is a hardware bug, and will be fix in the
>  			 * next sai version.
>  			 */
> -			if (!sai->is_slave_mode) {
> +			if (!sai->is_slave_mode[tx]) {
>  				/* Software Reset for both Tx and Rx */
>  				regmap_write(sai->regmap, FSL_SAI_TCSR(ofs),
>  					     FSL_SAI_CSR_SR);
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index b89b0ca26053..c2c43a7d9ba1 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -167,7 +167,7 @@ struct fsl_sai {
>  	struct clk *bus_clk;
>  	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
>  
> -	bool is_slave_mode;
> +	bool is_slave_mode[2];
>  	bool is_lsb_first;
>  	bool is_dsp_mode;
>  	bool synchronous[2];
> -- 
> 2.17.1
> 
