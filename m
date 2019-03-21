Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758FE218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfCUKQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:16:06 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34783 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:16:06 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A8882C0010;
        Thu, 21 Mar 2019 10:16:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-renesas-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: da9063: set range
Date:   Thu, 21 Mar 2019 11:15:56 +0100
Message-Id: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9062 and DA9063 have a year register that can go up to 0x3F.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-da9063.c | 9 ++++++---
 include/linux/rtc.h      | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 73b38d207d7e..b7052156e851 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -464,11 +464,14 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, DA9063_DRVNAME_RTC,
-					   &da9063_rtc_ops, THIS_MODULE);
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
+	rtc->rtc_dev->ops = &da9063_rtc_ops;
+	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->rtc_dev->range_max = RTC_TIMESTAMP_END_2063;
+
 	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
 	rtc->rtc_sync = false;
 
@@ -481,7 +484,7 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
 			irq_alarm, ret);
 
-	return ret;
+	return rtc_register_device(rtc->rtc_dev);
 }
 
 static struct platform_driver da9063_rtc_driver = {
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 588120ba372c..09fb4af5edab 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -164,6 +164,7 @@ struct rtc_device {
 /* useful timestamps */
 #define RTC_TIMESTAMP_BEGIN_1900	-2208989361LL /* 1900-01-01 00:00:00 */
 #define RTC_TIMESTAMP_BEGIN_2000	946684800LL /* 2000-01-01 00:00:00 */
+#define RTC_TIMESTAMP_END_2063		2966371199LL /* 2063-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_9999		253402300799LL /* 9999-12-31 23:59:59 */
 
-- 
2.20.1

