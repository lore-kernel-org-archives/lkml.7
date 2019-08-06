Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C761C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BFC2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbfHFJLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:11:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52781 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbfHFJLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:11:43 -0400
Received: from [167.98.27.226] (helo=ct-lt-765.unassigned)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1huvUu-0005Yj-W8; Tue, 06 Aug 2019 10:11:13 +0100
Received: from ikerpalomar by ct-lt-765.unassigned with local (Exim 4.89)
        (envelope-from <ikerpalomar@ct-lt-765.unassigned>)
        id 1huvUu-0003Th-9e; Tue, 06 Aug 2019 10:11:12 +0100
From:   Iker Perez <iker.perez@codethink.co.uk>
To:     linux-hwmon@vger.kernel.org, linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Iker Perez del Palomar Sustatxa 
        <iker.perez@codethink.co.uk>
Subject: [PATCH 2/4] hwmon: (lm75) Create function from code to write into registers
Date:   Tue,  6 Aug 2019 10:11:05 +0100
Message-Id: <20190806091107.13322-3-iker.perez@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190806091107.13322-1-iker.perez@codethink.co.uk>
References: <20190806091107.13322-1-iker.perez@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>

Wrap the existing code to write configurations into registers in
a function.

Added error handling to the function.

Signed-off-by: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
---
 drivers/hwmon/lm75.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 1c012301b6ca..477ac0732ddf 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -228,6 +228,27 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
 
+static int lm75_write_config(struct lm75_data *data, u8 set_mask,
+			     u8 clr_mask)
+{
+	u8 value;
+
+	clr_mask |= LM75_SHUTDOWN;
+	value = data->current_conf & ~clr_mask;
+	value |= set_mask;
+
+	if (data->current_conf != value) {
+		s32 err;
+
+		err = i2c_smbus_write_byte_data(data->client, LM75_REG_CONF,
+						value);
+		if (err)
+			return err;
+		data->current_conf = value;
+	}
+	return 0;
+}
+
 static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
@@ -389,7 +410,6 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct device *hwmon_dev;
 	struct lm75_data *data;
 	int status, err;
-	int new;
 	enum lm75_type kind;
 
 	if (client->dev.of_node)
@@ -429,16 +449,16 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return status;
 	}
 	data->orig_conf = status;
-	new = status & ~(data->params->clr_mask | LM75_SHUTDOWN);
-	new |= data->params->set_mask;
-	if (status != new)
-		i2c_smbus_write_byte_data(client, LM75_REG_CONF, new);
+	data->current_conf = status;
 
-	err = devm_add_action_or_reset(dev, lm75_remove, data);
+	err = lm75_write_config(data, data->params->set_mask,
+				data->params->clr_mask);
 	if (err)
 		return err;
 
-	dev_dbg(dev, "Config %02x\n", new);
+	err = devm_add_action_or_reset(dev, lm75_remove, data);
+	if (err)
+		return err;
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data, &lm75_chip_info,
-- 
2.11.0

