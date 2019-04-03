Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5DAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C402084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXTR7nmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfDCEC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42067 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfDCECB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:02:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so7595771pgh.9;
        Tue, 02 Apr 2019 21:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39NNYeOrV7mh6FA8OvJAbA6NUD0BCyEWK7Cku8gU+xE=;
        b=JXTR7nmBJTUYf6ab5jmfTGZ6v93ePKFKj37s2ZTn8Ylr9G6b8pOpvQH0DFJ68ovTza
         YYAzzQg9vGGuDs/PYBqQ8r5DeIW6PDlmPXXgaBh9PycVbzFtBc4S2j6K8fw+PnCVSc1Q
         iXLuuxTHGItceaxPhvzApe6uHUh9ve5y2jxo2uvtMWieboNUv4wX9xMxLrtVSdu1xfwp
         MVJ9kUPcPakH20gzEH6P/Ni++UzI66YBZo3nxnn2lq29JQZ12Jqmhjl60f2Sxct5ekML
         s7d92ornq5srbj4LjNGnP4OauELne7Os5FkmTe7CEUDmTkLVLIi27YORoZX0ivju+lw9
         6SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39NNYeOrV7mh6FA8OvJAbA6NUD0BCyEWK7Cku8gU+xE=;
        b=Icvze9zPfCtVWOKynyH1r5/ud0WGzCOdAdFiGRvXm60bgsMNRzeDggiXZe33FqIBtt
         GRKD/xwgyJa1UyvT0gWeb7QFpQIJO1JfUNmmkkSNe4iEf/DI/wbBHNlbvwk9wNTJ3mDb
         W4cQ5gbpU756RE/qaCPDUm+3Gop86XoNWXSLMqeic2QnQmftRN0GxcXxATVZOnm/T35b
         vn6NgcL3MSbYMDUjpxjpAzD8MS7eYr6bdGeF1h6qT+9GS1EVOh71+ALIOED3/TPbzoZq
         2uyPACCjg1gGEQPgGNY9C1j512DW0AvJkvoHxm5EBkdUXtFkxn9VBEZ+GRaLUDXdrJ0a
         OibQ==
X-Gm-Message-State: APjAAAU/6Oh93VvMlpIw8uNoYK/ko8wOFmDs/CxFSXD+8qhpRFXnaEAm
        mWBehcka9KMn6kc4VKtDhLVLD+Vl
X-Google-Smtp-Source: APXvYqyD8xKZZX6LmOLIiIG3Fy8Go8G4Yo60sWe1jZgd7VW1jEw09FjTrNuzka7oQow2bJPObaC8xQ==
X-Received: by 2002:a63:450f:: with SMTP id s15mr69435269pga.157.1554264120464;
        Tue, 02 Apr 2019 21:02:00 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:59 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] spi: gpio: Drop mflags argument from spi_gpio_request()
Date:   Tue,  2 Apr 2019 21:01:29 -0700
Message-Id: <20190403040133.1459-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic of setting mflags in spi_gpio_request() is very simple and
there isn't much benefit in having it in that function. Move all of
that code outside into spi_gpio_probe() in order to simplify things.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 8feb036aaf36..84ca803f6f69 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -290,25 +290,15 @@ static void spi_gpio_cleanup(struct spi_device *spi)
  * floating signals.  (A weak pulldown would save power too, but many
  * drivers expect to see all-ones data as the no slave "response".)
  */
-static int spi_gpio_request(struct device *dev,
-			    struct spi_gpio *spi_gpio,
-			    u16 *mflags)
+static int spi_gpio_request(struct device *dev, struct spi_gpio *spi_gpio)
 {
 	spi_gpio->mosi = devm_gpiod_get_optional(dev, "mosi", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->mosi))
 		return PTR_ERR(spi_gpio->mosi);
-	if (!spi_gpio->mosi)
-		/* HW configuration without MOSI pin */
-		*mflags |= SPI_MASTER_NO_TX;
 
 	spi_gpio->miso = devm_gpiod_get_optional(dev, "miso", GPIOD_IN);
 	if (IS_ERR(spi_gpio->miso))
 		return PTR_ERR(spi_gpio->miso);
-	/*
-	 * No setting SPI_MASTER_NO_RX here - if there is only a MOSI
-	 * pin connected the host can still do RX by changing the
-	 * direction of the line.
-	 */
 
 	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->sck))
@@ -382,7 +372,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
 	const struct of_device_id	*of_id;
-	u16 master_flags = 0;
 
 	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
@@ -404,14 +393,23 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	spi_gpio->pdev = pdev;
 
-	status = spi_gpio_request(dev, spi_gpio, &master_flags);
+	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
 			    SPI_CS_HIGH;
-	master->flags = master_flags;
+	if (!spi_gpio->mosi) {
+		/* HW configuration without MOSI pin
+		 *
+		 * No setting SPI_MASTER_NO_RX here - if there is only
+		 * a MOSI pin connected the host can still do RX by
+		 * changing the direction of the line.
+		 */
+		master->flags = SPI_MASTER_NO_TX;
+	}
+
 	master->bus_num = pdev->id;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
@@ -421,7 +419,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if (master_flags & SPI_MASTER_NO_TX) {
+	if (master->flags & SPI_MASTER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
-- 
2.20.1

