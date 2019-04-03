Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01142084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9+qnXCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfDCECs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46951 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfDCEBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:01:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so7326219pll.13;
        Tue, 02 Apr 2019 21:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jy4yvhUe/wOfMugw4ZT/NujP1DfOs+r6jOZ3EbRTWA=;
        b=i9+qnXCpX4OPa9W2N7S/TZZO0QiyI/b9x72Vonoiqoll1KcrBEtyZ5YF1GT6Ja9kDJ
         53rTcOl7kolC2qA/MBPFucM8X1w7lKekL3t6OAecjDOWIDPsH6C818t44dMExyTZxT5J
         MF5B3P00qFAwLBrZM6Xad6uGEtN0RarEsJ7O/SOkvE+AjzIHqN/811drcgRuob53m5CT
         F6IOQwTjfDmEOR8Kg0ha2fEXCFwrbBP3xihVM0E05Yc29KmKh2Q3KbmxRdHUgrscpFAz
         uH41AmAEU4Sp5sqj4zfrReFl0QvpQTweinWXGiO42UVk/5qaLenfYV6Q5KKVjCEE1bOY
         hFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jy4yvhUe/wOfMugw4ZT/NujP1DfOs+r6jOZ3EbRTWA=;
        b=WJYL0VHaGgqYa3v9OXUrzS5NwUwmGSPUPyzhXLdYAzPSkzg2GmBvst0haTHxm9Cbnl
         QekxWmf7l3/WIHwcv3mJCpUZG2Pruk7X3y6vLw+0tqKzBTM4BVZAO19Dh54EQGCJ/srK
         fUv/yRSEyVxmCVHxQloc2S4mBaqIJJv6WvivN13Zk8LGkNk1x64ofEx+aihu1QiwfpcO
         TQB4Z+Sy4BXhP75f2zN3IT9diICqgLfRxEBm3jnBvgOW1PrlNJN8AAlZJUYGrVMK0af/
         X+1Xc2ftXoYoSPxmLTSNvuvJDAnDZjW9wt3R4r0ekvOmv6VzODIyU4ZrBqeewxvJ3TqF
         ZcRQ==
X-Gm-Message-State: APjAAAW6PY/H9L8x4CQvU1LyIkPkP6QxGFOiPDktNmlHzxkXrSz8k1gb
        dupwDWz95sM9gbSWti1Y3kjUwoTi
X-Google-Smtp-Source: APXvYqybv+XCRVSAHIKSd9Qf4och78Mi6wj1QhdOEmSf+W18CLu7zI0M7Nol7ORD0pBqzoJS/NM6OA==
X-Received: by 2002:a17:902:9a0b:: with SMTP id v11mr74492018plp.194.1554264113956;
        Tue, 02 Apr 2019 21:01:53 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] spi: gpio: Add local struct spi_bitbang pointer in spi_gpio_probe()
Date:   Tue,  2 Apr 2019 21:01:24 -0700
Message-Id: <20190403040133.1459-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct spi_bitbang *bb" in spi_gpio_probe() for
brevity. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 2869af5ff936..ca97b861c625 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -380,6 +380,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
 	struct device			*dev = &pdev->dev;
+	struct spi_bitbang		*bb;
 	u16 master_flags = 0;
 	bool use_of = 0;
 
@@ -434,23 +435,23 @@ static int spi_gpio_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 	master->dev.of_node = dev->of_node;
 #endif
-
-	spi_gpio->bitbang.master = master;
-	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
-	spi_gpio->bitbang.set_line_direction = spi_gpio_set_direction;
+	bb = &spi_gpio->bitbang;
+	bb->master = master;
+	bb->chipselect = spi_gpio_chipselect;
+	bb->set_line_direction = spi_gpio_set_direction;
 
 	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
-		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
+		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
+		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
+		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
+		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
 	} else {
-		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
-		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
+		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
+		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
+		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
+		bb->txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
 	}
-	spi_gpio->bitbang.setup_transfer = spi_bitbang_setup_transfer;
+	bb->setup_transfer = spi_bitbang_setup_transfer;
 
 	status = spi_bitbang_start(&spi_gpio->bitbang);
 	if (status)
-- 
2.20.1

