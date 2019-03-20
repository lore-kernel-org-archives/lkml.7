Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCC6213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfCTMop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:44:45 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54303 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfCTMoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:44:44 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 832CAFF80B;
        Wed, 20 Mar 2019 12:44:41 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: ps3: convert to devm_rtc_allocate_device
Date:   Wed, 20 Mar 2019 13:44:27 +0100
Message-Id: <20190320124428.14445-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124428.14445-1-alexandre.belloni@bootlin.com>
References: <20190320124428.14445-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ps3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ps3.c b/drivers/rtc/rtc-ps3.c
index 7e2a941a195b..f8b56f3b2529 100644
--- a/drivers/rtc/rtc-ps3.c
+++ b/drivers/rtc/rtc-ps3.c
@@ -47,13 +47,15 @@ static int __init ps3_rtc_probe(struct platform_device *dev)
 {
 	struct rtc_device *rtc;
 
-	rtc = devm_rtc_device_register(&dev->dev, "rtc-ps3", &ps3_rtc_ops,
-				  THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&dev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &ps3_rtc_ops;
+
 	platform_set_drvdata(dev, rtc);
-	return 0;
+
+	return rtc_register_device(rtc);
 }
 
 static struct platform_driver ps3_rtc_driver = {
-- 
2.20.1

