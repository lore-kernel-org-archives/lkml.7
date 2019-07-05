Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CEFC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C2921852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc33cekh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfGEHKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:10:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39309 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGEHKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:10:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id m202so6487199oig.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxBN84xswbhhWfhJZ4vJ56rbkxQJ6uMES8Lq5hzLdBY=;
        b=mc33cekhckA7wJjQPFB96WQWGU23cxC27TC5cLWhp1tkIGBdYA3u5o1I17M1ckqlQd
         zFZm1wF32d0kzplRgk9f+FK97QneoXTF+BUYf5NuDMGFDmxhI7P7x6djrqp7Aih7DRb+
         L0PWOaB0R1SQfDkhqQMvbEzlmLlm62KLmQ6n9n9ryzaaDAQOcPdh71DVU/KfEHOpIU+S
         maqwuTUWDwen5vjdE19DurUUEl/sqsqu+jbp90i6znc6XdV9POHpZR0mzfmXlA5DIei5
         4VA1xvTQfzYrzVl8AyFB+X3uvWz0jJfdnYQdjTX0krPFmiuU+ihk42PbP7UvgPeYDJDj
         cFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxBN84xswbhhWfhJZ4vJ56rbkxQJ6uMES8Lq5hzLdBY=;
        b=WfYFiCUjsHZfLUrXopX6b7SMjlxHe3ESLY+jUzqNE1hqI6fbrQhNKo20erweb/5cnx
         64hFAK2bTTzZ0jHPpBro/ovuDCMiz0htNWZygWe5a7NvBb3A0eBPeU6ldKJdMQiUp/Kd
         n0piR1r5dnGiybjEZ4rLyK1oW3j/1kUYYsNj1oN9/yse1nWLxS7oFVqAmFEtzE28fbC0
         A0fjJ1TqOCDaeDdf5hotDXClxkpY3uLhB331lvhKo8Cy6ZDf5lF6LjkHvDYOukhF5Wbl
         o91KCHqFDQbbqSTdWfLbLoifOKXz53Lp8PwXnKhIYEFupjMaQf8aTMD7b71FYgAYuBm3
         Gcag==
X-Gm-Message-State: APjAAAVqjqB68kAtdgwPG5CB173h9I9hIk9cVjQOsYiLjn2f/9llR1dZ
        GP1aL3UOxmXW+hGgD7SoBaPgmK7cn6S2UGT/RcRqAg==
X-Google-Smtp-Source: APXvYqylRoOrXW9piygIdp/MUCNdlQwgFS7OKeAodWKUYf14PwDLt6pn2w/rrprynkga74yQySStlO0D+Em9QWuAc3Q=
X-Received: by 2002:aca:ecc1:: with SMTP id k184mr1195557oih.82.1562310603045;
 Fri, 05 Jul 2019 00:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org> <20190705042623.129541-4-cychiang@chromium.org>
In-Reply-To: <20190705042623.129541-4-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 5 Jul 2019 15:09:52 +0800
Message-ID: <CA+Px+wXVghbk8k0WE5TEsGRQXx26K0-=h3O7cje-F1phwBGrbQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: rockchip_max98090: Add dai_link for HDMI
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> index c5fc24675a33..195309d1225a 100644
> --- a/sound/soc/rockchip/rockchip_max98090.c
> +++ b/sound/soc/rockchip/rockchip_max98090.c
>  static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
> @@ -92,38 +95,59 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
>
>         ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
>                                      SND_SOC_CLOCK_OUT);
> -       if (ret < 0) {
> -               dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
> +       if (ret && ret != -ENOTSUPP) {
> +               dev_err(cpu_dai->dev, "Can't set cpu dai clock %d\n", ret);
>                 return ret;
>         }
>
>         ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
>                                      SND_SOC_CLOCK_IN);
> -       if (ret < 0) {
> -               dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
> +       if (ret && ret != -ENOTSUPP) {
> +               dev_err(codec_dai->dev, "Can't set codec dai clock %d\n", ret);
>                 return ret;
>         }
Does it imply: it is acceptable even if they are "not supported"?


>
> -       return ret;
> +       return 0;
>  }
>
>  static const struct snd_soc_ops rk_aif1_ops = {
>         .hw_params = rk_aif1_hw_params,
>  };
>
> -SND_SOC_DAILINK_DEFS(hifi,
> +SND_SOC_DAILINK_DEFS(analog,
>         DAILINK_COMP_ARRAY(COMP_EMPTY()),
>         DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
>         DAILINK_COMP_ARRAY(COMP_EMPTY()));
>
> -static struct snd_soc_dai_link rk_dailink = {
> -       .name = "max98090",
> -       .stream_name = "Audio",
> -       .ops = &rk_aif1_ops,
> -       /* set max98090 as slave */
> -       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> -               SND_SOC_DAIFMT_CBS_CFS,
> -       SND_SOC_DAILINK_REG(hifi),
> +SND_SOC_DAILINK_DEFS(hdmi,
> +       DAILINK_COMP_ARRAY(COMP_EMPTY()),
> +       DAILINK_COMP_ARRAY(COMP_CODEC("hdmi-audio-codec.3.auto", "i2s-hifi")),
> +       DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +enum {
> +       DAILINK_MAX98090,
> +       DAILINK_HDMI,
> +};
> +
> +/* max98090 and HDMI codec dai_link */
> +static struct snd_soc_dai_link rk_dailinks[] = {
> +       [DAILINK_MAX98090] = {
> +               .name = "max98090",
> +               .stream_name = "Analog",
> +               .ops = &rk_aif1_ops,
> +               /* set max98090 as slave */
> +               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +                       SND_SOC_DAIFMT_CBS_CFS,
> +               SND_SOC_DAILINK_REG(analog),
> +       },
> +       [DAILINK_HDMI] = {
> +               .name = "HDMI",
> +               .stream_name = "HDMI",
> +               .ops = &rk_aif1_ops,
> +               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +                       SND_SOC_DAIFMT_CBS_CFS,
> +               SND_SOC_DAILINK_REG(hdmi),
> +       }
>  };
>
>  static int rk_98090_headset_init(struct snd_soc_component *component);
> @@ -136,8 +160,8 @@ static struct snd_soc_aux_dev rk_98090_headset_dev = {
>  static struct snd_soc_card snd_soc_card_rk = {
>         .name = "ROCKCHIP-I2S",
>         .owner = THIS_MODULE,
> -       .dai_link = &rk_dailink,
> -       .num_links = 1,
> +       .dai_link = rk_dailinks,
> +       .num_links = ARRAY_SIZE(rk_dailinks),
>         .aux_dev = &rk_98090_headset_dev,
>         .num_aux_devs = 1,
>         .dapm_widgets = rk_dapm_widgets,
> @@ -173,27 +197,48 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
>         int ret = 0;
>         struct snd_soc_card *card = &snd_soc_card_rk;
>         struct device_node *np = pdev->dev.of_node;
> +       struct device_node *np_analog;
> +       struct device_node *np_cpu;
> +       struct of_phandle_args args;
>
>         /* register the soc card */
>         card->dev = &pdev->dev;
>
> -       rk_dailink.codecs->of_node = of_parse_phandle(np,
> -                       "rockchip,audio-codec", 0);
> -       if (!rk_dailink.codecs->of_node) {
> +       np_analog = of_parse_phandle(np, "rockchip,audio-codec", 0);
> +       if (!np_analog) {
>                 dev_err(&pdev->dev,
>                         "Property 'rockchip,audio-codec' missing or invalid\n");
>                 return -EINVAL;
>         }
> +       rk_dailinks[DAILINK_MAX98090].codecs->of_node = np_analog;
> +
> +       ret = of_parse_phandle_with_fixed_args(np, "rockchip,audio-codec",
> +                                              0, 0, &args);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "Unable to parse property 'rockchip,audio-codec'\n");
> +               return ret;
> +       }
> +
> +       ret = snd_soc_get_dai_name(
> +                       &args, &rk_dailinks[DAILINK_MAX98090].codecs->dai_name);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Unable to get codec dai_name\n");
> +               return ret;
> +       }
> +
> +       np_cpu = of_parse_phandle(np, "rockchip,i2s-controller", 0);
>
> -       rk_dailink.cpus->of_node = of_parse_phandle(np,
> -                       "rockchip,i2s-controller", 0);
> -       if (!rk_dailink.cpus->of_node) {
> +       if (!np_cpu) {
>                 dev_err(&pdev->dev,
>                         "Property 'rockchip,i2s-controller' missing or invalid\n");
>                 return -EINVAL;
>         }
>
> -       rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
> +       rk_dailinks[DAILINK_MAX98090].cpus->of_node = np_cpu;
> +       rk_dailinks[DAILINK_MAX98090].platforms->of_node = np_cpu;
> +       rk_dailinks[DAILINK_HDMI].cpus->of_node = np_cpu;
> +       rk_dailinks[DAILINK_HDMI].platforms->of_node = np_cpu;
>
>         rk_98090_headset_dev.codec_of_node = of_parse_phandle(np,
>                         "rockchip,headset-codec", 0);
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
