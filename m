Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B341C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1E4218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfCVHNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:13:44 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35073 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfCVHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:13:41 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 26748200003;
        Fri, 22 Mar 2019 07:13:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] rtc: wm831x: remove unnecessary goto
Date:   Fri, 22 Mar 2019 08:13:26 +0100
Message-Id: <20190322071328.16123-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322071328.16123-1-alexandre.belloni@bootlin.com>
References: <20190322071328.16123-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no specific handling in the error path of wm831x_rtc_probe, remove
the unnecessary goto and label.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-wm831x.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index deaffe0eaf2f..1b0c3b3f63e8 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -429,7 +429,7 @@ static int wm831x_rtc_probe(struct platform_device *pdev)
 	ret = wm831x_reg_read(wm831x, WM831X_RTC_CONTROL);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to read RTC control: %d\n", ret);
-		goto err;
+		return ret;
 	}
 	if (ret & WM831X_RTC_ALM_ENA)
 		wm831x_rtc->alarm_enabled = 1;
@@ -459,9 +459,6 @@ static int wm831x_rtc_probe(struct platform_device *pdev)
 	wm831x_rtc_add_randomness(wm831x);
 
 	return 0;
-
-err:
-	return ret;
 }
 
 static const struct dev_pm_ops wm831x_rtc_pm_ops = {
-- 
2.20.1

