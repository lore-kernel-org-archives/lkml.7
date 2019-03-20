Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E107C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F4E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfCTMeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:34:24 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:49149 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfCTMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:34:24 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C3317200013;
        Wed, 20 Mar 2019 12:34:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/6] rtc: goldfish: convert to devm_rtc_allocate_device
Date:   Wed, 20 Mar 2019 13:34:12 +0100
Message-Id: <20190320123417.13724-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-goldfish.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
index a1c44d0c8557..d4cb33f209fb 100644
--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -205,19 +205,19 @@ static int goldfish_rtc_probe(struct platform_device *pdev)
 	if (rtcdrv->irq < 0)
 		return -ENODEV;
 
-	rtcdrv->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					       &goldfish_rtc_ops,
-					       THIS_MODULE);
+	rtcdrv->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtcdrv->rtc))
 		return PTR_ERR(rtcdrv->rtc);
 
+	rtcdrv->rtc->ops = &goldfish_rtc_ops;
+
 	err = devm_request_irq(&pdev->dev, rtcdrv->irq,
 			       goldfish_rtc_interrupt,
 			       0, pdev->name, rtcdrv);
 	if (err)
 		return err;
 
-	return 0;
+	return rtc_register_device(rtcdrv->rtc);
 }
 
 static const struct of_device_id goldfish_rtc_of_match[] = {
-- 
2.20.1

