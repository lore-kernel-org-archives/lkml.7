Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D5C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9702182B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psgmVbWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfE0UKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:10:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38183 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfE0UKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so528678wmh.3;
        Mon, 27 May 2019 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wv4bRiRVjlotB3NJW4BQD8xcTUogsyFuw65oZfNvb1s=;
        b=psgmVbWcSlCI1+YNxxBbHm4Laul+Afg6UqNDgL6/++9kS667P0ea4J6kdRN5MJyZyp
         Y9XA+ZjsPBzbXsFrDMFZtdGdVsP0BQhcJB1LTxy1II8/8K7SjS97AMbgL6F7TJlgUieH
         cIKMyAUHumWxoz7j8JUMvw7FOa9AhQGdnotivIlitt6aH7z4CPJ1gslea3eeQjiR3dLt
         D2U8+gdYAeWrqVvEbaOYDCeuRbU7wBMcj4ZTD2Zi9nr4bhzkDvAW14S234U2a58G6snQ
         HWMc4xR3bTKVDmjHBdYWlUxnRlQdOLf1o8SSX26DlT/bkB/baJ5EuESmYzDDFeI9HTkg
         IA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wv4bRiRVjlotB3NJW4BQD8xcTUogsyFuw65oZfNvb1s=;
        b=JmQqxh8zs5vpLdEbDQ10i5/83Qay1nzedvS0tMhST364injMysqwo/SCP5WciPRLb5
         spYi8Gd6ogruIyaXyh/IQdgh2CX7fnlSiDZssygCwzM1KCim+y+s6hTr2GWk4CAWsenK
         mdUROosOHIvhKDAGasTFiVoH46fLA/meFMXKRlrHxShE7tjdhjWnhyUXxXw+InCmNHMJ
         +rwfo5Durg467X3bPGwZnJdE0/cpW+kP569r6pkUIoEJNRF5+d0DIy+tv2onYLHVUmMO
         lbfZFb1B96KTOpobCic+4mkhxEIgtSICV6Ule5IY6bH9dgS3ZkKvVuKJWdJMyHdZBfXe
         VZLg==
X-Gm-Message-State: APjAAAUJxN1lm1VpNPf7nhnkHyFCJXtu9V4h7dAIm36RpdHaDNJpNfNS
        3eW+mgr/Yx4u2D8SJF5P0/0=
X-Google-Smtp-Source: APXvYqzRen9k8IsaoDFCRgz5uh2Kh75YVlp6HkmpKHkpJQcDv7nSUTkHyUNb9OYwV/fN7pzBgLzz9A==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr508352wmh.86.1558987816422;
        Mon, 27 May 2019 13:10:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:15 -0700 (PDT)
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
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
Date:   Mon, 27 May 2019 22:06:23 +0200
Message-Id: <20190527200627.8635-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
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
index b6c66a62e915..045d0cc4b62a 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -166,10 +166,12 @@
  *
  * @reg_dac_tx_data: TX FIFO offset for DMA config.
  * @has_reset: SoC needs reset deasserted.
+ * @val_fctl_ftx: TX FIFO flush bitmask.
  */
 struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
+	unsigned int val_fctl_ftx;
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
+			   quirks->val_fctl_ftx, quirks->val_fctl_ftx);
 
 	/* clear TX counter */
 	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
@@ -418,15 +423,18 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 };
 
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
 };
 
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
+	.val_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
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

