Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAA7C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B78D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RHC2CuJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfDWP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:59:27 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61177 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbfDWP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:59:26 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NFuOK1008853;
        Tue, 23 Apr 2019 17:58:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=PdlUUgbt8YtJQbaXRQuaTjUuREqoOEk6yxI4tQvkYMI=;
 b=RHC2CuJXbgT16wT6WV++ad+C+hjAzazMEa0UEayI7rMRKxrdBXJLALIAp2reB50ApyN7
 20+lpiwsstn8CeBLhtjX2kXaNBLo+WGdPEtBuRQBL1+brTDMHoFzHBlh3RsLpMluLHyH
 uIDHV2UG2tY1jcwRE5eQYgCMUO1DoNkovwo1ThIHqAB24tccwdSoH7fwgPrIgtxAk6KH
 9OgWIYSUdG/6Z3jRvIExR3Z5xxjG4fqKJfgHz7HeWJPgxs/8tDE8/dERQCZqCIZJLtx2
 5/Ozx8EcPg1Y/6Lq5FIie9zZymfReCVwBH3hYPDNADUkW3b4CZadCFxRyL+TX2V3GnEW ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6rrcg3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Apr 2019 17:58:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF7FB38;
        Tue, 23 Apr 2019 15:58:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A6F5329B5;
        Tue, 23 Apr 2019 15:58:27 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 23 Apr
 2019 17:58:27 +0200
Received: from localhost (10.48.0.131) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 23 Apr 2019 17:58:27 +0200
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
Subject: [PATCH v2] ASoC: stm32: sai: simplify dai driver initialisation
Date:   Tue, 23 Apr 2019 17:58:08 +0200
Message-ID: <1556035088-11228-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress the useless dynamic allocation of the dai driver structure.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---

V1 to V2:
- add "sai" in commit title to identify the driver
- add reviewed-by

 sound/soc/stm/stm32_sai_sub.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 77aa38183955..2a74ce7c9440 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -110,7 +110,7 @@ struct stm32_sai_sub_data {
 	struct regmap *regmap;
 	const struct regmap_config *regmap_config;
 	struct snd_dmaengine_dai_dma_data dma_params;
-	struct snd_soc_dai_driver *cpu_dai_drv;
+	struct snd_soc_dai_driver cpu_dai_drv;
 	struct snd_soc_dai *cpu_dai;
 	struct snd_pcm_substream *substream;
 	struct stm32_sai_data *pdata;
@@ -1234,8 +1234,7 @@ static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
 	.periods_max = 8,
 };
 
-static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
-{
+static struct snd_soc_dai_driver stm32_sai_playback_dai = {
 		.probe = stm32_sai_dai_probe,
 		.pcm_new = stm32_sai_pcm_new,
 		.id = 1, /* avoid call to fmt_single_name() */
@@ -1252,11 +1251,9 @@ static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
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
@@ -1272,7 +1269,6 @@ static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
 				SNDRV_PCM_FMTBIT_S32_LE,
 		},
 		.ops = &stm32_sai_pcm_dai_ops,
-	}
 };
 
 static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
@@ -1441,29 +1437,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
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
@@ -1495,9 +1468,11 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
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
@@ -1507,7 +1482,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_component,
-					      sai->cpu_dai_drv, 1);
+					      &sai->cpu_dai_drv, 1);
 	if (ret)
 		return ret;
 
-- 
2.7.4

