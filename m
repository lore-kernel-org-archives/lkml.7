Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74649CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A002173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0V7U6xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfJWSbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:31:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36747 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfJWSba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:31:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so12644632pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhucI9QNtNBjoT1eOT78ESBAn4mEJQ0ycZgAHsd53Fc=;
        b=O0V7U6xdxg3UJAoCsFL181e1vuQig/OWqm5AcucL89tYd3b9qkjvMM9lP+EMxIsd/D
         nULS8++93595dJ/MuPxdOiWNwPro4vx1uibpDaTFOBc/mbbfnZWArkgAkdi/1Sj4/3pn
         CnpHhKkutuirpbGJ15oFkWcPeKybaQuwdY/Oazfd9/NO6HOUG/4hvUOU/gPflhn79F4c
         jtn03qKJHmp9p9aXWAi6MaSW2jHtLl2JfuzxfmqRrM5JSt3BefvV2/wNb5KsF+eiNmTo
         9HFMS5Pxk97txKDYDYBY6kMTP4UH0oyklI+Gu8j1EQSiUodwRt97MzOGork+gaeFtCPn
         6VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhucI9QNtNBjoT1eOT78ESBAn4mEJQ0ycZgAHsd53Fc=;
        b=saFDKDDrnGNpqu/wDkL7sWsQSgEkjv6JIopHAkwwbsXZW4ydphMntST2C0yk9pGjjt
         JSf/UpJNQHq6BpZaBd/RKnIyOcN57KcoGxID4gmpHuG84NOUv3FZDuKPArE1P2VZ8woC
         Gu+t52LrJpI3JjcD82IZibKh8NJlHxMgOBZkPTlEqLKMgKoRY8ILJWJdtBjfglRKckrZ
         bY79EHK4kRMq/LcYqqj8ipOnwngF5+45ZP9i0KJlBTyIAGF/nuJZu7bWzzGdrbQOPEY9
         5BHWT/jTffmGYRjeFXT4oblUM5Hnu/x7Llmm8/DObVlOhMAU0JUoGs/kdYU813Wtmkw5
         omGQ==
X-Gm-Message-State: APjAAAV/+Qgzi6vrpovfbppd54XLGTQSu/TCL2uz6+Bjn5tYS0eoId08
        3UOKPl1pv/DMdN736bmH2xo=
X-Google-Smtp-Source: APXvYqxzu1oD36VJIGp854tNQIRLLmtcz4McKHR96Hyw1WByLg+NWOb5VOZ+kJaLQ35nHQjMgw5vEw==
X-Received: by 2002:aa7:8ac5:: with SMTP id b5mr12396158pfd.66.1571855488547;
        Wed, 23 Oct 2019 11:31:28 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z4sm30137417pfn.45.2019.10.23.11.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 11:31:28 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:31:03 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_esai: Add spin lock to protect reset and stop
Message-ID: <20191023183102.GA16043@Asurada-Nvidia.nvidia.com>
References: <1571815789-15656-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571815789-15656-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:29:49PM +0800, Shengjiu Wang wrote:
> xrun may happen at the end of stream, the
> trigger->fsl_esai_trigger_stop maybe called in the middle of
> fsl_esai_hw_reset, this may cause esai in wrong state
> after stop, and there may be endless xrun interrupt.

What about fsl_esai_trigger_start? It touches ESAI_xFCR_xFEN bit
that is being checked in the beginning of fsl_esai_hw_reset.

Could the scenario below be possible also?

1) ESAI TX starts
2) Xrun happens to TX
3) Starting fsl_esai_hw_reset (enabled[TX] = true; enabled[RX] = false)
4) ESAI RX starts
5) Finishing fsl_esai_hw_reset (enabled[RX] is still false)

Thanks
Nicolin

> So Add spin lock to lock these two function.
> 
> Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 37b14c48b537..6a797648b66d 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -33,6 +33,7 @@
>   * @fsysclk: system clock source to derive HCK, SCK and FS
>   * @spbaclk: SPBA clock (optional, depending on SoC design)
>   * @task: tasklet to handle the reset operation
> + * @lock: spin lock to handle reset and stop behavior
>   * @fifo_depth: depth of tx/rx FIFO
>   * @slot_width: width of each DAI slot
>   * @slots: number of slots
> @@ -56,6 +57,7 @@ struct fsl_esai {
>  	struct clk *fsysclk;
>  	struct clk *spbaclk;
>  	struct tasklet_struct task;
> +	spinlock_t lock; /* Protect reset and stop */
>  	u32 fifo_depth;
>  	u32 slot_width;
>  	u32 slots;
> @@ -676,8 +678,10 @@ static void fsl_esai_hw_reset(unsigned long arg)
>  {
>  	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
>  	bool tx = true, rx = false, enabled[2];
> +	unsigned long lock_flags;
>  	u32 tfcr, rfcr;
>  
> +	spin_lock_irqsave(&esai_priv->lock, lock_flags);
>  	/* Save the registers */
>  	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
>  	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
> @@ -715,6 +719,8 @@ static void fsl_esai_hw_reset(unsigned long arg)
>  		fsl_esai_trigger_start(esai_priv, tx);
>  	if (enabled[rx])
>  		fsl_esai_trigger_start(esai_priv, rx);
> +
> +	spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
>  }
>  
>  static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
> @@ -722,6 +728,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  {
>  	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> +	unsigned long lock_flags;
>  
>  	esai_priv->channels[tx] = substream->runtime->channels;
>  
> @@ -734,7 +741,9 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		spin_lock_irqsave(&esai_priv->lock, lock_flags);
>  		fsl_esai_trigger_stop(esai_priv, tx);
> +		spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1002,6 +1011,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, esai_priv);
>  
> +	spin_lock_init(&esai_priv->lock);
>  	ret = fsl_esai_hw_init(esai_priv);
>  	if (ret)
>  		return ret;
> -- 
> 2.21.0
> 
