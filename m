Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4EAC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F17D22CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qVswcN+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbfIEMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36175 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388977AbfIEMBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id p13so2684935wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klSkJhbs0NB+xI0c1ebxNosV7pVJl7beazxfFo4LBZg=;
        b=qVswcN+PucNQH6v4EQigxCZdHKTEzMwj6G2zSXUlL9Q3vyaySUauYMtEwxR5tBfkTX
         Vl/wABaSlML2K61iULZEg9ci45M0aAYXwsUTPRKD55tXQk4EtDd41q/6q033f5nkHvfJ
         +qHF+b/8Kowqxp9iuzSOMwteKYzNFPmUoAVTW0FBnhdvtWeVvCGHIFLNS+b55o5njqS4
         2EVfcQ5qtdUqtDgwR9T7GbXyUujllGe+DCGRPCI9M5s0RC35d/GTQ9b+eHNo/BPRTHAs
         109aM4zFeYs3qeABFt6PzFK8FWOj5EyNdbvW3NeM23Ykr/vHc2xeAA3Q5sFRzOaJ6WV9
         yi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klSkJhbs0NB+xI0c1ebxNosV7pVJl7beazxfFo4LBZg=;
        b=M0Q3BMuKLECDShgdIWIfvcfTdg+FM0Z2Im1s/0Pqi1pPkbl+lB3w0jPHtcxJqSvax0
         razwTAkRzmb/NycPjOrVx71SfmYVgDzuEt4bP3VnS+/7iJu9jipOcSx4C3bqrt/3XCH1
         JNzAzTc9G7uT/8+WSU/wkhyWryYslhQs23OOVA67EQ0X0lyXc4d79HME42wwi0Levdas
         nowfehE99EUOC54UecK0EYdhhjitIfiunR3UScEnGxig5hhMdqNRw+HdhV9+u2ig+B9k
         Qp8iBP68zWUskCseMQEUbyM/vUkEIOZKsxp2RlyWNAofSDrJ9vDMwNr9jPQkEW47fC9v
         9xpQ==
X-Gm-Message-State: APjAAAUEDB+/fDFjXx19PMHqfaUOD7Da0GOsGixDym1zvvWbBDhn9Vvg
        QDmG4ZhnerqcHk0sPeiMIEOvxlpFYFtnGw==
X-Google-Smtp-Source: APXvYqzMpRsgyQhdaXkYR6VhupFXcKpJSMlYFG0Sb+nF3uP8ydsPZns1A+Qc1CimphV2UL/tqKaqyQ==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr2607200wmr.30.1567684896038;
        Thu, 05 Sep 2019 05:01:36 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 8/8] ASoC: meson: tdmout: add sm1 support
Date:   Thu,  5 Sep 2019 14:01:20 +0200
Message-Id: <20190905120120.31752-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905120120.31752-1-jbrunet@baylibre.com>
References: <20190905120120.31752-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the sm1, the TDMOUT number of input is extended and the
the gain enable bit moved to accommodate this extension

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdmout.c | 103 ++++++++++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 19 deletions(-)

diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index 86537fc0ecb5..418ec314b37d 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -24,6 +24,7 @@
 #define TDMOUT_CTRL1			0x04
 #define  TDMOUT_CTRL1_TYPE_MASK		GENMASK(6, 4)
 #define  TDMOUT_CTRL1_TYPE(x)		((x) << 4)
+#define  SM1_TDMOUT_CTRL1_GAIN_EN	7
 #define  TDMOUT_CTRL1_MSB_POS_MASK	GENMASK(12, 8)
 #define  TDMOUT_CTRL1_MSB_POS(x)	((x) << 8)
 #define  TDMOUT_CTRL1_SEL_SHIFT		24
@@ -51,25 +52,6 @@ static const struct regmap_config axg_tdmout_regmap_cfg = {
 	.max_register	= TDMOUT_MASK_VAL,
 };
 
-static const struct snd_kcontrol_new axg_tdmout_controls[] = {
-	SOC_DOUBLE("Lane 0 Volume", TDMOUT_GAIN0,  0,  8, 255, 0),
-	SOC_DOUBLE("Lane 1 Volume", TDMOUT_GAIN0, 16, 24, 255, 0),
-	SOC_DOUBLE("Lane 2 Volume", TDMOUT_GAIN1,  0,  8, 255, 0),
-	SOC_DOUBLE("Lane 3 Volume", TDMOUT_GAIN1, 16, 24, 255, 0),
-	SOC_SINGLE("Gain Enable Switch", TDMOUT_CTRL1,
-		   TDMOUT_CTRL1_GAIN_EN, 1, 0),
-};
-
-static const char * const tdmout_sel_texts[] = {
-	"IN 0", "IN 1", "IN 2",
-};
-
-static SOC_ENUM_SINGLE_DECL(axg_tdmout_sel_enum, TDMOUT_CTRL1,
-			    TDMOUT_CTRL1_SEL_SHIFT, tdmout_sel_texts);
-
-static const struct snd_kcontrol_new axg_tdmout_in_mux =
-	SOC_DAPM_ENUM("Input Source", axg_tdmout_sel_enum);
-
 static struct snd_soc_dai *
 axg_tdmout_get_be(struct snd_soc_dapm_widget *w)
 {
@@ -197,6 +179,25 @@ static int axg_tdmout_prepare(struct regmap *map,
 	return axg_tdm_formatter_set_channel_masks(map, ts, TDMOUT_MASK0);
 }
 
+static const struct snd_kcontrol_new axg_tdmout_controls[] = {
+	SOC_DOUBLE("Lane 0 Volume", TDMOUT_GAIN0,  0,  8, 255, 0),
+	SOC_DOUBLE("Lane 1 Volume", TDMOUT_GAIN0, 16, 24, 255, 0),
+	SOC_DOUBLE("Lane 2 Volume", TDMOUT_GAIN1,  0,  8, 255, 0),
+	SOC_DOUBLE("Lane 3 Volume", TDMOUT_GAIN1, 16, 24, 255, 0),
+	SOC_SINGLE("Gain Enable Switch", TDMOUT_CTRL1,
+		   TDMOUT_CTRL1_GAIN_EN, 1, 0),
+};
+
+static const char * const axg_tdmout_sel_texts[] = {
+	"IN 0", "IN 1", "IN 2",
+};
+
+static SOC_ENUM_SINGLE_DECL(axg_tdmout_sel_enum, TDMOUT_CTRL1,
+			    TDMOUT_CTRL1_SEL_SHIFT, axg_tdmout_sel_texts);
+
+static const struct snd_kcontrol_new axg_tdmout_in_mux =
+	SOC_DAPM_ENUM("Input Source", axg_tdmout_sel_enum);
+
 static const struct snd_soc_dapm_widget axg_tdmout_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("IN 0", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("IN 1", NULL, 0, SND_SOC_NOPM, 0, 0),
@@ -252,6 +253,67 @@ static const struct axg_tdm_formatter_driver g12a_tdmout_drv = {
 	},
 };
 
+static const struct snd_kcontrol_new sm1_tdmout_controls[] = {
+	SOC_DOUBLE("Lane 0 Volume", TDMOUT_GAIN0,  0,  8, 255, 0),
+	SOC_DOUBLE("Lane 1 Volume", TDMOUT_GAIN0, 16, 24, 255, 0),
+	SOC_DOUBLE("Lane 2 Volume", TDMOUT_GAIN1,  0,  8, 255, 0),
+	SOC_DOUBLE("Lane 3 Volume", TDMOUT_GAIN1, 16, 24, 255, 0),
+	SOC_SINGLE("Gain Enable Switch", TDMOUT_CTRL1,
+		   SM1_TDMOUT_CTRL1_GAIN_EN, 1, 0),
+};
+
+static const char * const sm1_tdmout_sel_texts[] = {
+	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4",
+};
+
+static SOC_ENUM_SINGLE_DECL(sm1_tdmout_sel_enum, TDMOUT_CTRL1,
+			    TDMOUT_CTRL1_SEL_SHIFT, sm1_tdmout_sel_texts);
+
+static const struct snd_kcontrol_new sm1_tdmout_in_mux =
+	SOC_DAPM_ENUM("Input Source", sm1_tdmout_sel_enum);
+
+static const struct snd_soc_dapm_widget sm1_tdmout_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("IN 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("SRC SEL", SND_SOC_NOPM, 0, 0, &sm1_tdmout_in_mux),
+	SND_SOC_DAPM_PGA_E("ENC", SND_SOC_NOPM, 0, 0, NULL, 0,
+			   axg_tdm_formatter_event,
+			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD)),
+	SND_SOC_DAPM_AIF_OUT("OUT", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route sm1_tdmout_dapm_routes[] = {
+	{ "SRC SEL", "IN 0", "IN 0" },
+	{ "SRC SEL", "IN 1", "IN 1" },
+	{ "SRC SEL", "IN 2", "IN 2" },
+	{ "SRC SEL", "IN 3", "IN 3" },
+	{ "SRC SEL", "IN 4", "IN 4" },
+	{ "ENC", NULL, "SRC SEL" },
+	{ "OUT", NULL, "ENC" },
+};
+
+static const struct snd_soc_component_driver sm1_tdmout_component_drv = {
+	.controls		= sm1_tdmout_controls,
+	.num_controls		= ARRAY_SIZE(sm1_tdmout_controls),
+	.dapm_widgets		= sm1_tdmout_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sm1_tdmout_dapm_widgets),
+	.dapm_routes		= sm1_tdmout_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sm1_tdmout_dapm_routes),
+};
+
+static const struct axg_tdm_formatter_driver sm1_tdmout_drv = {
+	.component_drv	= &sm1_tdmout_component_drv,
+	.regmap_cfg	= &axg_tdmout_regmap_cfg,
+	.ops		= &axg_tdmout_ops,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk = true,
+		.skew_offset = 2,
+	},
+};
+
 static const struct of_device_id axg_tdmout_of_match[] = {
 	{
 		.compatible = "amlogic,axg-tdmout",
@@ -259,6 +321,9 @@ static const struct of_device_id axg_tdmout_of_match[] = {
 	}, {
 		.compatible = "amlogic,g12a-tdmout",
 		.data = &g12a_tdmout_drv,
+	}, {
+		.compatible = "amlogic,sm1-tdmout",
+		.data = &sm1_tdmout_drv,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_tdmout_of_match);
-- 
2.21.0

