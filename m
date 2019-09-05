Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ABDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B0D206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403937AbfIETou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:44:50 -0400
Received: from fieldses.org ([173.255.197.46]:56752 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390054AbfIETog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id F03084116; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 9/9] Remove string_escape_mem_ascii
Date:   Thu,  5 Sep 2019 15:44:33 -0400
Message-Id: <1567712673-1629-9-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It's easier to do this in string_escape_mem now.

Might also consider non-ascii and quote-mark sprintf modifiers and then
we might make do with seq_printk.
---
 fs/seq_file.c                  |  3 ++-
 include/linux/string_helpers.h |  3 +--
 lib/string_helpers.c           | 24 ++++--------------------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 63e5a7c4dbf7..0e45a25523ad 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -390,7 +390,8 @@ void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
 	size_t size = seq_get_buf(m, &buf);
 	int ret;
 
-	ret = string_escape_mem_ascii(src, isz, buf, size);
+	ret = string_escape_mem(src, isz, buf, size, ESCAPE_NP|ESCAPE_NONASCII|
+				ESCAPE_STYLE_SLASH|ESCAPE_STYLE_HEX, "\"\\");
 	seq_commit(m, ret < size ? ret : -1);
 }
 EXPORT_SYMBOL(seq_escape_mem_ascii);
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 5d350f7f6874..f3388591d83f 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -43,6 +43,7 @@ static inline int string_unescape_any_inplace(char *buf)
 
 #define ESCAPE_SPECIAL		0x01
 #define ESCAPE_NP		0x02
+#define ESCAPE_NONASCII		0x04
 #define ESCAPE_ANY_NP		(ESCAPE_SPECIAL | ESCAPE_NP)
 #define ESCAPE_STYLE_SLASH	0x20
 #define ESCAPE_STYLE_OCTAL	0x40
@@ -52,8 +53,6 @@ static inline int string_unescape_any_inplace(char *buf)
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
 
-int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
-					size_t osz);
 static inline int string_escape_str(const char *src, char *dst, size_t sz,
 		unsigned int flags, const char *only)
 {
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 6f553f893fda..1dacf76eada0 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -439,6 +439,8 @@ static bool is_special(char c)
  *		'\a' - alert (BEL)
  *		'\e' - escape
  *		'\0' - null
+ *	%ESCAPE_NONASCII:
+ *		escape characters with the high bit set
  *	%ESCAPE_NP:
  *		escape only non-printable characters (checked by isprint)
  *	%ESCAPE_ANY_NP:
@@ -468,7 +470,8 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 
 		if ((is_dict && strchr(esc, c)) ||
 		    (flags & ESCAPE_NP && !isprint(c)) ||
-		    (flags & ESCAPE_SPECIAL && is_special(c))) {
+		    (flags & ESCAPE_SPECIAL && is_special(c)) ||
+		    (flags & ESCAPE_NONASCII && !isascii(c))) {
 
 			if (flags & ESCAPE_STYLE_SLASH &&
 					escape_special(c, &p, end))
@@ -491,25 +494,6 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 }
 EXPORT_SYMBOL(string_escape_mem);
 
-int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
-					size_t osz)
-{
-	char *p = dst;
-	char *end = p + osz;
-
-	while (isz--) {
-		unsigned char c = *src++;
-
-		if (!isprint(c) || !isascii(c) || c == '"' || c == '\\')
-			escape_hex(c, &p, end);
-		else
-			escape_passthrough(c, &p, end);
-	}
-
-	return p - dst;
-}
-EXPORT_SYMBOL(string_escape_mem_ascii);
-
 /*
  * Return an allocated string that has been escaped of special characters
  * and double quotes, making it safe to log in quotes.
-- 
2.21.0

