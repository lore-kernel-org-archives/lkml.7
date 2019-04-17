Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDC720835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfDQLyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbfDQLyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E1FDACBC;
        Wed, 17 Apr 2019 11:54:13 +0000 (UTC)
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
Subject: [PATCH v7 01/10] vsprintf: Shuffle restricted_pointer()
Date:   Wed, 17 Apr 2019 13:53:41 +0200
Message-Id: <20190417115350.20479-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a preparation step for further changes.

The patch does not change the code.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 98 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 791b6fa36905..eb7b4a06e1f0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -717,6 +717,55 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	return pointer_string(buf, end, (const void *)hashval, spec);
 }
 
+int kptr_restrict __read_mostly;
+
+static noinline_for_stack
+char *restricted_pointer(char *buf, char *end, const void *ptr,
+			 struct printf_spec spec)
+{
+	switch (kptr_restrict) {
+	case 0:
+		/* Always print %pK values */
+		break;
+	case 1: {
+		const struct cred *cred;
+
+		/*
+		 * kptr_restrict==1 cannot be used in IRQ context
+		 * because its test for CAP_SYSLOG would be meaningless.
+		 */
+		if (in_irq() || in_serving_softirq() || in_nmi()) {
+			if (spec.field_width == -1)
+				spec.field_width = 2 * sizeof(ptr);
+			return string(buf, end, "pK-error", spec);
+		}
+
+		/*
+		 * Only print the real pointer value if the current
+		 * process has CAP_SYSLOG and is running with the
+		 * same credentials it started with. This is because
+		 * access to files is checked at open() time, but %pK
+		 * checks permission at read() time. We don't want to
+		 * leak pointer values if a binary opens a file using
+		 * %pK and then elevates privileges before reading it.
+		 */
+		cred = current_cred();
+		if (!has_capability_noaudit(current, CAP_SYSLOG) ||
+		    !uid_eq(cred->euid, cred->uid) ||
+		    !gid_eq(cred->egid, cred->gid))
+			ptr = NULL;
+		break;
+	}
+	case 2:
+	default:
+		/* Always print 0's for %pK */
+		ptr = NULL;
+		break;
+	}
+
+	return pointer_string(buf, end, ptr, spec);
+}
+
 static noinline_for_stack
 char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_spec spec,
 		  const char *fmt)
@@ -1476,55 +1525,6 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 	return string(buf, end, uuid, spec);
 }
 
-int kptr_restrict __read_mostly;
-
-static noinline_for_stack
-char *restricted_pointer(char *buf, char *end, const void *ptr,
-			 struct printf_spec spec)
-{
-	switch (kptr_restrict) {
-	case 0:
-		/* Always print %pK values */
-		break;
-	case 1: {
-		const struct cred *cred;
-
-		/*
-		 * kptr_restrict==1 cannot be used in IRQ context
-		 * because its test for CAP_SYSLOG would be meaningless.
-		 */
-		if (in_irq() || in_serving_softirq() || in_nmi()) {
-			if (spec.field_width == -1)
-				spec.field_width = 2 * sizeof(ptr);
-			return string(buf, end, "pK-error", spec);
-		}
-
-		/*
-		 * Only print the real pointer value if the current
-		 * process has CAP_SYSLOG and is running with the
-		 * same credentials it started with. This is because
-		 * access to files is checked at open() time, but %pK
-		 * checks permission at read() time. We don't want to
-		 * leak pointer values if a binary opens a file using
-		 * %pK and then elevates privileges before reading it.
-		 */
-		cred = current_cred();
-		if (!has_capability_noaudit(current, CAP_SYSLOG) ||
-		    !uid_eq(cred->euid, cred->uid) ||
-		    !gid_eq(cred->egid, cred->gid))
-			ptr = NULL;
-		break;
-	}
-	case 2:
-	default:
-		/* Always print 0's for %pK */
-		ptr = NULL;
-		break;
-	}
-
-	return pointer_string(buf, end, ptr, spec);
-}
-
 static noinline_for_stack
 char *netdev_bits(char *buf, char *end, const void *addr,
 		  struct printf_spec spec,  const char *fmt)
-- 
2.16.4

