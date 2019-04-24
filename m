Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD30C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AECB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126382;
	bh=d0e7Akk4c+fMPoIk/crsOeWOg3mxKyeGXWZHTC0WQ2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R+TH3TbTlI2eLUZUQW+6n4pH8Zq7TenQTX4Enddnl+KTXBmoUZC/gryax5ySde3jN
	 1KyPAW1II9Qiqk/KmbSb4kD+Vl7uJ1wvwSg3reIKvBsJqyyRQwgxY4SG1I4ysd1zWE
	 tYHcNHoeLT0Xe4C+0M8Lgkj5IXEPkaV5sLSpLi2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbfDXRTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388653AbfDXRTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:36 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36DEC2190A;
        Wed, 24 Apr 2019 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126374;
        bh=d0e7Akk4c+fMPoIk/crsOeWOg3mxKyeGXWZHTC0WQ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSQ5B5Lsb2FgAxP4en/AhM0pB9iSs4uMR2C8MJ/5F4jdei5iILzNivMmEFkXdROT0
         6rudDlKSK1m5UexsJxFC2//u4aQ4Z4K498AeqfUFVTFF6QWeFaXsJm1fdLAFA0NDoX
         MuBat4JHh2O/NY1+tzrnM8o4lNxs+iQTIp9ywuC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 089/168] ASoC: fsl_esai: fix channel swap issue when stream starts
Date:   Wed, 24 Apr 2019 19:08:53 +0200
Message-Id: <20190424170929.034654687@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: S.j. Wang <shengjiu.wang@nxp.com>

commit 0ff4e8c61b794a4bf6c854ab071a1abaaa80f358 upstream.

There is very low possibility ( < 0.1% ) that channel swap happened
in beginning when multi output/input pin is enabled. The issue is
that hardware can't send data to correct pin in the beginning with
the normal enable flow.

This is hardware issue, but there is no errata, the workaround flow
is that: Each time playback/recording, firstly clear the xSMA/xSMB,
then enable TE/RE, then enable xSMB and xSMA (xSMB must be enabled
before xSMA). Which is to use the xSMA as the trigger start register,
previously the xCR_TE or xCR_RE is the bit for starting.

Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Cc: <stable@vger.kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/fsl/fsl_esai.c |   47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -57,6 +57,8 @@ struct fsl_esai {
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
+	u32 tx_mask;
+	u32 rx_mask;
 	u32 hck_rate[2];
 	u32 sck_rate[2];
 	bool hck_dir[2];
@@ -357,21 +359,13 @@ static int fsl_esai_set_dai_tdm_slot(str
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR,
 			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
 
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
-			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(tx_mask));
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
-			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(tx_mask));
-
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR,
 			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
 
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
-			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(rx_mask));
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
-			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
-
 	esai_priv->slot_width = slot_width;
 	esai_priv->slots = slots;
+	esai_priv->tx_mask = tx_mask;
+	esai_priv->rx_mask = rx_mask;
 
 	return 0;
 }
@@ -582,6 +576,7 @@ static int fsl_esai_trigger(struct snd_p
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u8 i, channels = substream->runtime->channels;
 	u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
+	u32 mask;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -594,15 +589,38 @@ static int fsl_esai_trigger(struct snd_p
 		for (i = 0; tx && i < channels; i++)
 			regmap_write(esai_priv->regmap, REG_ESAI_ETDR, 0x0);
 
+		/*
+		 * When set the TE/RE in the end of enablement flow, there
+		 * will be channel swap issue for multi data line case.
+		 * In order to workaround this issue, we switch the bit
+		 * enablement sequence to below sequence
+		 * 1) clear the xSMB & xSMA: which is done in probe and
+		 *                           stop state.
+		 * 2) set TE/RE
+		 * 3) set xSMB
+		 * 4) set xSMA:  xSMA is the last one in this flow, which
+		 *               will trigger esai to start.
+		 */
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
 				   tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
+		mask = tx ? esai_priv->tx_mask : esai_priv->rx_mask;
+
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
+				   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(mask));
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
+				   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
+
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
+				   ESAI_xSMA_xS_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
+				   ESAI_xSMB_xS_MASK, 0);
 
 		/* Disable and reset FIFO */
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
@@ -887,6 +905,15 @@ static int fsl_esai_probe(struct platfor
 		return ret;
 	}
 
+	esai_priv->tx_mask = 0xFFFFFFFF;
+	esai_priv->rx_mask = 0xFFFFFFFF;
+
+	/* Clear the TSMA, TSMB, RSMA, RSMB */
+	regmap_write(esai_priv->regmap, REG_ESAI_TSMA, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_TSMB, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_RSMA, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_esai_component,
 					      &fsl_esai_dai, 1);
 	if (ret) {


