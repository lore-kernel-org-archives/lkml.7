Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E700DC32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72D3206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfHFCkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 22:40:25 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:62562 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbfHFCkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:40:25 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 22:40:23 EDT
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td972e51551ac1401c81b6c@ACLMS3.advantech.com.tw>;
 Tue, 6 Aug 2019 10:31:59 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v4 2/2] hwmon: (nct7904) Fix the confused calculation of case hwmon_fan_min in function "nct7904_write_fan".
Date:   Tue, 6 Aug 2019 02:31:46 +0000
Message-ID: <83bd9eed7e19ffc8c064648ae00bf1c71b9d2815.1565006479.git.amy.shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d1b58bc36bcb0204bca811d97a8ef1063fe876e0.1565006479.git.amy.shih@advantech.com.tw>
References: <d1b58bc36bcb0204bca811d97a8ef1063fe876e0.1565006479.git.amy.shih@advantech.com.tw>
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

Use the macro "DIV_ROUND_CLOSEST" instead.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>

Changes in v4:
- Fix the confused calculation of case hwmon_fan_min in function
"nct7904_write_fan".
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
index 6527b56e4f6c..76372f20d71a 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -553,7 +553,7 @@ static int nct7904_write_fan(struct device *dev, u32 attr, int channel,
 		if (val <= 0)
 			return -EINVAL;
 
-		val = clamp_val((1350000 + (val >> 1)) / val, 1, 0x1fff);
+		val = clamp_val(DIV_ROUND_CLOSEST(1350000, val), 1, 0x1fff);
 		tmp = (val >> 5) & 0xff;
 		ret = nct7904_write_reg(data, BANK_1,
 					FANIN1_HV_HL_REG + channel * 2, tmp);
-- 
2.17.1

