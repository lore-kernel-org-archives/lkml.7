Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B927C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B7720873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CGC57N2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfEONTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:19:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55802 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfEONTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:19:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so2643741wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2l6cV/XBERtzMJN9MOTGY475jDhdiqP66F5DuNPZchA=;
        b=CGC57N2dTGbsXRGtWoOCsuPXcWdTNYdtBnNwGPHVxj/xgHCEmAU+fWutrPVXsGWrtX
         ivDqS0xAD9YMFpwOaXT2zSBZxxAPBp1KpSt/mzgPPbWwI37tVaeFluhbumSfyybfzW/b
         5kZ4ZPJePgq5ZkOveKQw+IkgnH+gjijoiihuWZOvmUL8a7ujnsjSdQ2PjDvtZ+qDwRSz
         JyE4d0T94VpJ6Nb5ojSOgEsu6eCOYVI1SG4sXKIcc0YXUVEl1oTm0oYae/nhbXHC+D4W
         dkg22QmikZSOFjdYhAMkbAX3rTcV41NIglH2PrUJB/sYBkaUianICIhSQiXq560vFDe9
         Ys3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2l6cV/XBERtzMJN9MOTGY475jDhdiqP66F5DuNPZchA=;
        b=i2cNziO3R/byXE+C/8sDN5PL0voAysadaH1xdLvYsbjO2EjBn/b33gEVtwfGvmJhV2
         mzfUCAb5Kr32y0K7QasFuT3jGtLLJ1cCQRRjBn5wp+XMCgCFg/4Ut4k59lKVbl3KZ4u7
         IJCUnERZ2lxGKnfwFjlzt1ZRIaMCcy8RD9G991aQlJGactgrpJ7RGAkF0Lpp7w1/AUBR
         20QvtOkVgOUbzJLceCVbegJW7kSnpKlZ42W7QV8fP3NnkZFiiqjFmC1mR4THeEWRPrfu
         Z6nhQ3KCUyPdnGtPg0KeIHfVu8G97fXFV3GehCEtCbgL3oy473/adp0h+IMdsdUE4KG6
         M3Yg==
X-Gm-Message-State: APjAAAUuYt5IoDnQiu+7QShsHVJ7K5sTEKkYZ8l1rgOiQenAzUI/xB9/
        wOqVpjOQglhicQ5Jftzv89xFaA==
X-Google-Smtp-Source: APXvYqzV9IrpFP9v8rb7MSFaAjwig9e+NH7CRTqfvbqgP9tO28VK202yRIKwpDr1/QkYKbKCB1e97Q==
X-Received: by 2002:a1c:a695:: with SMTP id p143mr23747745wme.128.1557926348128;
        Wed, 15 May 2019 06:19:08 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b206sm2789848wmd.28.2019.05.15.06.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:19:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 5/5] ASoC: meson: add g12a tohdmitx control
Date:   Wed, 15 May 2019 15:18:58 +0200
Message-Id: <20190515131858.32130-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the hdmitx control glue of the Amlogic g12a SoC family.
This glue links the 3 TDM and 2 SPDIF output interfaces of the SoC to
the related inputs of the Synopsys HDMI controller found in these SoCs.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig         |   8 +
 sound/soc/meson/Makefile        |   2 +
 sound/soc/meson/g12a-tohdmitx.c | 413 ++++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 sound/soc/meson/g12a-tohdmitx.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 8779fe23671d..4e5b4d4f3531 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -56,6 +56,7 @@ config SND_MESON_AXG_SOUND_CARD
 	imply SND_MESON_AXG_SPDIFOUT
 	imply SND_MESON_AXG_SPDIFIN
 	imply SND_MESON_AXG_PDM
+	imply SND_MESON_G12A_TOHDMITX if DRM_MESON_DW_HDMI
 	help
 	  Select Y or M to add support for the AXG SoC sound card
 
@@ -82,4 +83,11 @@ config SND_MESON_AXG_PDM
 	help
 	  Select Y or M to add support for PDM input embedded
 	  in the Amlogic AXG SoC family
+
+config SND_MESON_G12A_TOHDMITX
+	tristate "Amlogic G12A To HDMI TX Control Support"
+	imply SND_SOC_HDMI_CODEC
+	help
+	  Select Y or M to add support for HDMI audio on the g12a SoC
+	  family
 endmenu
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index b45dfb9e2f88..1a8b1470ed84 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -11,6 +11,7 @@ snd-soc-meson-axg-sound-card-objs := axg-card.o
 snd-soc-meson-axg-spdifin-objs := axg-spdifin.o
 snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 snd-soc-meson-axg-pdm-objs := axg-pdm.o
+snd-soc-meson-g12a-tohdmitx-objs := g12a-tohdmitx.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
 obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
@@ -23,3 +24,4 @@ obj-$(CONFIG_SND_MESON_AXG_SOUND_CARD) += snd-soc-meson-axg-sound-card.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFIN) += snd-soc-meson-axg-spdifin.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
 obj-$(CONFIG_SND_MESON_AXG_PDM) += snd-soc-meson-axg-pdm.o
+obj-$(CONFIG_SND_MESON_G12A_TOHDMITX) += snd-soc-meson-g12a-tohdmitx.o
diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
new file mode 100644
index 000000000000..707ccb192e4c
--- /dev/null
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2019 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <sound/pcm_params.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+#define G12A_TOHDMITX_DRV_NAME "g12a-tohdmitx"
+
+#define TOHDMITX_CTRL0			0x0
+#define  CTRL0_ENABLE_SHIFT		31
+#define  CTRL0_I2S_DAT_SEL		GENMASK(13, 12)
+#define  CTRL0_I2S_LRCLK_SEL		GENMASK(9, 8)
+#define  CTRL0_I2S_BLK_CAP_INV		BIT(7)
+#define  CTRL0_I2S_BCLK_O_INV		BIT(6)
+#define  CTRL0_I2S_BCLK_SEL		GENMASK(5, 4)
+#define  CTRL0_SPDIF_CLK_CAP_INV	BIT(3)
+#define  CTRL0_SPDIF_CLK_O_INV		BIT(2)
+#define  CTRL0_SPDIF_SEL		BIT(1)
+#define  CTRL0_SPDIF_CLK_SEL		BIT(0)
+
+struct g12a_tohdmitx_input {
+	struct snd_pcm_hw_params params;
+	unsigned int fmt;
+};
+
+static struct snd_soc_dapm_widget *
+g12a_tohdmitx_get_input(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p = NULL;
+	struct snd_soc_dapm_widget *in;
+
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
+		if (!p->connect)
+			continue;
+
+		/* Check that we still are in the same component */
+		if (snd_soc_dapm_to_component(w->dapm) !=
+		    snd_soc_dapm_to_component(p->source->dapm))
+			continue;
+
+		if (p->source->id == snd_soc_dapm_dai_in)
+			return p->source;
+
+		in = g12a_tohdmitx_get_input(p->source);
+		if (in)
+			return in;
+	}
+
+	return NULL;
+}
+
+static struct g12a_tohdmitx_input *
+g12a_tohdmitx_get_input_data(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_widget *in =
+		g12a_tohdmitx_get_input(w);
+	struct snd_soc_dai *dai;
+
+	if (WARN_ON(!in))
+		return NULL;
+
+	dai = in->priv;
+
+	return dai->playback_dma_data;
+}
+
+static const char * const g12a_tohdmitx_i2s_mux_texts[] = {
+	"I2S A", "I2S B", "I2S C",
+};
+
+static SOC_ENUM_SINGLE_EXT_DECL(g12a_tohdmitx_i2s_mux_enum,
+				g12a_tohdmitx_i2s_mux_texts);
+
+static int g12a_tohdmitx_get_input_val(struct snd_soc_component *component,
+				       unsigned int mask)
+{
+	unsigned int val;
+
+	snd_soc_component_read(component, TOHDMITX_CTRL0, &val);
+	return (val & mask) >> __ffs(mask);
+}
+
+static int g12a_tohdmitx_i2s_mux_get_enum(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+
+	ucontrol->value.enumerated.item[0] =
+		g12a_tohdmitx_get_input_val(component, CTRL0_I2S_DAT_SEL);
+
+	return 0;
+}
+
+static int g12a_tohdmitx_i2s_mux_put_enum(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int mux = ucontrol->value.enumerated.item[0];
+	unsigned int val = g12a_tohdmitx_get_input_val(component,
+						       CTRL0_I2S_DAT_SEL);
+
+	/* Force disconnect of the mux while updating */
+	if (val != mux)
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
+
+	snd_soc_component_update_bits(component, TOHDMITX_CTRL0,
+				      CTRL0_I2S_DAT_SEL |
+				      CTRL0_I2S_LRCLK_SEL |
+				      CTRL0_I2S_BCLK_SEL,
+				      FIELD_PREP(CTRL0_I2S_DAT_SEL, mux) |
+				      FIELD_PREP(CTRL0_I2S_LRCLK_SEL, mux) |
+				      FIELD_PREP(CTRL0_I2S_BCLK_SEL, mux));
+
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new g12a_tohdmitx_i2s_mux =
+	SOC_DAPM_ENUM_EXT("I2S Source", g12a_tohdmitx_i2s_mux_enum,
+			  g12a_tohdmitx_i2s_mux_get_enum,
+			  g12a_tohdmitx_i2s_mux_put_enum);
+
+static const char * const g12a_tohdmitx_spdif_mux_texts[] = {
+	"SPDIF A", "SPDIF B",
+};
+
+static SOC_ENUM_SINGLE_EXT_DECL(g12a_tohdmitx_spdif_mux_enum,
+				g12a_tohdmitx_spdif_mux_texts);
+
+static int g12a_tohdmitx_spdif_mux_get_enum(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+
+	ucontrol->value.enumerated.item[0] =
+		g12a_tohdmitx_get_input_val(component, CTRL0_SPDIF_SEL);
+
+	return 0;
+}
+
+static int g12a_tohdmitx_spdif_mux_put_enum(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int mux = ucontrol->value.enumerated.item[0];
+	unsigned int val = g12a_tohdmitx_get_input_val(component,
+						       CTRL0_SPDIF_SEL);
+
+	/* Force disconnect of the mux while updating */
+	if (val != mux)
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
+
+	snd_soc_component_update_bits(component, TOHDMITX_CTRL0,
+				      CTRL0_SPDIF_SEL |
+				      CTRL0_SPDIF_CLK_SEL,
+				      FIELD_PREP(CTRL0_SPDIF_SEL, mux) |
+				      FIELD_PREP(CTRL0_SPDIF_CLK_SEL, mux));
+
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new g12a_tohdmitx_spdif_mux =
+	SOC_DAPM_ENUM_EXT("SPDIF Source", g12a_tohdmitx_spdif_mux_enum,
+			  g12a_tohdmitx_spdif_mux_get_enum,
+			  g12a_tohdmitx_spdif_mux_put_enum);
+
+static const struct snd_kcontrol_new g12a_tohdmitx_out_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOHDMITX_CTRL0,
+				    CTRL0_ENABLE_SHIFT, 1, 0);
+
+static const struct snd_soc_dapm_widget g12a_tohdmitx_widgets[] = {
+	SND_SOC_DAPM_MUX("I2S SRC", SND_SOC_NOPM, 0, 0,
+			 &g12a_tohdmitx_i2s_mux),
+	SND_SOC_DAPM_SWITCH("I2S OUT EN", SND_SOC_NOPM, 0, 0,
+			    &g12a_tohdmitx_out_enable),
+	SND_SOC_DAPM_MUX("SPDIF SRC", SND_SOC_NOPM, 0, 0,
+			 &g12a_tohdmitx_spdif_mux),
+	SND_SOC_DAPM_SWITCH("SPDIF OUT EN", SND_SOC_NOPM, 0, 0,
+			    &g12a_tohdmitx_out_enable),
+};
+
+static int g12a_tohdmitx_input_probe(struct snd_soc_dai *dai)
+{
+	struct g12a_tohdmitx_input *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dai->playback_dma_data = data;
+	return 0;
+}
+
+static int g12a_tohdmitx_input_remove(struct snd_soc_dai *dai)
+{
+	kfree(dai->playback_dma_data);
+	return 0;
+}
+
+static int g12a_tohdmitx_input_hw_params(struct snd_pcm_substream *substream,
+					 struct snd_pcm_hw_params *params,
+					 struct snd_soc_dai *dai)
+{
+	struct g12a_tohdmitx_input *data = dai->playback_dma_data;
+
+	/* Save the stream params for the downstream link */
+	memcpy(&data->params, params, sizeof(*params));
+
+	return 0;
+}
+
+static int g12a_tohdmitx_output_hw_params(struct snd_pcm_substream *substream,
+					  struct snd_pcm_hw_params *params,
+					  struct snd_soc_dai *dai)
+{
+	struct g12a_tohdmitx_input *in_data =
+		g12a_tohdmitx_get_input_data(dai->capture_widget);
+
+	if (!in_data)
+		return -ENODEV;
+
+	memcpy(params, &in_data->params, sizeof(*params));
+
+	return 0;
+}
+
+static int g12a_tohdmitx_input_set_fmt(struct snd_soc_dai *dai,
+				       unsigned int fmt)
+{
+	struct g12a_tohdmitx_input *data = dai->playback_dma_data;
+
+	/* Save the source stream format for the downstream link */
+	data->fmt = fmt;
+	return 0;
+}
+
+static int g12a_tohdmitx_output_startup(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct g12a_tohdmitx_input *in_data =
+		g12a_tohdmitx_get_input_data(dai->capture_widget);
+
+	if (!in_data)
+		return -ENODEV;
+
+	if (!in_data->fmt)
+		return 0;
+
+	return snd_soc_runtime_set_dai_fmt(rtd, in_data->fmt);
+}
+
+static const struct snd_soc_dai_ops g12a_tohdmitx_input_ops = {
+	.hw_params	= g12a_tohdmitx_input_hw_params,
+	.set_fmt	= g12a_tohdmitx_input_set_fmt,
+};
+
+static const struct snd_soc_dai_ops g12a_tohdmitx_output_ops = {
+	.hw_params	= g12a_tohdmitx_output_hw_params,
+	.startup	= g12a_tohdmitx_output_startup,
+};
+
+#define TOHDMITX_SPDIF_FORMATS					\
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |	\
+	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+#define TOHDMITX_I2S_FORMATS					\
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |	\
+	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE |	\
+	 SNDRV_PCM_FMTBIT_S32_LE)
+
+#define TOHDMITX_STREAM(xname, xsuffix, xfmt, xchmax)		\
+{								\
+	.stream_name	= xname " " xsuffix,			\
+	.channels_min	= 1,					\
+	.channels_max	= (xchmax),				\
+	.rate_min       = 8000,					\
+	.rate_max	= 192000,				\
+	.formats	= (xfmt),				\
+}
+
+#define TOHDMITX_IN(xname, xid, xfmt, xchmax) {				\
+	.name = xname,							\
+	.id = (xid),							\
+	.playback = TOHDMITX_STREAM(xname, "Playback", xfmt, xchmax),	\
+	.ops = &g12a_tohdmitx_input_ops,				\
+	.probe = g12a_tohdmitx_input_probe,				\
+	.remove = g12a_tohdmitx_input_remove,				\
+}
+
+#define TOHDMITX_OUT(xname, xid, xfmt, xchmax) {			\
+	.name = xname,							\
+	.id = (xid),							\
+	.capture = TOHDMITX_STREAM(xname, "Capture", xfmt, xchmax),	\
+	.ops = &g12a_tohdmitx_output_ops,				\
+}
+
+static struct snd_soc_dai_driver g12a_tohdmitx_dai_drv[] = {
+	TOHDMITX_IN("I2S IN A", TOHDMITX_I2S_IN_A,
+		    TOHDMITX_I2S_FORMATS, 8),
+	TOHDMITX_IN("I2S IN B", TOHDMITX_I2S_IN_B,
+		    TOHDMITX_I2S_FORMATS, 8),
+	TOHDMITX_IN("I2S IN C", TOHDMITX_I2S_IN_C,
+		    TOHDMITX_I2S_FORMATS, 8),
+	TOHDMITX_OUT("I2S OUT", TOHDMITX_I2S_OUT,
+		     TOHDMITX_I2S_FORMATS, 8),
+	TOHDMITX_IN("SPDIF IN A", TOHDMITX_SPDIF_IN_A,
+		    TOHDMITX_SPDIF_FORMATS, 2),
+	TOHDMITX_IN("SPDIF IN B", TOHDMITX_SPDIF_IN_B,
+		    TOHDMITX_SPDIF_FORMATS, 2),
+	TOHDMITX_OUT("SPDIF OUT", TOHDMITX_SPDIF_OUT,
+		     TOHDMITX_SPDIF_FORMATS, 2),
+};
+
+static int g12a_tohdmi_component_probe(struct snd_soc_component *c)
+{
+	/* Initialize the static clock parameters */
+	return snd_soc_component_write(c, TOHDMITX_CTRL0,
+		     CTRL0_I2S_BLK_CAP_INV | CTRL0_SPDIF_CLK_CAP_INV);
+}
+
+static const struct snd_soc_dapm_route g12a_tohdmitx_routes[] = {
+	{ "I2S SRC", "I2S A", "I2S IN A Playback" },
+	{ "I2S SRC", "I2S B", "I2S IN B Playback" },
+	{ "I2S SRC", "I2S C", "I2S IN C Playback" },
+	{ "I2S OUT EN", "Switch", "I2S SRC" },
+	{ "I2S OUT Capture", NULL, "I2S OUT EN" },
+	{ "SPDIF SRC", "SPDIF A", "SPDIF IN A Playback" },
+	{ "SPDIF SRC", "SPDIF B", "SPDIF IN B Playback" },
+	{ "SPDIF OUT EN", "Switch", "SPDIF SRC" },
+	{ "SPDIF OUT Capture", NULL, "SPDIF OUT EN" },
+};
+
+static const struct snd_soc_component_driver g12a_tohdmitx_component_drv = {
+	.probe			= g12a_tohdmi_component_probe,
+	.dapm_widgets		= g12a_tohdmitx_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(g12a_tohdmitx_widgets),
+	.dapm_routes		= g12a_tohdmitx_routes,
+	.num_dapm_routes	= ARRAY_SIZE(g12a_tohdmitx_routes),
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static const struct regmap_config g12a_tohdmitx_regmap_cfg = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+static const struct of_device_id g12a_tohdmitx_of_match[] = {
+	{ .compatible = "amlogic,g12a-tohdmitx", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, g12a_tohdmitx_of_match);
+
+static int g12a_tohdmitx_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *regs;
+	struct regmap *map;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	map = devm_regmap_init_mmio(dev, regs, &g12a_tohdmitx_regmap_cfg);
+	if (IS_ERR(map)) {
+		dev_err(dev, "failed to init regmap: %ld\n",
+			PTR_ERR(map));
+		return PTR_ERR(map);
+	}
+
+	return devm_snd_soc_register_component(dev,
+			&g12a_tohdmitx_component_drv, g12a_tohdmitx_dai_drv,
+			ARRAY_SIZE(g12a_tohdmitx_dai_drv));
+}
+
+static struct platform_driver g12a_tohdmitx_pdrv = {
+	.driver = {
+		.name = G12A_TOHDMITX_DRV_NAME,
+		.of_match_table = g12a_tohdmitx_of_match,
+	},
+	.probe = g12a_tohdmitx_probe,
+};
+module_platform_driver(g12a_tohdmitx_pdrv);
+
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_DESCRIPTION("Amlogic G12a To HDMI Tx Control Codec Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

