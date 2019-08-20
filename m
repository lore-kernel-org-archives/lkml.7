Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44710C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF9922DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322946;
	bh=wvvlVYCFfLRq8LSzbUNsr1ZzrkTRpU70PUlg4rS7Lf0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JenuIqKmgfgqKWwA/zzslEDWQShFJDBhIaBiynJTfR8MscDS6waLA2ru5ToRby3EB
	 tGPA3jiSSpHqJemvd+RtyN+w+qBjYoj/a+dthwsw626aFGj6V87DeLu8odDGBUZO8a
	 i552ngh0TA508m/Q6Lmx+a75eOqB/vcv0lRTxmSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfHTRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:42:24 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:39147 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:07 -0400
Received: by mail-wr1-f97.google.com with SMTP id t16so13258098wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=rEm//JA9Ode+pkJQsVxasRJPsyZWnLEZfrP5SRv2v4A=;
        b=Sgjac72jG7d162s7vmzb/kEOm/+6qVx3KaBvr2KgbWYv6U+hqEx0/RkB8nj/FKDfkD
         Tih2dqVnKV9gPfCppkkhEobgmxWm+r/B5xb2C/WYqAuXzv+bQEUCecujSHNIkSc5kdnY
         +EvMFaYJgFlZ97W3ht12lW7KeVPjhSadA9+qKArEAUN/P/QMNwRnCoYAVAdETylzHnob
         NBlwKydMavMd0Ucsk/t4rLQuFtKwbQ7FyqgYaJGVBTBJi1UuCa0hTbnD8dcjrVHdTdxb
         1/uUv4T+RQAXKJTqh/hIuRnppgd0CjKrlqn8eOMtBfyOntMP3OaZOEDtBtWDl34ilomM
         T91A==
X-Gm-Message-State: APjAAAUleShD9GqQIFYYRzDeBWKzOv6CAia/f0y+G5cHAEbC1wxi/fx7
        qOvjzQRugeDCct5LoHKbhtrBGVPGOQKhg+6oC1o6e0k6D/4J98ciHgnMBWSwaHyz5A==
X-Google-Smtp-Source: APXvYqx2NvCEqcvM7LJG+fzCYUWBys0UGZitIliEf8ce3MjbJm4BQPX76bNDLkREPboSx+tHL788Fsk8liDZ
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr36897292wrw.151.1566322864978;
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id a4sm313012wro.12.2019.08.20.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0880-00032I-L5; Tue, 20 Aug 2019 17:41:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 006C12743150; Tue, 20 Aug 2019 18:41:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Pass the channels number as an argument" to the asoc tree
In-Reply-To: <48887cf7abfaab6597db233b24d7a088a913e48a.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174104.006C12743150@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Pass the channels number as an argument

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

From 0083a507a78fdfa868acc0709408b59e72488a61 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:25 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Pass the channels number as an argument

The channels number have been hardcoded to 2 so far, while the controller
supports more than that.

Remove the instance where it has been hardcoded to compute the BCLK
divider, and pass it through as an argument to ease further support of more
channels.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/48887cf7abfaab6597db233b24d7a088a913e48a.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 4c636f1cf7dc..6b172dfbc25d 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -238,10 +238,11 @@ static unsigned long sun8i_i2s_get_bclk_parent_rate(const struct sun4i_i2s *i2s)
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 				  unsigned long parent_rate,
 				  unsigned int sampling_rate,
+				  unsigned int channels,
 				  unsigned int word_size)
 {
 	const struct sun4i_i2s_clk_div *dividers = i2s->variant->bclk_dividers;
-	int div = parent_rate / sampling_rate / word_size / 2;
+	int div = parent_rate / sampling_rate / word_size / channels;
 	int i;
 
 	for (i = 0; i < i2s->variant->num_bclk_dividers; i++) {
@@ -286,6 +287,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
 
 static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int rate,
+				  unsigned int channels,
 				  unsigned int word_size)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -333,7 +335,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 
 	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
 	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
-					  rate, word_size);
+					  rate, channels, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
@@ -488,7 +490,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      2, params_width(params));
 }
 
 static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
-- 
2.20.1

