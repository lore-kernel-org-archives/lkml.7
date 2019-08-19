Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770AC206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242851;
	bh=naLkSi6HCcekYJoGDeGYtnqekGWpuAududHuhSwuFWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oAYtYuHUgHqPm0SJxQ/zyGy+qNkutDfLLSYI6FOepuaiEDTmGrSY9yrQHh6wTpwyL
	 kJLThTKgNQeIlB68kdPkKiFIPnSyYaBlAKyaEJ6FeNkLgKonqjvMycDv4er80eT5L2
	 E5yfKdiO9zSl97Wu1j2lc2f0didcj8sP5rQHziUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfHST1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfHST0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:13 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3DF322CF4;
        Mon, 19 Aug 2019 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242773;
        bh=naLkSi6HCcekYJoGDeGYtnqekGWpuAududHuhSwuFWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSAqU7a6ySkxUsTrRCfziifAcrtQ/XNk8+ABQzWN7UWvv9bOqv6nHRkFIRD6SHpzX
         v1w0iabbQwQbJP6z7hr9SYFJyq8BQVuW1syY+tuttuVU4A1dgSauyKwuyOqupnHCkd
         bEK4RbQm6q7v/pcX1WwuyFviiT1gSV71PQXvQJVs=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] ASoC: sun4i-i2s: Fix the LRCK polarity
Date:   Mon, 19 Aug 2019 21:25:20 +0200
Message-Id: <e03fb6b2a916223070b9f18405b0ef117a452ff4.1566242458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The LRCK polarity "normal" polarity in the I2S/TDM specs and in the
Allwinner datasheet are not the same. In the case where the i2s controller
is being used as the LRCK master, it's pretty clear when looked at under a
scope.

Let's fix this, and add a comment to clear up as much the confusion as
possible.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index e614c2d52af5..9c9061621b15 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -570,23 +570,29 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	u32 mode, val;
 	u8 offset;
 
-	/* DAI clock polarity */
+	/*
+	 * DAI clock polarity
+	 *
+	 * The setup for LRCK contradicts the datasheet, but under a
+	 * scope it's clear that the LRCK polarity is reversed
+	 * compared to the expected polarity on the bus.
+	 */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
+		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Invert frame clock */
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		val = 0;
 		break;
 	case SND_SOC_DAIFMT_NB_NF:
-		val = 0;
+		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
 		break;
 	default:
 		return -EINVAL;
-- 
git-series 0.9.1
