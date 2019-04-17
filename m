Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3DD21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bLeAeSCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbfDQUoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:44:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45061 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733134AbfDQUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:44:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so54460wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvQGbdki4sfylBEdmd2o1C+/gcCUzEF0u1B6+PlWzsU=;
        b=bLeAeSCDxjpzrqXrv63QkEP25CJLiFdCj0ISKvgqRrZ9LVlY9tFQsZT4R/yaVUFpTG
         XdX+JevCLjw0pz7aKTQNt/ICoNO41sh7qOD7w7WA4h9eXCiofyfBTVmYI5mLAQW4Q8K7
         hyIj+/2rvzv93aTsA3DCorfA7DB84hjwNDPchMl6oSWSdFZ7i6iXmwBMzsz9Om/qG1hE
         YznUjxVW14Gjz96SEja5nvVXIrivlMjcGKiFFbxdikHEV9kHMQRm0x2SZuui+uaefRY3
         KbyWI+oc1t4hjwbgj06WJvxhvOutgbStm1qHePI/KWLeKA+j5fZF/KhzGbK4ziTv+szd
         Ly/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvQGbdki4sfylBEdmd2o1C+/gcCUzEF0u1B6+PlWzsU=;
        b=TwBqO0rXqbd9JFJ5oxJ35WXy0jyQOLV0h9HG6SGh2rETZraUlf176M+A+1uEaLqQTu
         mhPivOUrKajZRE5f4XDLxetek5wRnwqKRpSgDqHh4hbV/RApKKdGqj2ngbzcH2zBULcl
         SM6N9Gusl0gfslPXeazs+rTx19Dp4cOKTGOMzl+8ctHJa5afCAliXb1DYkhWPjOOV5UF
         QQMi2BqBa4+FMECsOjWHgzKWsAruNz+uEDAwG6Tbs+kkQSRgj09tLzM66JaeJImQGEUu
         aAVGPRkFUWFOPKXyoIhwxCU/KxBH2kYBlxwMy/rZcKrUik6ItvMics9wt7E0o0Wih1gw
         F/7w==
X-Gm-Message-State: APjAAAXbT2BhxBWwu1kWyvbfgzVQlQ66tx/aOJFFMffUuc5fw8jKJ9Wi
        MfmnMeLJOP7yeBL93wYJGpBaBg==
X-Google-Smtp-Source: APXvYqyprh0ZW5E545GdWfcqPk/iGY2Yw8mg5p/NcxaMUorxGhXmA4Ss4jPG5NUlwzXiyn4CaYbhrA==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr7849875wru.33.1555533852505;
        Wed, 17 Apr 2019 13:44:12 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id c20sm98716866wre.28.2019.04.17.13.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:44:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to DDR modes
Date:   Wed, 17 Apr 2019 22:43:53 +0200
Message-Id: <20190417204355.469-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activating DDR in the Amlogic mmc controller, among other things, will
divide the output clock by 2. So by activating it with clock on, we are
creating a glitch on the output.

Instead, let's deal with DDR when the clock output is off, when setting
the clock.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 72 +++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 118f09da8dfb..f77b9327a590 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -169,6 +169,7 @@ struct meson_host {
 	struct clk *rx_clk;
 	struct clk *tx_clk;
 	unsigned long req_rate;
+	bool ddr;
 
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
@@ -384,16 +385,6 @@ static void meson_mmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 			     mmc_get_dma_dir(data));
 }
 
-static bool meson_mmc_timing_is_ddr(struct mmc_ios *ios)
-{
-	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
-	    ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_HS400)
-		return true;
-
-	return false;
-}
-
 /*
  * Gating the clock on this controller is tricky.  It seems the mmc clock
  * is also used by the controller.  It may crash during some operation if the
@@ -430,36 +421,41 @@ static void meson_mmc_clk_ungate(struct meson_host *host)
 	writel(cfg, host->regs + SD_EMMC_CFG);
 }
 
-static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
+static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
+			     bool ddr)
 {
 	struct mmc_host *mmc = host->mmc;
-	unsigned long rate = ios->clock;
 	int ret;
 	u32 cfg;
 
-	/* DDR modes require higher module clock */
-	if (meson_mmc_timing_is_ddr(ios))
-		rate <<= 1;
-
 	/* Same request - bail-out */
-	if (host->req_rate == rate)
+	if (host->ddr == ddr && host->req_rate == rate)
 		return 0;
 
 	/* stop clock */
 	meson_mmc_clk_gate(host);
 	host->req_rate = 0;
+	mmc->actual_clock = 0;
 
-	if (!rate) {
-		mmc->actual_clock = 0;
-		/* return with clock being stopped */
+	/* return with clock being stopped */
+	if (!rate)
 		return 0;
-	}
 
 	/* Stop the clock during rate change to avoid glitches */
 	cfg = readl(host->regs + SD_EMMC_CFG);
 	cfg |= CFG_STOP_CLOCK;
 	writel(cfg, host->regs + SD_EMMC_CFG);
 
+	if (ddr) {
+		/* DDR modes require higher module clock */
+		rate <<= 1;
+		cfg |= CFG_DDR;
+	} else {
+		cfg &= ~CFG_DDR;
+	}
+	writel(cfg, host->regs + SD_EMMC_CFG);
+	host->ddr = ddr;
+
 	ret = clk_set_rate(host->mmc_clk, rate);
 	if (ret) {
 		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
@@ -471,12 +467,14 @@ static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 	mmc->actual_clock = clk_get_rate(host->mmc_clk);
 
 	/* We should report the real output frequency of the controller */
-	if (meson_mmc_timing_is_ddr(ios))
+	if (ddr) {
+		host->req_rate >>= 1;
 		mmc->actual_clock >>= 1;
+	}
 
 	dev_dbg(host->dev, "clk rate: %u Hz\n", mmc->actual_clock);
-	if (ios->clock != mmc->actual_clock)
-		dev_dbg(host->dev, "requested rate was %u\n", ios->clock);
+	if (rate != mmc->actual_clock)
+		dev_dbg(host->dev, "requested rate was %lu\n", rate);
 
 	/* (re)start clock */
 	meson_mmc_clk_ungate(host);
@@ -750,6 +748,25 @@ static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
 }
 
+static int meson_mmc_prepare_ios_clock(struct meson_host *host,
+				       struct mmc_ios *ios)
+{
+	bool ddr;
+
+	switch (ios->timing) {
+	case MMC_TIMING_MMC_DDR52:
+	case MMC_TIMING_UHS_DDR50:
+		ddr = true;
+		break;
+
+	default:
+		ddr = false;
+		break;
+	}
+
+	return meson_mmc_clk_set(host, ios->clock, ddr);
+}
+
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -819,15 +836,10 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	val &= ~CFG_BUS_WIDTH_MASK;
 	val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
 
-	val &= ~CFG_DDR;
-	if (meson_mmc_timing_is_ddr(ios))
-		val |= CFG_DDR;
-
-	err = meson_mmc_clk_set(host, ios);
+	err = meson_mmc_prepare_ios_clock(host, ios);
 	if (err)
 		dev_err(host->dev, "Failed to set clock: %d\n,", err);
 
-	writel(val, host->regs + SD_EMMC_CFG);
 	dev_dbg(host->dev, "SD_EMMC_CFG:  0x%08x\n", val);
 }
 
-- 
2.20.1

