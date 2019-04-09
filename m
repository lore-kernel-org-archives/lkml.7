Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A819EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC9E20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfDIKQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:16:43 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38883 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDIKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:16:41 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AD2C7240006;
        Tue,  9 Apr 2019 10:16:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/6] rtc: lpc32xx: simplify IRQ setup
Date:   Tue,  9 Apr 2019 12:16:28 +0200
Message-Id: <20190409101631.5116-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409101631.5116-1-alexandre.belloni@bootlin.com>
References: <20190409101631.5116-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the optional IRQ setup to a single location.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lpc32xx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index f9e899fc4889..652b969158d4 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -199,21 +199,13 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct lpc32xx_rtc *rtc;
-	int rtcirq, err;
+	int err;
 	u32 tmp;
 
-	rtcirq = platform_get_irq(pdev, 0);
-	if (rtcirq < 0) {
-		dev_warn(&pdev->dev, "Can't get interrupt resource\n");
-		rtcirq = -1;
-	}
-
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (unlikely(!rtc))
 		return -ENOMEM;
 
-	rtc->irq = rtcirq;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->rtc_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rtc->rtc_base))
@@ -269,7 +261,10 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 	 * IRQ is enabled after device registration in case alarm IRQ
 	 * is pending upon suspend exit.
 	 */
-	if (rtc->irq >= 0) {
+	rtc->irq = platform_get_irq(pdev, 0);
+	if (rtc->irq < 0) {
+		dev_warn(&pdev->dev, "Can't get interrupt resource\n");
+	} else {
 		if (devm_request_irq(&pdev->dev, rtc->irq,
 				     lpc32xx_rtc_alarm_interrupt,
 				     0, pdev->name, rtc) < 0) {
-- 
2.20.1

