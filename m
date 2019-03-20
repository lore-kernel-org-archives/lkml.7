Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5052184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfCTMdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:33:02 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33877 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfCTMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:33:01 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D15C11BF20E;
        Wed, 20 Mar 2019 12:32:58 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/7] rtc: xgene: stop caching alarm_time
Date:   Wed, 20 Mar 2019 13:32:31 +0100
Message-Id: <20190320123233.13519-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
References: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in caching alarm_time for .read_alarm because
.read_alarm is only called at boo time and thus alarm_time is always 0.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-xgene.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index eb745deda936..6f7d7648a9bd 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -35,7 +35,6 @@
 struct xgene_rtc_dev {
 	struct rtc_device *rtc;
 	struct device *dev;
-	unsigned long alarm_time;
 	void __iomem *csr_base;
 	struct clk *clk;
 	unsigned int irq_wake;
@@ -68,7 +67,8 @@ static int xgene_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
 
-	rtc_time_to_tm(pdata->alarm_time, &alrm->time);
+	/* If possible, CMR should be read here */
+	rtc_time_to_tm(0, &alrm->time);
 	alrm->enabled = readl(pdata->csr_base + RTC_CCR) & RTC_CCR_IE;
 
 	return 0;
@@ -105,8 +105,7 @@ static int xgene_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	unsigned long alarm_time;
 
 	rtc_tm_to_time(&alrm->time, &alarm_time);
-	pdata->alarm_time = alarm_time;
-	writel((u32)pdata->alarm_time, pdata->csr_base + RTC_CMR);
+	writel((u32)alarm_time, pdata->csr_base + RTC_CMR);
 
 	xgene_rtc_alarm_irq_enable(dev, alrm->enabled);
 
-- 
2.20.1

