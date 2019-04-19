Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875AEC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBBF20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfDSS7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:59:40 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36960 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfDSS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:59:39 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id C6B953A7CBA;
        Fri, 19 Apr 2019 08:25:06 +0000 (UTC)
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D384A240007;
        Fri, 19 Apr 2019 08:25:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/6] rtc: ds2404: set range
Date:   Fri, 19 Apr 2019 10:24:56 +0200
Message-Id: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The real-time clock is a 5-byte binary counter. It is incremented 256 times
per second. The least significant byte is a count of fractional seconds.
The upper four bytes are a count of seconds. The realtime clock can
accumulate 136 years of seconds before rolling over.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds2404.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index b886b6a5c178..7b36c09bed10 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -234,6 +234,10 @@ static int rtc_probe(struct platform_device *pdev)
 
 	chip->ops = &ds2404_gpio_ops;
 
+	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(chip->rtc))
+		return PTR_ERR(chip->rtc);
+
 	retval = chip->ops->map_io(chip, pdev, pdata);
 	if (retval)
 		goto err_chip;
@@ -244,12 +248,12 @@ static int rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	chip->rtc = devm_rtc_device_register(&pdev->dev, "ds2404",
-					&ds2404_rtc_ops, THIS_MODULE);
-	if (IS_ERR(chip->rtc)) {
-		retval = PTR_ERR(chip->rtc);
+	chip->rtc->ops = &ds2404_rtc_ops;
+	chip->rtc->range_max = U32_MAX;
+
+	retval = rtc_register_device(chip->rtc);
+	if (retval)
 		goto err_io;
-	}
 
 	ds2404_enable_osc(&pdev->dev);
 	return 0;
-- 
2.20.1

