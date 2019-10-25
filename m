Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BB3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837F42070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406730AbfJYHRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:17:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55410 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733140AbfJYHRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:17:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 38CE71A0409;
        Fri, 25 Oct 2019 09:17:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F49B1A00FD;
        Fri, 25 Oct 2019 09:17:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 04A9C402BC;
        Fri, 25 Oct 2019 15:16:59 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ASoC: fsl_esai: Add spin lock to protect reset, stop and start
Date:   Fri, 25 Oct 2019 15:13:53 +0800
Message-Id: <36e1d0157d2b71985b88e841d416d04c584c04fe.1571986436.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xrun may happen at the end of stream, the
trigger->fsl_esai_trigger_stop maybe called in the middle of
fsl_esai_hw_reset, this may cause esai in wrong state
after stop, and there may be endless xrun interrupt.

This issue may also happen with trigger->fsl_esai_trigger_start.

So Add spin lock to lock those functions.

Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Change in v2
-add lock for fsl_esai_trigger_start.

 sound/soc/fsl/fsl_esai.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 37b14c48b537..9b28e2af26e4 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -33,6 +33,7 @@
  * @fsysclk: system clock source to derive HCK, SCK and FS
  * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @task: tasklet to handle the reset operation
+ * @lock: spin lock to handle reset and stop behavior
  * @fifo_depth: depth of tx/rx FIFO
  * @slot_width: width of each DAI slot
  * @slots: number of slots
@@ -56,6 +57,7 @@ struct fsl_esai {
 	struct clk *fsysclk;
 	struct clk *spbaclk;
 	struct tasklet_struct task;
+	spinlock_t lock; /* Protect reset and stop */
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
@@ -676,8 +678,10 @@ static void fsl_esai_hw_reset(unsigned long arg)
 {
 	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
 	bool tx = true, rx = false, enabled[2];
+	unsigned long lock_flags;
 	u32 tfcr, rfcr;
 
+	spin_lock_irqsave(&esai_priv->lock, lock_flags);
 	/* Save the registers */
 	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
 	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
@@ -715,6 +719,8 @@ static void fsl_esai_hw_reset(unsigned long arg)
 		fsl_esai_trigger_start(esai_priv, tx);
 	if (enabled[rx])
 		fsl_esai_trigger_start(esai_priv, rx);
+
+	spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
 }
 
 static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -722,6 +728,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned long lock_flags;
 
 	esai_priv->channels[tx] = substream->runtime->channels;
 
@@ -729,12 +736,16 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		spin_lock_irqsave(&esai_priv->lock, lock_flags);
 		fsl_esai_trigger_start(esai_priv, tx);
+		spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		spin_lock_irqsave(&esai_priv->lock, lock_flags);
 		fsl_esai_trigger_stop(esai_priv, tx);
+		spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
 		break;
 	default:
 		return -EINVAL;
@@ -1002,6 +1013,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, esai_priv);
 
+	spin_lock_init(&esai_priv->lock);
 	ret = fsl_esai_hw_init(esai_priv);
 	if (ret)
 		return ret;
-- 
2.21.0

