Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD6C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644C122DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322878;
	bh=FYVfMHt40niVuahDgCxsBhpOHaXwGDVn93lPCWEk/yI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=luBUkK4Fiu0uHzzXK0j91YX8cSxrEaSaxKkju75hSMdq/+J/4vZalvhw4G9XUn2b0
	 28nOsmi+LLjuPsXbMlfXKtvjSGV8Y9nq7sD4LK8bkvRZx7vzQTpCzKd+f+q8lcbmue
	 K9dFMKG4a7IPMhsE/g5z+MbUIuV6T0MC0fI9KPtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfHTRlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:17 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:38697 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbfHTRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:10 -0400
Received: by mail-wr1-f99.google.com with SMTP id g17so13295200wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=yCDyVLCiFyaHGZVMltg2SfBdT7xmop4SmEPuiPFwdPM=;
        b=NSRU/5RRDfG21PgNwEoB6jIUA+kRW6RxJCPyOyeXq5xHvwm75mWu9HmxCTRInTG6u7
         t0RUUdauMBBRtd7jDRuWtB0hqkxIWTrIX2FCsGU7ZZE2IA+RgizDY9uCq32503Y4PXxI
         Z5qYOyhs2ARS9OWMigfLkQ7RWzo5+O4WFc4ZNA57BS6aoUdXSNV/gnxPdB62zwuwK0DL
         IIZwin+H9UKgvQS4mtoMv0uJN380kvOAWNvLqu42mrJInEESwr5Qd3xUZ4ySH4eG1rM3
         P//iIkN2rYlViO8OLTJ+FeJY8VrtRQHExTi3CBeZomazc9HpHA2XKLhKlUpz8V3lw23T
         2QtA==
X-Gm-Message-State: APjAAAWZU3/hzzgnTLVjuHk6jarBVLcU/d/zjMdeqpBMjJjP1RB/faxu
        cra9HtEzXV10Mp4oFL2QHRAF7ua6nKLO7ES4aIKXvvF4IuJneRo6kPmMh5g6VIoZtQ==
X-Google-Smtp-Source: APXvYqz5YHpKm90mjMqOxMGkNMOoE2BSG7fts0HS8pd2YGeQKJqMEr3P96B8XrAPliZ9bt9z/gCCJ/bhsYWk
X-Received: by 2002:adf:e710:: with SMTP id c16mr36940977wrm.292.1566322868040;
        Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id y18sm299785wrn.82.2019.08.20.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0883-00033J-LP; Tue, 20 Aug 2019 17:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0F796274314E; Tue, 20 Aug 2019 18:41:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK" to the asoc tree
In-Reply-To: <c3595e3a9788c2ef2dcc30aa3c8c4953bb5cc249.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174107.0F796274314E@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 7df8f9a20196072162d9dc8fe99943f2d35f23d5 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:14 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK

The BCLK divider should be calculated using the parameters that actually
make the BCLK rate: the number of channels, the sampling rate and the
sample width.

We've been using the oversample_rate previously because in the former SoCs,
the BCLK's parent is MCLK, which in turn is being used to generate the
oversample rate, so we end up with something like this:

oversample = mclk_rate / sampling_rate
bclk_div = oversample / word_size / channels

So, bclk_div = mclk_rate / sampling_rate / word_size / channels.

And this is actually better, since the oversampling ratio only plays a role
because the MCLK is its parent, not because of what BCLK is supposed to be.

Furthermore, that assumption of MCLK being the parent has been broken on
newer SoCs, so let's use the proper formula, and have the parent rate as an
argument.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Fixes: 66ecce332538 ("ASoC: sun4i-i2s: Add compatibility with A64 codec I2S")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/c3595e3a9788c2ef2dcc30aa3c8c4953bb5cc249.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 70608fa30bf2..d879db581073 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -222,10 +222,11 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 };
 
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
-				  unsigned int oversample_rate,
+				  unsigned long parent_rate,
+				  unsigned int sampling_rate,
 				  unsigned int word_size)
 {
-	int div = oversample_rate / word_size / 2;
+	int div = parent_rate / sampling_rate / word_size / 2;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_bclk_div); i++) {
@@ -315,8 +316,8 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-					  word_size);
+	bclk_div = sun4i_i2s_get_bclk_div(i2s, i2s->mclk_freq,
+					  rate, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
-- 
2.20.1

