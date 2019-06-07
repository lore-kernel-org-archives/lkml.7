Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC402146E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfFGRJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:09:56 -0400
Received: from ms.lwn.net ([45.79.88.28]:57672 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbfFGRJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:09:54 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C756A737;
        Fri,  7 Jun 2019 17:09:53 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:09:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH] lib/string_helpers: fix some kerneldoc warnings
Message-ID: <20190607110952.409011ba@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to some sad limitations in how kerneldoc comments are parsed, the
documentation in lib/string_helpers.c generates these warnings:

./lib/string_helpers.c:236: WARNING: Unexpected indentation.
./lib/string_helpers.c:241: WARNING: Block quote ends without a blank line; unexpected unindent.
./lib/string_helpers.c:446: WARNING: Unexpected indentation.
./lib/string_helpers.c:451: WARNING: Block quote ends without a blank line; unexpected unindent.
./lib/string_helpers.c:474: WARNING: Unexpected indentation.

Rework the comments to obtain something like the desired result.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 lib/string_helpers.c | 77 +++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 29c490e5d478..a9f5ef9289e6 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -230,35 +230,36 @@ static bool unescape_special(char **src, char **dst)
  * @src:	source buffer (escaped)
  * @dst:	destination buffer (unescaped)
  * @size:	size of the destination buffer (0 to unlimit)
- * @flags:	combination of the flags (bitwise OR):
- *	%UNESCAPE_SPACE:
+ * @flags:	combination of the flags.
+ *
+ * Description:
+ * The function unquotes characters in the given string.
+ *
+ * Because the size of the output will be the same as or less than the size of
+ * the input, the transformation may be performed in place.
+ *
+ * Caller must provide valid source and destination pointers. Be aware that
+ * destination buffer will always be NULL-terminated. Source string must be
+ * NULL-terminated as well.  The supported flags are::
+ *
+ *	UNESCAPE_SPACE:
  *		'\f' - form feed
  *		'\n' - new line
  *		'\r' - carriage return
  *		'\t' - horizontal tab
  *		'\v' - vertical tab
- *	%UNESCAPE_OCTAL:
+ *	UNESCAPE_OCTAL:
  *		'\NNN' - byte with octal value NNN (1 to 3 digits)
- *	%UNESCAPE_HEX:
+ *	UNESCAPE_HEX:
  *		'\xHH' - byte with hexadecimal value HH (1 to 2 digits)
- *	%UNESCAPE_SPECIAL:
+ *	UNESCAPE_SPECIAL:
  *		'\"' - double quote
  *		'\\' - backslash
  *		'\a' - alert (BEL)
  *		'\e' - escape
- *	%UNESCAPE_ANY:
+ *	UNESCAPE_ANY:
  *		all previous together
  *
- * Description:
- * The function unquotes characters in the given string.
- *
- * Because the size of the output will be the same as or less than the size of
- * the input, the transformation may be performed in place.
- *
- * Caller must provide valid source and destination pointers. Be aware that
- * destination buffer will always be NULL-terminated. Source string must be
- * NULL-terminated as well.
- *
  * Return:
  * The amount of the characters processed to the destination buffer excluding
  * trailing '\0' is returned.
@@ -440,7 +441,29 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  * @isz:	source buffer size
  * @dst:	destination buffer (escaped)
  * @osz:	destination buffer size
- * @flags:	combination of the flags (bitwise OR):
+ * @flags:	combination of the flags
+ * @only:	NULL-terminated string containing characters used to limit
+ *		the selected escape class. If characters are included in @only
+ *		that would not normally be escaped by the classes selected
+ *		in @flags, they will be copied to @dst unescaped.
+ *
+ * Description:
+ * The process of escaping byte buffer includes several parts. They are applied
+ * in the following sequence.
+ *
+ *	1. The character is matched to the printable class, if asked, and in
+ *	   case of match it passes through to the output.
+ *	2. The character is not matched to the one from @only string and thus
+ *	   must go as-is to the output.
+ *	3. The character is checked if it falls into the class given by @flags.
+ *	   %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
+ *	   character. Note that they actually can't go together, otherwise
+ *	   %ESCAPE_HEX will be ignored.
+ *
+ * Caller must provide valid source and destination pointers. Be aware that
+ * destination buffer will not be NULL-terminated, thus caller have to append
+ * it if needs.   The supported flags are::
+ *
  *	%ESCAPE_SPACE: (special white space, not space itself)
  *		'\f' - form feed
  *		'\n' - new line
@@ -463,26 +486,6 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *		all previous together
  *	%ESCAPE_HEX:
  *		'\xHH' - byte with hexadecimal value HH (2 digits)
- * @only:	NULL-terminated string containing characters used to limit
- *		the selected escape class. If characters are included in @only
- *		that would not normally be escaped by the classes selected
- *		in @flags, they will be copied to @dst unescaped.
- *
- * Description:
- * The process of escaping byte buffer includes several parts. They are applied
- * in the following sequence.
- *	1. The character is matched to the printable class, if asked, and in
- *	   case of match it passes through to the output.
- *	2. The character is not matched to the one from @only string and thus
- *	   must go as-is to the output.
- *	3. The character is checked if it falls into the class given by @flags.
- *	   %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
- *	   character. Note that they actually can't go together, otherwise
- *	   %ESCAPE_HEX will be ignored.
- *
- * Caller must provide valid source and destination pointers. Be aware that
- * destination buffer will not be NULL-terminated, thus caller have to append
- * it if needs.
  *
  * Return:
  * The total size of the escaped output that would be generated for
-- 
2.21.0

