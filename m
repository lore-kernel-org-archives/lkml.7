Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B28C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E943621848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbfISPIW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:08:22 -0400
Received: from mailoutvs37.siol.net ([185.57.226.228]:56510 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388808AbfISPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:08:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9783A52321B;
        Thu, 19 Sep 2019 17:08:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qXh4faEEmrjJ; Thu, 19 Sep 2019 17:08:15 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CD1F6523266;
        Thu, 19 Sep 2019 17:08:14 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 1BCEA52321B;
        Thu, 19 Sep 2019 17:08:10 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
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
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 3/4] ASoC: rockchip_max98090: Add dai_link for HDMI
Date:   Thu, 19 Sep 2019 17:08:09 +0200
Message-ID: <1660944.WuPFEyXK2U@jernej-laptop>
In-Reply-To: <20190919135450.62309-4-cychiang@chromium.org>
References: <20190919135450.62309-1-cychiang@chromium.org> <20190919135450.62309-4-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne četrtek, 19. september 2019 ob 15:54:49 CEST je Cheng-Yi Chiang 
napisal(a):
> Use two dai_links. One for HDMI and one for max98090.
> With this setup, audio can play to speaker and HDMI selectively.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../boot/dts/rk3288-veyron-analog-audio.dtsi  |   1 +
>  sound/soc/rockchip/rockchip_max98090.c        | 129 ++++++++++++++----
>  2 files changed, 103 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
> b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi index
> 445270aa136e..51208d161d65 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
> @@ -17,6 +17,7 @@
>  		rockchip,hp-det-gpios = <&gpio6 RK_PA5 
GPIO_ACTIVE_HIGH>;
>  		rockchip,mic-det-gpios = <&gpio6 RK_PB3 
GPIO_ACTIVE_LOW>;
>  		rockchip,headset-codec = <&headsetcodec>;
> +		rockchip,hdmi-codec = <&hdmi>;
>  	};
>  };
> 
> diff --git a/sound/soc/rockchip/rockchip_max98090.c
> b/sound/soc/rockchip/rockchip_max98090.c index c5fc24675a33..6c217492bb30
> 100644
> --- a/sound/soc/rockchip/rockchip_max98090.c
> +++ b/sound/soc/rockchip/rockchip_max98090.c
> @@ -11,6 +11,7 @@
>  #include <linux/gpio.h>
>  #include <linux/of_gpio.h>
>  #include <sound/core.h>
> +#include <sound/hdmi-codec.h>
>  #include <sound/jack.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
> @@ -41,6 +42,7 @@ static const struct snd_soc_dapm_widget rk_dapm_widgets[]
> = { SND_SOC_DAPM_MIC("Headset Mic", NULL),
>  	SND_SOC_DAPM_MIC("Int Mic", NULL),
>  	SND_SOC_DAPM_SPK("Speaker", NULL),
> +	SND_SOC_DAPM_LINE("HDMI", NULL),
>  };
> 
>  static const struct snd_soc_dapm_route rk_audio_map[] = {
> @@ -52,6 +54,7 @@ static const struct snd_soc_dapm_route rk_audio_map[] = {
>  	{"Headphone", NULL, "HPR"},
>  	{"Speaker", NULL, "SPKL"},
>  	{"Speaker", NULL, "SPKR"},
> +	{"HDMI", NULL, "TX"},
>  };
> 
>  static const struct snd_kcontrol_new rk_mc_controls[] = {
> @@ -59,6 +62,7 @@ static const struct snd_kcontrol_new rk_mc_controls[] = {
>  	SOC_DAPM_PIN_SWITCH("Headset Mic"),
>  	SOC_DAPM_PIN_SWITCH("Int Mic"),
>  	SOC_DAPM_PIN_SWITCH("Speaker"),
> +	SOC_DAPM_PIN_SWITCH("HDMI"),
>  };
> 
>  static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
> @@ -92,38 +96,63 @@ static int rk_aif1_hw_params(struct snd_pcm_substream
> *substream,
> 
>  	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
>  				     SND_SOC_CLOCK_OUT);
> -	if (ret < 0) {
> -		dev_err(codec_dai->dev, "Can't set codec clock %d\n", 
ret);
> +	if (ret) {
> +		dev_err(cpu_dai->dev, "Can't set cpu dai clock %d\n", 
ret);
>  		return ret;
>  	}
> 
> +	/* HDMI codec dai does not need to set sysclk. */
> +	if (!strcmp(rtd->dai_link->name, "HDMI"))
> +		return 0;
> +
>  	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
>  				     SND_SOC_CLOCK_IN);
> -	if (ret < 0) {
> -		dev_err(codec_dai->dev, "Can't set codec clock %d\n", 
ret);
> +	if (ret) {
> +		dev_err(codec_dai->dev, "Can't set codec dai clock 
%d\n", ret);
>  		return ret;
>  	}
> 
> -	return ret;
> +	return 0;
>  }
> 
>  static const struct snd_soc_ops rk_aif1_ops = {
>  	.hw_params = rk_aif1_hw_params,
>  };
> 
> -SND_SOC_DAILINK_DEFS(hifi,
> -	DAILINK_COMP_ARRAY(COMP_EMPTY()),
> -	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
> -	DAILINK_COMP_ARRAY(COMP_EMPTY()));
> -
> -static struct snd_soc_dai_link rk_dailink = {
> -	.name = "max98090",
> -	.stream_name = "Audio",
> -	.ops = &rk_aif1_ops,
> -	/* set max98090 as slave */
> -	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> -		SND_SOC_DAIFMT_CBS_CFS,
> -	SND_SOC_DAILINK_REG(hifi),
> +SND_SOC_DAILINK_DEFS(analog,
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
> +		     DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +SND_SOC_DAILINK_DEFS(hdmi,
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
> +		     DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "i2s-hifi")),
> +		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
> +
> +enum {
> +	DAILINK_MAX98090,
> +	DAILINK_HDMI,
> +};
> +
> +/* max98090 and HDMI codec dai_link */
> +static struct snd_soc_dai_link rk_dailinks[] = {
> +	[DAILINK_MAX98090] = {
> +		.name = "max98090",
> +		.stream_name = "Analog",
> +		.ops = &rk_aif1_ops,
> +		/* set max98090 as slave */
> +		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBS_CFS,
> +		SND_SOC_DAILINK_REG(analog),
> +	},
> +	[DAILINK_HDMI] = {
> +		.name = "HDMI",
> +		.stream_name = "HDMI",
> +		.ops = &rk_aif1_ops,
> +		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBS_CFS,
> +		SND_SOC_DAILINK_REG(hdmi),
> +	}
>  };
> 
>  static int rk_98090_headset_init(struct snd_soc_component *component);
> @@ -136,8 +165,8 @@ static struct snd_soc_aux_dev rk_98090_headset_dev = {
>  static struct snd_soc_card snd_soc_card_rk = {
>  	.name = "ROCKCHIP-I2S",
>  	.owner = THIS_MODULE,
> -	.dai_link = &rk_dailink,
> -	.num_links = 1,
> +	.dai_link = rk_dailinks,
> +	.num_links = ARRAY_SIZE(rk_dailinks),
>  	.aux_dev = &rk_98090_headset_dev,
>  	.num_aux_devs = 1,
>  	.dapm_widgets = rk_dapm_widgets,
> @@ -173,27 +202,73 @@ static int snd_rk_mc_probe(struct platform_device
> *pdev) int ret = 0;
>  	struct snd_soc_card *card = &snd_soc_card_rk;
>  	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np_analog;
> +	struct device_node *np_cpu;
> +	struct device_node *np_hdmi_codec;
> +	struct of_phandle_args args;
> 
>  	/* register the soc card */
>  	card->dev = &pdev->dev;
> 
> -	rk_dailink.codecs->of_node = of_parse_phandle(np,
> -			"rockchip,audio-codec", 0);
> -	if (!rk_dailink.codecs->of_node) {
> +	np_analog = of_parse_phandle(np, "rockchip,audio-codec", 0);
> +	if (!np_analog) {
>  		dev_err(&pdev->dev,
>  			"Property 'rockchip,audio-codec' missing or 
invalid\n");
>  		return -EINVAL;
>  	}
> +	rk_dailinks[DAILINK_MAX98090].codecs->of_node = np_analog;
> +
> +	ret = of_parse_phandle_with_fixed_args(np, "rockchip,audio-codec",
> +					       0, 0, &args);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Unable to parse property 'rockchip,audio-
codec'\n");
> +		return ret;
> +	}
> +
> +	ret = snd_soc_get_dai_name(
> +			&args, &rk_dailinks[DAILINK_MAX98090].codecs-
>dai_name);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to get codec dai_name\n");
> +		return ret;
> +	}
> +
> +	np_cpu = of_parse_phandle(np, "rockchip,i2s-controller", 0);
> 
> -	rk_dailink.cpus->of_node = of_parse_phandle(np,
> -			"rockchip,i2s-controller", 0);
> -	if (!rk_dailink.cpus->of_node) {
> +	if (!np_cpu) {
>  		dev_err(&pdev->dev,
>  			"Property 'rockchip,i2s-controller' missing 
or invalid\n");
>  		return -EINVAL;
>  	}
> 
> -	rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
> +	np_hdmi_codec = of_parse_phandle(np, "rockchip,hdmi-codec", 0);
> +	if (!np_hdmi_codec) {
> +		dev_err(&pdev->dev,
> +			"Property 'rockchip,hdmi-codec' missing or 
invalid\n");
> +		return -EINVAL;
> +	}

Property "rockchip,hdmi-codec" is added in this series, right? You can't make 
it mandatory, because kernel must be backward compatible with old device tree 
files and they don't have this property.

Think about use case when user happily used this driver and after kernel 
update, it suddenly stops working. You can't assume that board DTB file will be 
updated along with kernel update.

Just make it optional and don't expose jack functionality if it's not present.

Best regards,
Jernej

> +
> +	rk_dailinks[DAILINK_HDMI].codecs->of_node = np_hdmi_codec;
> +
> +	ret = of_parse_phandle_with_fixed_args(np, "rockchip,hdmi-codec",
> +					       0, 0, &args);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Unable to parse property 'rockchip,hdmi-
codec'\n");
> +		return ret;
> +	}
> +
> +	ret = snd_soc_get_dai_name(
> +			&args, &rk_dailinks[DAILINK_HDMI].codecs-
>dai_name);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to get hdmi codec 
dai_name\n");
> +		return ret;
> +	}
> +
> +	rk_dailinks[DAILINK_MAX98090].cpus->of_node = np_cpu;
> +	rk_dailinks[DAILINK_MAX98090].platforms->of_node = np_cpu;
> +	rk_dailinks[DAILINK_HDMI].cpus->of_node = np_cpu;
> +	rk_dailinks[DAILINK_HDMI].platforms->of_node = np_cpu;
> 
>  	rk_98090_headset_dev.codec_of_node = of_parse_phandle(np,
>  			"rockchip,headset-codec", 0);




