Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D507C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E36F20674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WsOjrktz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCOWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:22:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9256 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbfLCOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:22:04 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3EGmgs011509;
        Tue, 3 Dec 2019 15:16:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=X6SFhefHKL3s7V39AZGDRkkqo5eWgLZZ/k9fvJmXZdc=;
 b=WsOjrktz1I6R+x2e8lc2wW3G6RrWTXVa8oaUQtj49yz4w/TRFctal/2qVRMWe3w2HiSS
 c9Zi+z73zkl5hCbbKDsjfLKuX/xPiN1GPL2T4uFMbOgc2liZyarg7giVujX6tNq7qBZS
 cUP+48nfFsXVmbowFStrOQ4US8AexhzuPeNvnT7bk3mcr79+RqAqYBnG3ZsDBW0sVKuS
 5WF5qZ/ELzhK8lOK6pQjVQI5dO5xh6cF7Ah0JulW3SIArGLSYND4VCnlYrQpuAIIuXSJ
 3IAgQ3S95e41ihJ3NNW/e6/zy2b+gi+Hb0ANH1Pvp1BT4CqMHRkCmPVHfT/aLobdvKDJ 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkeea010y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 15:16:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B141E100042;
        Tue,  3 Dec 2019 15:16:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BD542B9F94;
        Tue,  3 Dec 2019 15:16:46 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Dec 2019 15:16:45
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
CC:     <apatard@mandriva.com>
Subject: [PATCH] ASoC: cs42l51: add dac mux widget in codec routes
Date:   Tue, 3 Dec 2019 15:16:27 +0100
Message-ID: <20191203141627.29471-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_03:2019-12-02,2019-12-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "DAC mux" DAPM widget in CS42l51 audio codec routes,
to support DAC mux control and to remove error trace
"DAC Mux has no paths" at widget creation.
Note: ADC path of DAC mux is not routed in this patch.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 55408c8fcb4e..e47758e4fb36 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -214,12 +214,10 @@ static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC_E("Right ADC", "Right HiFi Capture",
 		CS42L51_POWER_CTL1, 2, 1,
 		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
-	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
-		CS42L51_POWER_CTL1, 5, 1,
-		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
-	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
-		CS42L51_POWER_CTL1, 6, 1,
-		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("Left DAC", NULL, CS42L51_POWER_CTL1, 5, 1,
+			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("Right DAC", NULL, CS42L51_POWER_CTL1, 6, 1,
+			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
 
 	/* analog/mic */
 	SND_SOC_DAPM_INPUT("AIN1L"),
@@ -255,6 +253,12 @@ static const struct snd_soc_dapm_route cs42l51_routes[] = {
 	{"HPL", NULL, "Left DAC"},
 	{"HPR", NULL, "Right DAC"},
 
+	{"Right DAC", NULL, "DAC Mux"},
+	{"Left DAC", NULL, "DAC Mux"},
+
+	{"DAC Mux", "Direct PCM", "Playback"},
+	{"DAC Mux", "DSP PCM", "Playback"},
+
 	{"Left ADC", NULL, "Left PGA"},
 	{"Right ADC", NULL, "Right PGA"},
 
-- 
2.17.1

