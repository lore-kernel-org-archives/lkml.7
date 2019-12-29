Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABAC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DAF207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfL2UpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 15:45:12 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43297 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfL2UpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 15:45:09 -0500
X-Originating-IP: 92.184.100.83
Received: from localhost (unknown [92.184.100.83])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 22C1D240004;
        Sun, 29 Dec 2019 20:45:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Eugen.Hristev@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/9] rtc: at91rm9200: avoid time readout in at91_rtc_setalarm
Date:   Sun, 29 Dec 2019 21:44:17 +0100
Message-Id: <20191229204421.337612-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191229204421.337612-1-alexandre.belloni@bootlin.com>
References: <20191229204421.337612-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rtc time is read out in at91_rtc_setalarm but it it immediately
overwritten by the alarm time. Remove the readout.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91rm9200.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 997734ed9a5b..30b77e0f39ef 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -255,25 +255,17 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
  */
 static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct rtc_time tm;
-
-	at91_rtc_decodetime(AT91_RTC_TIMR, AT91_RTC_CALR, &tm);
-
-	tm.tm_mon = alrm->time.tm_mon;
-	tm.tm_mday = alrm->time.tm_mday;
-	tm.tm_hour = alrm->time.tm_hour;
-	tm.tm_min = alrm->time.tm_min;
-	tm.tm_sec = alrm->time.tm_sec;
+	struct rtc_time tm = alrm->time;
 
 	at91_rtc_write_idr(AT91_RTC_ALARM);
 	at91_rtc_write(AT91_RTC_TIMALR,
-		  bin2bcd(tm.tm_sec) << 0
-		| bin2bcd(tm.tm_min) << 8
-		| bin2bcd(tm.tm_hour) << 16
+		  bin2bcd(alrm->time.tm_sec) << 0
+		| bin2bcd(alrm->time.tm_min) << 8
+		| bin2bcd(alrm->time.tm_hour) << 16
 		| AT91_RTC_HOUREN | AT91_RTC_MINEN | AT91_RTC_SECEN);
 	at91_rtc_write(AT91_RTC_CALALR,
-		  bin2bcd(tm.tm_mon + 1) << 16		/* tm_mon starts at zero */
-		| bin2bcd(tm.tm_mday) << 24
+		  bin2bcd(alrm->time.tm_mon + 1) << 16		/* tm_mon starts at zero */
+		| bin2bcd(alrm->time.tm_mday) << 24
 		| AT91_RTC_DATEEN | AT91_RTC_MTHEN);
 
 	if (alrm->enabled) {
-- 
2.23.0

