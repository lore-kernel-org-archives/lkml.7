Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826D5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2BA2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oslCAO+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEBMLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:11:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEBMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:11:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so3008873wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DMTq9JcxyVCz0Q2fJLJXLfrffkSxj54Pn7XsbAbBnI=;
        b=oslCAO+lO2hL62JG/AvposxGWFidzIh9jDsshfJiet5KL7h4MmFuYJluhUfupieJr3
         V7xuP7w/V19OBBcE5AP4kSC4Aw1H7i1la0pH1YZhncgmW1jLjO1YLoRsEXjyf7gvh9SE
         g3YielP4LcN6b+HqnI+/dpRSv+ozYAzhQHgFo8mMYAkQ9sxZWnjqBfOERQi2UOOlhDPn
         OA76DebTTnZlKBuGB/PtQw8tvgpiRFNVAE07r3LtAPD7lEDbc+SbGEP9dsNg3TyE2k0k
         eWe6MEYg/lZxXpgPlSJFoPAYKipg51X71O8kwbwmFDUMLnYkfWFREnECAjkN+M/YwxI6
         23KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DMTq9JcxyVCz0Q2fJLJXLfrffkSxj54Pn7XsbAbBnI=;
        b=r2JUfwFSNoBokagtJJjIkSiQ3EgkYiTnEIbrJRs2ZfzLqMc3VOYCFys4+M2VSPc2WE
         pvFMWA8Y+5LXayimLz935tyv8xdlJQ9UU0rvTGBByLgI8tCtrYQkBk7X8k6WVTj30S6H
         ytcwdhUzeRB3xEtOZXProwzmGX3I1SeH6PzlIQ13A5erL2b10E454SfFZjnpJO5s1E8u
         P4LezHnMn/AJK2RCTSGm8k0Dv2TbrU59GMmg8oymZgPHctWnH170HYfcBist1H6Eqbg9
         rlJWSSQ0sQtX0N85libfD6iClW5CwlxplCnI19XJYwJ5MHX3aC7nicIGRLQO1O485Rky
         ncgw==
X-Gm-Message-State: APjAAAWhLxyJBQ27+g7xnAU+O1noebkkn49PNmCc5CVmvu3Fn/BOcU4j
        16lDhEussQKCi14NyqJ6VLiCyg==
X-Google-Smtp-Source: APXvYqxPpSr69Uo2DyyWt+KewV2XbIEZcNPyt+thynQ+bTt/UE5/35zqVy0xaESF7LMsPLyG2m+Ozg==
X-Received: by 2002:a5d:4711:: with SMTP id y17mr2725743wrq.122.1556799058474;
        Thu, 02 May 2019 05:10:58 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-8-187.w90-86.abo.wanadoo.fr. [90.86.125.187])
        by smtp.gmail.com with ESMTPSA id u9sm3648348wmd.14.2019.05.02.05.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:10:57 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz,
        tiwai@suse.com, kaichieh.chuang@mediatek.com,
        shunli.wang@mediatek.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 4/5] ASoC: mediatek: mt8516: Add ADDA DAI driver
Date:   Thu,  2 May 2019 14:10:40 +0200
Message-Id: <20190502121041.8045-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502121041.8045-1-fparent@baylibre.com>
References: <20190502121041.8045-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ADDA DAI driver for the MediaTek MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 sound/soc/mediatek/mt8516/Makefile            |   3 +-
 sound/soc/mediatek/mt8516/mt8516-afe-common.h |  18 +
 sound/soc/mediatek/mt8516/mt8516-dai-adda.c   | 316 ++++++++++++++++++
 3 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-dai-adda.c

diff --git a/sound/soc/mediatek/mt8516/Makefile b/sound/soc/mediatek/mt8516/Makefile
index 6e49b01d02c2..dc05ab45560d 100644
--- a/sound/soc/mediatek/mt8516/Makefile
+++ b/sound/soc/mediatek/mt8516/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 snd-soc-mt8516-afe-objs := \
-	mt8516-afe-pcm.o
+	mt8516-afe-pcm.o \
+	mt8516-dai-adda.o
 
 obj-$(CONFIG_SND_SOC_MT8516) += snd-soc-mt8516-afe.o
diff --git a/sound/soc/mediatek/mt8516/mt8516-afe-common.h b/sound/soc/mediatek/mt8516/mt8516-afe-common.h
new file mode 100644
index 000000000000..e70877c044a4
--- /dev/null
+++ b/sound/soc/mediatek/mt8516/mt8516-afe-common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+#ifndef _MT8516_AFE_COMMON_H_
+#define _MT8516_AFE_COMMON_H_
+
+#include "../common/mtk-base-afe.h"
+
+enum {
+	MT8516_AFE_BE_ADDA,
+};
+
+int mt8516_dai_adda_register(struct mtk_base_afe *afe);
+
+#endif
diff --git a/sound/soc/mediatek/mt8516/mt8516-dai-adda.c b/sound/soc/mediatek/mt8516/mt8516-dai-adda.c
new file mode 100644
index 000000000000..76e53772d784
--- /dev/null
+++ b/sound/soc/mediatek/mt8516/mt8516-dai-adda.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Copyright (c) 2019 MediaTek, Inc
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include "mt8516-afe-common.h"
+#include "mt8516-afe-regs.h"
+
+enum {
+	MTK_AFE_ADDA_DL_RATE_8K = 0,
+	MTK_AFE_ADDA_DL_RATE_11K = 1,
+	MTK_AFE_ADDA_DL_RATE_12K = 2,
+	MTK_AFE_ADDA_DL_RATE_16K = 3,
+	MTK_AFE_ADDA_DL_RATE_22K = 4,
+	MTK_AFE_ADDA_DL_RATE_24K = 5,
+	MTK_AFE_ADDA_DL_RATE_32K = 6,
+	MTK_AFE_ADDA_DL_RATE_44K = 7,
+	MTK_AFE_ADDA_DL_RATE_48K = 8,
+};
+
+enum {
+	MTK_AFE_ADDA_UL_RATE_8K = 0,
+	MTK_AFE_ADDA_UL_RATE_16K = 1,
+	MTK_AFE_ADDA_UL_RATE_32K = 2,
+	MTK_AFE_ADDA_UL_RATE_48K = 3,
+};
+
+static int mt8516_afe_setup_i2s(struct mtk_base_afe *afe,
+				    struct snd_pcm_substream *substream,
+				    unsigned int rate, int bit_width)
+{
+	int fs = afe->memif_fs(substream, rate);
+	unsigned int val;
+
+	if (bit_width > 16)
+		val |= AFE_I2S_CON1_WLEN_32BIT;
+
+	if (fs < 0)
+		return -EINVAL;
+
+	val = AFE_I2S_CON1_I2S2_TO_PAD |
+	      AFE_I2S_CON1_LOW_JITTER_CLK |
+	      AFE_I2S_CON1_RATE(fs) |
+	      AFE_I2S_CON1_FORMAT_I2S |
+	      AFE_I2S_CON1_EN;
+
+	regmap_write(afe->regmap, AFE_I2S_CON1, val);
+
+	return 0;
+}
+
+static int mt8516_afe_setup_adda_dl(struct mtk_base_afe *afe, unsigned int rate)
+{
+	unsigned int val = AFE_ADDA_DL_8X_UPSAMPLE |
+			   AFE_ADDA_DL_MUTE_OFF |
+			   AFE_ADDA_DL_DEGRADE_GAIN;
+
+	if (rate == 8000 || rate == 16000)
+		val |= AFE_ADDA_DL_VOICE_DATA;
+
+	switch (rate) {
+	case 8000:
+		val |= MTK_AFE_ADDA_DL_RATE_8K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 11025:
+		val |= MTK_AFE_ADDA_DL_RATE_11K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 12000:
+		val |= MTK_AFE_ADDA_DL_RATE_12K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 16000:
+		val |= MTK_AFE_ADDA_DL_RATE_16K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 22050:
+		val |= MTK_AFE_ADDA_DL_RATE_22K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 24000:
+		val |= MTK_AFE_ADDA_DL_RATE_24K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 32000:
+		val |= MTK_AFE_ADDA_DL_RATE_32K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 44100:
+		val |= MTK_AFE_ADDA_DL_RATE_44K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	case 48000:
+		val |= MTK_AFE_ADDA_DL_RATE_48K << AFE_ADDA_DL_RATE_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_write(afe->regmap, AFE_ADDA_PREDIS_CON0, 0);
+	regmap_write(afe->regmap, AFE_ADDA_PREDIS_CON1, 0);
+	regmap_write(afe->regmap, AFE_ADDA_DL_SRC2_CON0, val);
+	regmap_write(afe->regmap, AFE_ADDA_DL_SRC2_CON1, 0xf74f0000);
+
+	return 0;
+}
+
+static int mt8516_afe_setup_adda_ul(struct mtk_base_afe *afe, unsigned int rate)
+{
+	unsigned int val = 0;
+	unsigned int val2 = 0;
+
+	switch (rate) {
+	case 8000:
+		val |= MTK_AFE_ADDA_UL_RATE_8K << AFE_ADDA_UL_RATE_CH1_SHIFT;
+		val |= MTK_AFE_ADDA_UL_RATE_8K << AFE_ADDA_UL_RATE_CH2_SHIFT;
+		val2 |= 1 << AFE_ADDA_NEWIF_ADC_VOICE_MODE_SHIFT;
+		break;
+	case 16000:
+		val |= MTK_AFE_ADDA_UL_RATE_16K << AFE_ADDA_UL_RATE_CH1_SHIFT;
+		val |= MTK_AFE_ADDA_UL_RATE_16K << AFE_ADDA_UL_RATE_CH2_SHIFT;
+		val2 |= 1 << AFE_ADDA_NEWIF_ADC_VOICE_MODE_SHIFT;
+		break;
+	case 32000:
+		val |= MTK_AFE_ADDA_UL_RATE_32K << AFE_ADDA_UL_RATE_CH1_SHIFT;
+		val |= MTK_AFE_ADDA_UL_RATE_32K << AFE_ADDA_UL_RATE_CH2_SHIFT;
+		val2 |= 1 << AFE_ADDA_NEWIF_ADC_VOICE_MODE_SHIFT;
+		break;
+	case 48000:
+		val |= MTK_AFE_ADDA_UL_RATE_48K << AFE_ADDA_UL_RATE_CH1_SHIFT;
+		val |= MTK_AFE_ADDA_UL_RATE_48K << AFE_ADDA_UL_RATE_CH2_SHIFT;
+		val2 |= 3 << AFE_ADDA_NEWIF_ADC_VOICE_MODE_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0,
+		(AFE_ADDA_UL_RATE_CH1_MASK << AFE_ADDA_UL_RATE_CH1_SHIFT) ||
+		(AFE_ADDA_UL_RATE_CH2_MASK << AFE_ADDA_UL_RATE_CH2_MASK), val);
+	regmap_update_bits(afe->regmap, AFE_ADDA_NEWIF_CFG1,
+		AFE_ADDA_NEWIF_ADC_VOICE_MODE_CLR, val2);
+	regmap_update_bits(afe->regmap, AFE_ADDA_TOP_CON0, 1, 0);
+
+	return 0;
+}
+
+static void mt8516_afe_adda_shutdown(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int stream = substream->stream;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_update_bits(afe->regmap, AFE_ADDA_DL_SRC2_CON0, 1, 0);
+		regmap_update_bits(afe->regmap, AFE_I2S_CON1, 1, 0);
+	} else {
+		regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0, 1, 0);
+	}
+
+	regmap_update_bits(afe->regmap, AFE_ADDA_UL_DL_CON0, 1, 0);
+}
+
+static int mt8516_afe_adda_hw_params(struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int width_val = params_width(params) > 16 ?
+		(AFE_CONN_24BIT_O03 | AFE_CONN_24BIT_O04) : 0;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		regmap_update_bits(afe->regmap, AFE_CONN_24BIT,
+			   AFE_CONN_24BIT_O03 | AFE_CONN_24BIT_O04, width_val);
+
+	return 0;
+}
+
+static int mt8516_afe_adda_prepare(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	const unsigned int rate = substream->runtime->rate;
+	unsigned int stream = substream->stream;
+	int bit_width = snd_pcm_format_width(substream->runtime->format);
+	int ret;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = mt8516_afe_setup_adda_dl(afe, rate);
+		if (ret)
+			return ret;
+
+		ret = mt8516_afe_setup_i2s(afe, substream, rate, bit_width);
+		if (ret)
+			return ret;
+
+		regmap_update_bits(afe->regmap, AFE_ADDA_DL_SRC2_CON0, 1, 1);
+	} else {
+		ret = mt8516_afe_setup_adda_ul(afe, rate);
+		if (ret)
+			return ret;
+
+		regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0, 1, 1);
+	}
+
+	regmap_update_bits(afe->regmap, AFE_ADDA_UL_DL_CON0, 1, 1);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mt8516_afe_adda_ops = {
+	.shutdown	= mt8516_afe_adda_shutdown,
+	.hw_params	= mt8516_afe_adda_hw_params,
+	.prepare	= mt8516_afe_adda_prepare,
+};
+
+static const struct snd_kcontrol_new adda_o03_o04_enable_ctl =
+	SOC_DAPM_SINGLE_VIRT("Switch", 1);
+
+static const char * const ain_text[] = {
+	"INT ADC", "EXT ADC"
+};
+
+static SOC_ENUM_SINGLE_DECL(ain_enum, AFE_ADDA_TOP_CON0, 0, ain_text);
+
+static const struct snd_kcontrol_new ain_mux =
+	SOC_DAPM_ENUM("AIN Source", ain_enum);
+
+enum {
+	SUPPLY_SEQ_ADDA_AFE_ON,
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
+	SND_SOC_DAPM_MUX("AIN Mux", SND_SOC_NOPM, 0, 0, &ain_mux),
+
+	SND_SOC_DAPM_SWITCH("ADDA O03_O04", SND_SOC_NOPM, 0, 0,
+			    &adda_o03_o04_enable_ctl),
+
+
+	SND_SOC_DAPM_SUPPLY_S("ADDA Enable", SUPPLY_SEQ_ADDA_AFE_ON,
+			      AFE_DAC_CON0, 0, 0,
+			      NULL, 0),
+
+	/* Clocks */
+	SND_SOC_DAPM_CLOCK_SUPPLY("top_pdn_audio"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_dac_clk"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_dac_predis_clk"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_adc_clk"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
+	/* playback */
+	{"ADDA O03_O04", "Switch", "O03"},
+	{"ADDA O03_O04", "Switch", "O04"},
+	{"ADDA Playback", NULL, "ADDA O03_O04"},
+
+	/* capture */
+	{"AIN Mux", "INT ADC", "ADDA Capture"},
+
+	/* enable */
+	{"ADDA Playback", NULL, "ADDA Enable"},
+	{"ADDA Capture", NULL, "ADDA Enable"},
+
+	/* clock */
+	{"ADDA Playback", NULL, "aud_dac_clk"},
+	{"ADDA Playback", NULL, "aud_dac_predis_clk"},
+	{"ADDA Playback", NULL, "top_pdn_audio"},
+
+	{"ADDA Capture", NULL, "top_pdn_audio"},
+	{"ADDA Capture", NULL, "aud_adc_clk"},
+};
+
+static struct snd_soc_dai_driver mtk_dai_adda_driver[] = {
+	{
+		.name = "ADDA",
+		.id = MT8516_AFE_BE_ADDA,
+		.playback = {
+			.stream_name = "ADDA Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+		},
+		.capture = {
+			.stream_name = "ADDA Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_32000 |
+				 SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.ops = &mt8516_afe_adda_ops,
+	},
+};
+
+int mt8516_dai_adda_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_adda_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_adda_driver);
+
+	dai->dapm_widgets = mtk_dai_adda_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_adda_widgets);
+	dai->dapm_routes = mtk_dai_adda_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_adda_routes);
+
+	return 0;
+}
-- 
2.20.1

