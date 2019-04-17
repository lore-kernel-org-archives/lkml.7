Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56144C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbfDQLyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732019AbfDQLyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93C95B02C;
        Wed, 17 Apr 2019 11:54:20 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v7 06/10] vsprintf: Factor out %pO handler as kobject_string()
Date:   Wed, 17 Apr 2019 13:53:46 +0200
Message-Id: <20190417115350.20479-7-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move code from the long pointer() function. We are going to improve
error handling that will make it even more complicated.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tobin Harding <me@tobin.cc>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/vsprintf.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 12b71a4d4613..9817d171f608 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1888,6 +1888,17 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+static char *kobject_string(char *buf, char *end, void *ptr,
+			    struct printf_spec spec, const char *fmt)
+{
+	switch (fmt[1]) {
+	case 'F':
+		return device_node_string(buf, end, ptr, spec, fmt + 1);
+	}
+
+	return ptr_to_id(buf, end, ptr, spec);
+}
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2082,11 +2093,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'G':
 		return flags_string(buf, end, ptr, fmt);
 	case 'O':
-		switch (fmt[1]) {
-		case 'F':
-			return device_node_string(buf, end, ptr, spec, fmt + 1);
-		}
-		break;
+		return kobject_string(buf, end, ptr, spec, fmt);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}
-- 
2.16.4

