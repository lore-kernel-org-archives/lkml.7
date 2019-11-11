Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0FBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A221872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8TpWEM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKM7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:59:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40886 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:59:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so14527025wrs.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4ubUXtKB+J2uUhFjOOYE/2DGaUw76V9ImU/UoPSd30=;
        b=O8TpWEM1zGN5JwYiXACyejO7elmVd/iwBpF91Bd2ZnSE+j/HHDU/insUNU7DnLKpdZ
         oUkOs5qn4NpTMYIuMsOcYJ2GmJak18C1L7ZRfiVxRNZFaGRLqvEzSbz+xd1ObzBHdvDn
         WBrjSXpX8bXvWgL+wKqCudksk8dnwZqRqvpj0HnFJUI4NLTQl2HO46mfISiZ5Db4oEwt
         2IL+Z51y6+8Yy56FzJWIBynCj0zC7+4Wtpb4fp6FBsCWWcg3MuaDARwwVxLtuoNtIaVB
         rdT0kH7QgZpbZCQ+6lqlWmPGpVtdpdBn+Le1aorzrinqEiVlCGM6SBAnBQdKRJxjB9/d
         k2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4ubUXtKB+J2uUhFjOOYE/2DGaUw76V9ImU/UoPSd30=;
        b=rd1OhY8xYPTtm+oYUSKA6cE64QM9q2wJNI6SbjGQ5QK6MrWMG6AE6jnxvpc6srPxwS
         xn8Dqh7350tMqoAm5aaNZRzejttEnLvTVuvQ1w7zIWt5fX0m5SVkMxMsva/qoyTROwLh
         2NYHU4NEheChKuIn9YO9/B4tB4TiEsfSRd2yzMYDSNAsXKWmbKLDMaCYNyyntGkq0b6G
         kfBPedLFvp57GCCD1SpRrvu+1P9fk6zWuxAVHSuHsd5pC/ktjc5ozHgFy/cGL1fOhuUu
         CFFcAOgFlB20YeujsH9LZJfmnOTuAH4QAzBKmOGlHdgwPvwC5+jm6iSMsqeXujZT2iK1
         mjkQ==
X-Gm-Message-State: APjAAAVssUnDafBj11sv4WuwARVHHOXm4aoEbBomc65tklTRTxILvUj8
        ejsp3UJSTLoLtrKM+MsbUON8Pc3Cmcx/KyDFccqOlNKk
X-Google-Smtp-Source: APXvYqwCXiI2RgOZKsqVZVpR+X3dtB+xlXATxh/NM04aXvEKxz+b9oxnwC+Y0L+gQ1sWGTP9xIkuxWq/fm1g0fHzUWE=
X-Received: by 2002:a05:6000:1181:: with SMTP id g1mr21673345wrx.131.1573477158306;
 Mon, 11 Nov 2019 04:59:18 -0800 (PST)
MIME-Version: 1.0
References: <1e706afe53fdd1fbbbc79277c48a98f8416ba873.1573458378.git.shengjiu.wang@nxp.com>
In-Reply-To: <1e706afe53fdd1fbbbc79277c48a98f8416ba873.1573458378.git.shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 11 Nov 2019 14:59:07 +0200
Message-ID: <CAEnQRZAVpF39PPDQyoquWv8s=EhcJ1a4Nn+fCvuq_b9kHUiGOA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2] ASoC: fsl_audmix: Add spin lock to
 protect tdms
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 9:53 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Audmix support two substream, When two substream start
> to run, the trigger function may be called by two substream
> in same time, that the priv->tdms may be updated wrongly.
>
> The expected priv->tdms is 0x3, but sometimes the
> result is 0x2, or 0x1.
>
> Fixes: be1df61cf06e ("ASoC: fsl: Add Audio Mixer CPU DAI driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
> Change in v2
> -add Fixes, Cc stable, and Acked-by.
>
>  sound/soc/fsl/fsl_audmix.c | 6 ++++++
>  sound/soc/fsl/fsl_audmix.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index c7e4e9757dce..a1db1bce330f 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -286,6 +286,7 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>                                   struct snd_soc_dai *dai)
>  {
>         struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
> +       unsigned long lock_flags;
>
>         /* Capture stream shall not be handled */
>         if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> @@ -295,12 +296,16 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>         case SNDRV_PCM_TRIGGER_START:
>         case SNDRV_PCM_TRIGGER_RESUME:
>         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +               spin_lock_irqsave(&priv->lock, lock_flags);
>                 priv->tdms |= BIT(dai->driver->id);
> +               spin_unlock_irqrestore(&priv->lock, lock_flags);
>                 break;
>         case SNDRV_PCM_TRIGGER_STOP:
>         case SNDRV_PCM_TRIGGER_SUSPEND:
>         case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +               spin_lock_irqsave(&priv->lock, lock_flags);
>                 priv->tdms &= ~BIT(dai->driver->id);
> +               spin_unlock_irqrestore(&priv->lock, lock_flags);
>                 break;
>         default:
>                 return -EINVAL;
> @@ -491,6 +496,7 @@ static int fsl_audmix_probe(struct platform_device *pdev)
>                 return PTR_ERR(priv->ipg_clk);
>         }
>
> +       spin_lock_init(&priv->lock);
>         platform_set_drvdata(pdev, priv);
>         pm_runtime_enable(dev);
>
> diff --git a/sound/soc/fsl/fsl_audmix.h b/sound/soc/fsl/fsl_audmix.h
> index 7812ffec45c5..479f05695d53 100644
> --- a/sound/soc/fsl/fsl_audmix.h
> +++ b/sound/soc/fsl/fsl_audmix.h
> @@ -96,6 +96,7 @@ struct fsl_audmix {
>         struct platform_device *pdev;
>         struct regmap *regmap;
>         struct clk *ipg_clk;
> +       spinlock_t lock; /* Protect tdms */
>         u8 tdms;
>  };
>
> --
> 2.21.0
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
