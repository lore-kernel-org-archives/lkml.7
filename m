Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0760C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912922146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVqf+s0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDCECH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45141 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfDCECC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:02:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so7593959pgk.12;
        Tue, 02 Apr 2019 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQnPRHBYBncms8D+H1okMWZ+MjeILBMAYDZbMM2hsC8=;
        b=RVqf+s0WgJTl4KGO1hALttS6DkfOn+T5OuGU1CTG98d2u2NOBOUzSJj578cvPL5psn
         9Y5oPqXUdOla+AHFksxvWWuVRRlLpo+ATmD+bUiCD5deNsXfsDSo9g4PfYdr75y3bHoJ
         wMoROOs7uRPUHRA+BQABEPWRy7dOKNwtOiE/Hu+3cF58De64FqEsW4oU+Fzk8iF/BH+K
         HxhYJwI+DQ/A7ERQ67bkUJDJXA+2aMZmlbzwFYmS5MuZPDqG2K6cOXIcvQ6Sgb7Cd5wv
         cW3o7UqPRzLMup2NDmmBn+3njwFS1++PK/EYh7Qfa/dZlcN9TTusVsFrhUoBxEyEVs8M
         tjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQnPRHBYBncms8D+H1okMWZ+MjeILBMAYDZbMM2hsC8=;
        b=rOHYLAh3TGamaefr0244oPNBVMSivmJb2/giDN7NLz/0LIbPUnWbRtZNCqDAfuLffK
         mdA7ryceJ36UsN95O0ZdKFc+No44+p6sc4ylIdB+Mzl+6f14+2ZrN1tkMP5R4h7ebkAX
         p3b0Dv5662beqYgNB6kOfBrKdChoD66CVNdr1fItuWkgTf/KNTNpFcwLw+oJ06qly551
         josLcYTCNF+ts3bscyUutWFNTg4WNOpO1X+PCRlJuy1OdNBoUeYXPkS9W2+k1g1dME+J
         SBPVdC9T1eiWuJAKNn6uCBaezqrEdNg1J41q85mkZK/PSKy1kWIr4uZeMghNchJ/16KC
         836g==
X-Gm-Message-State: APjAAAVT0lzH9qY7c5ci2cRyhLBFaZbYvgKxIjbxqHeSPTeTNJcEiRvk
        g0azZBiazfCGhk0HV06+J5Z/BqTP
X-Google-Smtp-Source: APXvYqyiU76RxdOYmcXJysoHeQ7fASKhbnbSoV2Ep7nsLyRO95wjHhNlwUw2h3xHMIsRBk2eM5PB8Q==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr17899629pga.37.1554264121792;
        Tue, 02 Apr 2019 21:02:01 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:02:00 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] spi: gpio: Drop unused pdev field in struct spi_gpio
Date:   Tue,  2 Apr 2019 21:01:30 -0700
Message-Id: <20190403040133.1459-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no code using 'pdev' field in struct spi_gpio. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 84ca803f6f69..3a6a9c6966c0 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -42,7 +42,6 @@
 
 struct spi_gpio {
 	struct spi_bitbang		bitbang;
-	struct platform_device		*pdev;
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
@@ -391,8 +390,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spi_gpio);
 
-	spi_gpio->pdev = pdev;
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
-- 
2.20.1

