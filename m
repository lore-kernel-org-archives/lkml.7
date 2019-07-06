Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C10C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C2120989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MhXumSV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfGFJ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 05:59:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36890 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 05:59:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id z13so3067542uaa.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2Rz/d21/ylv5Zd5tSKi5YqfwGQ980yh4WNadx9GYzU=;
        b=MhXumSV4QoeqvPMiVA5KMYVeE+uN2th6BsySYscGyYhJjh3srusH1YsRVfrkrYlVen
         7ZUCu1dWeAV26hNlZSvWFcuU7tmTva0QMuiGbbaxaZtBQNJiKVrnj/g9MjCDAiMF3z5p
         2c94LPDUb0u0w1hsNsGm1S9a1uVjq58OkHTE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2Rz/d21/ylv5Zd5tSKi5YqfwGQ980yh4WNadx9GYzU=;
        b=dhrmprWWfy2ddTQtiUiCWFuRVBz9OSthVV9mno2yOKrEBEkU5GTu9bJ0tqxo48dFFR
         9kv5nYYTwVtkxHzT1Jb798YOrH0xFjXb/PcqkLyzQwvQRMwi46TnNKHYL95qlGnvzxZw
         DZq1TdjVWD4/OYctiTuxLLEx/lty1Sf41YUoBbFrX6v07hg6jXNpLlsYIAtBj4ArfK0W
         EbOSI36H3u6SXIazIKioL3OfV8w2/sNKy6QkHY0FItcDDKR875yf7M5dFW9ouLYLlclV
         yGWOChiJlQsRr+oU3HrW6lu9h5gpqfBeBibwtaVrtksih+kf8GFMePRJ4SZgMOweHuTS
         RRGw==
X-Gm-Message-State: APjAAAVJRzizR0xsqHpfTLSW39JrzC9hv5g2j/hdoce/gfda+6kspN3I
        chIw4WeMfsI7UY0k6t02nTm9jQBe2B0t70ICSBDfbQ==
X-Google-Smtp-Source: APXvYqwUUszDaeoohzqNnkpQSYnHVhSPEY45kVLHkzpLi5HEdIAQnRyv7V0QmFsdPAf8yIUxZoaDtdCrRbHH7LsGI9Q=
X-Received: by 2002:a9f:3605:: with SMTP id r5mr4738015uad.131.1562407158879;
 Sat, 06 Jul 2019 02:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-4-cychiang@chromium.org> <CA+Px+wXVghbk8k0WE5TEsGRQXx26K0-=h3O7cje-F1phwBGrbQ@mail.gmail.com>
In-Reply-To: <CA+Px+wXVghbk8k0WE5TEsGRQXx26K0-=h3O7cje-F1phwBGrbQ@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Sat, 6 Jul 2019 17:58:52 +0800
Message-ID: <CAFv8NwKBA_=R2YsgU+dvr_G5fUCNiVL-TOKL=26rK2m_qbrcbw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: rockchip_max98090: Add dai_link for HDMI
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 3:10 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> > diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> > index c5fc24675a33..195309d1225a 100644
> > --- a/sound/soc/rockchip/rockchip_max98090.c
> > +++ b/sound/soc/rockchip/rockchip_max98090.c
> >  static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
> > @@ -92,38 +95,59 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
> >
> >         ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
> >                                      SND_SOC_CLOCK_OUT);
> > -       if (ret < 0) {
> > -               dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
> > +       if (ret && ret != -ENOTSUPP) {
> > +               dev_err(cpu_dai->dev, "Can't set cpu dai clock %d\n", ret);
I should remove this change because cpu dai should support sysclk ops.

> >                 return ret;
> >         }
> >
> >         ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
> >                                      SND_SOC_CLOCK_IN);
> > -       if (ret < 0) {
> > -               dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
> > +       if (ret && ret != -ENOTSUPP) {
> > +               dev_err(codec_dai->dev, "Can't set codec dai clock %d\n", ret);
> >                 return ret;
> >         }
> Does it imply: it is acceptable even if they are "not supported"?
Thank you for this good catch.
Here machine driver has the knowledge of deciding whether it is
expected to see the ops is not supported.
For HDMI path using hdmi-codec driver, it is expected to see -ENOTSUPP.
But it is not expected for codec DAI of max98090.
I should distinguish them.

>
>
> >
> > -       return ret;
> > +       return 0;
> >  }
> >
> >  static const struct snd_soc_ops rk_aif1_ops = {
> >         .hw_params = rk_aif1_hw_params,
> >  };
> >
> > -SND_SOC_DAILINK_DEFS(hifi,
> > +SND_SOC_DAILINK_DEFS(analog,
> >         DAILINK_COMP_ARRAY(COMP_EMPTY()),
> >         DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
> >         DAILINK_COMP_ARRAY(COMP_EMPTY()));
> >
> > -static struct snd_soc_dai_link rk_dailink = {
> > -       .name = "max98090",
> > -       .stream_name = "Audio",
> > -       .ops = &rk_aif1_ops,
> > -       /* set max98090 as slave */
> > -       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > -               SND_SOC_DAIFMT_CBS_CFS,
> > -       SND_SOC_DAILINK_REG(hifi),
> > +SND_SOC_DAILINK_DEFS(hdmi,
> > +       DAILINK_COMP_ARRAY(COMP_EMPTY()),
> > +       DAILINK_COMP_ARRAY(COMP_CODEC("hdmi-audio-codec.3.auto", "i2s-hifi")),
> > +       DAILINK_COMP_ARRAY(COMP_EMPTY()));
> > +
> > +enum {
> > +       DAILINK_MAX98090,
> > +       DAILINK_HDMI,
> > +};
> > +
> > +/* max98090 and HDMI codec dai_link */
> > +static struct snd_soc_dai_link rk_dailinks[] = {
> > +       [DAILINK_MAX98090] = {
> > +               .name = "max98090",
> > +               .stream_name = "Analog",
> > +               .ops = &rk_aif1_ops,
> > +               /* set max98090 as slave */
> > +               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > +                       SND_SOC_DAIFMT_CBS_CFS,
> > +               SND_SOC_DAILINK_REG(analog),
> > +       },
> > +       [DAILINK_HDMI] = {
> > +               .name = "HDMI",
> > +               .stream_name = "HDMI",
> > +               .ops = &rk_aif1_ops,
> > +               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > +                       SND_SOC_DAIFMT_CBS_CFS,
> > +               SND_SOC_DAILINK_REG(hdmi),
> > +       }
> >  };
> >
> >  static int rk_98090_headset_init(struct snd_soc_component *component);
> > @@ -136,8 +160,8 @@ static struct snd_soc_aux_dev rk_98090_headset_dev = {
> >  static struct snd_soc_card snd_soc_card_rk = {
> >         .name = "ROCKCHIP-I2S",
> >         .owner = THIS_MODULE,
> > -       .dai_link = &rk_dailink,
> > -       .num_links = 1,
> > +       .dai_link = rk_dailinks,
> > +       .num_links = ARRAY_SIZE(rk_dailinks),
> >         .aux_dev = &rk_98090_headset_dev,
> >         .num_aux_devs = 1,
> >         .dapm_widgets = rk_dapm_widgets,
> > @@ -173,27 +197,48 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
> >         int ret = 0;
> >         struct snd_soc_card *card = &snd_soc_card_rk;
> >         struct device_node *np = pdev->dev.of_node;
> > +       struct device_node *np_analog;
> > +       struct device_node *np_cpu;
> > +       struct of_phandle_args args;
> >
> >         /* register the soc card */
> >         card->dev = &pdev->dev;
> >
> > -       rk_dailink.codecs->of_node = of_parse_phandle(np,
> > -                       "rockchip,audio-codec", 0);
> > -       if (!rk_dailink.codecs->of_node) {
> > +       np_analog = of_parse_phandle(np, "rockchip,audio-codec", 0);
> > +       if (!np_analog) {
> >                 dev_err(&pdev->dev,
> >                         "Property 'rockchip,audio-codec' missing or invalid\n");
> >                 return -EINVAL;
> >         }
> > +       rk_dailinks[DAILINK_MAX98090].codecs->of_node = np_analog;
> > +
> > +       ret = of_parse_phandle_with_fixed_args(np, "rockchip,audio-codec",
> > +                                              0, 0, &args);
> > +       if (ret) {
> > +               dev_err(&pdev->dev,
> > +                       "Unable to parse property 'rockchip,audio-codec'\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = snd_soc_get_dai_name(
> > +                       &args, &rk_dailinks[DAILINK_MAX98090].codecs->dai_name);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Unable to get codec dai_name\n");
> > +               return ret;
> > +       }
> > +
> > +       np_cpu = of_parse_phandle(np, "rockchip,i2s-controller", 0);
> >
> > -       rk_dailink.cpus->of_node = of_parse_phandle(np,
> > -                       "rockchip,i2s-controller", 0);
> > -       if (!rk_dailink.cpus->of_node) {
> > +       if (!np_cpu) {
> >                 dev_err(&pdev->dev,
> >                         "Property 'rockchip,i2s-controller' missing or invalid\n");
> >                 return -EINVAL;
> >         }
> >
> > -       rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
> > +       rk_dailinks[DAILINK_MAX98090].cpus->of_node = np_cpu;
> > +       rk_dailinks[DAILINK_MAX98090].platforms->of_node = np_cpu;
> > +       rk_dailinks[DAILINK_HDMI].cpus->of_node = np_cpu;
> > +       rk_dailinks[DAILINK_HDMI].platforms->of_node = np_cpu;
> >
> >         rk_98090_headset_dev.codec_of_node = of_parse_phandle(np,
> >                         "rockchip,headset-codec", 0);
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
