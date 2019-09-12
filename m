Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A18ECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F288214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfILDnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 23:43:35 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:60492 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfILDnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 23:43:35 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 23:43:32 EDT
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tda31a8ab12ac1401c8187c@ACLMS3.advantech.com.tw>;
 Thu, 12 Sep 2019 11:33:27 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <bichan.lu@advantech.com.tw>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v1,1/1] hwmon: (nct7904) Fix incorrect SMI status register setting of LTD temperature and fan.
Date:   Thu, 12 Sep 2019 11:33:00 +0000
Message-ID: <20190912113300.4714-1-Amy.Shih@advantech.com.tw>
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

According to datasheet, the SMI status register setting of LTD
temperature is SMI_STS3, and the SMI status register setting
of fan is SMI_STS5 and SMI_STS6.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index ce688ab4fce2..95b447cfa24c 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -51,6 +51,7 @@
 #define VSEN1_HV_HL_REG		0x00	/* Bank 1; 2 regs (HV/LV) per sensor */
 #define VSEN1_LV_HL_REG		0x01	/* Bank 1; 2 regs (HV/LV) per sensor */
 #define SMI_STS1_REG		0xC1	/* Bank 0; SMI Status Register */
+#define SMI_STS3_REG		0xC3	/* Bank 0; SMI Status Register */
 #define SMI_STS5_REG		0xC5	/* Bank 0; SMI Status Register */
 #define SMI_STS7_REG		0xC7	/* Bank 0; SMI Status Register */
 #define SMI_STS8_REG		0xC8	/* Bank 0; SMI Status Register */
@@ -210,7 +211,7 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
 		return 0;
 	case hwmon_fan_alarm:
 		ret = nct7904_read_reg(data, BANK_0,
-				       SMI_STS7_REG + (channel >> 3));
+				       SMI_STS5_REG + (channel >> 3));
 		if (ret < 0)
 			return ret;
 		*val = (ret >> (channel & 0x07)) & 1;
@@ -351,7 +352,13 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 		*val = sign_extend32(temp, 10) * 125;
 		return 0;
 	case hwmon_temp_alarm:
-		if (channel < 5) {
+		if (channel == 4) {
+			ret = nct7904_read_reg(data, BANK_0,
+					       SMI_STS3_REG);
+			if (ret < 0)
+				return ret;
+			*val = (ret >> 1) & 1;
+		} else if (channel < 4) {
 			ret = nct7904_read_reg(data, BANK_0,
 					       SMI_STS1_REG);
 			if (ret < 0)
-- 
2.17.1

