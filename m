Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05BFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627E217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qoW/NLTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfDEJ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:28:24 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25454 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730448AbfDEJ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:28:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x359QAd5028061;
        Fri, 5 Apr 2019 11:27:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=U4x9fcXFNftjJOYqvmBBUzk/hhIqNaud8Vh3hEG7MVU=;
 b=qoW/NLTzqMYg7z6VppTQwKZ5y89s3oT9jowGJmOu0YmpphcI66smAwmln+GqiLnYBESo
 TTLwaupL8V6ssTHCFHSsW3DFQZkZ2AQK2ctHq7oiyNnIWC2SW0j+cGha6iE8Rd7gYngO
 cJ6Y4yWdZN3LVYVqzXKukirmYIO8brXEhmhsebrduJKO91RRGyNUR7cc4epncxlfWGFr
 r814yBCIv7qiRYFHxdaDaD66k/kgy6m9z/Qh4IaW3itdxpgDucitYl2QEH3B4kdSzjxb
 CHfUvAcQcebe3D6UHTbrdlvMi/cV+0Lrk/gjuv9GUXIC1wqyhM9TFTbrvQKg35V4LeZF 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgevgbuu-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 11:27:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 15A0634;
        Fri,  5 Apr 2019 09:27:03 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D763D2607;
        Fri,  5 Apr 2019 09:27:02 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Apr 2019
 11:27:02 +0200
Received: from localhost (10.48.0.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Apr 2019 11:27:02 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH] ASoC: stm32: simplify dai driver initialisation
Date:   Fri, 5 Apr 2019 11:26:27 +0200
Message-ID: <1554456387-3088-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress the useless dynamic allocation of the dai driver structure.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3dd54bc..e3b021c 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -109,7 +109,7 @@ struct stm32_sai_sub_data {
 	struct regmap *regmap;
 	const struct regmap_config *regmap_config;
 	struct snd_dmaengine_dai_dma_data dma_params;
-	struct snd_soc_dai_driver *cpu_dai_drv;
+	struct snd_soc_dai_driver cpu_dai_drv;
 	struct snd_soc_dai *cpu_dai;
 	struct snd_pcm_substream *substream;
 	struct stm32_sai_data *pdata;
@@ -1204,8 +1204,7 @@ static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
 	.periods_max = 8,
 };
 
-static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
-{
+static struct snd_soc_dai_driver stm32_sai_playback_dai = {
 		.probe = stm32_sai_dai_probe,
 		.pcm_new = stm32_sai_pcm_new,
 		.id = 1, /* avoid call to fmt_single_name() */
@@ -1222,11 +1221,9 @@ static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
 				SNDRV_PCM_FMTBIT_S32_LE,
 		},
 		.ops = &stm32_sai_pcm_dai_ops,
-	}
 };
 
-static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
-{
+static struct snd_soc_dai_driver stm32_sai_capture_dai = {
 		.probe = stm32_sai_dai_probe,
 		.id = 1, /* avoid call to fmt_single_name() */
 		.capture = {
@@ -1242,7 +1239,6 @@ static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
 				SNDRV_PCM_FMTBIT_S32_LE,
 		},
 		.ops = &stm32_sai_pcm_dai_ops,
-	}
 };
 
 static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
@@ -1411,29 +1407,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	return 0;
 }
 
-static int stm32_sai_sub_dais_init(struct platform_device *pdev,
-				   struct stm32_sai_sub_data *sai)
-{
-	sai->cpu_dai_drv = devm_kzalloc(&pdev->dev,
-					sizeof(struct snd_soc_dai_driver),
-					GFP_KERNEL);
-	if (!sai->cpu_dai_drv)
-		return -ENOMEM;
-
-	if (STM_SAI_IS_PLAYBACK(sai)) {
-		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
-		       sizeof(stm32_sai_playback_dai));
-		sai->cpu_dai_drv->playback.stream_name = sai->cpu_dai_drv->name;
-	} else {
-		memcpy(sai->cpu_dai_drv, &stm32_sai_capture_dai,
-		       sizeof(stm32_sai_capture_dai));
-		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
-	}
-	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
-
-	return 0;
-}
-
 static int stm32_sai_sub_probe(struct platform_device *pdev)
 {
 	struct stm32_sai_sub_data *sai;
@@ -1465,9 +1438,11 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = stm32_sai_sub_dais_init(pdev, sai);
-	if (ret)
-		return ret;
+	if (STM_SAI_IS_PLAYBACK(sai))
+		sai->cpu_dai_drv = stm32_sai_playback_dai;
+	else
+		sai->cpu_dai_drv = stm32_sai_capture_dai;
+	sai->cpu_dai_drv.name = dev_name(&pdev->dev);
 
 	ret = devm_request_irq(&pdev->dev, sai->pdata->irq, stm32_sai_isr,
 			       IRQF_SHARED, dev_name(&pdev->dev), sai);
@@ -1477,7 +1452,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_component,
-					      sai->cpu_dai_drv, 1);
+					      &sai->cpu_dai_drv, 1);
 	if (ret)
 		return ret;
 
-- 
2.7.4

