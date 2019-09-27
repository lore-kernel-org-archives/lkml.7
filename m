Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1262C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AD721848
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 01:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9jRo5ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfI0Byk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:54:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40095 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfI0Byk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 21:54:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so581352pfb.7;
        Thu, 26 Sep 2019 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jkv3+m25h7+mBhaDAmoi1fNnMKQwdsBy4HY8NW+mFDw=;
        b=r9jRo5iilNs2wTjYGE0eSV/p47GTFQWk4EutxtXr3Bcmzu2B+W8P2aA+zWEaQG3XpI
         q+vSIcrJCKg7pixYzCF1spux84sDxuwZJRfoBGT084K6gTz5zIkRZtrDN4YMHQPopUKX
         B61JV1lqcFDNK6jOs9Mf8k3uFulbefsTS/0H76qPF5eKIpuHQwtmhcEjBA9Al5WEl0Km
         tVZAPt23J+8MxX7V88vgWWe07RDsuuJHtlAvLVua2+UMP8f/azziJlTqrsVJNOkN0K5G
         CF7/ji92yJsZN3tG9o7/tNMZdSqOE8xjFP5EoGJBrNwCKwMQKXn2nqoQRSFFG0Y26OZo
         oGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jkv3+m25h7+mBhaDAmoi1fNnMKQwdsBy4HY8NW+mFDw=;
        b=LeWK70aoNzBpsOGfL736JvzJsTkHR7jV++4rWBwpNWr6fGSrjP6tlAXqtIAYCp0auv
         mGEF0Vf+/ZP5kXJiOlzGZwdrhanHh212qTY9a6aLJgrg/IyoV+QMt2JvPkA5NpLu4C/C
         aPDHQm1qFpXvab20U//bB3t+k8UuF7HT93Z6UkIbXIWjajb+sinZs/PexECi+aq+ET0l
         o3pahcuStE3gSvWFYPRNLdB/vLRQ3+/MzV2ogN7+w1tRtkbueKbe1BH8BlTIt/sS+vUT
         PQZP+GlZmVQcYmi6OEwwwPhDV2qmE3ZN6InjZ93rq8uM6zJdmFJTkS7RDEbVnjFRtqsM
         yO4A==
X-Gm-Message-State: APjAAAWgcb2k7jXsG9Rqd2ckzYzVqb6aW9zBuypTKibKfT8B2EtBdk97
        n4uJ4lRekHSxTbuPfoBtpPE=
X-Google-Smtp-Source: APXvYqzl/BASHUYGj0Nc0aDqh/JKm2tGMJg8oKPiZ1pYyew3VA2OEU6saze0fWlG1mYPcdifDALaLQ==
X-Received: by 2002:a63:5566:: with SMTP id f38mr6495741pgm.389.1569549279228;
        Thu, 26 Sep 2019 18:54:39 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x9sm9494303pje.27.2019.09.26.18.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 18:54:38 -0700 (PDT)
Date:   Thu, 26 Sep 2019 18:53:53 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH V6 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190927015352.GA3253@Asurada-Nvidia.nvidia.com>
References: <cover.1569493933.git.shengjiu.wang@nxp.com>
 <b6a4de2bbf960ef291ee902afe4388bd0fc1d347.1569493933.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a4de2bbf960ef291ee902afe4388bd0fc1d347.1569493933.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 09:46:12AM +0800, Shengjiu Wang wrote:
> There is error "aplay: pcm_write:2023: write error: Input/output error"
> on i.MX8QM/i.MX8QXP platform for S24_3LE format.
> 
> In i.MX8QM/i.MX8QXP, the DMA is EDMA, which don't support 24bit
> sample, but we didn't add any constraint, that cause issues.
> 
> So we need to query the caps of dma, then update the hw parameters
> according to the caps.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c     |  4 +--
>  sound/soc/fsl/fsl_asrc.h     |  3 ++
>  sound/soc/fsl/fsl_asrc_dma.c | 64 ++++++++++++++++++++++++++++++++----
>  3 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 584badf956d2..0bf91a6f54b9 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -115,7 +115,7 @@ static void fsl_asrc_sel_proc(int inrate, int outrate,
>   * within range [ANCA, ANCA+ANCB-1], depends on the channels of pair A
>   * while pair A and pair C are comparatively independent.
>   */
> -static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
> +int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
>  {
>  	enum asrc_pair_index index = ASRC_INVALID_PAIR;
>  	struct fsl_asrc *asrc_priv = pair->asrc_priv;
> @@ -158,7 +158,7 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
>   *
>   * It clears the resource from asrc_priv and releases the occupied channels.
>   */
> -static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
> +void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
>  {
>  	struct fsl_asrc *asrc_priv = pair->asrc_priv;
>  	enum asrc_pair_index index = pair->index;
> diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
> index 38af485bdd22..2b57e8c53728 100644
> --- a/sound/soc/fsl/fsl_asrc.h
> +++ b/sound/soc/fsl/fsl_asrc.h
> @@ -462,4 +462,7 @@ struct fsl_asrc {
>  #define DRV_NAME "fsl-asrc-dai"
>  extern struct snd_soc_component_driver fsl_asrc_component;
>  struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir);
> +int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair);
> +void fsl_asrc_release_pair(struct fsl_asrc_pair *pair);
> +
>  #endif /* _FSL_ASRC_H */
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index 01052a0808b0..2a60fc6142b1 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -16,13 +16,11 @@
>  
>  #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
>  
> -static const struct snd_pcm_hardware snd_imx_hardware = {
> +static struct snd_pcm_hardware snd_imx_hardware = {
>  	.info = SNDRV_PCM_INFO_INTERLEAVED |
>  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		SNDRV_PCM_INFO_MMAP |
> -		SNDRV_PCM_INFO_MMAP_VALID |
> -		SNDRV_PCM_INFO_PAUSE |
> -		SNDRV_PCM_INFO_RESUME,
> +		SNDRV_PCM_INFO_MMAP_VALID,
>  	.buffer_bytes_max = FSL_ASRC_DMABUF_SIZE,
>  	.period_bytes_min = 128,
>  	.period_bytes_max = 65535, /* Limited by SDMA engine */
> @@ -270,12 +268,25 @@ static int fsl_asrc_dma_hw_free(struct snd_pcm_substream *substream)
>  
>  static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
>  {
> +	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
> +	struct snd_dmaengine_dai_dma_data *dma_data;
>  	struct device *dev = component->dev;
>  	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
>  	struct fsl_asrc_pair *pair;
> +	struct dma_chan *tmp_chan = NULL;
> +	u8 dir = tx ? OUT : IN;
> +	bool release_pair = true;
> +	int ret = 0;
> +
> +	ret = snd_pcm_hw_constraint_integer(substream->runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set pcm hw params periods\n");
> +		return ret;
> +	}
>  
>  	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
>  	if (!pair)
> @@ -285,11 +296,50 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
>  
>  	runtime->private_data = pair;
>  
> -	snd_pcm_hw_constraint_integer(substream->runtime,
> -				      SNDRV_PCM_HW_PARAM_PERIODS);
> +	/* Request a dummy pair, which will be released later.
> +	 * Request pair function needs channel num as input, for this
> +	 * dummy pair, we just request "1" channel temporarily.
> +	 */
> +	ret = fsl_asrc_request_pair(1, pair);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request asrc pair\n");
> +		goto req_pair_err;
> +	}
> +
> +	/* Request a dummy dma channel, which will be released later. */
> +	tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
> +	if (!tmp_chan) {
> +		dev_err(dev, "failed to get dma channel\n");
> +		ret = -EINVAL;
> +		goto dma_chan_err;
> +	}
> +
> +	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
> +
> +	/* Refine the snd_imx_hardware according to caps of DMA. */
> +	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
> +							dma_data,
> +							&snd_imx_hardware,
> +							tmp_chan);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to refine runtime hwparams\n");
> +		goto out;
> +	}
> +
> +	release_pair = false;
>  	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
>  
> -	return 0;
> +out:
> +	dma_release_channel(tmp_chan);
> +
> +dma_chan_err:
> +	fsl_asrc_release_pair(pair);
> +
> +req_pair_err:
> +	if (release_pair)
> +		kfree(pair);
> +
> +	return ret;
>  }
>  
>  static int fsl_asrc_dma_shutdown(struct snd_pcm_substream *substream)
> -- 
> 2.21.0
> 
