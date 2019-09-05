Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D7AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F62206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbfIETpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:45:00 -0400
Received: from fieldses.org ([173.255.197.46]:56714 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389775AbfIETog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D38384120; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5/9] Remove unused %*pE[achnops] formats
Date:   Thu,  5 Sep 2019 15:44:29 -0400
Message-Id: <1567712673-1629-5-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The [achnops] are confusing, and in practice the only one anyone seems
to need is the bare %*pE.

I think some set of modifiers here might actually be useful, but the
ones we have are confusing and unused, so let's just toss these out and
then rethink what we might want to add back later.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 Documentation/core-api/printk-formats.rst | 23 ++---------
 lib/vsprintf.c                            | 50 ++---------------------
 2 files changed, 7 insertions(+), 66 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c6224d039bcb..4f9d20dfb342 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -180,35 +180,20 @@ Raw buffer as an escaped string
 
 ::
 
-	%*pE[achnops]
+	%*pE
 
 For printing raw buffer as an escaped string. For the following buffer::
 
 		1b 62 20 5c 43 07 22 90 0d 5d
 
-A few examples show how the conversion would be done (excluding surrounding
+An example shows how the conversion would be done (excluding surrounding
 quotes)::
 
 		%*pE		"\eb \C\a"\220\r]"
-		%*pEhp		"\x1bb \C\x07"\x90\x0d]"
-		%*pEa		"\e\142\040\\\103\a\042\220\r\135"
 
-The conversion rules are applied according to an optional combination
-of flags (see :c:func:`string_escape_mem` kernel documentation for the
-details):
+See :c:func:`string_escape_mem` kernel documentation for the details.
 
-	- a - ESCAPE_ANY
-	- c - ESCAPE_SPECIAL
-	- h - ESCAPE_HEX
-	- n - ESCAPE_NULL
-	- o - ESCAPE_OCTAL
-	- p - ESCAPE_NP
-	- s - ESCAPE_SPACE
-
-By default ESCAPE_ANY_NP is used.
-
-ESCAPE_ANY_NP is the sane choice for many cases, in particularly for
-printing SSIDs.
+This is used, for example, for printing SSIDs.
 
 If field width is omitted then 1 byte only will be escaped.
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b0967cf17137..5522d2a052e1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1537,9 +1537,6 @@ static noinline_for_stack
 char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		     const char *fmt)
 {
-	bool found = true;
-	int count = 1;
-	unsigned int flags = 0;
 	int len;
 
 	if (spec.field_width == 0)
@@ -1548,38 +1545,6 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	if (check_pointer(&buf, end, addr, spec))
 		return buf;
 
-	do {
-		switch (fmt[count++]) {
-		case 'a':
-			flags |= ESCAPE_ANY;
-			break;
-		case 'c':
-			flags |= ESCAPE_SPECIAL;
-			break;
-		case 'h':
-			flags |= ESCAPE_HEX;
-			break;
-		case 'n':
-			flags |= ESCAPE_NULL;
-			break;
-		case 'o':
-			flags |= ESCAPE_OCTAL;
-			break;
-		case 'p':
-			flags |= ESCAPE_NP;
-			break;
-		case 's':
-			flags |= ESCAPE_SPACE;
-			break;
-		default:
-			found = false;
-			break;
-		}
-	} while (found);
-
-	if (!flags)
-		flags = ESCAPE_ANY_NP;
-
 	len = spec.field_width < 0 ? 1 : spec.field_width;
 
 	/*
@@ -1587,7 +1552,8 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	 * the given buffer, and returns the total size of the output
 	 * had the buffer been big enough.
 	 */
-	buf += string_escape_mem(addr, len, buf, buf < end ? end - buf : 0, flags, NULL);
+	buf += string_escape_mem(addr, len, buf, buf < end ? end - buf : 0,
+				 ESCAPE_ANY_NP, NULL);
 
 	return buf;
 }
@@ -2038,17 +2004,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
  * - '[Ii][4S][hnbl]' IPv4 addresses in host, network, big or little endian order
  * - 'I[6S]c' for IPv6 addresses printed as specified by
  *       http://tools.ietf.org/html/rfc5952
- * - 'E[achnops]' For an escaped buffer, where rules are defined by combination
- *                of the following flags (see string_escape_mem() for the
- *                details):
- *                  a - ESCAPE_ANY
- *                  c - ESCAPE_SPECIAL
- *                  h - ESCAPE_HEX
- *                  n - ESCAPE_NULL
- *                  o - ESCAPE_OCTAL
- *                  p - ESCAPE_NP
- *                  s - ESCAPE_SPACE
- *                By default ESCAPE_ANY_NP is used.
+ * - 'E[achnops]' For an escaped buffer (see string_escape_mem()
  * - 'U' For a 16 byte UUID/GUID, it prints the UUID/GUID in the form
  *       "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  *       Options for %pU are:
-- 
2.21.0

