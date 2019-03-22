Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7256BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EAE218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfCVHNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:13:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58103 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfCVHNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:13:38 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BD19120004;
        Fri, 22 Mar 2019 07:13:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: wm831x: set range
Date:   Fri, 22 Mar 2019 08:13:25 +0100
Message-Id: <20190322071328.16123-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm831x has a 32bit second counter.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-wm831x.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 7b824dabf104..deaffe0eaf2f 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -436,12 +436,16 @@ static int wm831x_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	wm831x_rtc->rtc = devm_rtc_device_register(&pdev->dev, "wm831x",
-					      &wm831x_rtc_ops, THIS_MODULE);
-	if (IS_ERR(wm831x_rtc->rtc)) {
-		ret = PTR_ERR(wm831x_rtc->rtc);
-		goto err;
-	}
+	wm831x_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(wm831x_rtc->rtc))
+		return PTR_ERR(wm831x_rtc->rtc);
+
+	wm831x_rtc->rtc->ops = &wm831x_rtc_ops;
+	wm831x_rtc->rtc->range_max = U32_MAX;
+
+	ret = rtc_register_device(wm831x_rtc->rtc);
+	if (ret)
+		return ret;
 
 	ret = devm_request_threaded_irq(&pdev->dev, alm_irq, NULL,
 				wm831x_alm_irq,
-- 
2.20.1

