Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF824C31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130521C38
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfFQIMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:12:15 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:52438 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:12:14 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td8729e9aafac14014b1070@ACLMS1.advantech.com.tw>;
 Mon, 17 Jun 2019 16:12:12 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2 4/9] hwmon: (nct7904) Fix incorrect register setting for the high value high limit of voltage.
Date:   Mon, 17 Jun 2019 08:11:50 +0000
Message-ID: <c89b56e49cf08098f07175a02ac18460e20aff8b.1560756733.git.amy.shih@advantech.com.tw>
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

In function nct7904_write_in, the high value high limit of voltage
registers should be VSEN1_HV_HL_REG.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
Changes in v2:
- Fix incorrect register setting of voltage.

 drivers/hwmon/nct7904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index cdd67932938d..402c1bb2a99f 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -615,12 +615,12 @@ static int nct7904_write_in(struct device *dev, u32 attr, int channel,
 		if (ret < 0)
 			return ret;
 		tmp = nct7904_read_reg(data, BANK_1,
-				       VSEN1_HV_LL_REG + index * 4);
+				       VSEN1_HV_HL_REG + index * 4);
 		if (tmp < 0)
 			return tmp;
 		tmp = (val >> 3) & 0xff;
 		ret = nct7904_write_reg(data, BANK_1,
-					VSEN1_HV_LL_REG + index * 4, tmp);
+					VSEN1_HV_HL_REG + index * 4, tmp);
 		return ret;
 	default:
 		return -EOPNOTSUPP;
-- 
2.17.1

