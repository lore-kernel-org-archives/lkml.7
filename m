Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D45DC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5071B218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfEaKVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:21:05 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:14526 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:21:05 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td81b886de1ac1401c8e60@ACLMS3.advantech.com.tw>;
 Fri, 31 May 2019 18:21:01 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (nct7904) Fix the incorrect value of tcpu_mask in nct7904_data struct.
Date:   Fri, 31 May 2019 10:20:47 +0000
Message-ID: <20190531102048.28691-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.82]
X-ClientProxiedBy: taipei09.ADVANTECH.CORP (172.20.0.236) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

Detect the multi-function of voltage, thermal diode and thermistor
from register VT_ADC_MD_REG to set value of tcpu_mask in nct7904_data
struct, set temp[1-5]_input the input values TEMP_CH1~4 and LTD of
temperature. Set temp[6~13]_input the input values of DTS temperature
that correspond to sensors TCPU1~8.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 72 +++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 04516789b070..6a74df6841f0 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -4,6 +4,9 @@
  * Copyright (c) 2015 Kontron
  * Author: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
  *
+ * Copyright (c) 2019 Advantech
+ * Author: Amy.Shih <amy.shih@advantech.com.tw>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -59,6 +62,8 @@
 #define T_CPU1_HV_REG		0xA0	/* Bank 0; 2 regs (HV/LV) per sensor */
 
 #define PRTS_REG		0x03	/* Bank 2 */
+#define PFE_REG			0x00	/* Bank 2; PECI Function Enable */
+#define TSI_CTRL_REG		0x50	/* Bank 2; TSI Control Register */
 #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
 #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
 
@@ -74,6 +79,8 @@ struct nct7904_data {
 	u32 vsen_mask;
 	u32 tcpu_mask;
 	u8 fan_mode[FANCTL_MAX];
+	u8 enable_dts;
+	u8 has_dts;
 };
 
 /* Access functions */
@@ -238,11 +245,15 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 
 	switch (attr) {
 	case hwmon_temp_input:
-		if (channel == 0)
+		if (channel == 4)
 			ret = nct7904_read_reg16(data, BANK_0, LTD_HV_REG);
+		else if (channel < 5)
+			ret = nct7904_read_reg16(data, BANK_0,
+						 TEMP_CH1_HV_REG + channel * 4);
 		else
 			ret = nct7904_read_reg16(data, BANK_0,
-					T_CPU1_HV_REG + (channel - 1) * 2);
+						 T_CPU1_HV_REG + (channel - 5)
+						 * 2);
 		if (ret < 0)
 			return ret;
 		temp = ((ret & 0xff00) >> 5) | (ret & 0x7);
@@ -258,11 +269,11 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
 	const struct nct7904_data *data = _data;
 
 	if (attr == hwmon_temp_input) {
-		if (channel == 0) {
-			if (data->vsen_mask & BIT(17))
+		if (channel < 5) {
+			if (data->tcpu_mask & BIT(channel))
 				return 0444;
 		} else {
-			if (data->tcpu_mask & BIT(channel - 1))
+			if (data->has_dts & BIT(channel - 5))
 				return 0444;
 		}
 	}
@@ -469,6 +480,7 @@ static int nct7904_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int ret, i;
 	u32 mask;
+	u8 val, bit;
 
 	data = devm_kzalloc(dev, sizeof(struct nct7904_data), GFP_KERNEL);
 	if (!data)
@@ -502,10 +514,52 @@ static int nct7904_probe(struct i2c_client *client,
 	data->vsen_mask = mask;
 
 	/* CPU_TEMP attributes */
-	ret = nct7904_read_reg16(data, BANK_0, DTS_T_CTRL0_REG);
-	if (ret < 0)
-		return ret;
-	data->tcpu_mask = ((ret >> 8) & 0xf) | ((ret & 0xf) << 4);
+	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL0_REG);
+
+	if ((ret & 0x6) == 0x6)
+		data->tcpu_mask |= 1; /* TR1 */
+	if ((ret & 0x18) == 0x18)
+		data->tcpu_mask |= 2; /* TR2 */
+	if ((ret & 0x20) == 0x20)
+		data->tcpu_mask |= 4; /* TR3 */
+	if ((ret & 0x80) == 0x80)
+		data->tcpu_mask |= 8; /* TR4 */
+
+	/* LTD */
+	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL2_REG);
+	if ((ret & 0x02) == 0x02)
+		data->tcpu_mask |= 0x10;
+
+	/* Multi-Function detecting for Volt and TR/TD */
+	ret = nct7904_read_reg(data, BANK_0, VT_ADC_MD_REG);
+
+	for (i = 0; i < 4; i++) {
+		val = (ret & (0x03 << i)) >> (i * 2);
+		bit = (1 << i);
+		if (val == 0)
+			data->tcpu_mask &= ~bit;
+	}
+
+	/* PECI */
+	ret = nct7904_read_reg(data, BANK_2, PFE_REG);
+	if (ret & 0x80) {
+		data->enable_dts = 1; //Enable DTS & PECI
+	} else {
+		ret = nct7904_read_reg(data, BANK_2, TSI_CTRL_REG);
+		if (ret & 0x80)
+			data->enable_dts = 0x3; //Enable DTS & TSI
+	}
+
+	/* Check DTS enable status */
+	if (data->enable_dts) {
+		data->has_dts =
+			nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
+		if (data->enable_dts & 0x2) {
+			data->has_dts |=
+			(nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG) & 0xF)
+								<< 4;
+		}
+	}
 
 	for (i = 0; i < FANCTL_MAX; i++) {
 		ret = nct7904_read_reg(data, BANK_3, FANCTL1_FMR_REG + i);
-- 
2.17.1

