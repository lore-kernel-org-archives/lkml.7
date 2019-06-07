Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D62C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD95D20657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ea18d6Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfFGP4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:56:39 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60348 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfFGP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922996; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=a8OsSC6tBUyRL7Rw6Y2ayx+S6UhMMk7UJeWp8lYsTyk=;
        b=ea18d6SqUDvF322Q5XlIJkJ8SOw/fRDJaO4ca4BAygoy70Z9AchjCPZT0P+ZRJALM5etFJ
        DZ5qBo/8K2x+1Z9T7xoLq5gOd8fbC7NYL3+u5M1zYp671s3O1ZC2LDjFuN/R51HCeamWkb
        6n/mbEtccfzeELbNbTrOrytfeP7vy0A=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] spi: spi-gpio: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 17:56:31 +0200
Message-Id: <20190607155631.15072-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/spi/spi-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index eca9d52ecf65..c242c962772d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -358,7 +358,7 @@ static void spi_gpio_put(void *data)
 	spi_master_put(data);
 }
 
-static int spi_gpio_probe(struct platform_device *pdev)
+static int __init_or_module spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
 	struct spi_master		*master;
-- 
2.21.0.593.g511ec345e18

