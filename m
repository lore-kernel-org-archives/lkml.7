Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE81C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563C6217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbfISDCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:02:43 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:46280 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfISDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:02:43 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tda5598ff72ac1401c8e70@ACLMS3.advantech.com.tw>;
 Thu, 19 Sep 2019 11:02:40 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <bichan.lu@advantech.com.tw>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v1,1/1] hwmon: (nct7904) Add array fan_alarm and vsen_alarm to store the alarms in nct7904_data struct.
Date:   Thu, 19 Sep 2019 11:02:05 +0800
Message-ID: <20190919030205.11440-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.114]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

SMI# interrupt for fan and voltage is Two-Times Interrupt Mode.
Fan or voltage exceeds high limit or going below low limit,
it will causes an interrupt if the previous interrupt has been
reset by reading all the interrupt Status Register. Thus, add the
array fan_alarm and vsen_alarm to store the alarms for all of the
fan and voltage sensors.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index f62dd1882451..b26419dbe840 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -99,6 +99,8 @@ struct nct7904_data {
 	u8 enable_dts;
 	u8 has_dts;
 	u8 temp_mode; /* 0: TR mode, 1: TD mode */
+	u8 fan_alarm[2];
+	u8 vsen_alarm[3];
 };
 
 /* Access functions */
@@ -214,7 +216,15 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
 				       SMI_STS5_REG + (channel >> 3));
 		if (ret < 0)
 			return ret;
-		*val = (ret >> (channel & 0x07)) & 1;
+		if (!data->fan_alarm[channel >> 3])
+			data->fan_alarm[channel >> 3] = ret & 0xff;
+		else
+			/* If there is new alarm showing up */
+			data->fan_alarm[channel >> 3] |= (ret & 0xff);
+		*val = (data->fan_alarm[channel >> 3] >> (channel & 0x07)) & 1;
+		/* Needs to clean the alarm if alarm existing */
+		if (*val)
+			data->fan_alarm[channel >> 3] ^= 1 << (channel & 0x07);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -298,7 +308,15 @@ static int nct7904_read_in(struct device *dev, u32 attr, int channel,
 				       SMI_STS1_REG + (index >> 3));
 		if (ret < 0)
 			return ret;
-		*val = (ret >> (index & 0x07)) & 1;
+		if (!data->vsen_alarm[index >> 3])
+			data->vsen_alarm[index >> 3] = ret & 0xff;
+		else
+			/* If there is new alarm showing up */
+			data->vsen_alarm[index >> 3] |= (ret & 0xff);
+		*val = (data->vsen_alarm[index >> 3] >> (index & 0x07)) & 1;
+		/* Needs to clean the alarm if alarm existing */
+		if (*val)
+			data->vsen_alarm[index >> 3] ^= 1 << (index & 0x07);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
-- 
2.17.1

