Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27907C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050E920835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbfDQLyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732085AbfDQLyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F38BAFFC;
        Wed, 17 Apr 2019 11:54:19 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v7 05/10] vsprintf: Factor out %pV handler as va_format()
Date:   Wed, 17 Apr 2019 13:53:45 +0200
Message-Id: <20190417115350.20479-6-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code from the long pointer() function. We are going to improve
error handling that will make it more complicated.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 8ca29bc0d786..12b71a4d4613 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1520,6 +1520,17 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
+static char *va_format(char *buf, char *end, struct va_format *va_fmt)
+{
+	va_list va;
+
+	va_copy(va, *va_fmt->va);
+	buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
+	va_end(va);
+
+	return buf;
+}
+
 static noinline_for_stack
 char *uuid_string(char *buf, char *end, const u8 *addr,
 		  struct printf_spec spec, const char *fmt)
@@ -2046,15 +2057,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'U':
 		return uuid_string(buf, end, ptr, spec, fmt);
 	case 'V':
-		{
-			va_list va;
-
-			va_copy(va, *((struct va_format *)ptr)->va);
-			buf += vsnprintf(buf, end > buf ? end - buf : 0,
-					 ((struct va_format *)ptr)->fmt, va);
-			va_end(va);
-			return buf;
-		}
+		return va_format(buf, end, ptr);
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
-- 
2.16.4

