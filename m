Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11847C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83B420855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0S+5YM/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfDDLSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:18:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36192 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfDDLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so3290164wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njYuZs0QQDpdwULWDM30jmxjNG8Fc5VRgpPkmqI8/tg=;
        b=0S+5YM/0pFsWqe0GLi2cBiX4o0bic1u2T7zVWJIgG1n5M6BB03QtaDEjJWEm7Vx2pR
         EcgDxDSrSSVf01WXzWAKTcGRAXamlJM4gIyRYY5INah/m9lF9zXv+NRVlQTfvev/5SEq
         Uu1zh2W9FXWMMAw2PDw1+qqkvMYxa14qEaj9oBtz23mNSCvOTRlbj1EtA879jt/isfwu
         TGpStKvevelZrysBcRYnvKBrcnw5B0w2PBv4xU0EmVsNGFBB+PmH2hGgXZl5X47PmZ8Z
         FT5fEpEXpu5GBk9s8d27wX1e6D0oFDsjKmUB85i36ZxkMRGpcPMuHBcqS/Wz1bBP9qH9
         G/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njYuZs0QQDpdwULWDM30jmxjNG8Fc5VRgpPkmqI8/tg=;
        b=RjZ9iG/G+Dj0csWlTNUIYYqf1RVCpBKGHM5F8fzxVUn8vlQG9q0MMM++1CgyVPVxAa
         0pwdooDYu/4ArFT0BUeBQ+BHF8a0ILWv1PoeWYr27/+xhpe/JvLzEtnrwJ7wnmf3K+bI
         7yiQBv75TujzhInPQ03A/RiKJHDIm9kfz0ZXB/NKJul7YVBXJtfl6jeox9/6E7VHiY+8
         VM7IYZ4H4iXCBpDuM4YZ2+RUVaz1PUapXqEcuP2T9zYx3nIT3HRRr63kcXLKiGpgRYtI
         PVEuB/XmjaU6Z5JYQbnfAd+mlPMoRG2UXZmMJgcaF8pnfhv7n9IbS1//oHN0NV0MJVkK
         ih3w==
X-Gm-Message-State: APjAAAUkI/5MCeZagYE+vNRrxhAibp5JY34sBmuU7xtm2a0YRUj90xvg
        R44jorpJPx+34eHp9BMiYWEhdQ==
X-Google-Smtp-Source: APXvYqzkiOI57ShWfPqvIEVkCyjm17C0ol6GaeDdt2KXAeDHcBYfsedCbIv2iTgknoTePhi47ecm2w==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr1681722wrq.242.1554376672697;
        Thu, 04 Apr 2019 04:17:52 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z23sm9024771wma.0.2019.04.04.04.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:17:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 5/6] ASoC: meson: axg-tdm-formatter: rework quirks settings
Date:   Thu,  4 Apr 2019 13:17:32 +0200
Message-Id: <20190404111733.28705-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The g12a tdmout requires a different signal skew offset than the axg.
With this change, the skew offset is added as a parameter of the tdm
formatters to prepare the addition of the g12a support.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-formatter.c |  6 ++++--
 sound/soc/meson/axg-tdm-formatter.h | 11 +++++++++--
 sound/soc/meson/axg-tdmin.c         | 16 +++++++++++-----
 sound/soc/meson/axg-tdmout.c        | 16 +++++++++++-----
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 43e390f9358a..0c6cce5c5773 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
 static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 {
 	struct axg_tdm_stream *ts = formatter->stream;
-	bool invert = formatter->drv->invert_sclk;
+	bool invert = formatter->drv->quirks->invert_sclk;
 	int ret;
 
 	/* Do nothing if the formatter is already enabled */
@@ -85,7 +85,9 @@ static int axg_tdm_formatter_enable(struct axg_tdm_formatter *formatter)
 		return ret;
 
 	/* Setup the stream parameter in the formatter */
-	ret = formatter->drv->ops->prepare(formatter->map, formatter->stream);
+	ret = formatter->drv->ops->prepare(formatter->map,
+					   formatter->drv->quirks,
+					   formatter->stream);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/meson/axg-tdm-formatter.h b/sound/soc/meson/axg-tdm-formatter.h
index cf947caf3cb1..9ef98e955cb2 100644
--- a/sound/soc/meson/axg-tdm-formatter.h
+++ b/sound/soc/meson/axg-tdm-formatter.h
@@ -14,18 +14,25 @@ struct regmap;
 struct snd_soc_dapm_widget;
 struct snd_kcontrol;
 
+struct axg_tdm_formatter_hw {
+	unsigned int skew_offset;
+	bool invert_sclk;
+};
+
 struct axg_tdm_formatter_ops {
 	struct axg_tdm_stream *(*get_stream)(struct snd_soc_dapm_widget *w);
 	void (*enable)(struct regmap *map);
 	void (*disable)(struct regmap *map);
-	int (*prepare)(struct regmap *map, struct axg_tdm_stream *ts);
+	int (*prepare)(struct regmap *map,
+		       const struct axg_tdm_formatter_hw *quirks,
+		       struct axg_tdm_stream *ts);
 };
 
 struct axg_tdm_formatter_driver {
 	const struct snd_soc_component_driver *component_drv;
 	const struct regmap_config *regmap_cfg;
 	const struct axg_tdm_formatter_ops *ops;
-	bool invert_sclk;
+	const struct axg_tdm_formatter_hw *quirks;
 };
 
 int axg_tdm_formatter_set_channel_masks(struct regmap *map,
diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index bbac44c81688..a790f925a4ef 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -107,21 +107,22 @@ static void axg_tdmin_disable(struct regmap *map)
 	regmap_update_bits(map, TDMIN_CTRL, TDMIN_CTRL_ENABLE, 0);
 }
 
-static int axg_tdmin_prepare(struct regmap *map, struct axg_tdm_stream *ts)
+static int axg_tdmin_prepare(struct regmap *map,
+			     const struct axg_tdm_formatter_hw *quirks,
+			     struct axg_tdm_stream *ts)
 {
-	unsigned int val = 0;
+	unsigned int val, skew = quirks->skew_offset;
 
 	/* Set stream skew */
 	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_DSP_A:
-		val |= TDMIN_CTRL_IN_BIT_SKEW(3);
+		skew += 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_DSP_B:
-		val = TDMIN_CTRL_IN_BIT_SKEW(2);
 		break;
 
 	default:
@@ -130,6 +131,8 @@ static int axg_tdmin_prepare(struct regmap *map, struct axg_tdm_stream *ts)
 		return -EINVAL;
 	}
 
+	val = TDMIN_CTRL_IN_BIT_SKEW(skew);
+
 	/* Set stream format mode */
 	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -204,7 +207,10 @@ static const struct axg_tdm_formatter_driver axg_tdmin_drv = {
 	.component_drv	= &axg_tdmin_component_drv,
 	.regmap_cfg	= &axg_tdmin_regmap_cfg,
 	.ops		= &axg_tdmin_ops,
-	.invert_sclk	= false,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk	= false,
+		.skew_offset	= 2,
+	},
 };
 
 static const struct of_device_id axg_tdmin_of_match[] = {
diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index f73368ee1088..3984818e2a7c 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -124,21 +124,22 @@ static void axg_tdmout_disable(struct regmap *map)
 	regmap_update_bits(map, TDMOUT_CTRL0, TDMOUT_CTRL0_ENABLE, 0);
 }
 
-static int axg_tdmout_prepare(struct regmap *map, struct axg_tdm_stream *ts)
+static int axg_tdmout_prepare(struct regmap *map,
+			      const struct axg_tdm_formatter_hw *quirks,
+			      struct axg_tdm_stream *ts)
 {
-	unsigned int val = 0;
+	unsigned int val, skew = quirks->skew_offset;
 
 	/* Set the stream skew */
 	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_DSP_A:
-		val |= TDMOUT_CTRL0_INIT_BITNUM(1);
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_DSP_B:
-		val |= TDMOUT_CTRL0_INIT_BITNUM(2);
+		skew += 1;
 		break;
 
 	default:
@@ -147,6 +148,8 @@ static int axg_tdmout_prepare(struct regmap *map, struct axg_tdm_stream *ts)
 		return -EINVAL;
 	}
 
+	val = TDMOUT_CTRL0_INIT_BITNUM(skew);
+
 	/* Set the slot width */
 	val |= TDMOUT_CTRL0_BITNUM(ts->iface->slot_width - 1);
 
@@ -234,7 +237,10 @@ static const struct axg_tdm_formatter_driver axg_tdmout_drv = {
 	.component_drv	= &axg_tdmout_component_drv,
 	.regmap_cfg	= &axg_tdmout_regmap_cfg,
 	.ops		= &axg_tdmout_ops,
-	.invert_sclk	= true,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk = true,
+		.skew_offset = 1,
+	},
 };
 
 static const struct of_device_id axg_tdmout_of_match[] = {
-- 
2.20.1

