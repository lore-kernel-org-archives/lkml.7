Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C37C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C724208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfIMT2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:28:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41854 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbfIMT2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:28:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D3CB1A0189;
        Fri, 13 Sep 2019 21:28:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 204D41A00D0;
        Fri, 13 Sep 2019 21:28:11 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 93EEE205DB;
        Fri, 13 Sep 2019 21:28:10 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mihai Serban <mihai.serban@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/3] ASoC: fsl_sai: Fix noise when using EDMA
Date:   Fri, 13 Sep 2019 22:28:05 +0300
Message-Id: <20190913192807.8423-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913192807.8423-1-daniel.baluta@nxp.com>
References: <20190913192807.8423-1-daniel.baluta@nxp.com>
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

Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
* rename variable to use_edma as per Nicolin's suggestion.

 sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ef0b74693093..b517e4bc1b87 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -628,6 +628,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 			   FSL_SAI_CR3_TRCE_MASK,
 			   FSL_SAI_CR3_TRCE);
 
+	/*
+	 * EDMA controller needs period size to be a multiple of
+	 * tx/rx maxburst
+	 */
+	if (sai->soc_data->use_edma)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   tx ? sai->dma_params_tx.maxburst :
+					   sai->dma_params_rx.maxburst);
+
 	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
 
@@ -1026,30 +1036,35 @@ static int fsl_sai_remove(struct platform_device *pdev)
 
 static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
 	.use_imx_pcm = false,
+	.use_edma = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.use_imx_pcm = true,
+	.use_edma = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
 	.use_imx_pcm = true,
+	.use_edma = false,
 	.fifo_depth = 16,
 	.reg_offset = 8,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.use_imx_pcm = true,
+	.use_edma = false,
 	.fifo_depth = 128,
 	.reg_offset = 8,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
 	.use_imx_pcm = true,
+	.use_edma = true,
 	.fifo_depth = 64,
 	.reg_offset = 0,
 };
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b12cb578f6d0..76b15deea80c 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -157,6 +157,7 @@
 
 struct fsl_sai_soc_data {
 	bool use_imx_pcm;
+	bool use_edma;
 	unsigned int fifo_depth;
 	unsigned int reg_offset;
 };
-- 
2.17.1

