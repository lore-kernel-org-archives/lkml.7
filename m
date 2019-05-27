Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79660C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451512075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iB8+5DWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfE0MnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:43:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36596 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfE0MnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:43:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id v22so8463360wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKFZPGKH5eGeLYYAtGCHsBSOPOjgodgPICLgkLIkvVM=;
        b=iB8+5DWCZC8jbgq5YM8DCbSOJJwcr+GQNlJVIM1Xm9Kgl3QzC6aIjYYNFonvI2etoE
         leQAh+sLaZW7zdKvONvUvItZZ60iVf9ZXxEta0ZS9OG1WKKsbQsXGC4ExCD+i2tCQMp/
         8AuePwV/jFczhXlAgu2fKf5WXeDUnccIUFzyCLpexhBb/pQlG6Y3sKsyxFK+4Cn0Z1WL
         B2J3/mX/QNUQ1dO8cQFy5j/EUFn5Ki8UGCxIcff3Nim0hADk88GN1zlOwJr1Lu2bJpzp
         hGt1t86hYoAqbIHEQbBtGLzYIqhyJIh0YDg2bOzT97HEHdvNu1+tGFQB3cZZDaj0TX6U
         Xoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKFZPGKH5eGeLYYAtGCHsBSOPOjgodgPICLgkLIkvVM=;
        b=Fr0eiK8f0OAVyjSSXIF6PCIOjCR13wBp1D+1s46kCCMevJsXQZc2Aw5bHzR6/G3zJk
         lD86a+fISY8/rVHWLKpiuGnVIbN9GTICgjLV2xQRSQnsAgCXrWTWVm9YAB87OYRECLoE
         oOvpjdpm81zQyA+QcnfVvy2oDhjaybU8MgtYfayJxSnQRbk/ImPtXsS8HsB73j9LTCr9
         Hgd8PtxaS2AziAbLnX7AP1DGWuwgSYAQYNcAHmXp4umw1WxB6L7HlStOTaj3kJYvqq9H
         CWEy30qp/qxlE7Tx07gKiDHBqZuWbgWQb40XhlITbQd15DOcT0neBTYGgVf+61qBswce
         kmGw==
X-Gm-Message-State: APjAAAV+fBpynmb8WNO1Uz15vD7My/QPAXRurcWOUWmsdJYU0Rd1TtZx
        4tZobyKCaBWnqN3AajxvMatnNQ==
X-Google-Smtp-Source: APXvYqzYFEfc+CAVT++3JgstGEGREHo3wv0+racX6ysjjaApP/NjpSOwnYG+6p8cWmXzewoznDOQ/w==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr9087883wmc.36.1558960992583;
        Mon, 27 May 2019 05:43:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm11494930wrt.45.2019.05.27.05.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 05:43:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v2 2/3] mmc: meson-gx: add dram-access-quirk
Date:   Mon, 27 May 2019 14:43:06 +0200
Message-Id: <20190527124307.32075-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527124307.32075-1-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
the data from DRAM, leading to a broken controller.

But each MMC controller has 1,5KiB of SRAM after the registers, that can
be used as bounce buffer to avoid direct DRAM access from the integrated
DMAs (this SRAM may be used by the boot ROM when DRAM is not yet initialized).

The quirk is to disable the chained descriptor for this controller, and
use this SRAM memory zone as buffer for the bounce buffer fallback mode.

The performance hit hasn't been evaluated, but the fix has been tested
using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
at 50MHz clock. It gave 170 Mbits/sec as SDR104 and 200MHz clock.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 70 ++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c5a8af4ca76b..bcf1789d26b6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -129,6 +129,9 @@
 #define SD_EMMC_TXD 0x94
 #define SD_EMMC_LAST_REG SD_EMMC_TXD
 
+#define SD_EMMC_SRAM_DATA_BUF_LEN 1536
+#define SD_EMMC_SRAM_DATA_BUF_OFF 0x200
+
 #define SD_EMMC_CFG_BLK_SIZE 512 /* internal buffer max: 512 bytes */
 #define SD_EMMC_CFG_RESP_TIMEOUT 256 /* in clock cycles */
 #define SD_EMMC_CMD_TIMEOUT 1024 /* in ms */
@@ -168,6 +171,8 @@ struct meson_host {
 	unsigned long req_rate;
 	bool ddr;
 
+	bool dram_access_quirk;
+
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
 	struct pinctrl_state *pins_clk_gate;
@@ -232,11 +237,20 @@ static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
 static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 					struct mmc_request *mrq)
 {
+	struct meson_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 	struct scatterlist *sg;
 	int i;
 	bool use_desc_chain_mode = true;
 
+	/*
+	 * When Controller DMA cannot directly access DDR memory, disable
+	 * support for Chain Mode to directly use the internal SRAM using
+	 * the bounce buffer mode.
+	 */
+	if (host->dram_access_quirk)
+		return;
+
 	/*
 	 * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
 	 * reported. For some strange reason this occurs in descriptor
@@ -1049,6 +1063,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
+	/* The G12A SDIO Controller needs an SRAM bounce buffer */
+	host->dram_access_quirk = device_property_read_bool(&pdev->dev,
+					"amlogic,dram-access-quirk");
+
 	/* Get regulators and the supported OCR mask */
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
@@ -1146,9 +1164,16 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto err_init_clk;
 
 	mmc->caps |= MMC_CAP_CMD23;
-	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
+	if (host->dram_access_quirk) {
+		/* Limit to the available sram memory */
+		mmc->max_segs = SD_EMMC_SRAM_DATA_BUF_LEN / mmc->max_blk_size;
+		mmc->max_blk_count = mmc->max_segs;
+	} else {
+		mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
+		mmc->max_segs = SD_EMMC_DESC_BUF_LEN /
+				sizeof(struct sd_emmc_desc);
+	}
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
-	mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
 	mmc->max_seg_size = mmc->max_req_size;
 
 	/*
@@ -1158,15 +1183,27 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	 */
 	mmc->caps2 &= ~MMC_CAP2_HS400;
 
-	/* data bounce buffer */
-	host->bounce_buf_size = mmc->max_req_size;
-	host->bounce_buf =
-		dma_alloc_coherent(host->dev, host->bounce_buf_size,
-				   &host->bounce_dma_addr, GFP_KERNEL);
-	if (host->bounce_buf == NULL) {
-		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
-		ret = -ENOMEM;
-		goto err_free_irq;
+	if (host->dram_access_quirk) {
+		/*
+		 * The MMC Controller embeds 1,5KiB of internal SRAM
+		 * that can be used to be used as bounce buffer.
+		 * In the case of the G12A SDIO controller, use these
+		 * instead of the DDR memory
+		 */
+		host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
+		host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
+		host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
+	} else {
+		/* data bounce buffer */
+		host->bounce_buf_size = mmc->max_req_size;
+		host->bounce_buf =
+			dma_alloc_coherent(host->dev, host->bounce_buf_size,
+					   &host->bounce_dma_addr, GFP_KERNEL);
+		if (host->bounce_buf == NULL) {
+			dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
+			ret = -ENOMEM;
+			goto err_free_irq;
+		}
 	}
 
 	host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
@@ -1183,8 +1220,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	return 0;
 
 err_bounce_buf:
-	dma_free_coherent(host->dev, host->bounce_buf_size,
-			  host->bounce_buf, host->bounce_dma_addr);
+	if (!host->dram_access_quirk)
+		dma_free_coherent(host->dev, host->bounce_buf_size,
+				  host->bounce_buf, host->bounce_dma_addr);
 err_free_irq:
 	free_irq(host->irq, host);
 err_init_clk:
@@ -1208,8 +1246,10 @@ static int meson_mmc_remove(struct platform_device *pdev)
 
 	dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
 			  host->descs, host->descs_dma_addr);
-	dma_free_coherent(host->dev, host->bounce_buf_size,
-			  host->bounce_buf, host->bounce_dma_addr);
+
+	if (!host->dram_access_quirk)
+		dma_free_coherent(host->dev, host->bounce_buf_size,
+				  host->bounce_buf, host->bounce_dma_addr);
 
 	clk_disable_unprepare(host->mmc_clk);
 	clk_disable_unprepare(host->core_clk);
-- 
2.21.0

