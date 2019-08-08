Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D20C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612421881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404038AbfHHPgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:36:12 -0400
Received: from sauhun.de ([88.99.104.3]:56468 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733213AbfHHPgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:36:09 -0400
Received: from localhost (p5486CA1C.dip0.t-ipconnect.de [84.134.202.28])
        by pokefinder.org (Postfix) with ESMTPSA id DD0163E4858;
        Thu,  8 Aug 2019 17:36:06 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFT 3/3] hwmon: w83793d: convert to use devm_i2c_new_dummy_device
Date:   Thu,  8 Aug 2019 17:35:58 +0200
Message-Id: <20190808153558.2362-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808153558.2362-1-wsa+renesas@sang-engineering.com>
References: <20190808153558.2362-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And simplify the error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/hwmon/w83793.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 46f5dfec8d0a..9df48b70c70c 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1551,9 +1551,6 @@ static int w83793_remove(struct i2c_client *client)
 	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
 		device_remove_file(dev, &w83793_temp[i].dev_attr);
 
-	i2c_unregister_device(data->lm75[0]);
-	i2c_unregister_device(data->lm75[1]);
-
 	/* Decrease data reference counter */
 	mutex_lock(&watchdog_data_mutex);
 	kref_put(&data->kref, w83793_release_resources);
@@ -1565,7 +1562,7 @@ static int w83793_remove(struct i2c_client *client)
 static int
 w83793_detect_subclients(struct i2c_client *client)
 {
-	int i, id, err;
+	int i, id;
 	int address = client->addr;
 	u8 tmp;
 	struct i2c_adapter *adapter = client->adapter;
@@ -1580,8 +1577,7 @@ w83793_detect_subclients(struct i2c_client *client)
 					"invalid subclient "
 					"address %d; must be 0x48-0x4f\n",
 					force_subclients[i]);
-				err = -EINVAL;
-				goto ERROR_SC_0;
+				return -EINVAL;
 			}
 		}
 		w83793_write_value(client, W83793_REG_I2C_SUBADDR,
@@ -1591,28 +1587,21 @@ w83793_detect_subclients(struct i2c_client *client)
 
 	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
 	if (!(tmp & 0x08))
-		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (tmp & 0x7));
+		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
+							  0x48 + (tmp & 0x7));
 	if (!(tmp & 0x80)) {
-		if ((data->lm75[0] != NULL)
+		if (!IS_ERR(data->lm75[0])
 		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
 			dev_err(&client->dev,
 				"duplicate addresses 0x%x, "
 				"use force_subclients\n", data->lm75[0]->addr);
-			err = -ENODEV;
-			goto ERROR_SC_1;
+			return -ENODEV;
 		}
-		data->lm75[1] = i2c_new_dummy(adapter,
-					      0x48 + ((tmp >> 4) & 0x7));
+		data->lm75[1] = devm_i2c_new_dummy_device(&client->dev, adapter,
+							  0x48 + ((tmp >> 4) & 0x7));
 	}
 
 	return 0;
-
-	/* Undo inits in case of errors */
-
-ERROR_SC_1:
-	i2c_unregister_device(data->lm75[0]);
-ERROR_SC_0:
-	return err;
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
@@ -1945,9 +1934,6 @@ static int w83793_probe(struct i2c_client *client,
 
 	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
 		device_remove_file(dev, &w83793_temp[i].dev_attr);
-
-	i2c_unregister_device(data->lm75[0]);
-	i2c_unregister_device(data->lm75[1]);
 free_mem:
 	kfree(data);
 exit:
-- 
2.20.1

