Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4188CC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2082820652
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfFQIXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:23:22 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:53019 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfFQIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:23:22 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td872a8c9b5ac14014b1070@ACLMS1.advantech.com.tw>;
 Mon, 17 Jun 2019 16:23:20 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2 9/9] hwmon: (nct7904) Fix wrong registers setting for temperature.
Date:   Mon, 17 Jun 2019 08:22:55 +0000
Message-ID: <9b03a23bbb5385658c21bf5129a5b1c9b5065237.1560756733.git.amy.shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <928e46508bbe1ebc0763c3d2403a5aebe95af552.1560756733.git.amy.shih@advantech.com.tw>
References: <928e46508bbe1ebc0763c3d2403a5aebe95af552.1560756733.git.amy.shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.58]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

For "attributes temp[1-*]_max" and "temp[1-*]_max_hyst", should
show the reading of "WARNING TEMPERATURE" and "WARNING TEMPERATURE
HYSTERESIS" registers. For attribute "temp[1-*]_crit" and
"temp[1-*]_crit_hyst", shuld show the reading of "CRITICAL TEMPERATURE"
and "CRITICAL TEMPERATURE HYSTERESIS" registers in datasheet.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
Changes in v2:
- Fix wrong registers setting for temperature.

 drivers/hwmon/nct7904.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index fc145c73a4e7..d842c10ba11f 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -399,23 +399,23 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 		return 0;
 	case hwmon_temp_max:
 		reg1 = LTD_HV_HL_REG;
-		reg2 = TEMP_CH1_C_REG;
-		reg3 = DTS_T_CPU1_C_REG;
+		reg2 = TEMP_CH1_W_REG;
+		reg3 = DTS_T_CPU1_W_REG;
 		break;
 	case hwmon_temp_max_hyst:
 		reg1 = LTD_LV_HL_REG;
-		reg2 = TEMP_CH1_CH_REG;
-		reg3 = DTS_T_CPU1_CH_REG;
+		reg2 = TEMP_CH1_WH_REG;
+		reg3 = DTS_T_CPU1_WH_REG;
 		break;
 	case hwmon_temp_crit:
 		reg1 = LTD_HV_LL_REG;
-		reg2 = TEMP_CH1_W_REG;
-		reg3 = DTS_T_CPU1_W_REG;
+		reg2 = TEMP_CH1_C_REG;
+		reg3 = DTS_T_CPU1_C_REG;
 		break;
 	case hwmon_temp_crit_hyst:
 		reg1 = LTD_LV_LL_REG;
-		reg2 = TEMP_CH1_WH_REG;
-		reg3 = DTS_T_CPU1_WH_REG;
+		reg2 = TEMP_CH1_CH_REG;
+		reg3 = DTS_T_CPU1_CH_REG;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -508,23 +508,23 @@ static int nct7904_write_temp(struct device *dev, u32 attr, int channel,
 	switch (attr) {
 	case hwmon_temp_max:
 		reg1 = LTD_HV_HL_REG;
-		reg2 = TEMP_CH1_C_REG;
-		reg3 = DTS_T_CPU1_C_REG;
+		reg2 = TEMP_CH1_W_REG;
+		reg3 = DTS_T_CPU1_W_REG;
 		break;
 	case hwmon_temp_max_hyst:
 		reg1 = LTD_LV_HL_REG;
-		reg2 = TEMP_CH1_CH_REG;
-		reg3 = DTS_T_CPU1_CH_REG;
+		reg2 = TEMP_CH1_WH_REG;
+		reg3 = DTS_T_CPU1_WH_REG;
 		break;
 	case hwmon_temp_crit:
 		reg1 = LTD_HV_LL_REG;
-		reg2 = TEMP_CH1_W_REG;
-		reg3 = DTS_T_CPU1_W_REG;
+		reg2 = TEMP_CH1_C_REG;
+		reg3 = DTS_T_CPU1_C_REG;
 		break;
 	case hwmon_temp_crit_hyst:
 		reg1 = LTD_LV_LL_REG;
-		reg2 = TEMP_CH1_WH_REG;
-		reg3 = DTS_T_CPU1_WH_REG;
+		reg2 = TEMP_CH1_CH_REG;
+		reg3 = DTS_T_CPU1_CH_REG;
 		break;
 	default:
 		return -EOPNOTSUPP;
-- 
2.17.1

