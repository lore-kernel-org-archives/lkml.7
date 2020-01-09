Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C95C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E359B206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 04:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ag8nqYeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgAIE63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 23:58:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36441 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIE63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 23:58:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1324322wma.1;
        Wed, 08 Jan 2020 20:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VMi5RKokSD1bSLba837QPSe93h6ZNWDgrRnva2rnDU=;
        b=ag8nqYeWGk2pLTA0jJLgOeLPs6j/8VzJrYnQflUrxpAuHEVC545WyJuOXttmHNsluR
         2ZH1X28E9gpXSqn3YiRnWsqI1l5a4IhoFaMKgH2WI8DjxScbecbQm4qB9TN3Wdi4pXSN
         zOl7Tn/UsEHSTnZEl1pQhc5Swjg1eW7aWK1ayjVqOTck9E8bGRamt65sOZCNXcQaD/53
         IO0RwTVbet55WKsk3d696k0Ite+YoCHee/1AP5OuScjTBQh7c+JKQ5+QgMJuKz/paBD0
         gK5CJ4Biuo94bkQquF3KhJiAdb5aL3zDPDJ4Fve8sdy/x6liyacgigvgwia0FqOrI6yD
         ybaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VMi5RKokSD1bSLba837QPSe93h6ZNWDgrRnva2rnDU=;
        b=KQ+FL+epLt+yLc50Eupq7jtAfKZYZ43rrhZMb+ldaop3y7W/M5SyjoX5kGzEEsXFjA
         hEQMx99mvue7PZ0O10Db8r0jn/ogr2mQw15ugQ7cZBMkdtQ+r5AVFq8mZI9a26StsHog
         W09zRu8h8eR0lCJYxrpU56paJ+s3dstP7FIkAJn7gYUnUN7kAMGjajU+xj+Ka7E6Vlex
         nZe50k4IEWk0cVa/EbwQhFE86kr+H96RZBqEf+hazaxv4QUcEwJ98nhJcKVEPOxjs/Dn
         RXvlCHRYNGsFSyG/z0VIUx6z5FesLM2EXwU0AfaVtQTqobmctjVx0mgS0uiLYP9uBqE7
         MH5g==
X-Gm-Message-State: APjAAAWMuAUnirIe6CYTbvCYip4/hrXZsBApAWRNQQNNhTgHETBmdYks
        3zS5Twzi3YH/827WdyInHPpoQIKBIJS4LUyvxjQ=
X-Google-Smtp-Source: APXvYqwYFA/wMpc6nvrIl61VRVfUPbN3ir93M5LfqjI+X4VbbeKgVjzJrn0QKex0Xjtz1VOP6CJpnivX1VhkTpB4cnc=
X-Received: by 2002:a1c:488a:: with SMTP id v132mr2154030wma.153.1578545906700;
 Wed, 08 Jan 2020 20:58:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1569493933.git.shengjiu.wang@nxp.com> <d728f65194e9978cbec4132b522d4fed420d704a.1569493933.git.shengjiu.wang@nxp.com>
In-Reply-To: <d728f65194e9978cbec4132b522d4fed420d704a.1569493933.git.shengjiu.wang@nxp.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 8 Jan 2020 20:58:15 -0800
Message-ID: <CANcMJZBy=yH+4YgZWwphiE-PO6d4hzhFK3XFtpN677ZAv_N4WQ@mail.gmail.com>
Subject: Re: [PATCH V6 3/4] ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, lars@metafoo.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 6:50 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> When set the runtime hardware parameters, we may need to query
> the capability of DMA to complete the parameters.
>
> This patch is to Extract this operation from
> dmaengine_pcm_set_runtime_hwparams function to a separate function
> snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> which need this feature can call this function.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

As a heads up, this patch seems to be causing a regression on the HiKey board.

On boot up I'm seeing:
[   17.721424] hi6210_i2s f7118000.i2s: ASoC: can't open component
f7118000.i2s: -6

And HDMI audio isn't working. With this patch reverted, audio works again.


> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index 89a05926ac73..5749a8a49784 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -369,4 +369,87 @@ int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
...
> +       ret = dma_get_slave_caps(chan, &dma_caps);
> +       if (ret == 0) {
> +               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> +                       hw->info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> +               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> +                       hw->info |= SNDRV_PCM_INFO_BATCH;
> +
> +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +                       addr_widths = dma_caps.dst_addr_widths;
> +               else
> +                       addr_widths = dma_caps.src_addr_widths;
> +       }

It seems a failing ret from dma_get_slave_caps() here is being returned...

> +
> +       /*
> +        * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
> +        * hw.formats set to 0, meaning no restrictions are in place.
> +        * In this case it's the responsibility of the DAI driver to
> +        * provide the supported format information.
> +        */
> +       if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
> +               /*
> +                * Prepare formats mask for valid/allowed sample types. If the
> +                * dma does not have support for the given physical word size,
> +                * it needs to be masked out so user space can not use the
> +                * format which produces corrupted audio.
> +                * In case the dma driver does not implement the slave_caps the
> +                * default assumption is that it supports 1, 2 and 4 bytes
> +                * widths.
> +                */
> +               for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
> +                       int bits = snd_pcm_format_physical_width(i);
> +
> +                       /*
> +                        * Enable only samples with DMA supported physical
> +                        * widths
> +                        */
> +                       switch (bits) {
> +                       case 8:
> +                       case 16:
> +                       case 24:
> +                       case 32:
> +                       case 64:
> +                               if (addr_widths & (1 << (bits / 8)))
> +                                       hw->formats |= pcm_format_to_bits(i);
> +                               break;
> +                       default:
> +                               /* Unsupported types */
> +                               break;
> +                       }
> +               }
> +
> +       return ret;

... down here.

Where as in the old code...

> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 748f5f641002..b9f147eaf7c4 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c

> @@ -145,56 +140,12 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
>         if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
>                 hw.info |= SNDRV_PCM_INFO_BATCH;
>
> -       ret = dma_get_slave_caps(chan, &dma_caps);
> -       if (ret == 0) {
> -               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> -                       hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> -               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> -                       hw.info |= SNDRV_PCM_INFO_BATCH;
> -
> -               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -                       addr_widths = dma_caps.dst_addr_widths;
> -               else
> -                       addr_widths = dma_caps.src_addr_widths;
> -       }

...the ret from dma_get_slave_caps()  checked above, but is not
actually returned.

Suggestions on how to sort this out?

thanks
-john
