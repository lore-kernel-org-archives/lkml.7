Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C623BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967B921903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127040;
	bh=WdhaBDNuR9iB8CvUZ+0lnq5JFVjmbCZ/SWYeioLM91w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flMcmFgrvSOMFNB2Z7sASocP7Ne3BMZ+rX4gT1TYj0xcOgKhastWDt3dOA9KKZbBu
	 VaAGyCOxoR/Ar6r9JX+vSicU5CfuNDEa+tyqJGf9HJFkY5p1Wo+8nc4T3WpUEdsN8x
	 Hud22Sw+4OJOK6iRvn5uWXTS6EM/xMeCo8n45Lrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbfDXRaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391013AbfDXRag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:36 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28452054F;
        Wed, 24 Apr 2019 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127036;
        bh=WdhaBDNuR9iB8CvUZ+0lnq5JFVjmbCZ/SWYeioLM91w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYKHs/Md6c+Dd72TBskK0WHwXBMFtXSOSMv2MExVYTqUYngG6vKGSCtd/NvDN1TtN
         CjA9icjldKSccQtUUTAbPmc2jtvu6CQccTOfD04P/CvGOU85WKa3Ie4w1BL+gdgHmo
         fwDkQML3F3vC+Bfz7v6sPrEX8HJpbJYDwhWq2Lok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Larin <cerg2010cerg2010@mail.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 36/96] iio: gyro: mpu3050: fix chip ID reading
Date:   Wed, 24 Apr 2019 19:09:41 +0200
Message-Id: <20190424170922.335765869@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -1176,8 +1177,9 @@ int mpu3050_common_probe(struct device *
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


