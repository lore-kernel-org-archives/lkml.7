Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27A1206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfCVHXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:23:08 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39199 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCVHXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:23:07 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DF388100009;
        Fri, 22 Mar 2019 07:23:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: sun4v: set range
Date:   Fri, 22 Mar 2019 08:22:55 +0100
Message-Id: <20190322072256.17108-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322072256.17108-1-alexandre.belloni@bootlin.com>
References: <20190322072256.17108-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sun4v Hypervisor Core API Specification states:
Time is described by a single unsigned 64-bit word equivalent to a time_t
for the POSIX time(2) system call. The word contains the time since the
Epoch (00:00:00 UTC, January 1, 1970), measured in seconds.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sun4v.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sun4v.c b/drivers/rtc/rtc-sun4v.c
index 378081fffa91..82fb51f79c6e 100644
--- a/drivers/rtc/rtc-sun4v.c
+++ b/drivers/rtc/rtc-sun4v.c
@@ -78,13 +78,15 @@ static int __init sun4v_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 
-	rtc = devm_rtc_device_register(&pdev->dev, "sun4v",
-				&sun4v_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &sun4v_rtc_ops;
+	rtc->range_max = U64_MAX;
 	platform_set_drvdata(pdev, rtc);
-	return 0;
+
+	return rtc_register_device(rtc);
 }
 
 static struct platform_driver sun4v_rtc_driver = {
-- 
2.20.1

