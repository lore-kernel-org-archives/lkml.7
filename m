Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B8EC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD8622296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfGVR1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:27:03 -0400
Received: from sauhun.de ([88.99.104.3]:42368 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731516AbfGVR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:38 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 58AE44A148F;
        Mon, 22 Jul 2019 19:26:36 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: tps80031: convert to devm_i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:35 +0200
Message-Id: <20190722172636.4589-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from i2c_new_dummy() to devm_i2c_new_dummy_device(). So, we now get
an ERRPTR which we use in error handling and we can skip removal of the
created devices.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested. Part of a tree-wide move to deprecate
i2c_new_dummy().

 drivers/mfd/tps80031.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
index 865257ade8ac..907452b86e32 100644
--- a/drivers/mfd/tps80031.c
+++ b/drivers/mfd/tps80031.c
@@ -437,12 +437,11 @@ static int tps80031_probe(struct i2c_client *client,
 		if (tps80031_slave_address[i] == client->addr)
 			tps80031->clients[i] = client;
 		else
-			tps80031->clients[i] = i2c_new_dummy(client->adapter,
-						tps80031_slave_address[i]);
-		if (!tps80031->clients[i]) {
+			tps80031->clients[i] = devm_i2c_new_dummy_device(&client->dev,
+						client->adapter, tps80031_slave_address[i]);
+		if (IS_ERR(tps80031->clients[i])) {
 			dev_err(&client->dev, "can't attach client %d\n", i);
-			ret = -ENOMEM;
-			goto fail_client_reg;
+			return PTR_ERR(tps80031->clients[i]);
 		}
 
 		i2c_set_clientdata(tps80031->clients[i], tps80031);
@@ -452,7 +451,7 @@ static int tps80031_probe(struct i2c_client *client,
 			ret = PTR_ERR(tps80031->regmap[i]);
 			dev_err(&client->dev,
 				"regmap %d init failed, err %d\n", i, ret);
-			goto fail_client_reg;
+			return ret;
 		}
 	}
 
@@ -461,7 +460,7 @@ static int tps80031_probe(struct i2c_client *client,
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"Silicon version number read failed: %d\n", ret);
-		goto fail_client_reg;
+		return ret;
 	}
 
 	ret = tps80031_read(&client->dev, TPS80031_SLAVE_ID3,
@@ -469,7 +468,7 @@ static int tps80031_probe(struct i2c_client *client,
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"Silicon eeprom version read failed: %d\n", ret);
-		goto fail_client_reg;
+		return ret;
 	}
 
 	dev_info(&client->dev, "ES version 0x%02x and EPROM version 0x%02x\n",
@@ -482,7 +481,7 @@ static int tps80031_probe(struct i2c_client *client,
 	ret = tps80031_irq_init(tps80031, client->irq, pdata->irq_base);
 	if (ret) {
 		dev_err(&client->dev, "IRQ init failed: %d\n", ret);
-		goto fail_client_reg;
+		return ret;
 	}
 
 	tps80031_pupd_init(tps80031, pdata);
@@ -506,12 +505,6 @@ static int tps80031_probe(struct i2c_client *client,
 
 fail_mfd_add:
 	regmap_del_irq_chip(client->irq, tps80031->irq_data);
-
-fail_client_reg:
-	for (i = 0; i < TPS80031_NUM_SLAVES; i++) {
-		if (tps80031->clients[i]  && (tps80031->clients[i] != client))
-			i2c_unregister_device(tps80031->clients[i]);
-	}
 	return ret;
 }
 
-- 
2.20.1

