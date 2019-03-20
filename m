Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CCDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CD02184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfCTMdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:33:11 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46383 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfCTMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:33:08 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E11BA100009;
        Wed, 20 Mar 2019 12:33:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 7/7] rtc: xgene: use .set_time
Date:   Wed, 20 Mar 2019 13:32:33 +0100
Message-Id: <20190320123233.13519-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
References: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-xgene.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index aef338428668..9888383f0088 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -49,7 +49,7 @@ static int xgene_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int xgene_rtc_set_mmss(struct device *dev, unsigned long secs)
+static int xgene_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 
@@ -57,7 +57,7 @@ static int xgene_rtc_set_mmss(struct device *dev, unsigned long secs)
 	 * NOTE: After the following write, the RTC_CCVR is only reflected
 	 *       after the update cycle of 1 seconds.
 	 */
-	writel((u32)secs, pdata->csr_base + RTC_CLR);
+	writel((u32)rtc_tm_to_time64(tm), pdata->csr_base + RTC_CLR);
 	readl(pdata->csr_base + RTC_CLR); /* Force a barrier */
 
 	return 0;
@@ -112,7 +112,7 @@ static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static const struct rtc_class_ops xgene_rtc_ops = {
 	.read_time	= xgene_rtc_read_time,
-	.set_mmss	= xgene_rtc_set_mmss,
+	.set_time	= xgene_rtc_set_time,
 	.read_alarm	= xgene_rtc_read_alarm,
 	.set_alarm	= xgene_rtc_set_alarm,
 	.alarm_irq_enable = xgene_rtc_alarm_irq_enable,
-- 
2.20.1

