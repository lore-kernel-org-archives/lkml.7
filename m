Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB0CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0FD22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322953;
	bh=4IVsKWjxhGpvKaKUXcrMJdPg8Md2fHk+i4Wn+to+sR0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CRWb+GTVFBotcxvbFrnxDN+xU5C5hDFtk7h+HfvLVfe8X1MB2K390SNdke5H/6LrM
	 GQBAHTbQA3EOCCTuI15J/CDuWvHnuDIBWA/wFprO9HgCCG88DxrKHbyIFTWViVp+6h
	 QsSvuOqOboBSb7PPtFxsyYWTy0mLCicjuENglOcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfHTRlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:06 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:46610 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:06 -0400
Received: by mail-ed1-f100.google.com with SMTP id z51so7252994edz.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=tZ1DiiOuBDIZzhX5DI1K9yRxUbP4c3jFKWVGax/+oTo=;
        b=T16cOS+9csBtbiEZGZxyUJzvg5X3qEVCKPtBuWD7k8G0gtiSVRGVk0AAFP0DUZkYiX
         E2pyaWRPmWIl6KUYl1xv41S9ke2fK59/PDrOzdp86N4beHf4lrqDBJ4OVtwRiT3bBylU
         PW9bt3RdQvyBDfRxwx6uznfOZ8+aUsuCYKQ0lPiPEkLF2rrJcC8YLZkdtQkpnQTaKg2y
         GeYc6XseyqhARhKxYg+ZzbhwG5lcONf6CS85ZTGh7y5RNYRxyci4qZ44VL2NATSkONAs
         uD8IyTkVNDzKFrJxZHCtr8z+gc1SwMBn68t6c9i2+yA0aeZ+2TvYebFfM1VgqQqzUOKW
         M2Ow==
X-Gm-Message-State: APjAAAWampulXswCW96sFJnxZTopW7LzbGw/dzzbtD0DHkjqmtsqPyzj
        5nMcZi7MXnNwR/tWV5B8WsIf38D6dV8WkDoCAdtVbqkDkllYOtR4Q0YIAob7fjTdZA==
X-Google-Smtp-Source: APXvYqxVYvjEkq1/WSs8U8kEZNNOw7hDX+wh+QkVqHWzvLXv7WNIzxVWanjlBkaNjXmBxHv7sdku2GIhZpZV
X-Received: by 2002:a50:d0c2:: with SMTP id g2mr32456105edf.251.1566322864514;
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id c21sm343874edx.37.2019.08.20.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0880-00032D-0B; Tue, 20 Aug 2019 17:41:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5B7A3274314C; Tue, 20 Aug 2019 18:41:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
        Mark Brown <broonie@kernel.org>, nicolas.ferre@microchip.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: mchp-i2s-mcc: Wait for RX/TX RDY only if controller is running" to the asoc tree
In-Reply-To: <20190820162411.24836-3-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174103.5B7A3274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mchp-i2s-mcc: Wait for RX/TX RDY only if controller is running

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

From 0f6fc97501b790c971b11b52a654009d21c45238 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 20 Aug 2019 19:24:10 +0300
Subject: [PATCH] ASoC: mchp-i2s-mcc: Wait for RX/TX RDY only if controller is
 running

Since hw_free() can be called multiple times and not just after a stop
trigger command, we should check whether the RX or TX ready interrupt was
truly enabled previously. For this, we assure that the condition of the
wait event is always true, except when RX/TX interrupts are enabled.

Fixes: 7e0cdf545a55 ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel Controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Link: https://lore.kernel.org/r/20190820162411.24836-3-codrin.ciubotariu@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 319f975586f1..ab7d5f98e759 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -691,22 +691,24 @@ static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
 		err = wait_event_interruptible_timeout(dev->wq_txrdy,
 						       dev->tx_rdy,
 						       msecs_to_jiffies(500));
+		if (err == 0) {
+			dev_warn_once(dev->dev,
+				      "Timeout waiting for Tx ready\n");
+			regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
+				     MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels));
+			dev->tx_rdy = 1;
+		}
 	} else {
 		err = wait_event_interruptible_timeout(dev->wq_rxrdy,
 						       dev->rx_rdy,
 						       msecs_to_jiffies(500));
-	}
-
-	if (err == 0) {
-		u32 idra;
-
-		dev_warn_once(dev->dev, "Timeout waiting for %s\n",
-			      is_playback ? "Tx ready" : "Rx ready");
-		if (is_playback)
-			idra = MCHP_I2SMCC_INT_TXRDY_MASK(dev->channels);
-		else
-			idra = MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels);
-		regmap_write(dev->regmap, MCHP_I2SMCC_IDRA, idra);
+		if (err == 0) {
+			dev_warn_once(dev->dev,
+				      "Timeout waiting for Rx ready\n");
+			regmap_write(dev->regmap, MCHP_I2SMCC_IDRA,
+				     MCHP_I2SMCC_INT_RXRDY_MASK(dev->channels));
+			dev->rx_rdy = 1;
+		}
 	}
 
 	if (!mchp_i2s_mcc_is_running(dev)) {
@@ -818,6 +820,8 @@ static int mchp_i2s_mcc_dai_probe(struct snd_soc_dai *dai)
 
 	init_waitqueue_head(&dev->wq_txrdy);
 	init_waitqueue_head(&dev->wq_rxrdy);
+	dev->tx_rdy = 1;
+	dev->rx_rdy = 1;
 
 	snd_soc_dai_init_dma_data(dai, &dev->playback, &dev->capture);
 
-- 
2.20.1

