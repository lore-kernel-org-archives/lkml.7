Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4946CC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B554208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="dhEKhKjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfF0Txa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:53:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38916 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0Txa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:53:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so2390979lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyjExCHwdDuT+ZRUy4Wx0tS5RD0zr2GPc2KHGmsxfJc=;
        b=dhEKhKjVpul/8+p2dC9a6u4AdtPpgvkYVgLRFj4YarCkAgelqDWE3RL4oGXRRLftnx
         9APEIpWjI36ePdcK+sSR5kuNevSGyf0G5qp2abEpJRwnizWYXofEZJgxLDkO1f15n9Kj
         cl3qrYx6LrlbCkspWrnJn8H1VIJG64YlX6CPJAYW2DJL1kis/IzygI84dwOnIjs36ejw
         AwUsBajvso2FPX/9e4yts+Ae0BBOnPYAErBGYGJi3mTcoyklLsc/cgTm7azETBFoSu/f
         ZLlpq6h2duSlbJuHKwiVAVIliz6/gydQzeK9eKo/CqGUfyo/MVNyZLT+LPZACMghiuZJ
         uNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyjExCHwdDuT+ZRUy4Wx0tS5RD0zr2GPc2KHGmsxfJc=;
        b=PGcpTI9hYYtgLEtQZNJRFpI0wNhxjEp14EGN6ZXfhQUlPUx62U5LDVHgInW0eIe0Df
         rHVDbdpXMBN7KdpC7E+nFURaeFS7ruWtmKDq8jzLrf7BXxvFTkz4WIK1Y5lcsNd5p5RZ
         lIqb5eG120zX7+2ZqAPe++JBT5uUE8ZebniOp8E3SeiK++ZLzCySaD77vo6BOqcE2GDP
         8hEm+A3zBdg3/PDFIoAidG/a59kBX9gJSzunmasjeAyiHV9HZgdar2/UW9cJxmUNLy3a
         WAMLE6/hMZgJkFBoK+9Q7J9Y139kI/dmqj+69zAoBbwciIqJBiwOoGMZUGJfZQUKyCih
         iTvA==
X-Gm-Message-State: APjAAAW42+HoqzF8/bP7iQDXWz56YrFKruqvRb1PeDsoEYPw6sNRtH8Q
        A+BEk9r8n3dpL1GXIM2LsmYY7w==
X-Google-Smtp-Source: APXvYqz5sISLIWRgKwraHEgQaGLSmH1xcM/FC4vCWXlkqWf/qYbgGzgtc425Zb5mF1kgCuPLnC/3RA==
X-Received: by 2002:a19:6602:: with SMTP id a2mr2912384lfc.25.1561665207444;
        Thu, 27 Jun 2019 12:53:27 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id r84sm740952lja.54.2019.06.27.12.53.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 12:53:26 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH] staging: kpc2000: fix brace issues in kpc2000_spi.c
Date:   Thu, 27 Jun 2019 21:53:23 +0200
Message-Id: <20190627195323.28913-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes issues found by checkpatch:

- "WARNING: braces {} are not necessary for single statement blocks"
- "WARNING: braces {} are not necessary for any arm of this statement"

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 39 ++++++++++-----------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 98484fbb9d2e..76db8e8510df 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -164,9 +164,9 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	u64 val;
 
 	addr += idx;
-	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0)) {
+	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0))
 		return cs->conf_cache;
-	}
+
 	val = readq(addr);
 	return val;
 }
@@ -188,11 +188,10 @@ kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx, unsigned lo
 	timeout = jiffies + msecs_to_jiffies(1000);
 	while (!(kp_spi_read_reg(cs, idx) & bit)) {
 		if (time_after(jiffies, timeout)) {
-			if (!(kp_spi_read_reg(cs, idx) & bit)) {
+			if (!(kp_spi_read_reg(cs, idx) & bit))
 				return -ETIMEDOUT;
-			} else {
+			else
 				return 0;
-			}
 		}
 		cpu_relax();
 	}
@@ -215,9 +214,8 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 		for (i = 0 ; i < c ; i++) {
 			char val = *tx++;
 
-			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_TXS) < 0) {
+			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_TXS) < 0)
 				goto out;
-			}
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
@@ -229,9 +227,8 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, 0x00);
 
-			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_RXS) < 0) {
+			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_RXS) < 0)
 				goto out;
-			}
 
 			test = kp_spi_read_reg(cs, KP_SPI_REG_RXDATA);
 			*rx++ = test;
@@ -261,9 +258,8 @@ kp_spi_setup(struct spi_device *spidev)
 	cs = spidev->controller_state;
 	if (!cs) {
 		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-		if (!cs) {
+		if (!cs)
 			return -ENOMEM;
-		}
 		cs->base = kpspi->base;
 		cs->conf_cache = -1;
 		spidev->controller_state = cs;
@@ -297,9 +293,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 	cs = spidev->controller_state;
 
 	/* reject invalid messages and transfers */
-	if (list_empty(&m->transfers)) {
+	if (list_empty(&m->transfers))
 		return -EINVAL;
-	}
 
 	/* validate input */
 	list_for_each_entry(transfer, &m->transfers, transfer_list) {
@@ -353,17 +348,14 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			sc.reg = kp_spi_read_reg(cs, KP_SPI_REG_CONFIG);
 
 			/* ...direction */
-			if (transfer->tx_buf) {
+			if (transfer->tx_buf)
 				sc.bitfield.trm = KP_SPI_REG_CONFIG_TRM_TX;
-			}
-			else if (transfer->rx_buf) {
+			else if (transfer->rx_buf)
 				sc.bitfield.trm = KP_SPI_REG_CONFIG_TRM_RX;
-			}
 
 			/* ...word length */
-			if (transfer->bits_per_word) {
+			if (transfer->bits_per_word)
 				word_len = transfer->bits_per_word;
-			}
 			sc.bitfield.wl = word_len - 1;
 
 			/* ...chip select */
@@ -382,9 +374,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			}
 		}
 
-		if (transfer->delay_usecs) {
+		if (transfer->delay_usecs)
 			udelay(transfer->delay_usecs);
-		}
 	}
 
 	/* de-assert chip select to end the sequence */
@@ -406,9 +397,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 kp_spi_cleanup(struct spi_device *spidev)
 {
 	struct kp_spi_controller_state *cs = spidev->controller_state;
-	if (cs) {
+	if (cs)
 		kfree(cs);
-	}
 }
 
 /******************
@@ -450,9 +440,8 @@ kp_spi_probe(struct platform_device *pldev)
 	kpspi->dev = &pldev->dev;
 
 	master->num_chipselect = 4;
-	if (pldev->id != -1) {
+	if (pldev->id != -1)
 		master->bus_num = pldev->id;
-	}
 
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
-- 
2.20.1

