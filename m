Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE57C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A65C20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDIUAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60303 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfDIUAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:00:00 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 24E81E0003;
        Tue,  9 Apr 2019 19:59:57 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: ab3100: set range
Date:   Tue,  9 Apr 2019 21:59:43 +0200
Message-Id: <20190409195945.20725-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ab3100 has a 48bit counter running at 65536 Hz (despite one of the
comment). The max value is then (2^48 - 1)/2^16 == 2^32 - 1.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab3100.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ab3100.c b/drivers/rtc/rtc-ab3100.c
index 821ff52a2222..f73a3707b897 100644
--- a/drivers/rtc/rtc-ab3100.c
+++ b/drivers/rtc/rtc-ab3100.c
@@ -228,15 +228,17 @@ static int __init ab3100_rtc_probe(struct platform_device *pdev)
 		/* Ignore any error on this write */
 	}
 
-	rtc = devm_rtc_device_register(&pdev->dev, "ab3100-rtc",
-					&ab3100_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		err = PTR_ERR(rtc);
-		return err;
-	}
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	rtc->ops = &ab3100_rtc_ops;
+	/* 48bit counter at (AB3100_RTC_CLOCK_RATE * 2) */
+	rtc->range_max = U32_MAX;
+
 	platform_set_drvdata(pdev, rtc);
 
-	return 0;
+	return rtc_register_device(rtc);
 }
 
 static struct platform_driver ab3100_rtc_driver = {
-- 
2.20.1

