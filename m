Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D14C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36F3233A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322911;
	bh=VdTnJl06HbLzMlvb+N6hUz8rzJnmV0E3OoG+XT1gQG4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=i3sJiajRTW+RC5wUWNw1S8BRtLWVWFD+sAHAJOrTkYF5d7KUZkY5GGB8pjEYNlNS6
	 Wi5oOu+M42FrBLvjc8sZ8//gs26PJgorn9tnW6qVglHVv/v8UuihXSQg2Jj63Rup+N
	 WdV+6cUhB6+ObuZpXKLwJx04LFEcP+pZqATK9W3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfHTRlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:20 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:41215 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbfHTRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:09 -0400
Received: by mail-wr1-f97.google.com with SMTP id j16so13258507wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=L1Zn2ORD9FSrc1HVb+RScuNQ8y1rYfCN6SkmynQKZbI=;
        b=svoQMP8ysbxFtPKojbzTmBwetgIPiUkmSYrRvGxxPyAU1zBMpb7PlC3M4mTQN7o8AU
         xSMqztJROemb4SHevWbBOpChLuzvFxz5mrLjfW9rVr79N35DHJMCvrYqsjDqItN8ZdLK
         6xHXJmuDk7FMr0otNhrWdK5zlQ2GNa5KQ1U5oBVpzBl9MYh5X4oiUgdoBp/ULNMVO9Zq
         UwToufD0Q2pmYjJKgVm/4iJ5JSI4EZTo9TH674kXz+EbeLuLxL0yYruMXmOOCTR2IllI
         QoYZB6XXF22+h7SoJryRU7jptGOm/XAwHHAOIkRGCaPwx6wAkIyxmLRy8Os7NnXXpLYg
         6qfA==
X-Gm-Message-State: APjAAAVzXq80fAOMDdSPEQMYrew7NSEIGTpviPshqd8uYIL4xPF99UPl
        DOqlEyLZvJaTvdSIRSMLCc1yKn+BpLzZCEShAr1V04nhU24qRdREb2N8Cq/g1A4FuQ==
X-Google-Smtp-Source: APXvYqy5TDi0UH/U2hkLDnHw3HPv5V5xfoaG9/13O8LBHUJJ0XtWYmNWX6MMUl3awmli3v9kooxjXG/VO8dN
X-Received: by 2002:a5d:4950:: with SMTP id r16mr35050963wrs.347.1566322867715;
        Tue, 20 Aug 2019 10:41:07 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id x15sm1831wmj.21.2019.08.20.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:07 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0883-00033G-FN; Tue, 20 Aug 2019 17:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D4AE3274314C; Tue, 20 Aug 2019 18:41:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Replace call to params_channels by local variable" to the asoc tree
In-Reply-To: <c0faaac69ad40248f24eed3c3b2fa1ccc4a85b70.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174106.D4AE3274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Replace call to params_channels by local variable

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

From c7dd0828c088a71f30de8d249f63b2fa9f0d322d Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:10 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Replace call to params_channels by local
 variable

The sun4i_i2s_hw_params already has a variable holding the value returned
by params_channels, so let's just use that variable instead of calling
params_channels multiple times.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/c0faaac69ad40248f24eed3c3b2fa1ccc4a85b70.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d879db581073..77b7b81daf74 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -412,10 +412,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 
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
2.20.1

