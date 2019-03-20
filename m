Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ECDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF692184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfCTMdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:33:07 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34855 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfCTMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:33:05 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A804BE0007;
        Wed, 20 Mar 2019 12:33:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/7] rtc: xgene: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 20 Mar 2019 13:32:32 +0100
Message-Id: <20190320123233.13519-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
References: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion as the range is enforced
by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-xgene.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 6f7d7648a9bd..aef338428668 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -45,7 +45,7 @@ static int xgene_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(readl(pdata->csr_base + RTC_CCVR), tm);
+	rtc_time64_to_tm(readl(pdata->csr_base + RTC_CCVR), tm);
 	return 0;
 }
 
@@ -68,7 +68,7 @@ static int xgene_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 
 	/* If possible, CMR should be read here */
-	rtc_time_to_tm(0, &alrm->time);
+	rtc_time64_to_tm(0, &alrm->time);
 	alrm->enabled = readl(pdata->csr_base + RTC_CCR) & RTC_CCR_IE;
 
 	return 0;
@@ -102,10 +102,8 @@ static int xgene_rtc_alarm_irq_enabled(struct device *dev)
 static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
-	unsigned long alarm_time;
 
-	rtc_tm_to_time(&alrm->time, &alarm_time);
-	writel((u32)alarm_time, pdata->csr_base + RTC_CMR);
+	writel((u32)rtc_tm_to_time64(&alrm->time), pdata->csr_base + RTC_CMR);
 
 	xgene_rtc_alarm_irq_enable(dev, alrm->enabled);
 
-- 
2.20.1

