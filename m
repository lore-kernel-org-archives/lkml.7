Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA338C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF321897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfIRIsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:48:23 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:13090 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfIRIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:48:23 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tda51af12ecac14014bf38@ACLMS1.advantech.com.tw>;
 Wed, 18 Sep 2019 16:48:18 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <bichan.lu@advantech.com.tw>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v3,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask in nct7904_data struct.
Date:   Wed, 18 Sep 2019 16:48:00 +0800
Message-ID: <20190918084801.9859-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.115]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

Voltage sensors overlap with external temperature sensors. Detect
the multi-function of voltage, thermal diode and thermistor from
register VT_ADC_MD_REG to set value of vsen_mask in nct7904_data
struct.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
Changes in v3:
- Simplified the bit map.
- Modified the if statement.
Changes in v2:
- Moved the if statement to outside.

 drivers/hwmon/nct7904.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 95b447cfa24c..f62dd1882451 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -915,12 +915,15 @@ static int nct7904_probe(struct i2c_client *client,
 
 	data->temp_mode = 0;
 	for (i = 0; i < 4; i++) {
-		val = (ret & (0x03 << i)) >> (i * 2);
+		val = (ret >> (i * 2)) & 0x03;
 		bit = (1 << i);
-		if (val == 0)
+		if (val == 0) {
 			data->tcpu_mask &= ~bit;
-		else if (val == 0x1 || val == 0x2)
-			data->temp_mode |= bit;
+		} else {
+			if (val == 0x1 || val == 0x2)
+				data->temp_mode |= bit;
+			data->vsen_mask &= ~(0x06 << (i * 2));
+		}
 	}
 
 	/* PECI */
-- 
2.17.1

