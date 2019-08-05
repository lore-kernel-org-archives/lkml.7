Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4756C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AA92087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=devtank-co-uk.20150623.gappssmtp.com header.i=@devtank-co-uk.20150623.gappssmtp.com header.b="mcQ6vKh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfHEKVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:21:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46094 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:21:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so83822944wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abvBm3ejtMnYT3sN09H6tZJ7+2C7h+kf6cOB3CVgCSI=;
        b=mcQ6vKh4V1pIdCuy/h49S6XFfD5777/lYEkQ2Pm9Awje0DmNIZHDf8RfViFEl4Moap
         8DlTzeByUVPTa8W/qlakH3cJxYF/XVxmIyJ49d0oAGgXSmSKz8A6XobSiZn76ACGM2M4
         O0z3B1nXGWCbnRv8FxndRuA3NZlRd3azE64HGUEdWtHQQcJVSqdYyO45YF6a4PJs3BL8
         /qO5hvvmVEk1eBx7syaWjTUfb/wWtxmmZxgmnrMpjZZmdisjxk6VuWMYo1V7oCH77h1R
         wRDGEZVi48E1uYGiMNGOantNYcld3u5+DMomgk/m1NwhpGYrqv9+lWBB2yD6Ef0dsyAf
         WWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abvBm3ejtMnYT3sN09H6tZJ7+2C7h+kf6cOB3CVgCSI=;
        b=RfHjlgvnzssNRyBcbHegmU5GlEmnYaS9JQarfGLMIlr4/dW6hUoCERvNTGO/sFj7pa
         xNNFlT1bnpDomxIQzrZB5UMdiEQrPY1j3gXMsyBvSt+x8ArDFJpSUNj6iKGBJE5yWksj
         Dq05jSaasuh0roVzWiM4PKmt9YOrbaO/VJRWCXzIMeSrYzId3e+bTad3Wk9Anzys+R5T
         7YF+LiuQlbI9aL7a/atAiAj+8zMrriAlYYU2NJjMMgAP5rdLWFw8wDCJRVSodBDasXiZ
         232IDWcR1p0nlgyoEZoi//2ypQdyzxccYSmW/0c0cDiV/fgaFhbbWXI4TftixsdRo3+4
         8rbg==
X-Gm-Message-State: APjAAAUAfENeBCdvm/J9PPvq8GcOvcR1VWRvarfYSOMAbEMQobIVta7k
        bkSSS1/1wPVngENOj4kKTjaHFZYz
X-Google-Smtp-Source: APXvYqzbdMg7Bw5qIP26QZAiy1xHRQgehI5Gi1QTUdCp7ASCdAlYUTQocwqztrEeFfaiuk3j2hLwXg==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr35915348wrw.349.1565000492062;
        Mon, 05 Aug 2019 03:21:32 -0700 (PDT)
Received: from jabjoe-thinkpad.lan ([141.105.200.141])
        by smtp.googlemail.com with ESMTPSA id w7sm98116105wrn.11.2019.08.05.03.21.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 03:21:31 -0700 (PDT)
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
To:     joe.burmeister@devtank.co.uk, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Add erase interface for AT25 driver.
Date:   Mon,  5 Aug 2019 11:21:26 +0100
Message-Id: <20190805102127.19624-1-joe.burmeister@devtank.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/misc/eeprom/at25.c | 75 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 99de6939cd5a..b1fb3bfd935d 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -43,6 +43,7 @@ struct at25_data {
 #define	AT25_WRSR	0x01		/* write status register */
 #define	AT25_READ	0x03		/* read byte(s) */
 #define	AT25_WRITE	0x02		/* write byte(s)/sector */
+#define AT25_CHIP_ERASE	0x62		/* Erase whole chip */
 
 #define	AT25_SR_nRDY	0x01		/* nRDY = write-in-progress */
 #define	AT25_SR_WEN	0x02		/* write enable (latched) */
@@ -52,6 +53,7 @@ struct at25_data {
 
 #define	AT25_INSTR_BIT3	0x08		/* Additional address bit in instr */
 
+
 #define EE_MAXADDRLEN	3		/* 24 bit addresses, up to 2 MBytes */
 
 /* Specs often allow 5 msec for a page write, sometimes 20 msec;
@@ -59,6 +61,8 @@ struct at25_data {
  */
 #define	EE_TIMEOUT	25
 
+#define ERASE_TIMEOUT 2020
+
 /*-------------------------------------------------------------------------*/
 
 #define	io_limit	PAGE_SIZE	/* bytes */
@@ -304,6 +308,71 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	return 0;
 }
 
+static void _eeprom_at25_store_erase_locked(struct at25_data *at25)
+{
+	unsigned long	timeout, retries;
+	int				sr, status;
+	u8	cp;
+
+	cp = AT25_WREN;
+	status = spi_write(at25->spi, &cp, 1);
+	if (status < 0) {
+		dev_dbg(&at25->spi->dev, "ERASE WREN --> %d\n", status);
+		return;
+	}
+	cp = AT25_CHIP_ERASE;
+	status = spi_write(at25->spi, &cp, 1);
+	if (status < 0) {
+		dev_dbg(&at25->spi->dev, "CHIP_ERASE --> %d\n", status);
+		return;
+	}
+	/* Wait for non-busy status */
+	timeout = jiffies + msecs_to_jiffies(ERASE_TIMEOUT);
+	retries = 0;
+	do {
+		sr = spi_w8r8(at25->spi, AT25_RDSR);
+		if (sr < 0 || (sr & AT25_SR_nRDY)) {
+			dev_dbg(&at25->spi->dev,
+				"rdsr --> %d (%02x)\n", sr, sr);
+			/* at HZ=100, this is sloooow */
+			msleep(1);
+			continue;
+		}
+		if (!(sr & AT25_SR_nRDY))
+			return;
+	} while (retries++ < 200 || time_before_eq(jiffies, timeout));
+
+	if ((sr < 0) || (sr & AT25_SR_nRDY)) {
+		dev_err(&at25->spi->dev,
+			"chip erase, timeout after %u msecs\n",
+			jiffies_to_msecs(jiffies -
+				(timeout - ERASE_TIMEOUT)));
+		status = -ETIMEDOUT;
+		return;
+	}
+}
+
+
+static ssize_t eeprom_at25_store_erase(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct at25_data *at25 = dev_get_drvdata(dev);
+	int erase = 0;
+
+	sscanf(buf, "%d", &erase);
+	if (erase) {
+		mutex_lock(&at25->lock);
+		_eeprom_at25_store_erase_locked(at25);
+		mutex_unlock(&at25->lock);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(erase, S_IWUSR, NULL, eeprom_at25_store_erase);
+
+
 static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
@@ -376,11 +445,15 @@ static int at25_probe(struct spi_device *spi)
 		at25->chip.name,
 		(chip.flags & EE_READONLY) ? " (readonly)" : "",
 		at25->chip.page_size);
+
+        if (!(chip.flags & EE_READONLY))
+            if (device_create_file(&spi->dev, &dev_attr_erase))
+                dev_err(&spi->dev, "can't create erase interface\n");
+
 	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
-
 static const struct of_device_id at25_of_match[] = {
 	{ .compatible = "atmel,at25", },
 	{ }
-- 
2.20.1

