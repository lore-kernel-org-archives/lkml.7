Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05347C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C005C206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siwyzn1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfGaLTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:19:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39207 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfGaLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:19:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so16083694wrt.6;
        Wed, 31 Jul 2019 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=249Tk7pJLhkH6dKEkJPPjfgArbiJqypC5jRcZzcgcv4=;
        b=siwyzn1hd+ANkqVt2/KMyUOMusnyUtFRj/sVQ2MzgddSDf/s9FP10LSZD5No+bxt7j
         6A6lI9eyUHF0FNxkrBbCYKsmMTTK0ZTURSLpS+dHyU9/3mFaXX0qCIqNAN2MOZS586lB
         Fc9Y6u57f1a7x1T8ODnRlsogjWsw/dP/mRDxRvuShoVICg6sMShCHc/3dHicvMGEYXvR
         g7wC6LGtuoI5mmYhCbRRG7ghIZdP0GLxpFF0WpAiOe7fJV8G/cVXGNtcO9f880pLcTnN
         f9Aguiu8TTNgYdSkioKoRh09PzIzWtO1rNd6A4Burj0PWTEsyU4cNMdQH8ggkijIO6G0
         ceAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=249Tk7pJLhkH6dKEkJPPjfgArbiJqypC5jRcZzcgcv4=;
        b=JEHGg2A1zp7p572OSGAFHRs9gA17ySUCNLQodM4XMVCgFxcQ5eJEcYirdFT6wENOVc
         pIvzIWla6neM8FRvHfWJkGH2jsJSH/8lxZt477TUPTKGzxF64sRBaZaW+P59pt2K4kjL
         U3zK99FsPerGQ8Eg7pIYox997QRexnQK2xJ0d4PzILo/8Urnsg4KJRthtm4yDhfglB9l
         ry/qL7INwBQwsvyO0Vgb85DLMVJRM2bGeACm7zZcbUFAJ+cWWnddmxiBA4MsVUsKg/wR
         2rsJhrPPyaDMkF26LHoCLkLaSw/Me9QQbajLbFyNSVfC5rYCswD50bmy+0iSDQyKQKx6
         pIpA==
X-Gm-Message-State: APjAAAVKNA2AtHxuRh5zojtK1jkJ+O5Xvx5Q7YsIGkNFzH+VkrEofmk8
        dfbo0uh7KI54IOr11MlUME0=
X-Google-Smtp-Source: APXvYqwZcDJk/YfJ8qxOLYiLjYl2vIfbhOAIwxf+wLhU1k2gxzwk63JhT2KvzW2jwNVGuFOt1vU4dQ==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr59063488wrs.36.1564571987783;
        Wed, 31 Jul 2019 04:19:47 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id b8sm88035205wmh.46.2019.07.31.04.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 04:19:47 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.wolfsonmicro.com, srinivas.kandagatla@linaro.org,
        piotrs@opensource.cirrus.com, paul@crapouillou.net,
        kmarinushkin@birdec.tech, anders.roxell@linaro.org,
        jbrunet@baylibre.com, m.felsch@pengutronix.de, vkoul@kernel.org,
        nh6z@nh6z.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com
Subject: [PATCH 2/2] ASoC: codecs: Add uda1334 codec driver
Date:   Wed, 31 Jul 2019 14:19:30 +0300
Message-Id: <20190731111930.20230-3-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190731111930.20230-1-andradanciu1997@gmail.com>
References: <20190731111930.20230-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UDA1334BTS supports the I2S-bus data format with word lengths of up
to 24 bits serial data format and has basic features such as de-emphasis
(at 44.1 kHz sampling rate) and mute.

Datasheet can be found at:
https://www.nxp.com/docs/en/data-sheet/UDA1334BTS.pdf

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/codecs/Kconfig   |   9 ++
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/uda1334.c | 295 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 sound/soc/codecs/uda1334.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index da4c1ae89742..89238343e34d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -199,6 +199,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TS3A227E if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
 	select SND_SOC_TWL6040 if TWL6040_CORE
+	select SND_SOC_UDA1334 if GPIOLIB
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WCD9335 if SLIMBUS
@@ -1207,6 +1208,14 @@ config SND_SOC_TWL4030
 config SND_SOC_TWL6040
 	tristate
 
+config SND_SOC_UDA1334
+	tristate "NXP UDA1334 DAC"
+	depends on GPIOLIB
+	help
+	  The UDA1334 is an NXP audio codec, supports the I2S-bus data format
+	  and has basic features such as de-emphasis (at 44.1 kHz sampling
+	  rate) and mute.
+
 config SND_SOC_UDA134X
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9230016b0f9f..c498373dcc5f 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -212,6 +212,7 @@ snd-soc-tscs454-objs := tscs454.o
 snd-soc-ts3a227e-objs := ts3a227e.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
+snd-soc-uda1334-objs := uda1334.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wcd9335-objs := wcd-clsh-v2.o wcd9335.o
@@ -494,6 +495,7 @@ obj-$(CONFIG_SND_SOC_TSCS454)	+= snd-soc-tscs454.o
 obj-$(CONFIG_SND_SOC_TS3A227E)	+= snd-soc-ts3a227e.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
+obj-$(CONFIG_SND_SOC_UDA1334)	+= snd-soc-uda1334.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
diff --git a/sound/soc/codecs/uda1334.c b/sound/soc/codecs/uda1334.c
new file mode 100644
index 000000000000..21ab8c5487ba
--- /dev/null
+++ b/sound/soc/codecs/uda1334.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// uda1334.c  --  UDA1334 ALSA SoC Audio driver
+//
+// Based on WM8523 ALSA SoC Audio driver written by Mark Brown
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+
+#define UDA1334_NUM_RATES 6
+
+/* codec private data */
+struct uda1334_priv {
+	struct gpio_desc *mute;
+	struct gpio_desc *deemph;
+	unsigned int sysclk;
+	unsigned int rate_constraint_list[UDA1334_NUM_RATES];
+	struct snd_pcm_hw_constraint_list rate_constraint;
+};
+
+static const struct snd_soc_dapm_widget uda1334_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_OUTPUT("LINEVOUTL"),
+SND_SOC_DAPM_OUTPUT("LINEVOUTR"),
+};
+
+static const struct snd_soc_dapm_route uda1334_dapm_routes[] = {
+	{ "LINEVOUTL", NULL, "DAC" },
+	{ "LINEVOUTR", NULL, "DAC" },
+};
+
+static int uda1334_put_deemph(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct uda1334_priv *uda1334 = snd_soc_component_get_drvdata(component);
+	int deemph = ucontrol->value.integer.value[0];
+
+	if (deemph > 1)
+		return -EINVAL;
+
+	gpiod_set_value_cansleep(uda1334->deemph, deemph);
+
+	return 0;
+};
+
+static int uda1334_get_deemph(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct uda1334_priv *uda1334 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ret = gpiod_get_value_cansleep(uda1334->deemph);
+	if (ret < 0)
+		return -EINVAL;
+
+	ucontrol->value.integer.value[0] = ret;
+
+	return 0;
+};
+
+static const struct snd_kcontrol_new uda1334_snd_controls[] = {
+	SOC_SINGLE_BOOL_EXT("Playback Deemphasis Switch", 0,
+			    uda1334_get_deemph, uda1334_put_deemph),
+};
+
+static const struct {
+	int value;
+	int ratio;
+} lrclk_ratios[UDA1334_NUM_RATES] = {
+	{ 1, 128 },
+	{ 2, 192 },
+	{ 3, 256 },
+	{ 4, 384 },
+	{ 5, 512 },
+	{ 6, 768 },
+};
+
+static int uda1334_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct uda1334_priv *uda1334 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * The set of sample rates that can be supported depends on the
+	 * MCLK supplied to the CODEC - enforce this.
+	 */
+	if (!uda1334->sysclk) {
+		dev_err(component->dev,
+			"No MCLK configured, call set_sysclk() on init\n");
+		return -EINVAL;
+	}
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   &uda1334->rate_constraint);
+
+	gpiod_set_value_cansleep(uda1334->mute, 1);
+
+	return 0;
+}
+
+static void uda1334_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct uda1334_priv *uda1334 = snd_soc_component_get_drvdata(component);
+
+	gpiod_set_value_cansleep(uda1334->mute, 0);
+}
+
+static int uda1334_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct uda1334_priv *uda1334 = snd_soc_component_get_drvdata(component);
+	unsigned int val;
+	int i, j = 0;
+
+	uda1334->sysclk = freq;
+
+	uda1334->rate_constraint.count = 0;
+	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
+		val = freq / lrclk_ratios[i].ratio;
+		/*
+		 * Check that it's a standard rate since core can't
+		 * cope with others and having the odd rates confuses
+		 * constraint matching.
+		 */
+
+		switch (val) {
+		case 8000:
+		case 32000:
+		case 44100:
+		case 48000:
+		case 64000:
+		case 88200:
+		case 96000:
+			dev_dbg(component->dev, "Supported sample rate: %dHz\n",
+				val);
+			uda1334->rate_constraint_list[j++] = val;
+			uda1334->rate_constraint.count++;
+			break;
+		default:
+			dev_dbg(component->dev, "Skipping sample rate: %dHz\n",
+				val);
+		}
+	}
+
+	/* Need at least one supported rate... */
+	if (uda1334->rate_constraint.count == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int uda1334_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	fmt &= (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK |
+		SND_SOC_DAIFMT_MASTER_MASK);
+
+	if (fmt != (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		    SND_SOC_DAIFMT_CBS_CFS)) {
+		dev_err(codec_dai->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int uda1334_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct uda1334_priv *uda1334 = snd_soc_component_get_drvdata(dai->component);
+
+	if (uda1334->mute)
+		gpiod_set_value_cansleep(uda1334->mute, mute);
+
+	return 0;
+}
+
+#define UDA1334_RATES SNDRV_PCM_RATE_8000_96000
+
+#define UDA1334_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+static const struct snd_soc_dai_ops uda1334_dai_ops = {
+	.startup	= uda1334_startup,
+	.shutdown	= uda1334_shutdown,
+	.set_sysclk	= uda1334_set_dai_sysclk,
+	.set_fmt	= uda1334_set_fmt,
+	.mute_stream	= uda1334_mute_stream,
+};
+
+static struct snd_soc_dai_driver uda1334_dai = {
+	.name = "uda1334-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = UDA1334_RATES,
+		.formats = UDA1334_FORMATS,
+	},
+	.ops = &uda1334_dai_ops,
+};
+
+static int uda1334_probe(struct snd_soc_component *component)
+{
+	struct uda1334_priv *uda1334 = snd_soc_component_get_drvdata(component);
+
+	uda1334->rate_constraint.list = &uda1334->rate_constraint_list[0];
+	uda1334->rate_constraint.count =
+		ARRAY_SIZE(uda1334->rate_constraint_list);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_component_dev_uda1334 = {
+	.probe			= uda1334_probe,
+	.controls		= uda1334_snd_controls,
+	.num_controls		= ARRAY_SIZE(uda1334_snd_controls),
+	.dapm_widgets		= uda1334_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(uda1334_dapm_widgets),
+	.dapm_routes		= uda1334_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(uda1334_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static const struct of_device_id uda1334_of_match[] = {
+	{ .compatible = "nxp,uda1334" },
+	{ /* sentinel*/ }
+};
+MODULE_DEVICE_TABLE(of, uda1334_of_match);
+
+static int uda1334_codec_probe(struct platform_device *pdev)
+{
+	struct uda1334_priv *uda1334;
+	int ret;
+
+	uda1334 = devm_kzalloc(&pdev->dev, sizeof(struct uda1334_priv),
+			       GFP_KERNEL);
+	if (!uda1334)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, uda1334);
+
+	uda1334->mute = devm_gpiod_get(&pdev->dev, "nxp,mute", GPIOD_OUT_LOW);
+	if (IS_ERR(uda1334->mute)) {
+		ret = PTR_ERR(uda1334->mute);
+		dev_err(&pdev->dev, "Failed to get mute line: %d\n", ret);
+		return ret;
+	}
+
+	uda1334->deemph = devm_gpiod_get(&pdev->dev, "nxp,deemph", GPIOD_OUT_LOW);
+	if (IS_ERR(uda1334->deemph)) {
+		ret = PTR_ERR(uda1334->deemph);
+		dev_err(&pdev->dev, "Failed to get deemph line: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &soc_component_dev_uda1334,
+					      &uda1334_dai, 1);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver uda1334_codec_driver = {
+	.probe		= uda1334_codec_probe,
+	.driver		= {
+		.name	= "uda1334-codec",
+		.of_match_table = uda1334_of_match,
+	},
+};
+module_platform_driver(uda1334_codec_driver);
+
+MODULE_DESCRIPTION("ASoC UDA1334 driver");
+MODULE_AUTHOR("Andra Danciu <andradanciu1997@gmail.com>");
+MODULE_ALIAS("platform:uda1334-codec");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

