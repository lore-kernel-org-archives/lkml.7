Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D64C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2862D217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfGVR1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:27:55 -0400
Received: from sauhun.de ([88.99.104.3]:42398 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfGVR0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:31 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id AEA374A14A4;
        Mon, 22 Jul 2019 19:26:29 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] mfd: max8925-i2c: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:17 +0200
Message-Id: <20190722172623.4166-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/max8925-i2c.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 20bb19b71109..114e905bef25 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -176,18 +176,18 @@ static int max8925_probe(struct i2c_client *client,
 	dev_set_drvdata(chip->dev, chip);
 	mutex_init(&chip->io_lock);
 
-	chip->rtc = i2c_new_dummy(chip->i2c->adapter, RTC_I2C_ADDR);
-	if (!chip->rtc) {
+	chip->rtc = i2c_new_dummy_device(chip->i2c->adapter, RTC_I2C_ADDR);
+	if (IS_ERR(chip->rtc)) {
 		dev_err(chip->dev, "Failed to allocate I2C device for RTC\n");
-		return -ENODEV;
+		return PTR_ERR(chip->rtc);
 	}
 	i2c_set_clientdata(chip->rtc, chip);
 
-	chip->adc = i2c_new_dummy(chip->i2c->adapter, ADC_I2C_ADDR);
-	if (!chip->adc) {
+	chip->adc = i2c_new_dummy_device(chip->i2c->adapter, ADC_I2C_ADDR);
+	if (IS_ERR(chip->adc)) {
 		dev_err(chip->dev, "Failed to allocate I2C device for ADC\n");
 		i2c_unregister_device(chip->rtc);
-		return -ENODEV;
+		return PTR_ERR(chip->adc);
 	}
 	i2c_set_clientdata(chip->adc, chip);
 
-- 
2.20.1

