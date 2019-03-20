Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB40C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038A92184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfCTMk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:40:56 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49495 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfCTMk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:40:56 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 12751240009;
        Wed, 20 Mar 2019 12:40:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/6] rtc: at91sam9: convert to devm_rtc_allocate_device
Date:   Wed, 20 Mar 2019 13:40:38 +0100
Message-Id: <20190320124042.14141-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
References: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91sam9.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7ec114b59513..cbbf8121dca0 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -418,13 +418,14 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	mr &= ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN);
 	rtt_writel(rtc, MR, mr);
 
-	rtc->rtcdev = devm_rtc_device_register(&pdev->dev, pdev->name,
-					&at91_rtc_ops, THIS_MODULE);
+	rtc->rtcdev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtcdev)) {
 		ret = PTR_ERR(rtc->rtcdev);
 		goto err_clk;
 	}
 
+	rtc->rtcdev->ops = &at91_rtc_ops;
+
 	/* register irq handler after we know what name we'll use */
 	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
 			       IRQF_SHARED | IRQF_COND_SUSPEND,
@@ -444,7 +445,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "%s: SET TIME!\n",
 				dev_name(&rtc->rtcdev->dev));
 
-	return 0;
+	return rtc_register_device(rtc->rtcdev);
 
 err_clk:
 	clk_disable_unprepare(rtc->sclk);
-- 
2.20.1

