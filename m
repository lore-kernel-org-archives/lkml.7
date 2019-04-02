Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA37BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C3421473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfDBNpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:45:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43250 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731446AbfDBNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:06 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0002mm-WC; Tue, 02 Apr 2019 14:39:59 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0004rm-53; Tue, 02 Apr 2019 14:39:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Grant Likely" <grant.likely@linaro.org>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.6138526@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 17/99] lib/string.c: remove duplicated function
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit cd514e727b18ff4d189b8e268db13729a4175091 upstream.

lib/string.c contains two functions, strnicmp and strncasecmp, which do
roughly the same thing, namely compare two strings case-insensitively up
to a given bound.  They have slightly different implementations, but the
only important difference is that strncasecmp doesn't handle len==0
appropriately; it effectively becomes strcasecmp in that case.  strnicmp
correctly says that two strings are always equal in their first 0
characters.

strncasecmp is the POSIX name for this functionality.  So rename the
non-broken function to the standard name.  To minimize the impact on the
rest of the kernel (and since both are exported to modules), make strnicmp
a wrapper for strncasecmp.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 lib/string.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

--- a/lib/string.c
+++ b/lib/string.c
@@ -31,14 +31,14 @@
 #include <asm/word-at-a-time.h>
 #include <asm/page.h>
 
-#ifndef __HAVE_ARCH_STRNICMP
+#ifndef __HAVE_ARCH_STRNCASECMP
 /**
- * strnicmp - Case insensitive, length-limited string comparison
+ * strncasecmp - Case insensitive, length-limited string comparison
  * @s1: One string
  * @s2: The other string
  * @len: the maximum number of characters to compare
  */
-int strnicmp(const char *s1, const char *s2, size_t len)
+int strncasecmp(const char *s1, const char *s2, size_t len)
 {
 	/* Yes, Virginia, it had better be unsigned */
 	unsigned char c1, c2;
@@ -60,6 +60,13 @@ int strnicmp(const char *s1, const char
 	} while (--len);
 	return (int)c1 - (int)c2;
 }
+EXPORT_SYMBOL(strncasecmp);
+#endif
+#ifndef __HAVE_ARCH_STRNICMP
+int strnicmp(const char *s1, const char *s2, size_t len)
+{
+	return strncasecmp(s1, s2, len);
+}
 EXPORT_SYMBOL(strnicmp);
 #endif
 
@@ -77,20 +84,6 @@ int strcasecmp(const char *s1, const cha
 EXPORT_SYMBOL(strcasecmp);
 #endif
 
-#ifndef __HAVE_ARCH_STRNCASECMP
-int strncasecmp(const char *s1, const char *s2, size_t n)
-{
-	int c1, c2;
-
-	do {
-		c1 = tolower(*s1++);
-		c2 = tolower(*s2++);
-	} while ((--n > 0) && c1 == c2 && c1 != 0);
-	return c1 - c2;
-}
-EXPORT_SYMBOL(strncasecmp);
-#endif
-
 #ifndef __HAVE_ARCH_STRCPY
 /**
  * strcpy - Copy a %NUL terminated string

