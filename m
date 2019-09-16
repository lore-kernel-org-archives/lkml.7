Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDEC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9C22077C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfIPCS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:18:57 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:49107 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfIPCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:18:57 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tda45fdd0e4ac14014bf38@ACLMS1.advantech.com.tw>;
 Mon, 16 Sep 2019 10:18:52 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <bichan.lu@advantech.com.tw>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v1,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask in nct7904_data struct.
Date:   Mon, 16 Sep 2019 10:18:36 +0800
Message-ID: <20190916021836.1945-1-Amy.Shih@advantech.com.tw>
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

Voltage sensors overlap with external temperature sensors. Detect
the multi-function of voltage, thermal diode and thermistor from
register VT_ADC_MD_REG to set value of vsen_mask in nct7904_data
struct.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 95b447cfa24c..ad61c3d92411 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -919,8 +919,11 @@ static int nct7904_probe(struct i2c_client *client,
 		bit = (1 << i);
 		if (val == 0)
 			data->tcpu_mask &= ~bit;
-		else if (val == 0x1 || val == 0x2)
+		else if (val == 0x1 || val == 0x2) {
 			data->temp_mode |= bit;
+			data->vsen_mask &= ~(0x06 << (i * 2));
+		} else
+			data->vsen_mask &= ~(0x06 << (i * 2));
 	}
 
 	/* PECI */
-- 
2.17.1

