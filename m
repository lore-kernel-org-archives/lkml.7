Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031B6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CC222CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K1wgI+Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfIEMBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44996 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388954AbfIEMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id 30so2420635wrk.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MS5XJHYT75fAQfNDJZYmwsq3IlOqs5XUG9bj/DNEg1Y=;
        b=K1wgI+BmLlwGuWLvWOKjgEhqHak7dEDjBF6ia+HKWkPbjOg55sHa+seoDjFEUKR32D
         EQG+xGcV5myYoBYwljoZI1XJTj2u2VTdMQHT6YaqBzo1naDi19CrI6+xwYm/8O1R1Plt
         y8xx3bew6U/zIbR1KOWbOFyNqtD7I/e6tBpq7beLfwQMnw5bS5dNE8BCl25cDh3dVh64
         X9Xmy4zUUExSFPPO/DWhtKEq5eowO6MSxJE+NZlFIgEGDk7G2zLdmVMr/+Q4yvmQaOfq
         ql4u1c4Uxts+yUfrXqB8AocXfyskaBTf7MODWsh1uCHHCxKv52CpgYcYKG9+mQQpgxDg
         6z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MS5XJHYT75fAQfNDJZYmwsq3IlOqs5XUG9bj/DNEg1Y=;
        b=ZRmmj2AzNgYq/2A6jAozj0fpDTC/xxKG4f88db5/qQ/OcThKTuu6tXpTWyeUvfIRX7
         McKfMpgrQvr1IC6D8pOT3yE5zMUZg5raj5XBoW/4EjT6swSEw9LjCtlqLgKWbgHOf2Vf
         aWW2odOfPp02qECGgHuZBqa32b0zjNYkMtJ+wumbE5Tru1lZHgXUslmSb9QfoZjB0Pyi
         F5NKwDiZQ6P85030Cwr18w79K8NAsXaFCI6xScYwAHW2q8ELNfpZQyVNwK1F6wwxNHru
         U+0fkEM0mLAXsBoplgfsRwx5UGS5puEB4w5RYG7BKxT2oQsNeACSMwerJPduE2CPvmWG
         IiDA==
X-Gm-Message-State: APjAAAXbkJRQ2WuQ9J6+8tS+DC9Q1BjzATwbda1dNbJtO8Evs4Vo1oK7
        fAehF6CQk880j+Wivzm49Nhccg==
X-Google-Smtp-Source: APXvYqz5PhdEL3jHaKHC3XzHvW9oTc+P2oasn9+crC56FOm8eG1k5Or2C2eIBzLJjHuj8/2pZCZ33A==
X-Received: by 2002:adf:e908:: with SMTP id f8mr1956221wrm.210.1567684894141;
        Thu, 05 Sep 2019 05:01:34 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 6/8] ASoC: meson: axg-frddr: add sm1 support
Date:   Thu,  5 Sep 2019 14:01:18 +0200
Message-Id: <20190905120120.31752-7-jbrunet@baylibre.com>
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

On sm1, the output routing bits have moved to CTRL2 register

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c  |  2 +-
 sound/soc/meson/axg-fifo.h  |  1 +
 sound/soc/meson/axg-frddr.c | 73 +++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 80a3dde35b5c..5a3749938900 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -306,7 +306,7 @@ static const struct regmap_config axg_fifo_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= FIFO_INIT_ADDR,
+	.max_register	= FIFO_CTRL2,
 };
 
 int axg_fifo_probe(struct platform_device *pdev)
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index 5caf81241dfe..bb1e2ce50256 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -61,6 +61,7 @@ struct snd_soc_pcm_runtime;
 #define  STATUS1_INT_STS(x)		((x) << 0)
 #define FIFO_STATUS2			0x18
 #define FIFO_INIT_ADDR			0x24
+#define FIFO_CTRL2			0x28
 
 struct axg_fifo {
 	struct regmap *map;
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 0968e8375000..6ab111c31b28 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -23,6 +23,12 @@
 #define CTRL0_SEL3_SHIFT		8
 #define CTRL0_SEL3_EN_SHIFT		11
 #define CTRL1_FRDDR_FORCE_FINISH	BIT(12)
+#define CTRL2_SEL1_SHIFT		0
+#define CTRL2_SEL1_EN_SHIFT		4
+#define CTRL2_SEL2_SHIFT		8
+#define CTRL2_SEL2_EN_SHIFT		12
+#define CTRL2_SEL3_SHIFT		16
+#define CTRL2_SEL3_EN_SHIFT		20
 
 static int g12a_frddr_dai_prepare(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
@@ -269,6 +275,70 @@ static const struct axg_fifo_match_data g12a_frddr_match_data = {
 	.dai_drv	= &g12a_frddr_dai_drv
 };
 
+/* On SM1, the output selection in on CTRL2 */
+static const struct snd_kcontrol_new sm1_frddr_out1_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL2,
+				    CTRL2_SEL1_EN_SHIFT, 1, 0);
+static const struct snd_kcontrol_new sm1_frddr_out2_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL2,
+				    CTRL2_SEL2_EN_SHIFT, 1, 0);
+static const struct snd_kcontrol_new sm1_frddr_out3_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL2,
+				    CTRL2_SEL3_EN_SHIFT, 1, 0);
+
+static SOC_ENUM_SINGLE_DECL(sm1_frddr_sel1_enum, FIFO_CTRL2, CTRL2_SEL1_SHIFT,
+			    axg_frddr_sel_texts);
+static SOC_ENUM_SINGLE_DECL(sm1_frddr_sel2_enum, FIFO_CTRL2, CTRL2_SEL2_SHIFT,
+			    axg_frddr_sel_texts);
+static SOC_ENUM_SINGLE_DECL(sm1_frddr_sel3_enum, FIFO_CTRL2, CTRL2_SEL3_SHIFT,
+			    axg_frddr_sel_texts);
+
+static const struct snd_kcontrol_new sm1_frddr_out1_demux =
+	SOC_DAPM_ENUM("Output Src 1", sm1_frddr_sel1_enum);
+static const struct snd_kcontrol_new sm1_frddr_out2_demux =
+	SOC_DAPM_ENUM("Output Src 2", sm1_frddr_sel2_enum);
+static const struct snd_kcontrol_new sm1_frddr_out3_demux =
+	SOC_DAPM_ENUM("Output Src 3", sm1_frddr_sel3_enum);
+
+static const struct snd_soc_dapm_widget sm1_frddr_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("SRC 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SRC 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SRC 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SWITCH("SRC 1 EN", SND_SOC_NOPM, 0, 0,
+			    &sm1_frddr_out1_enable),
+	SND_SOC_DAPM_SWITCH("SRC 2 EN", SND_SOC_NOPM, 0, 0,
+			    &sm1_frddr_out2_enable),
+	SND_SOC_DAPM_SWITCH("SRC 3 EN", SND_SOC_NOPM, 0, 0,
+			    &sm1_frddr_out3_enable),
+	SND_SOC_DAPM_DEMUX("SINK 1 SEL", SND_SOC_NOPM, 0, 0,
+			   &sm1_frddr_out1_demux),
+	SND_SOC_DAPM_DEMUX("SINK 2 SEL", SND_SOC_NOPM, 0, 0,
+			   &sm1_frddr_out2_demux),
+	SND_SOC_DAPM_DEMUX("SINK 3 SEL", SND_SOC_NOPM, 0, 0,
+			   &sm1_frddr_out3_demux),
+	SND_SOC_DAPM_AIF_OUT("OUT 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 5", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 6", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 7", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_component_driver sm1_frddr_component_drv = {
+	.dapm_widgets		= sm1_frddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sm1_frddr_dapm_widgets),
+	.dapm_routes		= g12a_frddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(g12a_frddr_dapm_routes),
+	.ops			= &g12a_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data sm1_frddr_match_data = {
+	.component_drv	= &sm1_frddr_component_drv,
+	.dai_drv	= &g12a_frddr_dai_drv
+};
+
 static const struct of_device_id axg_frddr_of_match[] = {
 	{
 		.compatible = "amlogic,axg-frddr",
@@ -276,6 +346,9 @@ static const struct of_device_id axg_frddr_of_match[] = {
 	}, {
 		.compatible = "amlogic,g12a-frddr",
 		.data = &g12a_frddr_match_data,
+	}, {
+		.compatible = "amlogic,sm1-frddr",
+		.data = &sm1_frddr_match_data,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_frddr_of_match);
-- 
2.21.0

