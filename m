Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B2CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD122189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfH1UvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:51:08 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41083 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH1UvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:51:05 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 67482100006;
        Wed, 28 Aug 2019 20:51:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Anson.Huang@nxp.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: snvs: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 28 Aug 2019 22:50:56 +0200
Message-Id: <20190828205056.31321-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828205056.31321-1-alexandre.belloni@bootlin.com>
References: <20190828205056.31321-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion now that the range is
enforced by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-snvs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 50dd4b8492eb..757f4daa7181 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -151,7 +151,7 @@ static int snvs_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	unsigned long time = rtc_read_lp_counter(data);
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -159,11 +159,9 @@ static int snvs_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int snvs_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	unsigned long time;
+	unsigned long time = rtc_tm_to_time64(tm);
 	int ret;
 
-	rtc_tm_to_time(tm, &time);
-
 	/* Disable RTC first */
 	ret = snvs_rtc_enable(data, false);
 	if (ret)
@@ -185,7 +183,7 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u32 lptar, lpsr;
 
 	regmap_read(data->regmap, data->offset + SNVS_LPTAR, &lptar);
-	rtc_time_to_tm(lptar, &alrm->time);
+	rtc_time64_to_tm(lptar, &alrm->time);
 
 	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
 	alrm->pending = (lpsr & SNVS_LPSR_LPTA) ? 1 : 0;
@@ -207,12 +205,9 @@ static int snvs_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	struct rtc_time *alrm_tm = &alrm->time;
-	unsigned long time;
+	unsigned long time = rtc_tm_to_time64(&alrm->time);
 	int ret;
 
-	rtc_tm_to_time(alrm_tm, &time);
-
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
 	ret = rtc_write_sync_lp(data);
 	if (ret)
-- 
2.21.0

