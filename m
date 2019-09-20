Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287A4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5DC205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1RNBUSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfITNRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:17:23 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41646 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfITNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:17:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id l2so4638139vsr.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AoavR4xdj4/imYAiuw54/Vm4zeQLkNQ/AqS6//uaDts=;
        b=V1RNBUStYm4YGiq1I5LEaUO2XQ+YNj9NmMJV25hOSUesQL6D+kLBldLfBEWG7Q6rRR
         DzJ9X+0zQnsML7Ja+Wx7ItQUzdH47FbhipjeyiDcAZvAIe8QobS1467LliWkQWModgvc
         0nCB4dHVchQxkXkc5j53SXBnZ20XyrEaISU6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AoavR4xdj4/imYAiuw54/Vm4zeQLkNQ/AqS6//uaDts=;
        b=PCcnMGRXsGrU4bJgLubgGjDkU8tjYCAD53jZdObFvbHzNICihPnuO7yTSuNpxaw7zG
         NzZQCkWBFabxyi1OXVmc9vYv1AdWntF9snrLL60sdFzYDA8gPr5PG2Yx9hgT3D5uTZ6E
         Rks9GP6zeGPJmz4r1Rd+rwcXlbE4rkFUb7ROgVGrblzmy80gsKDiREeMZaPVjJOZhuzH
         qYxo80U7F+LamE4mylTkz2JLhfNtfReRmAGy9gy23OOXBlmIQO9VkHEepR0Wdn/XFoX0
         UXHcOsO0ke9Ibfh/npimgm8IAOQjOQyq7hE6qYTp719x3qqa8aZDC4kDRPDGkriEXDBv
         /mhg==
X-Gm-Message-State: APjAAAXLTwnPaCTOUWp6PTWllgbkGNo4VA1ulhMSYEjbWXEfjWBWDSHn
        ROqxE+ZnXs1KQf5i8BhSTNlooLBIRhRZnjmPHDkrWw==
X-Google-Smtp-Source: APXvYqyr874RxvV+yRv00SR1IyW6VriKg173lF+YV+LA2MVXngfVaiigsw3tuxmxgFkVbVohsefqji/oZ/Ltb9CTzU4=
X-Received: by 2002:a67:2b86:: with SMTP id r128mr2668415vsr.119.1568985440641;
 Fri, 20 Sep 2019 06:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190919135450.62309-1-cychiang@chromium.org> <20190919135450.62309-4-cychiang@chromium.org>
 <1660944.WuPFEyXK2U@jernej-laptop>
In-Reply-To: <1660944.WuPFEyXK2U@jernej-laptop>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Fri, 20 Sep 2019 21:16:54 +0800
Message-ID: <CAFv8Nw+DxXJQMs+iv7OWoM_ZLz3hZyrwrZLW0AbLVnfHdUvP=Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] ASoC: rockchip_max98090: Add dai_link for HDMI
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
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
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 11:08 PM Jernej =C5=A0krabec <jernej.skrabec@siol.n=
et> wrote:
>
> Hi!
>
> Dne =C4=8Detrtek, 19. september 2019 ob 15:54:49 CEST je Cheng-Yi Chiang
> napisal(a):
> > Use two dai_links. One for HDMI and one for max98090.
> > With this setup, audio can play to speaker and HDMI selectively.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../boot/dts/rk3288-veyron-analog-audio.dtsi  |   1 +
> >  sound/soc/rockchip/rockchip_max98090.c        | 129 ++++++++++++++----
> >  2 files changed, 103 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
> > b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi index
> > 445270aa136e..51208d161d65 100644
> > --- a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
> > +++ b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
> > @@ -17,6 +17,7 @@
> >               rockchip,hp-det-gpios =3D <&gpio6 RK_PA5
> GPIO_ACTIVE_HIGH>;
> >               rockchip,mic-det-gpios =3D <&gpio6 RK_PB3
> GPIO_ACTIVE_LOW>;
> >               rockchip,headset-codec =3D <&headsetcodec>;
> > +             rockchip,hdmi-codec =3D <&hdmi>;
> >       };
> >  };
> >
> > diff --git a/sound/soc/rockchip/rockchip_max98090.c
> > b/sound/soc/rockchip/rockchip_max98090.c index c5fc24675a33..6c217492bb=
30
> > 100644
> > --- a/sound/soc/rockchip/rockchip_max98090.c
> > +++ b/sound/soc/rockchip/rockchip_max98090.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/gpio.h>
> >  #include <linux/of_gpio.h>
> >  #include <sound/core.h>
> > +#include <sound/hdmi-codec.h>
> >  #include <sound/jack.h>
> >  #include <sound/pcm.h>
> >  #include <sound/pcm_params.h>
> > @@ -41,6 +42,7 @@ static const struct snd_soc_dapm_widget rk_dapm_widge=
ts[]
> > =3D { SND_SOC_DAPM_MIC("Headset Mic", NULL),
> >       SND_SOC_DAPM_MIC("Int Mic", NULL),
> >       SND_SOC_DAPM_SPK("Speaker", NULL),
> > +     SND_SOC_DAPM_LINE("HDMI", NULL),
> >  };
> >
> >  static const struct snd_soc_dapm_route rk_audio_map[] =3D {
> > @@ -52,6 +54,7 @@ static const struct snd_soc_dapm_route rk_audio_map[]=
 =3D {
> >       {"Headphone", NULL, "HPR"},
> >       {"Speaker", NULL, "SPKL"},
> >       {"Speaker", NULL, "SPKR"},
> > +     {"HDMI", NULL, "TX"},
> >  };
> >
> >  static const struct snd_kcontrol_new rk_mc_controls[] =3D {
> > @@ -59,6 +62,7 @@ static const struct snd_kcontrol_new rk_mc_controls[]=
 =3D {
> >       SOC_DAPM_PIN_SWITCH("Headset Mic"),
> >       SOC_DAPM_PIN_SWITCH("Int Mic"),
> >       SOC_DAPM_PIN_SWITCH("Speaker"),
> > +     SOC_DAPM_PIN_SWITCH("HDMI"),
> >  };
> >
> >  static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
> > @@ -92,38 +96,63 @@ static int rk_aif1_hw_params(struct snd_pcm_substre=
am
> > *substream,
> >
> >       ret =3D snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
> >                                    SND_SOC_CLOCK_OUT);
> > -     if (ret < 0) {
> > -             dev_err(codec_dai->dev, "Can't set codec clock %d\n",
> ret);
> > +     if (ret) {
> > +             dev_err(cpu_dai->dev, "Can't set cpu dai clock %d\n",
> ret);
> >               return ret;
> >       }
> >
> > +     /* HDMI codec dai does not need to set sysclk. */
> > +     if (!strcmp(rtd->dai_link->name, "HDMI"))
> > +             return 0;
> > +
> >       ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
> >                                    SND_SOC_CLOCK_IN);
> > -     if (ret < 0) {
> > -             dev_err(codec_dai->dev, "Can't set codec clock %d\n",
> ret);
> > +     if (ret) {
> > +             dev_err(codec_dai->dev, "Can't set codec dai clock
> %d\n", ret);
> >               return ret;
> >       }
> >
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static const struct snd_soc_ops rk_aif1_ops =3D {
> >       .hw_params =3D rk_aif1_hw_params,
> >  };
> >
> > -SND_SOC_DAILINK_DEFS(hifi,
> > -     DAILINK_COMP_ARRAY(COMP_EMPTY()),
> > -     DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
> > -     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> > -
> > -static struct snd_soc_dai_link rk_dailink =3D {
> > -     .name =3D "max98090",
> > -     .stream_name =3D "Audio",
> > -     .ops =3D &rk_aif1_ops,
> > -     /* set max98090 as slave */
> > -     .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > -             SND_SOC_DAIFMT_CBS_CFS,
> > -     SND_SOC_DAILINK_REG(hifi),
> > +SND_SOC_DAILINK_DEFS(analog,
> > +                  DAILINK_COMP_ARRAY(COMP_EMPTY()),
> > +                  DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
> > +                  DAILINK_COMP_ARRAY(COMP_EMPTY()));
> > +
> > +SND_SOC_DAILINK_DEFS(hdmi,
> > +                  DAILINK_COMP_ARRAY(COMP_EMPTY()),
> > +                  DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "i2s-hifi")),
> > +                  DAILINK_COMP_ARRAY(COMP_EMPTY()));
> > +
> > +enum {
> > +     DAILINK_MAX98090,
> > +     DAILINK_HDMI,
> > +};
> > +
> > +/* max98090 and HDMI codec dai_link */
> > +static struct snd_soc_dai_link rk_dailinks[] =3D {
> > +     [DAILINK_MAX98090] =3D {
> > +             .name =3D "max98090",
> > +             .stream_name =3D "Analog",
> > +             .ops =3D &rk_aif1_ops,
> > +             /* set max98090 as slave */
> > +             .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > +                     SND_SOC_DAIFMT_CBS_CFS,
> > +             SND_SOC_DAILINK_REG(analog),
> > +     },
> > +     [DAILINK_HDMI] =3D {
> > +             .name =3D "HDMI",
> > +             .stream_name =3D "HDMI",
> > +             .ops =3D &rk_aif1_ops,
> > +             .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > +                     SND_SOC_DAIFMT_CBS_CFS,
> > +             SND_SOC_DAILINK_REG(hdmi),
> > +     }
> >  };
> >
> >  static int rk_98090_headset_init(struct snd_soc_component *component);
> > @@ -136,8 +165,8 @@ static struct snd_soc_aux_dev rk_98090_headset_dev =
=3D {
> >  static struct snd_soc_card snd_soc_card_rk =3D {
> >       .name =3D "ROCKCHIP-I2S",
> >       .owner =3D THIS_MODULE,
> > -     .dai_link =3D &rk_dailink,
> > -     .num_links =3D 1,
> > +     .dai_link =3D rk_dailinks,
> > +     .num_links =3D ARRAY_SIZE(rk_dailinks),
> >       .aux_dev =3D &rk_98090_headset_dev,
> >       .num_aux_devs =3D 1,
> >       .dapm_widgets =3D rk_dapm_widgets,
> > @@ -173,27 +202,73 @@ static int snd_rk_mc_probe(struct platform_device
> > *pdev) int ret =3D 0;
> >       struct snd_soc_card *card =3D &snd_soc_card_rk;
> >       struct device_node *np =3D pdev->dev.of_node;
> > +     struct device_node *np_analog;
> > +     struct device_node *np_cpu;
> > +     struct device_node *np_hdmi_codec;
> > +     struct of_phandle_args args;
> >
> >       /* register the soc card */
> >       card->dev =3D &pdev->dev;
> >
> > -     rk_dailink.codecs->of_node =3D of_parse_phandle(np,
> > -                     "rockchip,audio-codec", 0);
> > -     if (!rk_dailink.codecs->of_node) {
> > +     np_analog =3D of_parse_phandle(np, "rockchip,audio-codec", 0);
> > +     if (!np_analog) {
> >               dev_err(&pdev->dev,
> >                       "Property 'rockchip,audio-codec' missing or
> invalid\n");
> >               return -EINVAL;
> >       }
> > +     rk_dailinks[DAILINK_MAX98090].codecs->of_node =3D np_analog;
> > +
> > +     ret =3D of_parse_phandle_with_fixed_args(np, "rockchip,audio-code=
c",
> > +                                            0, 0, &args);
> > +     if (ret) {
> > +             dev_err(&pdev->dev,
> > +                     "Unable to parse property 'rockchip,audio-
> codec'\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D snd_soc_get_dai_name(
> > +                     &args, &rk_dailinks[DAILINK_MAX98090].codecs-
> >dai_name);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Unable to get codec dai_name\n");
> > +             return ret;
> > +     }
> > +
> > +     np_cpu =3D of_parse_phandle(np, "rockchip,i2s-controller", 0);
> >
> > -     rk_dailink.cpus->of_node =3D of_parse_phandle(np,
> > -                     "rockchip,i2s-controller", 0);
> > -     if (!rk_dailink.cpus->of_node) {
> > +     if (!np_cpu) {
> >               dev_err(&pdev->dev,
> >                       "Property 'rockchip,i2s-controller' missing
> or invalid\n");
> >               return -EINVAL;
> >       }
> >
> > -     rk_dailink.platforms->of_node =3D rk_dailink.cpus->of_node;
> > +     np_hdmi_codec =3D of_parse_phandle(np, "rockchip,hdmi-codec", 0);
> > +     if (!np_hdmi_codec) {
> > +             dev_err(&pdev->dev,
> > +                     "Property 'rockchip,hdmi-codec' missing or
> invalid\n");
> > +             return -EINVAL;
> > +     }
>
> Property "rockchip,hdmi-codec" is added in this series, right? You can't =
make
> it mandatory, because kernel must be backward compatible with old device =
tree
> files and they don't have this property.
>
> Think about use case when user happily used this driver and after kernel
> update, it suddenly stops working. You can't assume that board DTB file w=
ill be
> updated along with kernel update.
>
> Just make it optional and don't expose jack functionality if it's not pre=
sent.
Hi Jernej,
Thanks for the reply.
I see. Yes I can make it optional.
But it will become a little bit messy for two types of usage to share
one machine driver.

I think I will create two instances of structs for

dapm widgets,
dapm routes,
kcontrols,
dai_links

for "max98090 only" and "max98090+hdmi"

and set those fields in snd_soc_card depending on depending on the property=
.
These two usages can still share most of the function calls.
Hope this looks clean.

If you have a cleaner way of sharing machine driver please let me know.
I'll post an update probably next week.
Thanks a lot!


>
> Best regards,
> Jernej
>
> > +
> > +     rk_dailinks[DAILINK_HDMI].codecs->of_node =3D np_hdmi_codec;
> > +
> > +     ret =3D of_parse_phandle_with_fixed_args(np, "rockchip,hdmi-codec=
",
> > +                                            0, 0, &args);
> > +     if (ret) {
> > +             dev_err(&pdev->dev,
> > +                     "Unable to parse property 'rockchip,hdmi-
> codec'\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D snd_soc_get_dai_name(
> > +                     &args, &rk_dailinks[DAILINK_HDMI].codecs-
> >dai_name);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Unable to get hdmi codec
> dai_name\n");
> > +             return ret;
> > +     }
> > +
> > +     rk_dailinks[DAILINK_MAX98090].cpus->of_node =3D np_cpu;
> > +     rk_dailinks[DAILINK_MAX98090].platforms->of_node =3D np_cpu;
> > +     rk_dailinks[DAILINK_HDMI].cpus->of_node =3D np_cpu;
> > +     rk_dailinks[DAILINK_HDMI].platforms->of_node =3D np_cpu;
> >
> >       rk_98090_headset_dev.codec_of_node =3D of_parse_phandle(np,
> >                       "rockchip,headset-codec", 0);
>
>
>
>
