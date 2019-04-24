Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD14C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD152054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126795;
	bh=qi+/HfV0VHDdIQsv9jFy4YQh3tPo+/I48fm6xPFhd9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gzDOeldmqcW9C/kcXPP2HBN9XBEc/EK8xhKxbowdhFr3MSqS42clkxrio/b8ei0tn
	 UJz7I7nbcb+zARTJBsaR3PzmS25Zq5+xrg0Sk4aBo/pls3AGKJvk5FRRiHUIkEv83K
	 izoPdPn4T9L0HYni7qfOVBtrA1lNuIAF04ks87bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbfDXR0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390232AbfDXR0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:26:31 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205092054F;
        Wed, 24 Apr 2019 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126790;
        bh=qi+/HfV0VHDdIQsv9jFy4YQh3tPo+/I48fm6xPFhd9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOdly/HTw9ORzKO2ITCFgC1bJ/GOswTNdlZf5yefh8ab9FFz+cyJ11fL6B9g7gCZ3
         P3+vRK+c35vf99L2yXUZSYx09zwxHpINw/dIqkKvxYAzp7bK95HQbrtdtHFJgE6hdw
         bF+cq5qhup7dwsjAlZvGFfD7tPO02FM4Z0Mn5t8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Larin <cerg2010cerg2010@mail.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 18/70] iio: gyro: mpu3050: fix chip ID reading
Date:   Wed, 24 Apr 2019 19:09:38 +0200
Message-Id: <20190424170909.973864311@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Larin <cerg2010cerg2010@mail.ru>

commit 409a51e0a4a5f908763191fae2c29008632eb712 upstream.

According to the datasheet, the last bit of CHIP_ID register controls
I2C bus, and the first one is unused. Handle this correctly.

Note that there are chips out there that have a value such that
the id check currently fails.

Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/gyro/mpu3050-core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -29,7 +29,8 @@
 
 #include "mpu3050.h"
 
-#define MPU3050_CHIP_ID		0x69
+#define MPU3050_CHIP_ID		0x68
+#define MPU3050_CHIP_ID_MASK	0x7E
 
 /*
  * Register map: anything suffixed *_H is a big-endian high byte and always
@@ -1178,8 +1179,9 @@ int mpu3050_common_probe(struct device *
 		goto err_power_down;
 	}
 
-	if (val != MPU3050_CHIP_ID) {
-		dev_err(dev, "unsupported chip id %02x\n", (u8)val);
+	if ((val & MPU3050_CHIP_ID_MASK) != MPU3050_CHIP_ID) {
+		dev_err(dev, "unsupported chip id %02x\n",
+				(u8)(val & MPU3050_CHIP_ID_MASK));
 		ret = -ENODEV;
 		goto err_power_down;
 	}


