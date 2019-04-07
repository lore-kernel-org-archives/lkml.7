Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F13C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B9E2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDGVKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:10:35 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47653 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:10:35 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1E9E11BF204;
        Sun,  7 Apr 2019 21:10:32 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: coh901331: set range
Date:   Sun,  7 Apr 2019 23:10:24 +0200
Message-Id: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The COH 901 331 is a 32bit seconds counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-coh901331.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 0b232c84f674..5b214db919d0 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -188,6 +188,13 @@ static int __init coh901331_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	rtap->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtap->rtc))
+		return PTR_ERR(rtap->rtc);
+
+	rtap->rtc->ops = &coh901331_ops;
+	rtap->rtc->range_max = U32_MAX;
+
 	/* We enable/disable the clock only to assure it works */
 	ret = clk_prepare_enable(rtap->clk);
 	if (ret) {
@@ -197,12 +204,10 @@ static int __init coh901331_probe(struct platform_device *pdev)
 	clk_disable(rtap->clk);
 
 	platform_set_drvdata(pdev, rtap);
-	rtap->rtc = devm_rtc_device_register(&pdev->dev, "coh901331",
-					&coh901331_ops, THIS_MODULE);
-	if (IS_ERR(rtap->rtc)) {
-		ret = PTR_ERR(rtap->rtc);
+
+	ret = rtc_register_device(rtap->rtc);
+	if (ret)
 		goto out_no_rtc;
-	}
 
 	return 0;
 
-- 
2.20.1

