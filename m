Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EE5C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80F216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC/CSiPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEYQYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:24:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38201 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfEYQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so11926476wmh.3;
        Sat, 25 May 2019 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbqoVQVB81rH9/Oh9EOj+HyMcRISA85POp2mDoREhbs=;
        b=IC/CSiPkuVdpssu8k6hyO+0c5RveetIZXR6bHj0clPiaSo481s8Kz0b35tw6ux0MM6
         XakvCZ0VqtyJsK2wvvw6/51opcLYyUBE0t03LlA4AyOZTtUaR/4H4kGNn7QMeVbWbfga
         4zwyJLg8jkYRqpHPaeAkbus2T76g3FRtO00o1vfPA0vsIxVmdeqMox++FmjjInLiaHF3
         7o3mqdOm+XSUdy32aAILd5079DyDQjnnFzQ09fOs2DzU/XHE5ADe+YbNIaDJjpMEnf0u
         QSdsmDXiS4kF0elymiH1UTbahwRbOka8I5kfz81Pb04JXXN74gcPlisFmeWeN9qWhhar
         dbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbqoVQVB81rH9/Oh9EOj+HyMcRISA85POp2mDoREhbs=;
        b=X+938dqLC81N3TQ/3v/F8u88F2Hn/Nb6envhu2M9EGXD/0f3ItXXMmJ4Ne2yQ2xjKz
         w52MdIVzIujpWqIpqFMM4yAf1Y59OZ5yXCv2xY9mN9d/fhhex3Odeoz3v17Vy4j83B2b
         +jy6O2A29l7oU3vwGMDVxXNtN78IdFz0zPHM0ZwkPcL4RLkegp6rZ/2Y0JXj2gRyJP8h
         WrCkksvaa4A8PojfASK4KJykUZk5xAUnvgbJBbgvs44D0N43P4A7jLwXxm8UJVh4BX1X
         dQope741Nqu0nXCjXMOrl171iSRXw8/M0z/518atoGLYmQna+Hc0BvKgMdNIVs4gzKRY
         vdmQ==
X-Gm-Message-State: APjAAAVQCeRcA1/Nb4HMpv9LR//1f6uNfprk5KSjC4AnfXCLENYKDcLA
        d0N7l6qj3kQPETFrpNpBC0k=
X-Google-Smtp-Source: APXvYqxTUPHfbkGRqrcv73CLbSTer8ARaAejduD0uldwBW1Mn/rySStC4X1Si4JaSs/8XWn7bL01tA==
X-Received: by 2002:a05:600c:204a:: with SMTP id p10mr4187874wmg.161.1558801414715;
        Sat, 25 May 2019 09:23:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:33 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
Date:   Sat, 25 May 2019 18:23:19 +0200
Message-Id: <20190525162323.20216-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a different bit to flush the TX FIFO.

Add a quirks to prepare introduction of H6 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b6c66a62e915..8317bbee0712 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -166,10 +166,12 @@
  *
  * @reg_dac_tx_data: TX FIFO offset for DMA config.
  * @has_reset: SoC needs reset deasserted.
+ * @reg_fctl_ftx: TX FIFO flush bitmask.
  */
 struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
+	unsigned int reg_fctl_ftx;
 };
 
 struct sun4i_spdif_dev {
@@ -180,16 +182,19 @@ struct sun4i_spdif_dev {
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	const struct sun4i_spdif_quirks *quirks;
 };
 
 static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
 {
+	const struct sun4i_spdif_quirks *quirks = host->quirks;
+
 	/* soft reset SPDIF */
 	regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
 
 	/* flush TX FIFO */
 	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
-			   SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
+			   quirks->reg_fctl_ftx, quirks->reg_fctl_ftx);
 
 	/* clear TX counter */
 	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
@@ -418,15 +423,18 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 };
 
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
 };
 
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
 };
 
@@ -507,6 +515,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
+	host->quirks = quirks;
 
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 						&sun4i_spdif_regmap_config);
-- 
2.20.1

