Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40104C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118C123430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfH3WzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:55:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44870 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3WzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:55:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B8A351A008B;
        Sat, 31 Aug 2019 00:55:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A20AB1A0412;
        Sat, 31 Aug 2019 00:55:16 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 222C220627;
        Sat, 31 Aug 2019 00:55:16 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        gabrielcsmo@gmail.com, Daniel Baluta <daniel.baluta@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
Date:   Sat, 31 Aug 2019 01:55:14 +0300
Message-Id: <20190830225514.5283-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From SAI datasheet:

CHMOD, configures if transmit data pins are configured for TDM mode
or Output mode.
	* (0) TDM mode, transmit data pins are tri-stated when slots are
	masked or channels are disabled.
	* (1) Output mode, transmit data pins are never tri-stated and
	will output zero when slots are masked or channels are disabled.

When data pins are tri-stated, there is noise on some channels
when FS clock value is high and data is read while fsclk is
transitioning from high to low.

Fix this by setting CHMOD to Output Mode so that pins will output zero
when slots are masked or channels are disabled.

Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 15 ++++++++++++---
 sound/soc/fsl/fsl_sai.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index e896b577b1f7..b9daab0eb6eb 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -467,6 +467,12 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
 
+	/*
+	 * set CHMOD to Output Mode so that transmit data pins will
+	 * output zero when slots are masked or channels are disabled
+	 */
+	val_cr4 |= FSL_SAI_CR4_CHMOD;
+
 	/*
 	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
 	 * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
@@ -477,7 +483,8 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	if (!sai->is_slave_mode) {
 		if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
 			regmap_update_bits(sai->regmap, FSL_SAI_TCR4(ofs),
-				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
+				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
+				FSL_SAI_CR4_CHMOD_MASK,
 				val_cr4);
 			regmap_update_bits(sai->regmap, FSL_SAI_TCR5(ofs),
 				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
@@ -486,7 +493,8 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 				~0UL - ((1 << channels) - 1));
 		} else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
 			regmap_update_bits(sai->regmap, FSL_SAI_RCR4(ofs),
-				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
+				FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
+				FSL_SAI_CR4_CHMOD_MASK,
 				val_cr4);
 			regmap_update_bits(sai->regmap, FSL_SAI_RCR5(ofs),
 				FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
@@ -497,7 +505,8 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
-			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
+			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
+			   FSL_SAI_CR4_CHMOD_MASK,
 			   val_cr4);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
 			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index f96f8d97489d..1e3b4a6889a8 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -119,6 +119,8 @@
 #define FSL_SAI_CR4_FRSZ_MASK	(0x1f << 16)
 #define FSL_SAI_CR4_SYWD(x)	(((x) - 1) << 8)
 #define FSL_SAI_CR4_SYWD_MASK	(0x1f << 8)
+#define FSL_SAI_CR4_CHMOD	BIT(5)
+#define FSL_SAI_CR4_CHMOD_MASK	GENMASK(5, 5)
 #define FSL_SAI_CR4_MF		BIT(4)
 #define FSL_SAI_CR4_FSE		BIT(3)
 #define FSL_SAI_CR4_FSP		BIT(1)
-- 
2.17.1

