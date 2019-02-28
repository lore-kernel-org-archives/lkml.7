Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EE9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C8020C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbfB1NTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:19:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55010 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbfB1NTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:19:52 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SDH6tT010699;
        Thu, 28 Feb 2019 14:19:35 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtwxpdffc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 14:19:35 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AB6F3D;
        Thu, 28 Feb 2019 13:19:34 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3520156C3;
        Thu, 28 Feb 2019 13:19:34 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb
 2019 14:19:33 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb 2019 14:19:33
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 3/5] ASoC: stm32: sai: fix race condition in irq handler
Date:   Thu, 28 Feb 2019 14:19:23 +0100
Message-ID: <1551359965-25228-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
References: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When snd_pcm_stop_xrun() is called in interrupt routine,
substream context may have already been released.
Add protection on substream context.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index e418f446e03b..cad415e03b5e 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -102,6 +102,7 @@
  * @spdif_frm_cnt: S/PDIF playback frame counter
  * @iec958: iec958 data
  * @ctrl_lock: control lock
+ * @irq_lock: prevent race condition with IRQ
  */
 struct stm32_sai_sub_data {
 	struct platform_device *pdev;
@@ -133,6 +134,7 @@ struct stm32_sai_sub_data {
 	unsigned int spdif_frm_cnt;
 	struct snd_aes_iec958 iec958;
 	struct mutex ctrl_lock; /* protect resources accessed by controls */
+	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
 };
 
 enum stm32_sai_fifo_th {
@@ -474,8 +476,10 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 		status = SNDRV_PCM_STATE_XRUN;
 	}
 
-	if (status != SNDRV_PCM_STATE_RUNNING)
+	spin_lock(&sai->irq_lock);
+	if (status != SNDRV_PCM_STATE_RUNNING && sai->substream)
 		snd_pcm_stop_xrun(sai->substream);
+	spin_unlock(&sai->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -679,8 +683,11 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int imr, cr2, ret;
+	unsigned long flags;
 
+	spin_lock_irqsave(&sai->irq_lock, flags);
 	sai->substream = substream;
+	spin_unlock_irqrestore(&sai->irq_lock, flags);
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
 		snd_pcm_hw_constraint_mask64(substream->runtime,
@@ -1059,6 +1066,7 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned long flags;
 
 	regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX, SAI_XIMR_MASK, 0);
 
@@ -1069,7 +1077,9 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 
 	clk_rate_exclusive_put(sai->sai_mclk);
 
+	spin_lock_irqsave(&sai->irq_lock, flags);
 	sai->substream = NULL;
+	spin_unlock_irqrestore(&sai->irq_lock, flags);
 }
 
 static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
@@ -1433,6 +1443,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 	mutex_init(&sai->ctrl_lock);
+	spin_lock_init(&sai->irq_lock);
 	platform_set_drvdata(pdev, sai);
 
 	sai->pdata = dev_get_drvdata(pdev->dev.parent);
-- 
2.7.4

