Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A50621738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="NLjFJ84z";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="NLjFJ84z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCQPsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:48:31 -0400
Received: from node.akkea.ca ([192.155.83.177]:34294 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbfCQPsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:48:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id CE8374E2058;
        Sun, 17 Mar 2019 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837692; bh=C8eX/Q/Cvw3ZlHVFcCJXrh+AEs1hjbHeETT9wwkszlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NLjFJ84zLBtqh9ZwjvGladM0z5e/RdIoeU+JywE+wW7vL4JontnsbOQlEF6k51YHI
         j3pDcRRVtLSaMrnrt/4Q7vPdBIB4vfqhoFiE3PIqlaMcBVg8vnLRweUa+bo3CPipKN
         kCIOg+h8L7GOzOBRdbUdse8wLCOXloTrCK7bnKP4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n1UuniW3ILVg; Sun, 17 Mar 2019 15:48:12 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id D3A1C4E204B;
        Sun, 17 Mar 2019 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837692; bh=C8eX/Q/Cvw3ZlHVFcCJXrh+AEs1hjbHeETT9wwkszlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NLjFJ84zLBtqh9ZwjvGladM0z5e/RdIoeU+JywE+wW7vL4JontnsbOQlEF6k51YHI
         j3pDcRRVtLSaMrnrt/4Q7vPdBIB4vfqhoFiE3PIqlaMcBVg8vnLRweUa+bo3CPipKN
         kCIOg+h8L7GOzOBRdbUdse8wLCOXloTrCK7bnKP4=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] iio: light: vcnl4000 add support for the VCNL4040 proximity and light sensor
Date:   Sun, 17 Mar 2019 08:48:01 -0700
Message-Id: <20190317154802.15174-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317154802.15174-1-angus@akkea.ca>
References: <20190317154802.15174-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VCNL4040 is almost identical to the VCNL4200 as far as register
layout goes but just need to check a different ID register location.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/iio/light/vcnl4000.c | 51 ++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 836fa97b4e0c..d354143e5529 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1,8 +1,9 @@
 /*
- * vcnl4000.c - Support for Vishay VCNL4000/4010/4020/4200 combined ambient
+ * vcnl4000.c - Support for Vishay VCNL4000/4010/4020/4040/4200 combined ambient
  * light and proximity sensor
  *
  * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
+ * Copyright 2019 Pursim SPC
  *
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License.  See the file COPYING in the main
@@ -10,13 +11,14 @@
  *
  * IIO driver for:
  *   VCNL4000/10/20 (7-bit I2C slave address 0x13)
+ *   VCNL4040 (7-bit I2C slave address 0x60)
  *   VCNL4200 (7-bit I2C slave address 0x51)
  *
  * TODO:
  *   allow to adjust IR current
  *   proximity threshold and event handling
  *   periodic ALS/proximity measurement (VCNL4010/20)
- *   interrupts (VCNL4010/20, VCNL4200)
+ *   interrupts (VCNL4010/20/40, VCNL4200)
  */
 
 #include <linux/module.h>
@@ -30,6 +32,7 @@
 #define VCNL4000_DRV_NAME "vcnl4000"
 #define VCNL4000_PROD_ID	0x01
 #define VCNL4010_PROD_ID	0x02 /* for VCNL4020, VCNL4010 */
+#define VCNL4040_PROD_ID	0x86
 #define VCNL4200_PROD_ID	0x58
 
 #define VCNL4000_COMMAND	0x80 /* Command register */
@@ -49,6 +52,8 @@
 #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
 #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
 
+#define VCNL4040_DEV_ID		0x0c /* Device ID and version */
+
 /* Bit masks for COMMAND register */
 #define VCNL4000_AL_RDY		BIT(6) /* ALS data ready? */
 #define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
@@ -58,6 +63,7 @@
 enum vcnl4000_device_ids {
 	VCNL4000,
 	VCNL4010,
+	VCNL4040,
 	VCNL4200,
 };
 
@@ -90,6 +96,7 @@ static const struct i2c_device_id vcnl4000_id[] = {
 	{ "vcnl4000", VCNL4000 },
 	{ "vcnl4010", VCNL4010 },
 	{ "vcnl4020", VCNL4010 },
+	{ "vcnl4040", VCNL4040 },
 	{ "vcnl4200", VCNL4200 },
 	{ }
 };
@@ -128,14 +135,26 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 
 static int vcnl4200_init(struct vcnl4000_data *data)
 {
-	int ret;
+	int ret, id;
 
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
 	if (ret < 0)
 		return ret;
 
-	if ((ret & 0xff) != VCNL4200_PROD_ID)
-		return -ENODEV;
+	id = ret & 0xff;
+
+	if (id != VCNL4200_PROD_ID) {
+		ret = i2c_smbus_read_word_data(data->client, VCNL4040_DEV_ID);
+		if (ret < 0)
+			return ret;
+
+		id = ret & 0xff;
+
+		if (id != VCNL4040_PROD_ID)
+			return -ENODEV;
+	}
+
+	dev_dbg(&data->client->dev, "device id 0x%x", id);
 
 	data->rev = (ret >> 8) & 0xf;
 
@@ -150,9 +169,19 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	data->al_scale = 24000;
 	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
 	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
-	/* Integration time is 50ms, but the experiments show 54ms in total. */
-	data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
-	data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
+	switch (id) {
+	case VCNL4200_PROD_ID:
+		/* Integration time is 50ms, but the experiments */
+		/* show 54ms in total. */
+		data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
+		data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
+		break;
+	case VCNL4040_PROD_ID:
+		/* Integration time is 80ms, add 10ms. */
+		data->vcnl4200_al.sampling_rate = ktime_set(0, 100000 * 1000);
+		data->vcnl4200_ps.sampling_rate = ktime_set(0, 100000 * 1000);
+		break;
+	}
 	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
 	data->vcnl4200_ps.last_measurement = ktime_set(0, 0);
 	mutex_init(&data->vcnl4200_al.lock);
@@ -271,6 +300,12 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.measure_light = vcnl4000_measure_light,
 		.measure_proximity = vcnl4000_measure_proximity,
 	},
+	[VCNL4040] = {
+		.prod = "VCNL4040",
+		.init = vcnl4200_init,
+		.measure_light = vcnl4200_measure_light,
+		.measure_proximity = vcnl4200_measure_proximity,
+	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
 		.init = vcnl4200_init,
-- 
2.17.1

