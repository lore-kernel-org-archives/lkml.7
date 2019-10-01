Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C85ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762B4218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbfJANrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:47:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:34070 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388728AbfJANrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:47:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="221002712"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2019 06:47:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 197F3130; Tue,  1 Oct 2019 16:47:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH v2 1/4] lib/vsprintf: Print time64_t in human readable format
Date:   Tue,  1 Oct 2019 16:47:14 +0300
Message-Id: <20191001134717.81282-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
References: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are users which print time and date represented by content of
time64_t type in human readable format.

Instead of open coding that each time introduce %ptT[dt][r] specifier.

Few test cases for %ptT specifier has been added as well.

Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst | 22 ++++++++--------
 lib/test_printf.c                         | 13 +++++++---
 lib/vsprintf.c                            | 31 +++++++++++++++++++++--
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecbebf4ca8e7..83f452e45f3f 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -428,21 +428,23 @@ Examples::
 
 Passed by reference.
 
-Time and date (struct rtc_time)
--------------------------------
+Time and date
+-------------
 
 ::
 
-	%ptR		YYYY-mm-ddTHH:MM:SS
-	%ptRd		YYYY-mm-dd
-	%ptRt		HH:MM:SS
-	%ptR[dt][r]
+	%pt[RT]			YYYY-mm-ddTHH:MM:SS
+	%pt[RT]d		YYYY-mm-dd
+	%pt[RT]t		HH:MM:SS
+	%pt[RT][dt][r]
 
-For printing date and time as represented by struct rtc_time structure in
-human readable format.
+For printing date and time as represented by
+	R  struct rtc_time structure
+	T  time64_t type
+in human readable format.
 
-By default year will be incremented by 1900 and month by 1. Use %ptRr (raw)
-to suppress this behaviour.
+By default year will be incremented by 1900 and month by 1.
+Use %pt[RT]r (raw) to suppress this behaviour.
 
 Passed by reference.
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 5d94cbff2120..16fb668685dd 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -476,7 +476,7 @@ struct_va_format(void)
 }
 
 static void __init
-struct_rtc_time(void)
+time_and_date(void)
 {
 	/* 1543210543 */
 	const struct rtc_time tm = {
@@ -487,14 +487,21 @@ struct_rtc_time(void)
 		.tm_mon = 10,
 		.tm_year = 118,
 	};
+	/* 2019-01-04T15:32:23 */
+	time64_t t = 1546615943;
 
-	test("(%ptR?)", "%pt", &tm);
+	test("(%pt?)", "%pt", &tm);
 	test("2018-11-26T05:35:43", "%ptR", &tm);
 	test("0118-10-26T05:35:43", "%ptRr", &tm);
 	test("05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
 	test("05:35:43|0118-10-26", "%ptRtr|%ptRdr", &tm, &tm);
 	test("05:35:43|2018-11-26", "%ptRttr|%ptRdtr", &tm, &tm);
 	test("05:35:43 tr|2018-11-26 tr", "%ptRt tr|%ptRd tr", &tm, &tm);
+
+	test("2019-01-04T15:32:23", "%ptT", &t);
+	test("0119-00-04T15:32:23", "%ptTr", &t);
+	test("15:32:23|2019-01-04", "%ptTt|%ptTd", &t, &t);
+	test("15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
 }
 
 static void __init
@@ -610,7 +617,7 @@ test_pointer(void)
 	uuid();
 	dentry();
 	struct_va_format();
-	struct_rtc_time();
+	time_and_date();
 	struct_clk();
 	bitmap();
 	netdev_features();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index e78017a3e1bd..e4bc380deb62 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -33,6 +33,7 @@
 #include <linux/dcache.h>
 #include <linux/cred.h>
 #include <linux/rtc.h>
+#include <linux/time.h>
 #include <linux/uuid.h>
 #include <linux/of.h>
 #include <net/addrconf.h>
@@ -1780,6 +1781,29 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
 	return buf;
 }
 
+static noinline_for_stack
+char *time64_str(char *buf, char *end, const time64_t time,
+		 struct printf_spec spec, const char *fmt)
+{
+	struct rtc_time rtc_time;
+	struct tm tm;
+
+	time64_to_tm(time, 0, &tm);
+
+	rtc_time.tm_sec = tm.tm_sec;
+	rtc_time.tm_min = tm.tm_min;
+	rtc_time.tm_hour = tm.tm_hour;
+	rtc_time.tm_mday = tm.tm_mday;
+	rtc_time.tm_mon = tm.tm_mon;
+	rtc_time.tm_year = tm.tm_year;
+	rtc_time.tm_wday = tm.tm_wday;
+	rtc_time.tm_yday = tm.tm_yday;
+
+	rtc_time.tm_isdst = 0;
+
+	return rtc_str(buf, end, &rtc_time, spec, fmt);
+}
+
 static noinline_for_stack
 char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 		    const char *fmt)
@@ -1787,8 +1811,10 @@ char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 	switch (fmt[1]) {
 	case 'R':
 		return rtc_str(buf, end, (const struct rtc_time *)ptr, spec, fmt);
+	case 'T':
+		return time64_str(buf, end, *(const time64_t *)ptr, spec, fmt);
 	default:
-		return error_string(buf, end, "(%ptR?)", spec);
+		return error_string(buf, end, "(%pt?)", spec);
 	}
 }
 
@@ -2088,8 +2114,9 @@ static char *kobject_string(char *buf, char *end, void *ptr,
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)
- * - 't[R][dt][r]' For time and date as represented:
+ * - 't[RT][dt][r]' For time and date as represented by:
  *      R    struct rtc_time
+ *      T    time64_t
  * - 'C' For a clock, it prints the name (Common Clock Framework) or address
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
-- 
2.23.0

