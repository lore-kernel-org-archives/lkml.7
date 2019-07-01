Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EA120659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="yACaMc4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfGAJSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:18:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43280 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfGAJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:18:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so12310570ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnGzpgrloPpecP5lmIfO2uWEIueLQKQHuqUdB5786nE=;
        b=yACaMc4g8j3hx/NgX9T84gJhPdqw3OvWNan6U6E9stNXr9Sr4Adhmnz8YVybMIEsDX
         9kV4n2dluX5DwV8vWFdAslmKxvvis4evgjQ0NDOu8gGqTVLrGSRnlVR+vvbFy+kmn1XP
         fQVK17Y8S/cS59UTHp91/E5jAe3l9CCPccF3o/511ZnDPVC3SIj+IRFn1yT+TgAHFcZR
         t5mRn+YhsEdGaODChO8WNlhj/8aMDYWAyMV70IdBTvoOHqCUuukniZlJPNTBRQ0psvot
         RDy9dXoqbdGXTk4IJlzvIs53tyqt+YYgdHf6jamgqqRUDdFEp++5oXXL/ByhTxawtYop
         oAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnGzpgrloPpecP5lmIfO2uWEIueLQKQHuqUdB5786nE=;
        b=nQhQ7GSG6HF/rN4rEO4a30aHU8HrhoQzeEQbUGgZBxI7rIbnQRdK7q9Ur2bkE/mmuS
         IewoqLyKYNj/xsFhuR+xo/drlD6HamRH/EUZbGAQWb21h4xAEurOSG5UKx4jlwomKFaG
         dTaCBdnhAg1Fu0tJAp7XCFOmoJUMZ0j7ldfRJu/nWzn7UzoPkxiUgdimg6I/+W1poJZZ
         +mSG5nzRvmF0UGd/OYDzsyNLB/I7PKBMrermyzRaibV+pYhSsIG/7p7vEIP09IDU1slS
         tqzyYc0OXmW+fwknjWAF2abcdpyqMKjPQuoH/E97jBpq+IzKsXlvCpAueHBmXZxRt5qd
         GYBg==
X-Gm-Message-State: APjAAAU0HwBdtPNlUPf0rOa3BFWgl0I1kg7rEzkCXNYBbJkbVezUHwIS
        HjO1IcDuMg5jyLISKVipu+/gQw==
X-Google-Smtp-Source: APXvYqyPU7yNzZLFgu6Nh2z/u3nnbpMpnEUjP3Fk0MEn8WWnpZQSsQvJvuAt7/NvZogjBM3RZGMlkg==
X-Received: by 2002:a2e:2b8f:: with SMTP id r15mr12915741ljr.210.1561972702306;
        Mon, 01 Jul 2019 02:18:22 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id i23sm3134821ljb.7.2019.07.01.02.18.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 02:18:21 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH v2] staging: kpc2000: fix brace issues in kpc2000_spi.c
Date:   Mon,  1 Jul 2019 11:18:19 +0200
Message-Id: <20190701091819.18528-1-simon@nikanor.nu>
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

Changed in v2: rebased.

 drivers/staging/kpc2000/kpc2000_spi.c | 33 ++++++++++-----------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 021cc859feed..009dec2f4641 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -165,9 +165,9 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
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
@@ -192,11 +192,10 @@ kp_spi_wait_for_reg_bit(struct kp_spi_controller_state *cs, int idx,
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
@@ -269,9 +268,8 @@ kp_spi_setup(struct spi_device *spidev)
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
@@ -305,9 +303,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 	cs = spidev->controller_state;
 
 	/* reject invalid messages and transfers */
-	if (list_empty(&m->transfers)) {
+	if (list_empty(&m->transfers))
 		return -EINVAL;
-	}
 
 	/* validate input */
 	list_for_each_entry(transfer, &m->transfers, transfer_list) {
@@ -365,17 +362,14 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
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
@@ -394,9 +388,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			}
 		}
 
-		if (transfer->delay_usecs) {
+		if (transfer->delay_usecs)
 			udelay(transfer->delay_usecs);
-		}
 	}
 
 	/* de-assert chip select to end the sequence */
@@ -419,9 +412,8 @@ kp_spi_cleanup(struct spi_device *spidev)
 {
 	struct kp_spi_controller_state *cs = spidev->controller_state;
 
-	if (cs) {
+	if (cs)
 		kfree(cs);
-	}
 }
 
 /******************
@@ -464,9 +456,8 @@ kp_spi_probe(struct platform_device *pldev)
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

