Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77252C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F9C2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfIEGqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:46:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfIEGqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:46:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 752D65998B31670E5797;
        Thu,  5 Sep 2019 14:46:21 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 14:46:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tony@atomide.com>, <udeep.dutt@intel.com>,
        <ashutosh.dixit@intel.com>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <jonathanh@nvidia.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>
CC:     <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4/4] rtc: ds1347: Use PTR_ERR_OR_ZERO rather than its implementation
Date:   Thu, 5 Sep 2019 14:43:15 +0800
Message-ID: <1567665795-5901-5-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1567665795-5901-1-git-send-email-zhongjiang@huawei.com>
References: <1567665795-5901-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR. It is better to
use it directly. hence just replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/rtc/rtc-ds1347.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index d392a7b..5a64eea 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -151,10 +151,7 @@ static int ds1347_probe(struct spi_device *spi)
 	rtc = devm_rtc_device_register(&spi->dev, "ds1347",
 				&ds1347_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(rtc);
 }
 
 static struct spi_driver ds1347_driver = {
-- 
1.7.12.4

