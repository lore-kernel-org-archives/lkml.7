Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39399C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 00:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D2B20B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 00:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIEYI4AG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfDGA7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 20:59:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37938 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDGA7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 20:59:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so10904637wmc.3;
        Sat, 06 Apr 2019 17:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgktmzG1xTrc6JNyt4VcJOWfBd6zAUe7NnkAzgLCqf8=;
        b=YIEYI4AGQOrlzMMQf2EcI9u4bMg2RqaTrF1BNCdXjrkibJmKIzxJsFemF4YNF8LhT3
         PyBZlu898oSD6MfLXIcHM4603zJi+qOKGo1YU2v0dw5+VglJWXcP/MJucfwGJiultgRz
         CXQfQUGgj+o/L/fWRfgc6RhqUiAZw5dCmBCJHGAWSESIxuQ2Hlnc/2WC5HH/zpoIj7SQ
         WvO6dNYXuDMbAalq0KPzhqOn0zNVVVxT9FlVsOGtVNUOb8P5TEt4jvFDv5iV0wQBJ89m
         t6/yPROdR8/QyMOXu99kfW4ydTkNQVmrCmacGG2ErUxyZBqJMqCjnQq1uSYp6pP6e1BN
         FJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgktmzG1xTrc6JNyt4VcJOWfBd6zAUe7NnkAzgLCqf8=;
        b=kbyPm8IzoSKA2+UY8KNeb7FGUA7bmeJR7LMgduGyBmfydEgEl+88n430RfcVOYyWDu
         Eb+vmauJvf1P+bjbpf/m0Yq3LU3kWSka/XCpnOTij3BBIufzMLvzJimMRBf9l+KOlCFL
         Vqb//qNe+U50K6SLs9ataApKqfdmB6kSr4277gf9dcYQ6KXrab5C/a3Rd9dW2U1PMuWf
         L+Q1x8njl6sYi+e8TrF6irHaE8Yf7NHbG5Yj2wdSj5B6LxsTYk3WrDygQmsa61MJFa6O
         +ewHHw+CttOJWOroCa7uNhsl1SGNctQ/I7bhj2Cs1fnOS5xVPWpOfclmVIH3vPT9Yohu
         ZOGQ==
X-Gm-Message-State: APjAAAWgZP3oUc13vRSslWVXwQDEkZ5Ego0JwkpRio7G3bGoFHa+rwWC
        efoxVGug1jxGGx8xnhu3LvU=
X-Google-Smtp-Source: APXvYqyaQl/6MghsQfa1fYV2LerKF5cpq83zAwGB4512NdAKWXNH9SFedy7BTO+eIZdrWuNu+5lFZQ==
X-Received: by 2002:a1c:495:: with SMTP id 143mr11817116wme.78.1554598745795;
        Sat, 06 Apr 2019 17:59:05 -0700 (PDT)
Received: from localhost.localdomain ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id 192sm10439578wme.13.2019.04.06.17.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 17:59:04 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vicente Bergas <vicencb@gmail.com>
Subject: [PATCH] spi: rockchip: Revert "set min/max speed"
Date:   Sun,  7 Apr 2019 02:57:59 +0200
Message-Id: <20190407005759.2425-1-vicencb@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts
commit 420b82f84294 ("spi: rockchip: set min/max speed")
commit 74b7efa82b11 ("spi: rockchip: precompute rx sample delay")
The former breaks bursts of writes of 48 bytes or more.
Both patches touch the same part of the file and it is not trivial to
only revert the first. Reverting both just results in an easy to fix
conflict.

Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Vicente Bergas <vicencb@gmail.com>
---
 drivers/spi/spi-rockchip.c | 80 ++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3912526ead66..682f3567a8c8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -97,7 +97,6 @@
 #define CR0_BHT_8BIT				0x1
 
 #define CR0_RSD_OFFSET				14
-#define CR0_RSD_MAX				0x3
 
 #define CR0_FRF_OFFSET				16
 #define CR0_FRF_SPI					0x0
@@ -119,10 +118,6 @@
 /* Bit fields in SER, 2bit */
 #define SER_MASK					0x3
 
-/* Bit fields in BAUDR */
-#define BAUDR_SCKDV_MIN				2
-#define BAUDR_SCKDV_MAX				65534
-
 /* Bit fields in SR, 5bit */
 #define SR_MASK						0x1f
 #define SR_BUSY						(1 << 0)
@@ -155,7 +150,7 @@
 #define TXDMA					(1 << 1)
 
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
-#define MAX_SCLK_OUT				50000000U
+#define MAX_SCLK_OUT		50000000
 
 /*
  * SPI_CTRLR1 is 16-bits, so we should support lengths of 0xffff + 1. However,
@@ -184,11 +179,12 @@ struct rockchip_spi {
 
 	/*depth of the FIFO buffer */
 	u32 fifo_len;
-	/* frequency of spiclk */
-	u32 freq;
+	/* max bus freq supported */
+	u32 max_freq;
 
 	u8 n_bytes;
-	u8 rsd;
+	u32 rsd_nsecs;
+	u32 speed;
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 };
@@ -198,6 +194,11 @@ static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
+static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
+{
+	writel_relaxed(div, rs->regs + ROCKCHIP_SPI_BAUDR);
+}
+
 static inline void wait_for_idle(struct rockchip_spi *rs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
@@ -472,9 +473,10 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 	u32 cr1;
+	u32 div = 0;
 	u32 dmacr = 0;
+	int rsd = 0;
 
-	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
@@ -514,6 +516,33 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 			dmacr |= RF_DMA_EN;
 	}
 
+	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
+		rs->speed = MAX_SCLK_OUT;
+
+	/* the minimum divisor is 2 */
+	if (rs->max_freq < 2 * rs->speed) {
+		clk_set_rate(rs->spiclk, 2 * rs->speed);
+		rs->max_freq = clk_get_rate(rs->spiclk);
+	}
+
+	/* div doesn't support odd number */
+	div = DIV_ROUND_UP(rs->max_freq, rs->speed);
+	div = (div + 1) & 0xfffe;
+
+	/* Rx sample delay is expressed in parent clock cycles (max 3) */
+	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->max_freq >> 8),
+				1000000000 >> 8);
+	if (!rsd && rs->rsd_nsecs) {
+		pr_warn_once("rockchip-spi: %u Hz are too slow to express %u ns delay\n",
+			     rs->max_freq, rs->rsd_nsecs);
+	} else if (rsd > 3) {
+		rsd = 3;
+		pr_warn_once("rockchip-spi: %u Hz are too fast to express %u ns delay, clamping at %u ns\n",
+			     rs->max_freq, rs->rsd_nsecs,
+			     rsd * 1000000000U / rs->max_freq);
+	}
+	cr0 |= rsd << CR0_RSD_OFFSET;
+
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 	writel_relaxed(cr1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
@@ -530,12 +559,9 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-	/* the hardware only supports an even clock divisor, so
-	 * round divisor = spiclk / speed up to nearest even number
-	 * so that the resulting speed is <= the requested speed
-	 */
-	writel_relaxed(2 * DIV_ROUND_UP(rs->freq, 2 * xfer->speed_hz),
-			rs->regs + ROCKCHIP_SPI_BAUDR);
+	spi_set_clk(rs, div);
+
+	dev_dbg(rs->dev, "cr0 0x%x, div %d\n", cr0, div);
 }
 
 static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
@@ -564,6 +590,7 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
+	rs->speed = xfer->speed_hz;
 	rs->n_bytes = xfer->bits_per_word <= 8 ? 1 : 2;
 
 	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
@@ -652,24 +679,11 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_spiclk;
 
 	rs->dev = &pdev->dev;
-	rs->freq = clk_get_rate(rs->spiclk);
+	rs->max_freq = clk_get_rate(rs->spiclk);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
-				  &rsd_nsecs)) {
-		/* rx sample delay is expressed in parent clock cycles (max 3) */
-		u32 rsd = DIV_ROUND_CLOSEST(rsd_nsecs * (rs->freq >> 8),
-				1000000000 >> 8);
-		if (!rsd) {
-			dev_warn(rs->dev, "%u Hz are too slow to express %u ns delay\n",
-					rs->freq, rsd_nsecs);
-		} else if (rsd > CR0_RSD_MAX) {
-			rsd = CR0_RSD_MAX;
-			dev_warn(rs->dev, "%u Hz are too fast to express %u ns delay, clamping at %u ns\n",
-					rs->freq, rsd_nsecs,
-					CR0_RSD_MAX * 1000000000U / rs->freq);
-		}
-		rs->rsd = rsd;
-	}
+				  &rsd_nsecs))
+		rs->rsd_nsecs = rsd_nsecs;
 
 	rs->fifo_len = get_fifo_len(rs);
 	if (!rs->fifo_len) {
@@ -687,8 +701,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
-	master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
-	master->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
 	master->set_cs = rockchip_spi_set_cs;
 	master->transfer_one = rockchip_spi_transfer_one;
-- 
2.21.0

