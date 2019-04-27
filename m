Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD14C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E458205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330208;
	bh=haCo/VdjNQnJxg5VvAxc5X+gxlkO7/0QEcLXNrf/6YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x8a8j3k65H6hgFmJEZgkEJp4sUR2EDGXUiIphPz9ZW5I+be6Uyj1URI4Ass0ANrY0
	 n9V+pV/ohDMQHEKfevQxAPPITSmWSAhsPmeDNS7sbTjDar9o+1+odqcdJAEjj6ONWj
	 bA8Sryjdjw1ll7Ad95KoRANyFCz83uO+lZrRAz+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfD0Bix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfD0Biq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0063D2086A;
        Sat, 27 Apr 2019 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329125;
        bh=haCo/VdjNQnJxg5VvAxc5X+gxlkO7/0QEcLXNrf/6YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yPF0fwVINzVAOajPWjVvSt3p8zeJ9ISmk+AUw84OXhgOp188MlgFtfxZjVVYfwPVf
         f0t1tQxoxjOltHZeVUD7qqqLsNnGlQsvB6QhVxwxy0xkDYVRKhb1g5cUOhU0TfoKFk
         Is0OtsspgzFst0wcJ3Poz7tni35yKzqzD7vWpM8w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 06/79] ASoC: stm32: sai: fix race condition in irq handler
Date:   Fri, 26 Apr 2019 21:37:25 -0400
Message-Id: <20190427013838.6596-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

[ Upstream commit 26f98e82dd49b7c3cc5ef0edd882aa732a62b672 ]

When snd_pcm_stop_xrun() is called in interrupt routine,
substream context may have already been released.
Add protection on substream context.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index de4855b30e36..cc56102881be 100644
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
@@ -1061,6 +1068,7 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned long flags;
 
 	regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX, SAI_XIMR_MASK, 0);
 
@@ -1071,7 +1079,9 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 
 	clk_rate_exclusive_put(sai->sai_mclk);
 
+	spin_lock_irqsave(&sai->irq_lock, flags);
 	sai->substream = NULL;
+	spin_unlock_irqrestore(&sai->irq_lock, flags);
 }
 
 static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
@@ -1435,6 +1445,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 	mutex_init(&sai->ctrl_lock);
+	spin_lock_init(&sai->irq_lock);
 	platform_set_drvdata(pdev, sai);
 
 	sai->pdata = dev_get_drvdata(pdev->dev.parent);
-- 
2.19.1

