Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27EFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A03206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfHFCkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 22:40:24 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:62562 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfHFCkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:40:24 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 22:40:23 EDT
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td972e39214ac1401c81b6c@ACLMS3.advantech.com.tw>;
 Tue, 6 Aug 2019 10:30:19 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v4 1/2] hwmon: (nct7904) Fix the incorrect return value of case hwmon_fan_min in function "nct7904_write_fan".
Date:   Tue, 6 Aug 2019 02:30:07 +0000
Message-ID: <d1b58bc36bcb0204bca811d97a8ef1063fe876e0.1565006479.git.amy.shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.28]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

Return the -EINVAL(Invalid argument) when writing the values <= 0
to sysfs node fan[1-*]_min.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Changes in v4:
- Fix the incorrect return value of case hwmon_fan_min in function "nct7904_write_fan".
Changes in v3:
- Squashed subsequent fixes of below patches into one patch.

-- Fix bad fallthrough in various switch statements.
-- Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
-- Fix incorrect register setting of voltage.
-- Fix incorrect register bit mapping of temperature alarm.
-- Fix wrong return code 0x1fff in function nct7904_write_fan.
-- Delete wrong comment in function nct7904_write_in.
-- Fix wrong attribute names for temperature.
-- Fix wrong registers setting for temperature.

Changes in v2:
- Fix bad fallthrough in various switch statements.
- Fix the wrong declared of tmp as u8 in nct7904_write_in, declared tmp to int.
---
 drivers/hwmon/nct7904.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index d842c10ba11f..6527b56e4f6c 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -551,7 +551,7 @@ static int nct7904_write_fan(struct device *dev, u32 attr, int channel,
 	switch (attr) {
 	case hwmon_fan_min:
 		if (val <= 0)
-			return 0;
+			return -EINVAL;
 
 		val = clamp_val((1350000 + (val >> 1)) / val, 1, 0x1fff);
 		tmp = (val >> 5) & 0xff;
-- 
2.17.1

