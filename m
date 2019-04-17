Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27793C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0C7217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="warLkyBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfDQUoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:44:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38545 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733188AbfDQUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:44:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so93901wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2PG4RVUDpV3B0qjRGkkQWtaaCze4HgvXH3Z70Qm9O/U=;
        b=warLkyBWdpYp4KCSIryoCoiZ8g33ebunoaq+b324HnCWykVlBGG9uLeJFnplM4RNvu
         MQgIbQM/u8eXQjMn8bmy825OKBYcmspvxnC1G0Uc0DEd6vCKR/yfpdXyDdQpaHdYjx62
         otT8hh2K210mgQItR8iQwaLCqKrhOrgLezEZGM5Gr6Maz38CSwoi1q5R91LiYXKqIm2b
         pBy8P6l+FveatazYFV/RkNtmPF7GLssnnVDowUjoTuiIpJM/er/KRT7aJYfSSEKU/tV0
         /uV3DgSs0ckqP9ndEejdlFA0iBDq7mmNzZ2J5ZCIGQhvOt39cecFNBFFklIjdqR3qXRP
         qMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PG4RVUDpV3B0qjRGkkQWtaaCze4HgvXH3Z70Qm9O/U=;
        b=O+eBto/Q67BymKRrzz072uOhxpxBnDZiIUk2dnW1WI0/oOdoRR3VaCwEY8LSKeheoY
         I+a1LEQCkm7UEXYiEOnYPIPwnCeq6FCDj9sPkqf/lPbNawd0+nKNjkhhkgLdss6qpp0c
         mg500m43TZwctiwWYeDdrFjooM9RSRfn5ST7ETGzGBX4pifKHh3PJXbopSwhe3k8Lw5p
         7qIN6o+KstJjMzLVSHe+g5AAUPShcEzr/pMuf9CuV6aSmZNAnvKuAl1lpX44d0BfmtBB
         1ivCVwgaydA24j1J0TkBp3hKru7hz5qplAtgPtGEGZ/uXRxo+OuZSriXPIVjMLctPljn
         uFWg==
X-Gm-Message-State: APjAAAV7RfaNn07eCrG/PDt+lqJ+unjaH4cyFQbfFiBd/5MEbIe6gRRC
        q9k5Svjsi7pJf4UDGqMKUoGB5yT78b0=
X-Google-Smtp-Source: APXvYqxWlpqAumpKjW2+jOTflWWSx/sRI5APF8FOagYO+eqhKWjTteRqxvgudgS6a/W2cl5NA9witw==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr35201960wro.144.1555533855185;
        Wed, 17 Apr 2019 13:44:15 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id c20sm98716866wre.28.2019.04.17.13.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:44:14 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mmc: meson-gx: add signal resampling tuning
Date:   Wed, 17 Apr 2019 22:43:55 +0200
Message-Id: <20190417204355.469-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use signal resampling tuning for the UHS and HS200 modes.
Instead of trying to get the *best* resampling setting with complex
window calculation, we just stop on the first working setting.

If the tuning setting later proves unstable, we will just continue the
tuning where we left it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 73 +++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 50b03c167435..207c65b3ddf1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -488,6 +488,61 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	return clk_prepare_enable(host->mmc_clk);
 }
 
+static void meson_mmc_disable_resampling(struct meson_host *host)
+{
+	unsigned int val = readl(host->regs + host->data->adjust);
+
+	val &= ~ADJUST_ADJ_EN;
+	writel(val, host->regs + host->data->adjust);
+}
+
+static void meson_mmc_reset_resampling(struct meson_host *host)
+{
+	unsigned int val;
+
+	meson_mmc_disable_resampling(host);
+
+	val = readl(host->regs + host->data->adjust);
+	val &= ~ADJUST_ADJ_DELAY_MASK;
+	writel(val, host->regs + host->data->adjust);
+}
+
+static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	unsigned int val, dly, max_dly, i;
+	int ret;
+
+	/* Resampling is done using the source clock */
+	max_dly = DIV_ROUND_UP(clk_get_rate(host->mux_clk),
+			       clk_get_rate(host->mmc_clk));
+
+	val = readl(host->regs + host->data->adjust);
+	val |= ADJUST_ADJ_EN;
+	writel(val, host->regs + host->data->adjust);
+
+	if (mmc->doing_retune)
+		dly = FIELD_GET(ADJUST_ADJ_DELAY_MASK, val) + 1;
+	else
+		dly = 0;
+
+	for (i = 0; i < max_dly; i++) {
+		val &= ~ADJUST_ADJ_DELAY_MASK;
+		val |= FIELD_PREP(ADJUST_ADJ_DELAY_MASK, (dly + i) % max_dly);
+		writel(val, host->regs + host->data->adjust);
+
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret) {
+			dev_dbg(mmc_dev(mmc), "resampling delay: %u\n",
+				(dly + i) % max_dly);
+			return 0;
+		}
+	}
+
+	meson_mmc_reset_resampling(host);
+	return -EIO;
+}
+
 static int meson_mmc_prepare_ios_clock(struct meson_host *host,
 				       struct mmc_ios *ios)
 {
@@ -507,6 +562,19 @@ static int meson_mmc_prepare_ios_clock(struct meson_host *host,
 	return meson_mmc_clk_set(host, ios->clock, ddr);
 }
 
+static void meson_mmc_check_resampling(struct meson_host *host,
+				       struct mmc_ios *ios)
+{
+	switch (ios->timing) {
+	case MMC_TIMING_LEGACY:
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_MMC_DDR52:
+		meson_mmc_disable_resampling(host);
+		break;
+	}
+}
+
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -533,9 +601,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 
-		/* disable signal resampling */
-		writel(0, host->regs + host->data->adjust);
-
 		break;
 
 	case MMC_POWER_ON:
@@ -573,6 +638,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	val &= ~CFG_BUS_WIDTH_MASK;
 	val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
 
+	meson_mmc_check_resampling(host, ios);
 	err = meson_mmc_prepare_ios_clock(host, ios);
 	if (err)
 		dev_err(host->dev, "Failed to set clock: %d\n,", err);
@@ -962,6 +1028,7 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.get_cd         = meson_mmc_get_cd,
 	.pre_req	= meson_mmc_pre_req,
 	.post_req	= meson_mmc_post_req,
+	.execute_tuning = meson_mmc_resampling_tuning,
 	.card_busy	= meson_mmc_card_busy,
 	.start_signal_voltage_switch = meson_mmc_voltage_switch,
 };
-- 
2.20.1

