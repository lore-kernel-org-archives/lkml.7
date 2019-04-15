Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C42C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76367218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354116;
	bh=4PuXllrYoApSOJz2Fl/Olfhb0Aip4RpKgfgHPF6VY64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLyewenFd5d9punDrJoOjO+BvLlszOdp0EAe8WJYrdiRSPRWsN+1mgWtwao2gy1FH
	 Qvd55pwONd4uOY1N3TFHoa5439hTgPZm1g+VJ79ekpQhO5AEckHA/lQxMTRQWcgW5k
	 sh0EKHb0nO5s5aN266YZ/h6rxRyNTe+NBv5Igiog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDOSsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbfDOSsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:48:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06862073F;
        Mon, 15 Apr 2019 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354082;
        bh=4PuXllrYoApSOJz2Fl/Olfhb0Aip4RpKgfgHPF6VY64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFIjfAeb0oXYJPFbLg9dH+Gs5En/pqWVry/eggxk+s9ca4GpoHSMHSKSxdKUHuYeF
         jRMVculluHqDDMRlVS8RXmd8VnDe14oQkcT8/gvMCC+zzCcZ3CPgb7FkGVPfSECvtB
         W+tgYFcKaD28shq9bPKY11TJJliPeCfOyMlKVILE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 66/76] ASoC: fsl_esai: fix channel swap issue when stream starts
Date:   Mon, 15 Apr 2019 20:44:30 +0200
Message-Id: <20190415183727.473827045@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
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
@@ -59,6 +59,8 @@ struct fsl_esai {
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
+	u32 tx_mask;
+	u32 rx_mask;
 	u32 hck_rate[2];
 	u32 sck_rate[2];
 	bool hck_dir[2];
@@ -359,21 +361,13 @@ static int fsl_esai_set_dai_tdm_slot(str
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
@@ -594,6 +588,7 @@ static int fsl_esai_trigger(struct snd_p
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u8 i, channels = substream->runtime->channels;
 	u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
+	u32 mask;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -606,15 +601,38 @@ static int fsl_esai_trigger(struct snd_p
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
@@ -904,6 +922,15 @@ static int fsl_esai_probe(struct platfor
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


