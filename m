Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F07C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDC823407
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322868;
	bh=j6WbDTfAeBUjyh3wtQx4ZNm8v53mrWDry7SrQUO2D78=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sSSU5HMw09KnEH9dakXEFJ4NIITlxYezriEB7bwTO4klULoyXD7vcmyHTX3Azu4xR
	 3V/Q/DIGHfteZ2007u/J119U2qz1ZCGtuAZCaPIoiTyFe+cf/iOYvbf2GoyT2+xQ4j
	 6H72Mt7P1izqhKfLf/tnl4W9jt4vmp4boG+gnpFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfHTRlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:07 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:39683 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:06 -0400
Received: by mail-ed1-f97.google.com with SMTP id g8so7266285edm.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=W8Kj656ZzAu9ZCWcFyzALBjAvF+qnepQqiVrSJyXBEw=;
        b=aAFc41mMUX81i+1BfABRO4seQX6HsPmginlIwkX6A59UwQqvyMXfgViqZKIZ3StB50
         HSxJCZ7AFYlMXQT0JjCRzk6qgujC9tlhOB8LraB6pzFy6KbDGRWzf3PMbMe1DtcUSEJk
         3YpMn6bTPijLCcHAahytkP5LbDT+EsbCrZcwhommKUMQc/9FU9gu5Rd2yvKcsL1aZUjq
         H3HEXjWAZqebDYAM+zpPSKQmU2TRFJYepRRPey8W5WA/HvmlouCn0O7o/9eP7/ec1Ehf
         4MRkqfkrG0NzAtz64tezduyZtiOu6NMnx2OmItM1/u3nAtw1RP7XQdPyw8b69ycxGHkU
         Q9Mg==
X-Gm-Message-State: APjAAAW2T/2QjWg5+v2FlIma140dpJvcXfYyaWlIyJ9tsa1UEJdWgz7/
        I77e9tyM6/Y5jmfDy5HZMrHQBt1nFX08lL7IxtKUQqURJao5Pi0TjrFKReNPc26nbQ==
X-Google-Smtp-Source: APXvYqycUJGNwyDQAqgE9ikjjh0O2ad6gVXSpxvz0n3pOCKBILB1jeJoM8Yz5wKLX5S7xlfpyPxZQ/c1gXEv
X-Received: by 2002:a50:9999:: with SMTP id m25mr32699134edb.183.1566322864685;
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id f3sm221529edx.19.2019.08.20.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0880-00032E-8q; Tue, 20 Aug 2019 17:41:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8E819274314E; Tue, 20 Aug 2019 18:41:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
        Mark Brown <broonie@kernel.org>, nicolas.ferre@microchip.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: mchp-i2s-mcc: Fix unprepare of GCLK" to the asoc tree
In-Reply-To: <20190820162411.24836-2-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174103.8E819274314E@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mchp-i2s-mcc: Fix unprepare of GCLK

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 988b59467b2b14523a266957affbe9eca3e99fc9 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 20 Aug 2019 19:24:09 +0300
Subject: [PATCH] ASoC: mchp-i2s-mcc: Fix unprepare of GCLK

If hw_free() gets called after hw_params(), GCLK remains prepared,
preventing further use of it. This patch fixes this by unpreparing the
clock in hw_free() or if hw_params() gets an error.

Fixes: 7e0cdf545a55 ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel Controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Link: https://lore.kernel.org/r/20190820162411.24836-2-codrin.ciubotariu@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 86495883ca3f..319f975586f1 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -670,8 +670,13 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(dev->regmap, MCHP_I2SMCC_MRA, mra);
-	if (ret < 0)
+	if (ret < 0) {
+		if (dev->gclk_use) {
+			clk_unprepare(dev->gclk);
+			dev->gclk_use = 0;
+		}
 		return ret;
+	}
 	return regmap_write(dev->regmap, MCHP_I2SMCC_MRB, mrb);
 }
 
@@ -708,9 +713,13 @@ static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
 		regmap_write(dev->regmap, MCHP_I2SMCC_CR, MCHP_I2SMCC_CR_CKDIS);
 
 		if (dev->gclk_running) {
-			clk_disable_unprepare(dev->gclk);
+			clk_disable(dev->gclk);
 			dev->gclk_running = 0;
 		}
+		if (dev->gclk_use) {
+			clk_unprepare(dev->gclk);
+			dev->gclk_use = 0;
+		}
 	}
 
 	return 0;
-- 
2.20.1

