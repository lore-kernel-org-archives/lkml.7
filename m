Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D11C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D563F20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfDSTBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:01:24 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38444 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfDSTBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:20 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 646EC3AAF05;
        Fri, 19 Apr 2019 08:00:20 +0000 (UTC)
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 830EDFF809;
        Fri, 19 Apr 2019 08:00:19 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/8] rtc: ep93xx: use .set_time
Date:   Fri, 19 Apr 2019 10:00:03 +0200
Message-Id: <20190419080005.16138-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419080005.16138-1-alexandre.belloni@bootlin.com>
References: <20190419080005.16138-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ep93xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 60e390c6ef06..a243bd85b842 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -63,9 +63,10 @@ static int ep93xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int ep93xx_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int ep93xx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct ep93xx_rtc *ep93xx_rtc = dev_get_platdata(dev);
+	unsigned long secs = rtc_tm_to_time64(tm);
 
 	writel(secs + 1, ep93xx_rtc->mmio_base + EP93XX_RTC_LOAD);
 	return 0;
@@ -85,7 +86,7 @@ static int ep93xx_rtc_proc(struct device *dev, struct seq_file *seq)
 
 static const struct rtc_class_ops ep93xx_rtc_ops = {
 	.read_time	= ep93xx_rtc_read_time,
-	.set_mmss	= ep93xx_rtc_set_mmss,
+	.set_time	= ep93xx_rtc_set_time,
 	.proc		= ep93xx_rtc_proc,
 };
 
-- 
2.20.1

