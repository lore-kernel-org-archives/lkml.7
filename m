Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85364C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C99E20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=devtank-co-uk.20150623.gappssmtp.com header.i=@devtank-co-uk.20150623.gappssmtp.com header.b="068o3O1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406919AbfHIMyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:54:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406905AbfHIMyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:54:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so94921279wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y32KFC5Gmco7XtWCiisEpnhBgSBOWGVlewparZe3tOw=;
        b=068o3O1lgPGrnJDGhdnBf7bX6dF9HXO3wLzt5tlQih8ELJzjpi5XN6itsC9m26VaJT
         MWjNzwpumYm5PaGNTgihrdW2iHPxYfre+iogU4hW3CsIzSj016Ww2OIpfGFT+lexFcn6
         IXk6SId7Rbt/w1zBe2xKSqUbo3/HN+dVRSELxXzhT8bFEcw6HmfoglK5FVcINDHwpsbc
         aqphkBa3oOA2fUq5QJIHtx3aacw9NN6G0efDjPRcpWp0EpIEFo4IU1P+ZcoAl/CQlUpl
         gG1fYzkzrBqw2j123HyPnjhjg6v2k1tn0flHP9njM5g5CTmehIA0FmC4pcwvGCf2x3qa
         PW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y32KFC5Gmco7XtWCiisEpnhBgSBOWGVlewparZe3tOw=;
        b=lUI9AG2Ir/H/d5R5EQi4bFujVWCw4hCCQdPQDVCJa96RpL1dQ+7+bBeP4Yi53CF6OW
         82Px7kdNb1DWuEnMZUBxJCNWSceevqYoP/t0A91SMVt54l+CWa7FSSxC2/ImoaVwvodj
         hLTjFsbYL5sz6/JzdoShNIoawpv4cStLztkcstuNFt7zT22EXHCU0UgH3sKEYB6VZ1Ii
         dDlCOOEu5Sk1FtAc9u4QXhRM/D/HRJg763U0PKcn02cI2JjziUyG1Vz36aMfLrXeKere
         odWmHKDs3CXYqdg/XAX9JBhU7wXvRiitnt/XmACAGNoshs2QHOFTvN5ZkaxLdFfhs0Xe
         V3UQ==
X-Gm-Message-State: APjAAAUby6lt+kuEZnUBlB6BrTh3QkzEuXXqgRCsmvQ5hJgs0xNpuzhu
        wmuEox+6beupUnmli5XLo5TtGQ==
X-Google-Smtp-Source: APXvYqxLDHv3jxjGKDWsbywwOeEk3IGevqplEAVGrmT7HBU9VjuZwFqc+KTT9uefcoI9FLWi9teM/g==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr22200335wrm.161.1565355248494;
        Fri, 09 Aug 2019 05:54:08 -0700 (PDT)
Received: from jabjoe-desktop.lan (82-71-5-123.dsl.in-addr.zen.co.uk. [82.71.5.123])
        by smtp.googlemail.com with ESMTPSA id 2sm2748038wrg.83.2019.08.09.05.54.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 05:54:07 -0700 (PDT)
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
To:     joe.burmeister@devtank.co.uk, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add optional chip erase functionality to AT25 EEPROM driver.
Date:   Fri,  9 Aug 2019 13:53:55 +0100
Message-Id: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many, though not all, AT25s have an instruction for chip erase.
If there is one in the datasheet, it can be added to device tree.
Erase can then be done in userspace via the sysfs API with a new
"erase" device attribute. This matches the eeprom_93xx46 driver's
"erase".

Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 .../devicetree/bindings/eeprom/at25.txt       |  2 +
 drivers/misc/eeprom/at25.c                    | 83 ++++++++++++++++++-
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index b3bde97dc199..c65d11e14c7a 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -19,6 +19,7 @@ Optional properties:
 - spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
 - spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
 - read-only : this parameter-less property disables writes to the eeprom
+- chip_erase_instruction : Chip erase instruction for this AT25, often 0xc7 or 0x62.
 
 Obsolete legacy properties can be used in place of "size", "pagesize",
 "address-width", and "read-only":
@@ -39,4 +40,5 @@ Example:
 		pagesize = <64>;
 		size = <32768>;
 		address-width = <16>;
+		chip_erase_instruction = <0x62>;
 	};
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 99de6939cd5a..28141bc4028f 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -35,6 +35,7 @@ struct at25_data {
 	unsigned		addrlen;
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
+	u8			erase_instr;
 };
 
 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -59,6 +60,8 @@ struct at25_data {
  */
 #define	EE_TIMEOUT	25
 
+#define ERASE_TIMEOUT 2020
+
 /*-------------------------------------------------------------------------*/
 
 #define	io_limit	PAGE_SIZE	/* bytes */
@@ -304,6 +307,71 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
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
+	cp = at25->erase_instr;
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
@@ -311,6 +379,7 @@ static int at25_probe(struct spi_device *spi)
 	int			err;
 	int			sr;
 	int			addrlen;
+	int			has_erase;
 
 	/* Chip description */
 	if (!spi->dev.platform_data) {
@@ -352,6 +421,9 @@ static int at25_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, at25);
 	at25->addrlen = addrlen;
 
+	/* Optional chip erase instruction */
+	device_property_read_u8(&spi->dev, "chip_erase_instruction", &at25->erase_instr);
+
 	at25->nvmem_config.name = dev_name(&spi->dev);
 	at25->nvmem_config.dev = &spi->dev;
 	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
@@ -370,17 +442,22 @@ static int at25_probe(struct spi_device *spi)
 	if (IS_ERR(at25->nvmem))
 		return PTR_ERR(at25->nvmem);
 
-	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u\n",
+	has_erase = (!(chip.flags & EE_READONLY) && at25->erase_instr);
+
+	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u%s\n",
 		(chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
 		(chip.byte_len < 1024) ? "Byte" : "KByte",
 		at25->chip.name,
 		(chip.flags & EE_READONLY) ? " (readonly)" : "",
-		at25->chip.page_size);
+		at25->chip.page_size, (has_erase)?" <has erase>":"");
+
+	if (has_erase && device_create_file(&spi->dev, &dev_attr_erase))
+		dev_err(&spi->dev, "can't create erase interface\n");
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

