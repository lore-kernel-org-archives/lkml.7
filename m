Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBDDC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3FD222CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h2yZcd8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfJDUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:21:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33798 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfJDUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:21:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x94KLCbJ004449;
        Fri, 4 Oct 2019 15:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570220472;
        bh=G2vrhle0ogXEFE9GNb8NB4dmf6h7nmzclkwNhOY1Z+o=;
        h=From:To:CC:Subject:Date;
        b=h2yZcd8cOyQSjY2e2PB1Ap7gtZfuVbS7+cPx6Z5lFMWI03Nhfbni1GyP7LlxbAbS3
         Jf1z5isC8l5gXNJYqS8Yh+McavUHX8rSYLCw911At7/RJAo31XnRw2T6+Se61wCB42
         wfCeA0ssyhFHx7ZsPWjmPv0e+MBXF+IogP3glsZY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94KLCwo028616;
        Fri, 4 Oct 2019 15:21:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 4 Oct
 2019 15:21:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 4 Oct 2019 15:21:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94KLBcn060669;
        Fri, 4 Oct 2019 15:21:11 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <shifu0704@thundersoft.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <navada@ti.com>, <perex@perex.cz>,
        <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ASoC: tas2770: Fix snd_soc_update_bits error handling
Date:   Fri, 4 Oct 2019 15:22:45 -0500
Message-ID: <20191004202245.22855-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the documentation for snd_soc_update_bits the API
will return a 1 if the update was successful with a value change,
a 0 if the update was successful with no value change or a negative
if the command just failed.

So the value of return in the driver needs to be checked for being less
then 0 or the caller may indicate failure when the value actually
changed.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |  1 +
 sound/soc/codecs/tas2770.c           | 44 ++++++++++++++++++----------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 64eb896907bf..8a57185112a2 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -395,6 +395,7 @@ CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_SOC_OMAP_HDMI=m
 CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SOC_TLV320AIC23_I2C=m
+CONFIG_SND_SOC_TAS2770=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_HID_GENERIC=m
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index dbbb21fe0548..774c8f2833c8 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -82,7 +82,8 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
 		TAS2770_PWR_CTRL,
 		TAS2770_PWR_CTRL_MASK,
 		TAS2770_PWR_CTRL_SHUTDOWN);
-	if (ret)
+
+	if (ret < 0)
 		return ret;
 
 	return 0;
@@ -96,8 +97,9 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
 		TAS2770_PWR_CTRL,
 		TAS2770_PWR_CTRL_MASK,
 		TAS2770_PWR_CTRL_ACTIVE);
-	if (ret)
-		return -EINVAL;
+
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -149,7 +151,10 @@ static int tas2770_dac_event(struct snd_soc_dapm_widget *w,
 	}
 
 end:
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static const struct snd_kcontrol_new isense_switch =
@@ -199,7 +204,10 @@ static int tas2770_mute(struct snd_soc_dai *dai, int mute)
 			TAS2770_PWR_CTRL_MASK,
 			TAS2770_PWR_CTRL_ACTIVE);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
@@ -252,7 +260,10 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 		tas2770->i_sense_slot);
 
 end:
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
@@ -344,9 +355,11 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 	}
 
 end:
-	if (!ret)
-		tas2770->sampling_rate = samplerate;
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	tas2770->sampling_rate = samplerate;
+	return 0;
 }
 
 static int tas2770_hw_params(struct snd_pcm_substream *substream,
@@ -426,7 +439,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG1,
 		TAS2770_TDM_CFG_REG1_MASK,
 	(tdm_rx_start_slot << TAS2770_TDM_CFG_REG1_51_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	value = snd_soc_component_read32(component, TAS2770_TDM_CFG_REG3);
@@ -472,12 +485,12 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG3,
 		TAS2770_TDM_CFG_REG3_30_MASK,
 		(left_slot << TAS2770_TDM_CFG_REG3_30_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG3,
 		TAS2770_TDM_CFG_REG3_RXS_MASK,
 	(right_slot << TAS2770_TDM_CFG_REG3_RXS_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	switch (slot_width) {
@@ -511,10 +524,11 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		ret = -EINVAL;
 	}
 
-	if (!ret)
-		tas2770->slot_width = slot_width;
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	tas2770->slot_width = slot_width;
+	return 0;
 }
 
 static struct snd_soc_dai_ops tas2770_dai_ops = {
-- 
2.22.0.214.g8dca754b1e

