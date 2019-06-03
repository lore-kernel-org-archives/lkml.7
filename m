Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA94C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882A6271AB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="oLOzOFaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFCTU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:20:59 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:55344 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFCTU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:20:59 -0400
Received: from localhost.localdomain (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A794AC0101;
        Mon,  3 Jun 2019 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1559589657; bh=0ZOQ8oo0MRQTYnRxEe5Ztp+WG3N9bT3TzGBVaCY33eA=;
        h=From:To:Cc:Subject:Date;
        b=oLOzOFaNi+UanyTvl65bDSpLVo7pkbCsfAitG6cfQ5FTxlHTjQkzVkkKqON6CLvwq
         sXkADZ31m7oqL24vC70ViNBeBPxoHVAWaVaX2G5HjVBhfYqb5086/pDuPccWawedy5
         +WD6iAwcriLI7GLmSD0ogWd+/loG82HDl5kzh3nY=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: light: stk3310: Add support for stk3335
Date:   Mon,  3 Jun 2019 21:20:39 +0200
Message-Id: <20190603192040.24101-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martijn Braam <martijn@brixit.nl>

The stk3335 light/proximity sensor is similar to the stk3310 and stk3311
sensors and works with the stk3310 driver.

Signed-off-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/iio/light/stk3310.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 6e2a169da950..a25cc35f334e 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -40,6 +40,7 @@
 
 #define STK3310_CHIP_ID_VAL			0x13
 #define STK3311_CHIP_ID_VAL			0x1D
+#define STK3335_CHIP_ID_VAL			0x51
 #define STK3310_PSINT_EN			0x01
 #define STK3310_PS_MAX_VAL			0xFFFF
 
@@ -454,7 +455,8 @@ static int stk3310_init(struct iio_dev *indio_dev)
 		return ret;
 
 	if (chipid != STK3310_CHIP_ID_VAL &&
-	    chipid != STK3311_CHIP_ID_VAL) {
+	    chipid != STK3311_CHIP_ID_VAL &&
+	    chipid != STK3335_CHIP_ID_VAL) {
 		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
 		return -ENODEV;
 	}
@@ -666,6 +668,7 @@ static SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
 static const struct i2c_device_id stk3310_i2c_id[] = {
 	{"STK3310", 0},
 	{"STK3311", 0},
+	{"STK3335", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
@@ -673,6 +676,7 @@ MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 static const struct acpi_device_id stk3310_acpi_id[] = {
 	{"STK3310", 0},
 	{"STK3311", 0},
+	{"STK3335", 0},
 	{}
 };
 
-- 
2.21.0

