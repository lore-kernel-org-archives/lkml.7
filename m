Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB476C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B699B20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uifbI/QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDCECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41732 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCEB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:01:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so7451790pfd.8;
        Tue, 02 Apr 2019 21:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLfVSAt3KtcR71MR0EBWnUHcnDCLOACqvXbjCjoihCk=;
        b=uifbI/QXjzTmlNBZBYOK5jyrhzsTCeGJJwETGxfRuOvyBUzcpxQpY2IKQszNHsrXpd
         jx9eM/cJUL0CXL8Om39dMQhH+FM8zK/Y+Qwtvr7Qhei7Al/cBamq3JmNm7HipE3NO8sz
         M4yMEWb49hVkklCiYWd92GcTj/rEQzb225Y43XVxCOkmWb/hTcVt+0X6vc/vaQuSIQrp
         Bux9FnT3wnEyoWOMHoVfx0f6lwa3PqagOo3T3HuZY7CoKteDHS3V/US6vJ2Q0hVm3Qby
         S5bjkgCaLyErTB7+H1ORZEJ4kSUG4JAeIm3cz138o3RGp+QNYBM/8R6ngHzWkSGiYj28
         pPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLfVSAt3KtcR71MR0EBWnUHcnDCLOACqvXbjCjoihCk=;
        b=iIwLiQyaVlO6JXhw1iUrCKdG1rULgjFlZbl/jwt5zQbJMJkshEz7m8OFVK7ROoaehl
         X5TO3Kej6wAqq4V/QVzvx9l7y+mbjjYfhs2EM7uZhd8GXVLF2Ryp3tAcEYDjxbwF58yy
         Tg0gt7D1kXP4Z+Rz5KN1dGLutVKauEIfwBR8QnY85ve8dJEQdSw+UsFySMAKQGsKh3I6
         vK9mGcQpBlHXsfvGIF1oICpOp+O9bVG3xm18aaN7ttoq/X0Ue6PpiZNsgTqbI1PAaZbF
         JTJClqHzCjqc0lZkqeLK5AlrMe6dq45cc0LhbqH3w7rG+fhDUFYRMRl1Kkxjav3kQLp0
         yxng==
X-Gm-Message-State: APjAAAV09aghtBUaL38GyCgGlIr6sAb3LGq9KqVhOJcnH2KIz0LpW0QR
        q7ZLEolNAZbLKgwa3RTiEqnSmo2/
X-Google-Smtp-Source: APXvYqwOmOY7Fj6lcVIr2+RYH5XWq9tndFXJr0zQh76ISErXHVz5Fu/Ef3TT5H2ozmmUxJwmFbYAyg==
X-Received: by 2002:a65:524a:: with SMTP id q10mr58023109pgp.224.1554264115251;
        Tue, 02 Apr 2019 21:01:55 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:54 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] spi: gpio: Simplify SPI_MASTER_NO_TX check in spi_gpio_probe()
Date:   Tue,  2 Apr 2019 21:01:25 -0700
Message-Id: <20190403040133.1459-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap branches of the if statement in order to simplify it's logical
condition being checked. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index ca97b861c625..137f47e271dc 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -440,16 +440,16 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if ((master_flags & SPI_MASTER_NO_TX) == 0) {
-		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
-		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
-		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
-	} else {
+	if (master_flags & SPI_MASTER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
 		bb->txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
+	} else {
+		bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
+		bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
+		bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
+		bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-- 
2.20.1

