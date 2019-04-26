Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4F8C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB3E2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgCU5E+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDZMLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:11:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33924 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:11:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id a6so3000226edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iv+Qt/L8mJZ+qcF89VURhvr8O3ic6BiHoQtS2O+mf6w=;
        b=KgCU5E+mQUaAngkEPf8GYVsgqKE13B7je9UgwHKl0P6aQOkh12SOT9rGZ4lXG/7OXp
         8EeYa761UjVrsvbrqf4098fXcYb5CL5m3kl+IUhJTHT7NB9pbYn7nnxGeGJIOWn7AgwE
         QviFVg/QJhNo4/HEDWZBgrDpHjigmxreOePeknoFMqGRFVm9w/Xh+RDhtD/ScKPLpWZk
         0YoXcdyapohDn57eiQvYOXRXQWlciTA2IiqEGndjEjYsKMhwaGicwUqFjRyy80bd9lVU
         T1Ls1gTw9aAsqZJThE6575U9o1snUuNn0x9zTPwI1RsAdSXczFQ7eK9Bcp4WvkpgaFx0
         WVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iv+Qt/L8mJZ+qcF89VURhvr8O3ic6BiHoQtS2O+mf6w=;
        b=LTP2DDBjyeNibMNXtpKOjg9aL8Tg7NYmpxMVgH7lWPZNUYFTTP8EswtqvYwWxZPbjW
         Tk2oo5apVKc3JiiDasUWCMJ76LdhGNoGAXlOwTjFRLmDDFA1v4gEehPge1VJJFMYgfDT
         905qjQf2w9wjGJyEzWixNRc5usLP6wZ0cqbWXuaHAT36AVKaNwrQ870nl9BI6TND1Ua3
         xUvHXt39I5ZOubNoibTo39VNIFaCHKNR2HYYYIO/ynJDjc5pesahNKbgmjqYjfZuyAzq
         U636Lz8TuPhXBox04dOr2oH8TZcKZYl6zAp323li8wl6mne8Vm3J4aKdSWNYKSYhDlPA
         iW5A==
X-Gm-Message-State: APjAAAVwhKyXK1ONfmi6wPO31YSAbiFQZQ0TD2+IK6rJfBlbrxCK9OiQ
        bt6zHSljs51u78xPrZdd1HzwDF494WmRNQCY9Ac=
X-Google-Smtp-Source: APXvYqwg1tBQB8xAZ3L8jvxGUswWVPmzCPfBxX5vwnT3za6d2x7T4b6Y67klyNoMzXl9S9A9zAfjFLiLY1eYF1svXSw=
X-Received: by 2002:a50:a3c2:: with SMTP id t2mr27861786edb.46.1556280702041;
 Fri, 26 Apr 2019 05:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190422190213.30726-1-daniel.baluta@nxp.com> <20190422190213.30726-4-daniel.baluta@nxp.com>
In-Reply-To: <20190422190213.30726-4-daniel.baluta@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 26 Apr 2019 15:11:30 +0300
Message-ID: <CAEnQRZCK5dPoD7TunxLsf8EXVb-99Vb0OQnaqa2rmAQu3eyWvw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ASoC: fsl_sai: Move clock operation to PM runtime
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

This is the only patch in the series that wasn't applied.

On Mon, Apr 22, 2019 at 10:03 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Turn off/on clocks when device enters suspend/resume. This
> can help saving power.
>
> As a further optimization, we turn off/on mclk only when SAI
> is in master mode because otherwise mclk is externally provided.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 54 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 8623b7f882b9..7fd1a81ec1aa 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -596,15 +596,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  {
>         struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>         bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> -       struct device *dev = &sai->pdev->dev;
>         int ret;
>
> -       ret = clk_prepare_enable(sai->bus_clk);
> -       if (ret) {
> -               dev_err(dev, "failed to enable bus clock: %d\n", ret);
> -               return ret;
> -       }
> -
>         regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
>                            FSL_SAI_CR3_TRCE);
>
> @@ -621,8 +614,6 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>         bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>
>         regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> -
> -       clk_disable_unprepare(sai->bus_clk);
>  }
>
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> @@ -932,6 +923,14 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  {
>         struct fsl_sai *sai = dev_get_drvdata(dev);
>
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[0]]);
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[1]]);
> +
> +       clk_disable_unprepare(sai->bus_clk);
> +
>         regcache_cache_only(sai->regmap, true);
>         regcache_mark_dirty(sai->regmap);
>
> @@ -941,6 +940,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  static int fsl_sai_runtime_resume(struct device *dev)
>  {
>         struct fsl_sai *sai = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(sai->bus_clk);
> +       if (ret) {
> +               dev_err(dev, "failed to enable bus clock: %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> +               ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> +               if (ret)
> +                       goto disable_bus_clk;
> +       }
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> +               ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> +               if (ret)
> +                       goto disable_tx_clk;
> +       }
>
>         regcache_cache_only(sai->regmap, false);
>         regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
> @@ -948,7 +966,23 @@ static int fsl_sai_runtime_resume(struct device *dev)
>         usleep_range(1000, 2000);
>         regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
>         regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
> -       return regcache_sync(sai->regmap);
> +
> +       ret = regcache_sync(sai->regmap);
> +       if (ret)
> +               goto disable_rx_clk;
> +
> +       return 0;
> +
> +disable_rx_clk:
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[0]]);
> +disable_tx_clk:
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[1]]);
> +disable_bus_clk:
> +       clk_disable_unprepare(sai->bus_clk);
> +
> +       return ret;
>  }
>  #endif /* CONFIG_PM */
>
> --
> 2.17.1
>
