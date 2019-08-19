Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80550C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5581B22CF9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242744;
	bh=yQu3KA9uqkzoaxptkeyVKeN20q0tJpYXRmR37E58l3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPXREgI9FNewz4+tCMpwPHtAKclMtd8t3DCOZ5EN/LFzM1/JVlfSsRqfHjqqR1Ye2
	 p0PX/S5OKjEJ2r/8GJkmFc/H0zGqgXn0L0ICLNqwvVt3JMG0Fv0SzJcyzqf8lwV/8D
	 CaJ2kHm+1jZClxP+I5ERG04N3snLgrA1UvzhJtgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfHSTZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfHSTZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:25:41 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E196322CEC;
        Mon, 19 Aug 2019 19:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242741;
        bh=yQu3KA9uqkzoaxptkeyVKeN20q0tJpYXRmR37E58l3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puQPRqod9ydcPwLIv4SHOwPmIEjObuVGpVdDPed2UhUb8ESnQCtHpKGwr6g/LNbup
         2ysPweAL8ia8DX9Ew0T6NA73fd78Zo7cWCJXlHZt0N+xlV4EC4DiBz0cnsqLCEDBBF
         c1hu5ZrZsRV8VO7GSp4STN6dONOxi00YHEJPoslQ=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] ASoC: sun4i-i2s: Replace call to params_channels by local variable
Date:   Mon, 19 Aug 2019 21:25:10 +0200
Message-Id: <c0faaac69ad40248f24eed3c3b2fa1ccc4a85b70.1566242458.git-series.maxime.ripard@bootlin.com>
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

The sun4i_i2s_hw_params already has a variable holding the value returned
by params_channels, so let's just use that variable instead of calling
params_channels multiple times.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 1ed7670eae9c..ac84c29224eb 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -411,10 +411,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	/* Configure the channels */
 	regmap_field_write(i2s->field_txchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
-
+			   SUN4I_I2S_CHAN_SEL(channels));
 	regmap_field_write(i2s->field_rxchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
+			   SUN4I_I2S_CHAN_SEL(channels));
 
 	if (i2s->variant->has_chsel_tx_chen)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-- 
git-series 0.9.1
