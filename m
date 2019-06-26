Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90304C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC632082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFZJjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:39:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:33921 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFZJjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:39:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 02:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="163874489"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2019 02:39:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51137162; Wed, 26 Jun 2019 12:39:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] auxdisplay: charlcd: Deduplicate simple_strtoul()
Date:   Wed, 26 Jun 2019 12:39:43 +0300
Message-Id: <20190626093943.49780-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626093943.49780-1-andriy.shevchenko@linux.intel.com>
References: <20190626093943.49780-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in the commit
  8b2303de399f ("serial: core: Fix handling of options after MMIO address")
we may use simple_strtoul() which in comparison to kstrtoul() can do conversion
in-place without additional and unnecessary code to be written.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- Cc to Andrew
- fix compilation issue
 drivers/auxdisplay/charlcd.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 92745efefb54..3858dc7a4154 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -287,31 +287,6 @@ static int charlcd_init_display(struct charlcd *lcd)
 	return 0;
 }
 
-/*
- * Parses an unsigned integer from a string, until a non-digit character
- * is found. The empty string is not accepted. No overflow checks are done.
- *
- * Returns whether the parsing was successful. Only in that case
- * the output parameters are written to.
- *
- * TODO: If the kernel adds an inplace version of kstrtoul(), this function
- * could be easily replaced by that.
- */
-static bool parse_n(const char *s, unsigned long *res, const char **next_s)
-{
-	if (!isdigit(*s))
-		return false;
-
-	*res = 0;
-	while (isdigit(*s)) {
-		*res = *res * 10 + (*s - '0');
-		++s;
-	}
-
-	*next_s = s;
-	return true;
-}
-
 /*
  * Parses a movement command of the form "(.*);", where the group can be
  * any number of subcommands of the form "(x|y)[0-9]+".
@@ -336,6 +311,7 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
 {
 	unsigned long new_x = *x;
 	unsigned long new_y = *y;
+	char *p;
 
 	for (;;) {
 		if (!*s)
@@ -345,11 +321,15 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
 			break;
 
 		if (*s == 'x') {
-			if (!parse_n(s + 1, &new_x, &s))
+			new_x = simple_strtoul(s + 1, &p, 10);
+			if (p == s + 1)
 				return false;
+			s = p;
 		} else if (*s == 'y') {
-			if (!parse_n(s + 1, &new_y, &s))
+			new_y = simple_strtoul(s + 1, &p, 10);
+			if (p == s + 1)
 				return false;
+			s = p;
 		} else {
 			return false;
 		}
-- 
2.20.1

