Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73422C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1FC219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfGVR1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:27:52 -0400
Received: from sauhun.de ([88.99.104.3]:42368 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbfGVR0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:31 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 43EB54A14A5;
        Mon, 22 Jul 2019 19:26:30 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] mfd: max8997: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:18 +0200
Message-Id: <20190722172623.4166-12-wsa+renesas@sang-engineering.com>
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

 drivers/mfd/max8997.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 8c06c09e36d1..68d8f2b95287 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -185,25 +185,25 @@ static int max8997_i2c_probe(struct i2c_client *i2c,
 
 	mutex_init(&max8997->iolock);
 
-	max8997->rtc = i2c_new_dummy(i2c->adapter, I2C_ADDR_RTC);
-	if (!max8997->rtc) {
+	max8997->rtc = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_RTC);
+	if (IS_ERR(max8997->rtc)) {
 		dev_err(max8997->dev, "Failed to allocate I2C device for RTC\n");
-		return -ENODEV;
+		return PTR_ERR(max8997->rtc);
 	}
 	i2c_set_clientdata(max8997->rtc, max8997);
 
-	max8997->haptic = i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTIC);
-	if (!max8997->haptic) {
+	max8997->haptic = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_HAPTIC);
+	if (IS_ERR(max8997->haptic)) {
 		dev_err(max8997->dev, "Failed to allocate I2C device for Haptic\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(max8997->haptic);
 		goto err_i2c_haptic;
 	}
 	i2c_set_clientdata(max8997->haptic, max8997);
 
-	max8997->muic = i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
-	if (!max8997->muic) {
+	max8997->muic = i2c_new_dummy_device(i2c->adapter, I2C_ADDR_MUIC);
+	if (IS_ERR(max8997->muic)) {
 		dev_err(max8997->dev, "Failed to allocate I2C device for MUIC\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(max8997->muic);
 		goto err_i2c_muic;
 	}
 	i2c_set_clientdata(max8997->muic, max8997);
-- 
2.20.1

