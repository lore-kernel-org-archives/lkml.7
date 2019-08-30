Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B9C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3E82343D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfH3UJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:09:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44694 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfH3UJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:09:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52F54200033;
        Fri, 30 Aug 2019 22:09:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 450E0200423;
        Fri, 30 Aug 2019 22:09:02 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AF43C2061E;
        Fri, 30 Aug 2019 22:09:01 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        mihai.serban@gmail.com, Mihai Serban <mihai.serban@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl_sai: Fix noise when using EDMA
Date:   Fri, 30 Aug 2019 23:09:00 +0300
Message-Id: <20190830200900.19668-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihai Serban <mihai.serban@nxp.com>

EDMA requires the period size to be multiple of maxburst. Otherwise the
remaining bytes are not transferred and thus noise is produced.

We can handle this issue by adding a constraint on
SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.

Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 728307acab90..fe126029f4e3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -612,6 +612,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 			   FSL_SAI_CR3_TRCE_MASK,
 			   FSL_SAI_CR3_TRCE);
 
+	/*
+	 * some DMA controllers need period size to be a multiple of
+	 * tx/rx maxburst
+	 */
+	if (sai->soc_data->use_constraint_period_size)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   tx ? sai->dma_params_tx.maxburst :
+					   sai->dma_params_rx.maxburst);
+
 	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
 
@@ -1011,30 +1021,35 @@ static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
 	.use_imx_pcm = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 32,
 	.reg_offset = 0,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 16,
 	.reg_offset = 8,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 128,
 	.reg_offset = 8,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 64,
 	.reg_offset = 0,
+	.use_constraint_period_size = true,
 };
 
 static const struct of_device_id fsl_sai_ids[] = {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b89b0ca26053..3a3f6f8e5595 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -157,6 +157,7 @@
 
 struct fsl_sai_soc_data {
 	bool use_imx_pcm;
+	bool use_constraint_period_size;
 	unsigned int fifo_depth;
 	unsigned int reg_offset;
 };
-- 
2.17.1

