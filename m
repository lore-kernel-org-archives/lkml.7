Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0192C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651DF20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VqdScyXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfEMJQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:16:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39135 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfEMJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:16:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so12826757wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAXMadcZb2swWUhVzTHNUEypl5NTFLbqbQDV1LmgQb8=;
        b=VqdScyXowvctDJlC1aCl4asm0sjNlPtbHXr+6+n7i/ovoxmtMSiF84Z05uP1jvR2za
         36kMBLVuOUAw5Otm1WCcQQAXX9yMlkXJav1M1wnsZr2NsGpXAi7CVzlJUt+QfZPGJ/dA
         RS2wLK8kwmmrcsD1sHSL977S8pRRs3Czp4wry37Mk0tO+893gMfq/dxsUIQzteHKVCCC
         zKVD++SNW219EukS0UHc2UUi/tywmp+Iy90dAbnLxUl+aTGl6iKv/KHodBtM8bOuGTz0
         3l+18voIVm34cZSnGSc9TUnRzsR6WOwE8Avxf3Opta708oafTK/0rABCZehTY3uznofn
         pURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAXMadcZb2swWUhVzTHNUEypl5NTFLbqbQDV1LmgQb8=;
        b=uZXgHFcr8os0jIRiOgQ7a5860YSeDJFsVr9XDFRRHN/2hm6jfiwFG/gkM0eoWK9dcv
         2nTikiPK10OvxyMydQ1BMRWZSsQXeIjJsJnh55BFn2EfzsYOPLfltgE43oK/t2ws8rKN
         BEgmnxXxoZx+bBZ4j283HrXwlsGtQitCmu8bl+vmXYNE+WqcKpyMnXQUAnj2se37eNvS
         pl+fhGVRM8wJftlIzw6UG9a52SlwLFzt63KkQlbtUcFAv0tc++6jP7K8PUk4/59SJ/Fm
         UKhlbYqShGnOsUv8LkcKJklK4q/VZcsXBZYB5yxQYrepqbSaQZ8YXp3d8P5N49tpLRxU
         d7mA==
X-Gm-Message-State: APjAAAUjtNFaFDNzRoNs+scvrvA+DTO/HNyrAz3kt6YGX1CiLRzveKjH
        4v5XDroJ3lSS7Yvr4CxL/gawjg==
X-Google-Smtp-Source: APXvYqxbi5LwxhWm9kEHGvLxVj1r/h8O5xxC8YSIs0fr67Go/lgGEdpy3JCLDM9/trkqCJz+k3iFmA==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr15465115wma.68.1557738960756;
        Mon, 13 May 2019 02:16:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm10795091wrq.2.2019.05.13.02.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 02:16:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: meson-gx: add ddr-access-quirk
Date:   Mon, 13 May 2019 11:15:47 +0200
Message-Id: <20190513091548.16674-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513091548.16674-1-narmstrong@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
the data from DDR, leading to a broken controller.

But each MMC controller has 1,5KiB of SRAM after the registers, that can
be used as bounce buffer to avoid direct DDR access from the integrated
DMAs (this SRAM may be used by the boot ROM when DDR is not yet initialized).

The quirk is to disable the chained descriptor for this controller, and
use this SRAM memory zone as buffer for the bounce buffer fallback mode.

The performance hit hasn't been evaluated, but the fix has been tested
using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
at 50MHz clock. It gave 170 Mbits/sec as SDR104 and 200MHz clock.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 65 ++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c5a8af4ca76b..6ef465304052 100644
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
 
+	bool ddr_access_quirk;
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
+	if (host->ddr_access_quirk)
+		return;
+
 	/*
 	 * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
 	 * reported. For some strange reason this occurs in descriptor
@@ -1049,6 +1063,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
+	/* The G12A SDIO Controller needs an SRAM bounce buffer */
+	host->ddr_access_quirk = device_property_read_bool(&pdev->dev,
+					"amlogic,ddr-access-quirk");
+
 	/* Get regulators and the supported OCR mask */
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
@@ -1146,9 +1164,16 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto err_init_clk;
 
 	mmc->caps |= MMC_CAP_CMD23;
-	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
+	if (host->ddr_access_quirk) {
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
+	if (host->ddr_access_quirk) {
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
@@ -1208,8 +1245,10 @@ static int meson_mmc_remove(struct platform_device *pdev)
 
 	dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
 			  host->descs, host->descs_dma_addr);
-	dma_free_coherent(host->dev, host->bounce_buf_size,
-			  host->bounce_buf, host->bounce_dma_addr);
+
+	if (!host->ddr_access_quirk)
+		dma_free_coherent(host->dev, host->bounce_buf_size,
+				  host->bounce_buf, host->bounce_dma_addr);
 
 	clk_disable_unprepare(host->mmc_clk);
 	clk_disable_unprepare(host->core_clk);
-- 
2.21.0

