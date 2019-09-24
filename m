Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A466EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE94214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiWxYZbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394922AbfIXVof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:44:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36461 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfIXVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:44:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id t14so1578425pgs.3;
        Tue, 24 Sep 2019 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TaXClZL44x6R6m23BGIIOYUw8sFdA7SimmvF1Bs6II=;
        b=PiWxYZbA9Phtp8IDK7idRhXLPFpVl8Nivv0bnnYLe3e3GtA0prmh/cyb4fHtq4Gim9
         aqlwpu5kw/gwGvZgr1PevcKG1YZRm4NRav9JQY8t4jD9ouA1/i6jCrKJGPq1MnRdm8Za
         zcVcS52Iw7UOovvfOTsRw0smUUa/8C1pIbP5pRVkoBa2JcIuY3/NaibW6X98J/DrVnPP
         u4jagDKOIj26zhiMKPopz6CkiPG+busIukqq/hxVnslcJhWs4Uqbf5clU765/Ug97tzP
         vOBIcRr6706g6selmfD9KRihs4X4HljViLD/zguw80jjUXENnR6hn1v0FEDtWG+aN/C7
         T+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TaXClZL44x6R6m23BGIIOYUw8sFdA7SimmvF1Bs6II=;
        b=m6hwrDFZQljKqYn9xb2lspH47tRt6ugwVT9tb1PdP7hK2D/PiRmTqapFZjFRuLYmnC
         cHSHvN+FEhDg868zt8T14N5ZWdy6V5d0b9ORduEs59VQyMulbHqO8W1tUdmtukTzPd28
         z+CUsR9o0yjbLwA84Ko2pTv1056rzYR/ot5ZBxKGunskf26C4SSrdK2atPRCGepWF6ua
         +jFW2XsnwnZd1R0HYbQ6hdgeXPEl5CjCn/6L2iWF+OotjdEb53urOps2YnQZwc70udQm
         HwTfCVRI97rVj3qF6aq8mlRxmFdEffKCj3bkQSViVbBha9YC2V2UTpWLnalyp6sTrS/K
         G7sA==
X-Gm-Message-State: APjAAAV47cC4cMXHhoT0f+osmGVuHsQliuW+97pMN21JGUqcjeLgkKt2
        JMiOZ7+dv92O3s4kIVC8SgQ=
X-Google-Smtp-Source: APXvYqx85giUVZhiQHsCv//r2YbURAPCdsrA+9rcufqztCRKD6LsbMJVknHc1eyohUWvf/YPUk/5ZA==
X-Received: by 2002:a65:64d5:: with SMTP id t21mr5237437pgv.43.1569361472982;
        Tue, 24 Sep 2019 14:44:32 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b22sm4651877pfo.85.2019.09.24.14.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 14:44:32 -0700 (PDT)
Date:   Tue, 24 Sep 2019 14:43:44 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH V4 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190924214343.GA964@Asurada-Nvidia.nvidia.com>
References: <cover.1569296075.git.shengjiu.wang@nxp.com>
 <b93ce3dced55bbad8e0b4b7e700cf394b1ae1551.1569296075.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93ce3dced55bbad8e0b4b7e700cf394b1ae1551.1569296075.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 06:52:35PM +0800, Shengjiu Wang wrote:
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
> ---
>  sound/soc/fsl/fsl_asrc.c     |  4 +--
>  sound/soc/fsl/fsl_asrc.h     |  3 ++
>  sound/soc/fsl/fsl_asrc_dma.c | 59 +++++++++++++++++++++++++++++++-----
>  3 files changed, 56 insertions(+), 10 deletions(-)
> 
> @@ -270,12 +268,17 @@ static int fsl_asrc_dma_hw_free(struct snd_pcm_substream *substream)
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
> +	int ret = 0;
>  
>  	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);

Sorry, I didn't catch it previously. We would need to release
this memory also for all error-out paths, as the code doesn't
have any error-out routine, prior to applying this change.

>  	if (!pair)
> @@ -285,11 +288,51 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)

> +	/* Request a dummy pair, which will be released later.
> +	 * Request pair function needs channel num as input, for this
> +	 * dummy pair, we just request "1" channel temporary.
> +	 */

"temporary" => "temporarily"

> +	ret = fsl_asrc_request_pair(1, pair);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request asrc pair\n");
> +		return ret;
> +	}
> +
> +	/* Request a dummy dma channel, which will be release later. */

"release" => "released"
