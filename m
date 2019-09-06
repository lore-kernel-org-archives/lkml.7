Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F16C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DDB2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394710AbfIFPJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:09:45 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIFPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:09:44 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MIxBa-1hqFBB1WFm-00KR0F; Fri, 06 Sep 2019 17:09:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] exfat: stop using 32-bit time_t
Date:   Fri,  6 Sep 2019 17:09:05 +0200
Message-Id: <20190906150917.1025250-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190906150917.1025250-1-arnd@arndb.de>
References: <20190906150917.1025250-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UIMrIG7mtL2D3EjfnDs7nzByw34qqSgASrD2j2WILhDOKSfQ0t3
 /43vTZJ0IVYmAdA4Y99oPOKLDsm+X6klu6XtGWpemjllvc3IEaAJNRnKsS0AJGFRpVa2EWJ
 Upblf01PURlRK7I2J/uYVP++Fz5+rdTnsh1hJ+XMw1H2ECnN8kuIHvNULaMcvpyaT0M3Xdv
 66tsssxwcBzEBkbwVrDMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0SVBQh1K0k=:D/s+8TRAHcIpv7CTzMytoX
 +Wr/iT3PpbPL28nNgwctNOMvK+hs5KKI80ErECKnhJuMUXdD1CfC8NIKO3n8K5BRMbsa6B1GG
 Sd6fkJoZT5QbbeOo6QdcLMpykuK+FgeuSYLXyRYnLAdZ7/RJyi6bZcpJVTh8xDzSccy7Ju/fF
 ubTqFabPvo7ruIRh/GHedTKX/qMCx15QZQS8n9aPgWmoiexBXujWXqITaiOxcPARnnHuF4Ni9
 NJzGE6xMIqEQzmSzxBLgeohPp8rX3vxhK1yafo1/5ZB/AhilHU0L5jY6+Y6cJhob/1zja/I+C
 xXN31KFpjK9MW4/7VbNRcgNhkpRFYtNGHGE7FB9JbixY2+RyGnbYWe5W3skDEvz34aOk/CgG9
 UYXtxsDUtEplsTkR+yjoCR9RMYlEwXqzZmlQ2IldwlagY/UnQdlBKE8S4WPHzbL71ZFrsRbKU
 aA1xuzXLyjQP6EsDS1k/ABLmO/1Ggt6OBqVLykvEgCvGrajtWLf95A809MUBZ40iQSDTZb4Ph
 3tptzTZPci+mpqgvQ500/quazMMb1ywN/LOHxL/psK5MGjCE/5ZybFpitznBEYfosVLobKA2/
 8fHO+4WAmPRcRpNfZ1j9PPLgupszcqatHHq/5FyuGMZ/jmwKCZgl4oG2Gn+HUbiYpRK0EQFGP
 Y6cn2xTSoxNzRhkTa7icU69fXcTeahDe6g/dwGBH9oRnF8SNetZXwrVQaTYLUyEje+oitx1DR
 /SR4KUoAVAdm+qyfTO87a1P29bARdqw2wCTrR3UzU8XWU/qTWWQoxbvPYKhXg9VZfY54tK6X6
 jgzijJVWG+KPSyhrGZDiyc27vD/1FPB19tcOF1V1hDBF9ccFQU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

time_t suffers from overflow problems and should not be used.

In exfat, it is currently used in two open-coded time64_to_tm()
implementations. Changes those to use the existing function instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/exfat/exfat_super.c | 164 +++++++---------------------
 1 file changed, 38 insertions(+), 126 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 37e78620723f..7fd56654498f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -55,129 +55,65 @@ static int exfat_write_inode(struct inode *inode,
 static void exfat_write_super(struct super_block *sb);
 
 #define UNIX_SECS_1980    315532800L
-
-#if BITS_PER_LONG == 64
 #define UNIX_SECS_2108    4354819200L
-#endif
-
-/* days between 1.1.70 and 1.1.80 (2 leap days) */
-#define DAYS_DELTA_DECADE    (365 * 10 + 2)
-/* 120 (2100 - 1980) isn't leap year */
-#define NO_LEAP_YEAR_2100    (120)
-#define IS_LEAP_YEAR(y)    (!((y) & 0x3) && (y) != NO_LEAP_YEAR_2100)
-
-#define SECS_PER_MIN    (60)
-#define SECS_PER_HOUR   (60 * SECS_PER_MIN)
-#define SECS_PER_DAY    (24 * SECS_PER_HOUR)
-
-#define MAKE_LEAP_YEAR(leap_year, year)                         \
-	do {                                                    \
-		if (unlikely(year > NO_LEAP_YEAR_2100))         \
-			leap_year = ((year + 3) / 4) - 1;       \
-		else                                            \
-			leap_year = ((year + 3) / 4);           \
-	} while (0)
-
-/* Linear day numbers of the respective 1sts in non-leap years. */
-static time_t accum_days_in_year[] = {
-	/* Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec */
-	0,   0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0,
-};
 
 /* Convert a FAT time/date pair to a UNIX date (seconds since 1 1 70). */
 static void exfat_time_fat2unix(struct exfat_sb_info *sbi,
 				struct timespec64 *ts, struct date_time_t *tp)
 {
-	time_t year = tp->Year;
-	time_t ld;
-
-	MAKE_LEAP_YEAR(ld, year);
-
-	if (IS_LEAP_YEAR(year) && (tp->Month) > 2)
-		ld++;
-
-	ts->tv_sec = tp->Second +
-		     tp->Minute * SECS_PER_MIN +
-		     tp->Hour * SECS_PER_HOUR +
-		     (ld + accum_days_in_year[(tp->Month)] +
-		      (tp->Day - 1)) * SECS_PER_DAY +
-		     (year * 365 + DAYS_DELTA_DECADE) * SECS_PER_DAY +
-		     sys_tz.tz_minuteswest * SECS_PER_MIN;
+	ts->tv_sec = mktime64(tp->Year + 1980, tp->Month + 1, tp->Day,
+			      tp->Hour, tp->Minute, tp->Second);
 
-	ts->tv_nsec = 0;
+	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
 }
 
 /* Convert linear UNIX date to a FAT time/date pair. */
 static void exfat_time_unix2fat(struct exfat_sb_info *sbi,
 				struct timespec64 *ts, struct date_time_t *tp)
 {
-	time_t second = ts->tv_sec;
-	time_t day, month, year;
-	time_t ld;
+	time64_t second = ts->tv_sec;
+	struct tm tm;
 
-	second -= sys_tz.tz_minuteswest * SECS_PER_MIN;
+	time64_to_tm(second, 0, &tm);
 
-	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
 	if (second < UNIX_SECS_1980) {
-		tp->Second  = 0;
-		tp->Minute  = 0;
-		tp->Hour = 0;
-		tp->Day  = 1;
-		tp->Month  = 1;
-		tp->Year = 0;
+		tp->MilliSecond = 0;
+		tp->Second	= 0;
+		tp->Minute	= 0;
+		tp->Hour	= 0;
+		tp->Day		= 1;
+		tp->Month	= 1;
+		tp->Year	= 0;
 		return;
 	}
-#if (BITS_PER_LONG == 64)
+
 	if (second >= UNIX_SECS_2108) {
-		tp->Second  = 59;
-		tp->Minute  = 59;
-		tp->Hour = 23;
-		tp->Day  = 31;
-		tp->Month  = 12;
-		tp->Year = 127;
+		tp->MilliSecond = 999;
+		tp->Second	= 59;
+		tp->Minute	= 59;
+		tp->Hour	= 23;
+		tp->Day		= 31;
+		tp->Month	= 12;
+		tp->Year	= 127;
 		return;
 	}
-#endif
-	day = second / SECS_PER_DAY - DAYS_DELTA_DECADE;
-	year = day / 365;
-	MAKE_LEAP_YEAR(ld, year);
-	if (year * 365 + ld > day)
-		year--;
-
-	MAKE_LEAP_YEAR(ld, year);
-	day -= year * 365 + ld;
 
-	if (IS_LEAP_YEAR(year) && day == accum_days_in_year[3]) {
-		month = 2;
-	} else {
-		if (IS_LEAP_YEAR(year) && day > accum_days_in_year[3])
-			day--;
-		for (month = 1; month < 12; month++) {
-			if (accum_days_in_year[month + 1] > day)
-				break;
-		}
-	}
-	day -= accum_days_in_year[month];
-
-	tp->Second  = second % SECS_PER_MIN;
-	tp->Minute  = (second / SECS_PER_MIN) % 60;
-	tp->Hour = (second / SECS_PER_HOUR) % 24;
-	tp->Day  = day + 1;
-	tp->Month  = month;
-	tp->Year = year;
+	tp->MilliSecond = ts->tv_nsec / NSEC_PER_MSEC;
+	tp->Second	= tm.tm_sec;
+	tp->Minute	= tm.tm_min;
+	tp->Hour	= tm.tm_hour;
+	tp->Day		= tm.tm_mday;
+	tp->Month	= tm.tm_mon + 1;
+	tp->Year	= tm.tm_year + 1900 - 1980;
 }
 
 struct timestamp_t *tm_current(struct timestamp_t *tp)
 {
-	struct timespec64 ts;
-	time_t second, day, leap_day, month, year;
-
-	ktime_get_real_ts64(&ts);
+	time64_t second = ktime_get_real_seconds();
+	struct tm tm;
 
-	second = ts.tv_sec;
-	second -= sys_tz.tz_minuteswest * SECS_PER_MIN;
+	time64_to_tm(second, 0, &tm);
 
-	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
 	if (second < UNIX_SECS_1980) {
 		tp->sec  = 0;
 		tp->min  = 0;
@@ -187,7 +123,7 @@ struct timestamp_t *tm_current(struct timestamp_t *tp)
 		tp->year = 0;
 		return tp;
 	}
-#if BITS_PER_LONG == 64
+
 	if (second >= UNIX_SECS_2108) {
 		tp->sec  = 59;
 		tp->min  = 59;
@@ -197,37 +133,13 @@ struct timestamp_t *tm_current(struct timestamp_t *tp)
 		tp->year = 127;
 		return tp;
 	}
-#endif
-
-	day = second / SECS_PER_DAY - DAYS_DELTA_DECADE;
-	year = day / 365;
-
-	MAKE_LEAP_YEAR(leap_day, year);
-	if (year * 365 + leap_day > day)
-		year--;
 
-	MAKE_LEAP_YEAR(leap_day, year);
-
-	day -= year * 365 + leap_day;
-
-	if (IS_LEAP_YEAR(year) && day == accum_days_in_year[3]) {
-		month = 2;
-	} else {
-		if (IS_LEAP_YEAR(year) && day > accum_days_in_year[3])
-			day--;
-		for (month = 1; month < 12; month++) {
-			if (accum_days_in_year[month + 1] > day)
-				break;
-		}
-	}
-	day -= accum_days_in_year[month];
-
-	tp->sec  = second % SECS_PER_MIN;
-	tp->min  = (second / SECS_PER_MIN) % 60;
-	tp->hour = (second / SECS_PER_HOUR) % 24;
-	tp->day  = day + 1;
-	tp->mon  = month;
-	tp->year = year;
+	tp->sec  = tm.tm_sec;
+	tp->min  = tm.tm_min;
+	tp->hour = tm.tm_hour;
+	tp->day  = tm.tm_mday;
+	tp->mon  = tm.tm_mon + 1;
+	tp->year = tm.tm_year + 1900 - 1980;
 
 	return tp;
 }
-- 
2.20.0

