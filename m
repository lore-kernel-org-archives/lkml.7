Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F236C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E74021C38
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfFQIN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:13:58 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:39229 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:13:58 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td872a02fbdac1401c810b8@ACLMS3.advantech.com.tw>;
 Mon, 17 Jun 2019 16:13:56 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2 5/9] hwmon: (nct7904) Fix incorrect register bit mapping of temperature alarm.
Date:   Mon, 17 Jun 2019 08:12:30 +0000
Message-ID: <87e748a5f2e7d8e6ef69fa5acb177cb0a1474cb2.1560756733.git.amy.shih@advantech.com.tw>
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

In function nct7904_read_temp, the bit to shift for register
SMI_STS1_REG should be bit 1 & 3 & 5 &7 for TEMP_CH1~4.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
Changes in v2:
- Fix incorrect register bit mapping of temperature alarm.

 drivers/hwmon/nct7904.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 402c1bb2a99f..95348eebe8e4 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -356,7 +356,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 					       SMI_STS1_REG);
 			if (ret < 0)
 				return ret;
-			*val = (ret >> (channel & 0x07)) & 1;
+			*val = (ret >> (((channel * 2) + 1) & 0x07)) & 1;
 		} else {
 			if ((channel - 5) < 4) {
 				ret = nct7904_read_reg(data, BANK_0,
-- 
2.17.1

