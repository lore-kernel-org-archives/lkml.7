Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717102084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMGdznHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDCECE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42065 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfDCECA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:02:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so7595747pgh.9;
        Tue, 02 Apr 2019 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIvhZvEfkbeo4H9XjoKPljUa+D7k5vhWMpbvGBotaLs=;
        b=bMGdznHsx81EYZ4yET0F5yuaCpdXWqVJqtRm0dWFMLds6gvJCZGg6DDGkk+5h8optw
         P9htPS1IQXxEkPQu9RTPLHI2n5xtDhtfXdYmF1Wouz5XCVBg9Uabx+LqbiUO7ORGVRf2
         NbAhvvE/1RdhpfMlHiWpbPhAhKqYOgNTiV+p0rDMUytZpblSM3jEUozJZlydjL7x46bm
         Aa6Ziz4MdvcDgheZWN0DfGSVpmrseQRgHlbKWEZl4pwMLUqVxYp5W745FTdMwakO6QTn
         BjMOgKLvburc8LQKWXCS1mXS2FPrMIa3gECZGLyAY7ex9/BMfwUTEDgxCdY+DIRaT2Hb
         QmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIvhZvEfkbeo4H9XjoKPljUa+D7k5vhWMpbvGBotaLs=;
        b=L6Wj/GKcCxk75/zS8+yWIUTv47ZjXtUoeWqWy2jpsuHWG93EbTOHTqBCOmUeN3Rv+Q
         eFm/qdoQZoAD7i8L4t91cTz5W1UuhF4OygSoRoT2+alHcmgsHa+XhvfWHPl8rO2bfkF7
         9kRBNuLE/9SgbkLLgHLE7UYkEc+fjMFvWOzgq56dYesS0DkRyNZRtuSF4Lpr0sVXfla4
         lEps7cJRnsYm+9f67SAcP/+jE57ewjfVzgzxPbr6jhIiUe/ohHfllsrxEmGqlZepaY87
         tLKUVnmkAbpz/HgeLG4j2MfbbXTORLNf4SodpBOWIquegY1v20Q90UJcpnEhWTWG5J2b
         758Q==
X-Gm-Message-State: APjAAAWXxultlxqtnJdY6sEybjy6CP5kkZnYp5uRvF7WzuOMEOln3heD
        hxZRN831e3zTfJ7EJBHDzltDKcVD
X-Google-Smtp-Source: APXvYqx+Xz6lSUAlH4ppEZuZZgS80Abtb6x6Jc6jy3asPFa4TqW4p8ewRFreevY1zBelFGxU/MDbPQ==
X-Received: by 2002:a63:c706:: with SMTP id n6mr37001089pgg.310.1554264119436;
        Tue, 02 Apr 2019 21:01:59 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:58 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] spi: Don't call spi_get_gpio_descs() before device name is set
Date:   Tue,  2 Apr 2019 21:01:28 -0700
Message-Id: <20190403040133.1459-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move code calling spi_get_gpio_descs() to happen after ctlr->dev's
name is set in order to have proper GPIO consumer names.

Before:

cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-31, parent: platform/40049000.gpio, vf610-gpio:
 gpio-6   (                    |regulator-usb0-vbus ) out lo

gpiochip1: GPIOs 32-63, parent: platform/4004a000.gpio, vf610-gpio:
 gpio-36  (                    |scl                 ) in  hi
 gpio-37  (                    |sda                 ) in  hi
 gpio-40  (                    |(null) CS1          ) out lo
 gpio-41  (                    |(null) CS0          ) out lo ACTIVE LOW
 gpio-42  (                    |miso                ) in  hi
 gpio-43  (                    |mosi                ) in  lo
 gpio-44  (                    |sck                 ) out lo

After:

cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-31, parent: platform/40049000.gpio, vf610-gpio:
 gpio-6   (                    |regulator-usb0-vbus ) out lo

gpiochip1: GPIOs 32-63, parent: platform/4004a000.gpio, vf610-gpio:
 gpio-36  (                    |scl                 ) in  hi
 gpio-37  (                    |sda                 ) in  hi
 gpio-40  (                    |spi0 CS1            ) out lo
 gpio-41  (                    |spi0 CS0            ) out lo ACTIVE LOW
 gpio-42  (                    |miso                ) in  hi
 gpio-43  (                    |mosi                ) in  lo
 gpio-44  (                    |sck                 ) out lo

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bd2a424672df..19d663435b8c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2279,24 +2279,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
-	if (!spi_controller_is_slave(ctlr)) {
-		if (ctlr->use_gpio_descriptors) {
-			status = spi_get_gpio_descs(ctlr);
-			if (status)
-				return status;
-			/*
-			 * A controller using GPIO descriptors always
-			 * supports SPI_CS_HIGH if need be.
-			 */
-			ctlr->mode_bits |= SPI_CS_HIGH;
-		} else {
-			/* Legacy code path for GPIOs from DT */
-			status = of_spi_register_master(ctlr);
-			if (status)
-				return status;
-		}
-	}
-
 	/* even if it's just one always-selected device, there must
 	 * be at least one chipselect
 	 */
@@ -2353,6 +2335,25 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 * registration fails if the bus ID is in use.
 	 */
 	dev_set_name(&ctlr->dev, "spi%u", ctlr->bus_num);
+
+	if (!spi_controller_is_slave(ctlr)) {
+		if (ctlr->use_gpio_descriptors) {
+			status = spi_get_gpio_descs(ctlr);
+			if (status)
+				return status;
+			/*
+			 * A controller using GPIO descriptors always
+			 * supports SPI_CS_HIGH if need be.
+			 */
+			ctlr->mode_bits |= SPI_CS_HIGH;
+		} else {
+			/* Legacy code path for GPIOs from DT */
+			status = of_spi_register_master(ctlr);
+			if (status)
+				return status;
+		}
+	}
+
 	status = device_add(&ctlr->dev);
 	if (status < 0) {
 		/* free bus id */
-- 
2.20.1

