Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2714AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE63206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="h/0ZPQVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfCJQ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:56:43 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:36162 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfCJQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:56:41 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 1476320EA6;
        Sun, 10 Mar 2019 19:56:37 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OuVee13Njk-uaWGrxRs;
        Sun, 10 Mar 2019 19:56:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552236997; bh=ODRGNZeWG1i8IzpVt7fx/kQwWuiqQWRGJphWxyG7mb0=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=h/0ZPQVZe1AmPJftW131+DQFKmwN+8Zovovn1ynuEkl0gEof2lnPBo8S604ngvv8S
         JwOv+/FANg6e5EWY9cJ7tCBZ183aouCcF2PepPHGYmXrPaYhmN3zprDMkN/YgYctK8
         I41dmEIO4Da+uxaZdNXIEVItSUMSoNzXC36RGDD8=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:35])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id IQ4bmS2aOD-uadusgpu;
        Sun, 10 Mar 2019 19:56:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 4/6] lib: scanf: handle character ranges in %[...]
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 10 Mar 2019 19:56:36 +0300
Message-ID: <155223699650.4075.16018050078707979118.stgit@buzz>
In-Reply-To: <155223448227.4075.6846910559654700796.stgit@buzz>
References: <155223448227.4075.6846910559654700796.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete implementation isn't much bigger than present one.

This patch adds missing standard features:

  %[a-z] - matches 'a'..'z'
  %[][] - matches '[' and ']'   (']' must be first)
  %[_-] - matches '_' and '-'   ('-' must be last)

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 lib/vsprintf.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 66debf42387a..5c27c5d18d4e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3019,7 +3019,6 @@ EXPORT_SYMBOL_GPL(bprintf);
  * - memory-allocation "%m..."
  * - pointer "%p", ptrdiff_t "%t...", intmax_t "%j..."
  * - discaring of matching input "%*[...]"
- * - ranges or matching ']' in "%[...]"
  * - positional assignment "%n$"
  *
  * Non-standatd features:
@@ -3160,11 +3159,8 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		/*
 		 * Warning: This implementation of the '[' conversion specifier
 		 * deviates from its glibc counterpart in the following ways:
-		 * (1) It does NOT support ranges i.e. '-' is NOT a special
-		 *     character
-		 * (2) It cannot match the closing bracket ']' itself
-		 * (3) A field width is required
-		 * (4) '%*[' (discard matching input) is currently not supported
+		 * (1) A field width is required
+		 * (2) '%*[' (discard matching input) is currently not supported
 		 *
 		 * Example usage:
 		 * ret = sscanf("00:0a:95","%2[^:]:%2[^:]:%2[^:]",
@@ -3176,7 +3172,6 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		{
 			char *s = (char *)va_arg(args, char *);
 			DECLARE_BITMAP(set, 256) = {0};
-			unsigned int len = 0;
 			bool negate = (*fmt == '^');
 
 			/* field width is required */
@@ -3186,12 +3181,25 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			if (negate)
 				++fmt;
 
-			for ( ; *fmt && *fmt != ']'; ++fmt, ++len)
-				set_bit((u8)*fmt, set);
+			do {
+				/* no ']' found */
+				if (!*fmt)
+					return num;
 
-			/* no ']' or no character set found */
-			if (!*fmt || !len)
-				return num;
+				/* '-' at last position is non-special */
+				if (*fmt == '-' && *(fmt + 1) != ']') {
+					u8 a = *(fmt - 1);
+					u8 b = *(fmt + 1);
+
+					if (a <= b)
+						bitmap_set(set, a, b - a + 1);
+				} else
+					set_bit((u8)*fmt, set);
+
+				/* ']' at first position is non-special */
+			} while (*++fmt != ']');
+
+			/* skip ']' */
 			++fmt;
 
 			if (negate) {

