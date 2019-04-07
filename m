Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD0C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1F72083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDGVMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:12:36 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54997 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDGVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:12:35 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 859BA1C0002;
        Sun,  7 Apr 2019 21:12:33 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: stmp3xxx: set range
Date:   Sun,  7 Apr 2019 23:12:20 +0200
Message-Id: <20190407211223.14265-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the datasheet: "HW_RTC_SECONDS provides access to the 32-bit real-time
seconds counter."

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stmp3xxx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index b76318fd5bb0..a6a2963e89a5 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -361,8 +361,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 			STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
 		rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 
-	rtc_data->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				&stmp3xxx_rtc_ops, THIS_MODULE);
+	rtc_data->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc_data->rtc))
 		return PTR_ERR(rtc_data->rtc);
 
@@ -374,6 +373,13 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	rtc_data->rtc->ops = &stmp3xxx_rtc_ops;
+	rtc_data->rtc->range_max = U32_MAX;
+
+	err = rtc_register_device(rtc_data->rtc);
+	if (err)
+		return err;
+
 	stmp3xxx_wdt_register(pdev);
 	return 0;
 }
-- 
2.20.1

