Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB79C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996B6216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfGZODh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:03:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfGZODh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:03:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8BDE6CA4AD68E482E6F4;
        Fri, 26 Jul 2019 22:03:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 22:03:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <shobhitkukreti@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: remove set but not used variable 'bWifiBusy'
Date:   Fri, 26 Jul 2019 22:03:21 +0800
Message-ID: <20190726140321.19200-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

 In function halbtc8723b1ant_TdmaDurationAdjustForAcl:
drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c:1761:7: warning:
 variable bWifiBusy set but not used [-Wunused-but-set-variable]

It is never used so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 8e4caee..dd349c5 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1758,7 +1758,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 	static s32 up, dn, m, n, WaitCount;
 	s32 result;   /* 0: no change, +1: increase WiFi duration, -1: decrease WiFi duration */
 	u8 retryCount = 0, btInfoExt;
-	bool bWifiBusy = false;
 
 	BTC_PRINT(
 		BTC_MSG_ALGORITHM,
@@ -1766,11 +1765,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 		("[BTCoex], TdmaDurationAdjustForAcl()\n")
 	);
 
-	if (BT_8723B_1ANT_WIFI_STATUS_CONNECTED_BUSY == wifiStatus)
-		bWifiBusy = true;
-	else
-		bWifiBusy = false;
-
 	if (
 		(BT_8723B_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN == wifiStatus) ||
 		(BT_8723B_1ANT_WIFI_STATUS_CONNECTED_SCAN == wifiStatus) ||
-- 
2.7.4


