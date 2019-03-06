Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBECC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC02020840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M1HmzOSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfCFJKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:10:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40388 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfCFJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:10:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so8076008pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBRwHy++m0fL35ly3x5rDQiC6l/phzLeOzwcJKI4GMg=;
        b=M1HmzOSjpEtogua6APuDvc1MXvjctnAgQNWsWlPbtXCdXCSUPNR6wdNWF75mE7c7Nb
         67p8b3uZjJ23HksbGdFfjQiwbSE64nYLnIqeUnt4wLuZNesteF3jCDJv15rDM1/QCNGz
         ZwwQ0cUcVc0jgyGyEkqYkl1aQ0iiZp5et7k40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBRwHy++m0fL35ly3x5rDQiC6l/phzLeOzwcJKI4GMg=;
        b=ucq5WFlByWwjxyWuQogCR4CCioRg8LP6v3VsqPt664EhZc9wUS3ZdmcfPlZ/a5HIWr
         gh2cxMg8OpEX2TtIbFtjARUEl9cKz08KpAvCb8w7IyC+MuIOnWsCfbrOfw7V4VJ0I25w
         q6EWNE1C+b3yx44M7uXR/a1rGw5yTr3CYa2fJIth5bqgChpH5l9g2BecHFEN/jmcZRxP
         PKozII1b2zVDCMQl89XBYCAOGQduZpfkSolyV1wARXX8y8bC+Tfulh0aySR5T9KvSbkX
         LzR4DjBpVDaHlfKjOXgb4Bc789mklf61rHWuKFgExtt4Mih7WSUHMGuEy9dITl/oiddH
         mydg==
X-Gm-Message-State: APjAAAXu26fTToMKmGkVT1Uj27yF8Tpo+b6rb45SGnOTAOXimv6vwsKz
        shZQF3c89bhq7BHCMVvTpoTtdQ==
X-Google-Smtp-Source: APXvYqyszv1Zeh422CyvWLaT31AZoOsPBkaVdZKw/7jK3oEvf+N7nMA5QPKnwt4MjEj/xpYyOyxqvg==
X-Received: by 2002:a17:902:7082:: with SMTP id z2mr5735822plk.251.1551863401160;
        Wed, 06 Mar 2019 01:10:01 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id h65sm1603710pgc.93.2019.03.06.01.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 01:10:00 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Garlic Tseng <garlic.tseng@mediatek.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Shunli Wang <shunli.wang@mediatek.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ASoC: mediatek: Fix UBSAN warning.
Date:   Wed,  6 Mar 2019 17:09:02 +0800
Message-Id: <20190306090922.117634-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190306090922.117634-1-pihsun@chromium.org>
References: <20190306090922.117634-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sound/soc/mediatek/common/mtk-afe-fe-dai.c, when xxx_reg is -1, it's
a no-op to call mtk_regmap_update_bits, but since both xxx_reg and
xxx_shift are set to -1, the (1 << xxx_shift) in the argument would
trigger a UBSAN warning.

Fix the warning by setting those xxx_shift to 0 instead.

Note that since the code explicitly checks .mono_shift >= 0 and
.fs_shift >= 0 before using them in '<<' operator, those two members are
not set to 0.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c |  9 ++++-----
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 -------------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 16 ----------------
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 16 ----------------
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 20 --------------------
 5 files changed, 4 insertions(+), 70 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index cf4978be062f..3830e582e188 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -197,11 +197,10 @@ int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		if (memif->data->enable_shift >= 0)
-			mtk_regmap_update_bits(afe->regmap,
-					       memif->data->enable_reg,
-					       1 << memif->data->enable_shift,
-					       1 << memif->data->enable_shift);
+		mtk_regmap_update_bits(afe->regmap,
+				       memif->data->enable_reg,
+				       1 << memif->data->enable_shift,
+				       1 << memif->data->enable_shift);
 
 		/* set irq counter */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 968fba4d7533..7064a9fd6f74 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -994,7 +994,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 6,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL2",
@@ -1013,7 +1012,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 7,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL3",
@@ -1032,7 +1030,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 8,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL4",
@@ -1051,7 +1048,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 9,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL5",
@@ -1070,7 +1066,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 10,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DLM",
@@ -1089,7 +1084,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 12,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL1",
@@ -1108,7 +1102,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 0,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL2",
@@ -1127,7 +1120,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL3",
@@ -1146,7 +1138,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 2,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL4",
@@ -1165,7 +1156,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 3,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL5",
@@ -1184,7 +1174,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 4,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DLBT",
@@ -1203,7 +1192,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 13,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "ULBT",
@@ -1222,7 +1210,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 16,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 };
 
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index bff7d71d0742..08a6532da322 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -401,9 +401,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL1_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_DL2] = {
 		.name = "DL2",
@@ -420,9 +418,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_DL3] = {
 		.name = "DL3",
@@ -439,9 +435,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL3_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_VUL] = {
 		.name = "VUL",
@@ -458,9 +452,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_AWB] = {
 		.name = "AWB",
@@ -477,9 +469,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_VUL12] = {
 		.name = "VUL12",
@@ -496,9 +486,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL_DATA2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_DAI] = {
 		.name = "DAI",
@@ -515,9 +503,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DAI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_MOD_DAI] = {
 		.name = "MOD_DAI",
@@ -534,9 +520,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = MOD_DAI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 };
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 166aed28330d..0382896c162e 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -714,13 +714,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 21,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 1,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 0,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "DL2",
 		.id = MT8173_AFE_MEMIF_DL2,
@@ -732,13 +730,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 22,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 2,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 1,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "VUL",
 		.id = MT8173_AFE_MEMIF_VUL,
@@ -750,13 +746,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 27,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 3,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 6,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "DAI",
 		.id = MT8173_AFE_MEMIF_DAI,
@@ -768,13 +762,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = -1,
 		.mono_shift = -1,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 4,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 5,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "AWB",
 		.id = MT8173_AFE_MEMIF_AWB,
@@ -786,13 +778,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 24,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 6,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 3,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "MOD_DAI",
 		.id = MT8173_AFE_MEMIF_MOD_DAI,
@@ -804,13 +794,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 30,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 7,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 4,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "HDMI",
 		.id = MT8173_AFE_MEMIF_HDMI,
@@ -822,13 +810,10 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = -1,
 		.mono_shift = -1,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = -1,
-		.enable_shift = -1,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 8,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	},
 };
 
@@ -914,7 +899,6 @@ static const struct mtk_base_irq_data irq_data[MT8173_AFE_IRQ_NUM] = {
 		.irq_en_reg = AFE_IRQ_MCU_CON,
 		.irq_en_shift = 12,
 		.irq_fs_reg = -1,
-		.irq_fs_shift = -1,
 		.irq_fs_maskbit = -1,
 		.irq_clr_reg = AFE_IRQ_CLR,
 		.irq_clr_shift = 4,
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 4e045dd305a7..43be51bf0329 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -421,9 +421,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL1_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_DL2] = {
 		.name = "DL2",
@@ -440,9 +438,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_DL3] = {
 		.name = "DL3",
@@ -459,9 +455,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL3_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_VUL2] = {
 		.name = "VUL2",
@@ -478,9 +472,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_AWB] = {
 		.name = "AWB",
@@ -497,9 +489,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_AWB2] = {
 		.name = "AWB2",
@@ -516,9 +506,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_VUL12] = {
 		.name = "VUL12",
@@ -535,9 +523,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL12_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_MOD_DAI] = {
 		.name = "MOD_DAI",
@@ -554,9 +540,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = MOD_DAI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_HDMI] = {
 		.name = "HDMI",
@@ -569,13 +553,10 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.mono_reg = -1,
 		.mono_shift = -1,
 		.enable_reg = -1,	/* control in tdm for sync start */
-		.enable_shift = -1,
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = HDMI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 };
 
@@ -690,7 +671,6 @@ static const struct mtk_base_irq_data irq_data[MT8183_IRQ_NUM] = {
 		.irq_cnt_shift = 0,
 		.irq_cnt_maskbit = 0x3ffff,
 		.irq_fs_reg = -1,
-		.irq_fs_shift = -1,
 		.irq_fs_maskbit = -1,
 		.irq_en_reg = AFE_IRQ_MCU_CON0,
 		.irq_en_shift = IRQ8_MCU_ON_SFT,
-- 
2.21.0.352.gf09ad66450-goog

