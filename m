Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8018C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DE02070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv0ycOVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394077AbfITX00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:26:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394035AbfITX00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:26:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so3890035pls.9;
        Fri, 20 Sep 2019 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CA6mH2s7/mQqbWPAIxBYkadhzeqMoOn4kmubZpmIYQA=;
        b=sv0ycOVZPEhTBxFw+PhY1TKXnOl5DVN2Av+2c6JW39gGUGeaaPf9JWdZpzhfhjyDvO
         tHo5pFIxpbHshEplJahmcB28BZVO66DXVbj2Etn1qVpN/UyRaEys8guhMCBUGWa3Pdps
         RwEUfv849KjqGBzz5YzRqXMYHsE2hTKKND/lC1Ak9mBG11lytDDhN+YuEfWxOa7G7DG2
         70IUKQm0VRf3zc5GtNZG2Sz8i3JA1ZgYokOXQL3Rp2Nl2Ri/jFFw2/ckRuCEF/dQ2nF8
         FRjZ4M/463RnpHE6i+2XVRXIkNXaaQzojkcpObFvr65CCoiwweYS2QoO8s5RYoJnpHod
         fXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CA6mH2s7/mQqbWPAIxBYkadhzeqMoOn4kmubZpmIYQA=;
        b=X4xmH9wG7OZheSo0Xoe0A7Yjr6BTNedD3wA8iPHOCPtIF5g3Jrfb8PpremP2DlcxU3
         Fa84WGYUcWaCpwb2XilhJjP7Q3kuh3VPUThV/KyYYtb3YwohsgeJvKhWDLapAZXSZXUf
         /9ja0umVQ751udj774jirDjzsvHTEnWqdoEH5368T26VBqs/QN5LTdVU7vzfOqJeaCSv
         Kd+CUQBqlWHzFAdppWpOniKtf8fcLUdQSt/REYGEtKYttECPbtARZdjOuYuFnYEaZ2Wk
         DEJrMSvCYa7aZRiQ2NSIJnmBctxkG8mOlFNOXtzCD0FHykrrdvR+sdA+j00/lQAOk71i
         0mXQ==
X-Gm-Message-State: APjAAAV68LfyBGDJz1QN/LX/9GCRE4Oncufwxy5b5lg8F4XgGcKPspGK
        UWCSOzV68I8zA34rC2OimTc=
X-Google-Smtp-Source: APXvYqwAW5gxV9v80zvEtG/jnR4oL2FMp5gqh40w1OPjkDMijYj5VxPtPws76h5RT0qlX41fhMzS0g==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12mr17751680plo.2.1569021985410;
        Fri, 20 Sep 2019 16:26:25 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k5sm3716946pfp.109.2019.09.20.16.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 16:26:25 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:25:33 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH V3 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Message-ID: <20190920232533.GA29851@Asurada-Nvidia.nvidia.com>
References: <cover.1568861098.git.shengjiu.wang@nxp.com>
 <0fe619f4c8f0898cf51c7324c9a0784c5782ed91.1568861098.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe619f4c8f0898cf51c7324c9a0784c5782ed91.1568861098.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shengjiu,

One issue for error-out and some nit-pickings inline. Thanks.

On Thu, Sep 19, 2019 at 08:11:42PM +0800, Shengjiu Wang wrote:
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
>  sound/soc/fsl/fsl_asrc.h     |  3 +++
>  sound/soc/fsl/fsl_asrc_dma.c | 52 +++++++++++++++++++++++++++++++-----
>  3 files changed, 50 insertions(+), 9 deletions(-)
> 
> @@ -276,6 +274,11 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
>  	struct device *dev = component->dev;
>  	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
>  	struct fsl_asrc_pair *pair;
> +	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> +	u8 dir = tx ? OUT : IN;
> +	struct dma_chan *tmp_chan;
> +	struct snd_dmaengine_dai_dma_data *dma_data;

Nit: would it be possible to reorganize these a bit? Usually
we put struct things together unless there is a dependency,
similar to fsl_asrc_dma_hw_params().

> @@ -285,9 +288,44 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
>  
>  	runtime->private_data = pair;
>  
> +	/* Request a temp pair, which is release in the end */

Nit: "which will be released later" or "and will release it
later"? And could we use a work like "dummy"? Or at least I
would love to see the comments explaining the parameter "1"
in the function call below.

> +	ret = fsl_asrc_request_pair(1, pair);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request asrc pair\n");
> +		return ret;
> +	}
> +
> +	tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
> +	if (!tmp_chan) {
> +		dev_err(dev, "can't get dma channel\n");

Could we align with other error messages using "failed to"?

> +	ret = snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
> +	if (ret)
> +		return ret;
> +
[...]
> +	dma_release_channel(tmp_chan);
> +	fsl_asrc_release_pair(pair);

I think we need an "out:" here for those error-out routines
to goto. Otherwise, it'd be a pair leak?

> +

Could we drop this? There is a blank line below already :)

>  
>  	return 0;
>  }
> -- 
> 2.21.0
> 
