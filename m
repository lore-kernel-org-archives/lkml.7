Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C83F2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfCTMc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:32:59 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36883 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfCTMc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:32:58 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BC69120000C;
        Wed, 20 Mar 2019 12:32:55 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/7] rtc: xgene: correct checkpatch issues
Date:   Wed, 20 Mar 2019 13:32:30 +0100
Message-Id: <20190320123233.13519-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
References: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct trivial whitespace issues. Also sort the headers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-xgene.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index ba9121d02f02..eb745deda936 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -7,15 +7,15 @@
  *         Loc Ho <lho@apm.com>
  */
 
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/rtc.h>
+#include <linux/slab.h>
 
 /* RTC CSR Registers */
 #define RTC_CCVR		0x00
@@ -58,7 +58,7 @@ static int xgene_rtc_set_mmss(struct device *dev, unsigned long secs)
 	 * NOTE: After the following write, the RTC_CCVR is only reflected
 	 *       after the update cycle of 1 seconds.
 	 */
-	writel((u32) secs, pdata->csr_base + RTC_CLR);
+	writel((u32)secs, pdata->csr_base + RTC_CLR);
 	readl(pdata->csr_base + RTC_CLR); /* Force a barrier */
 
 	return 0;
@@ -106,7 +106,7 @@ static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	rtc_tm_to_time(&alrm->time, &alarm_time);
 	pdata->alarm_time = alarm_time;
-	writel((u32) pdata->alarm_time, pdata->csr_base + RTC_CMR);
+	writel((u32)pdata->alarm_time, pdata->csr_base + RTC_CMR);
 
 	xgene_rtc_alarm_irq_enable(dev, alrm->enabled);
 
@@ -123,7 +123,7 @@ static const struct rtc_class_ops xgene_rtc_ops = {
 
 static irqreturn_t xgene_rtc_interrupt(int irq, void *id)
 {
-	struct xgene_rtc_dev *pdata = (struct xgene_rtc_dev *) id;
+	struct xgene_rtc_dev *pdata = id;
 
 	/* Check if interrupt asserted */
 	if (!(readl(pdata->csr_base + RTC_STAT) & RTC_STAT_BIT))
-- 
2.20.1

