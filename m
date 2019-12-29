Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2428DC2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20D121744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 20:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfL2UpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 15:45:16 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33549 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfL2UpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 15:45:14 -0500
Received: from localhost (unknown [92.184.100.83])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 266CC200002;
        Sun, 29 Dec 2019 20:45:10 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Eugen.Hristev@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/9] rtc: at91rm9200: use FIELD_PREP/FIELD_GET
Date:   Sun, 29 Dec 2019 21:44:18 +0100
Message-Id: <20191229204421.337612-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191229204421.337612-1-alexandre.belloni@bootlin.com>
References: <20191229204421.337612-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use FIELD_PREP and FIELD_GET instead of hardcoding already defined values.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91rm9200.c | 42 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 30b77e0f39ef..5e811e04cb21 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
@@ -161,20 +162,20 @@ static void at91_rtc_decodetime(unsigned int timereg, unsigned int calreg,
 	} while ((time != at91_rtc_read(timereg)) ||
 			(date != at91_rtc_read(calreg)));
 
-	tm->tm_sec  = bcd2bin((time & AT91_RTC_SEC) >> 0);
-	tm->tm_min  = bcd2bin((time & AT91_RTC_MIN) >> 8);
-	tm->tm_hour = bcd2bin((time & AT91_RTC_HOUR) >> 16);
+	tm->tm_sec  = bcd2bin(FIELD_GET(AT91_RTC_SEC, time));
+	tm->tm_min  = bcd2bin(FIELD_GET(AT91_RTC_MIN, time));
+	tm->tm_hour = bcd2bin(FIELD_GET(AT91_RTC_HOUR, time));
 
 	/*
 	 * The Calendar Alarm register does not have a field for
 	 * the year - so these will return an invalid value.
 	 */
 	tm->tm_year  = bcd2bin(date & AT91_RTC_CENT) * 100;	/* century */
-	tm->tm_year += bcd2bin((date & AT91_RTC_YEAR) >> 8);	/* year */
+	tm->tm_year += bcd2bin(FIELD_GET(AT91_RTC_YEAR, date));	/* year */
 
-	tm->tm_wday = bcd2bin((date & AT91_RTC_DAY) >> 21) - 1;	/* day of the week [0-6], Sunday=0 */
-	tm->tm_mon  = bcd2bin((date & AT91_RTC_MONTH) >> 16) - 1;
-	tm->tm_mday = bcd2bin((date & AT91_RTC_DATE) >> 24);
+	tm->tm_wday = bcd2bin(FIELD_GET(AT91_RTC_DAY, date)) - 1;	/* day of the week [0-6], Sunday=0 */
+	tm->tm_mon  = bcd2bin(FIELD_GET(AT91_RTC_MONTH, date)) - 1;
+	tm->tm_mday = bcd2bin(FIELD_GET(AT91_RTC_DATE, date));
 }
 
 /*
@@ -211,16 +212,17 @@ static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 	at91_rtc_write_idr(AT91_RTC_ACKUPD);
 
 	at91_rtc_write(AT91_RTC_TIMR,
-			  bin2bcd(tm->tm_sec) << 0
-			| bin2bcd(tm->tm_min) << 8
-			| bin2bcd(tm->tm_hour) << 16);
+			  FIELD_PREP(AT91_RTC_SEC, bin2bcd(tm->tm_sec))
+			| FIELD_PREP(AT91_RTC_MIN, bin2bcd(tm->tm_min))
+			| FIELD_PREP(AT91_RTC_HOUR, bin2bcd(tm->tm_hour)));
 
 	at91_rtc_write(AT91_RTC_CALR,
-			  bin2bcd((tm->tm_year + 1900) / 100)	/* century */
-			| bin2bcd(tm->tm_year % 100) << 8	/* year */
-			| bin2bcd(tm->tm_mon + 1) << 16		/* tm_mon starts at zero */
-			| bin2bcd(tm->tm_wday + 1) << 21	/* day of the week [0-6], Sunday=0 */
-			| bin2bcd(tm->tm_mday) << 24);
+			  FIELD_PREP(AT91_RTC_CENT,
+				     bin2bcd((tm->tm_year + 1900) / 100))
+			| FIELD_PREP(AT91_RTC_YEAR, bin2bcd(tm->tm_year % 100))
+			| FIELD_PREP(AT91_RTC_MONTH, bin2bcd(tm->tm_mon + 1))
+			| FIELD_PREP(AT91_RTC_DAY, bin2bcd(tm->tm_wday + 1))
+			| FIELD_PREP(AT91_RTC_DATE, bin2bcd(tm->tm_mday)));
 
 	/* Restart Time/Calendar */
 	cr = at91_rtc_read(AT91_RTC_CR);
@@ -259,13 +261,13 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	at91_rtc_write_idr(AT91_RTC_ALARM);
 	at91_rtc_write(AT91_RTC_TIMALR,
-		  bin2bcd(alrm->time.tm_sec) << 0
-		| bin2bcd(alrm->time.tm_min) << 8
-		| bin2bcd(alrm->time.tm_hour) << 16
+		  FIELD_PREP(AT91_RTC_SEC, bin2bcd(alrm->time.tm_sec))
+		| FIELD_PREP(AT91_RTC_MIN, bin2bcd(alrm->time.tm_min))
+		| FIELD_PREP(AT91_RTC_HOUR, bin2bcd(alrm->time.tm_hour))
 		| AT91_RTC_HOUREN | AT91_RTC_MINEN | AT91_RTC_SECEN);
 	at91_rtc_write(AT91_RTC_CALALR,
-		  bin2bcd(alrm->time.tm_mon + 1) << 16		/* tm_mon starts at zero */
-		| bin2bcd(alrm->time.tm_mday) << 24
+		  FIELD_PREP(AT91_RTC_MONTH, bin2bcd(alrm->time.tm_mon + 1))
+		| FIELD_PREP(AT91_RTC_DATE, bin2bcd(alrm->time.tm_mday))
 		| AT91_RTC_DATEEN | AT91_RTC_MTHEN);
 
 	if (alrm->enabled) {
-- 
2.23.0

