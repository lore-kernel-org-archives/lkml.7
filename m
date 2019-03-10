Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC45C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79D32084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="UHSNKfWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCJQ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:56:40 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:36139 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbfCJQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:56:37 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id AE2D520E9F;
        Sun, 10 Mar 2019 19:56:33 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 2IdLbJ8AGt-uXEuCQUB;
        Sun, 10 Mar 2019 19:56:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552236993; bh=EvfI7shLh4iHDM/w+tSeYgIN/P6HGwdMwxQVgzrxVBA=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=UHSNKfWzQd5Evk1DSv+5Z+0V2NnmdcPeZWtLn9VQyOfegMF/dFhbez0P0eBPjA3l9
         SO58O8vBf0qlzOhqPyUGwM2lu9wvOumhrHWWXWEp/N3h4PWGtwoPUL4iSpsy6stGdR
         tm+dFpYls4BEQD/vnE5cpikF7hiqa9nL9WtFOWog=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:35])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id GVs2IZS7HW-uX4KpXdR;
        Sun, 10 Mar 2019 19:56:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 2/6] lib: scanf: handle integer overflows in vsscanf
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 10 Mar 2019 19:56:32 +0300
Message-ID: <155223699287.4075.13184771244455866778.stgit@buzz>
In-Reply-To: <155223448227.4075.6846910559654700796.stgit@buzz>
References: <155223448227.4075.6846910559654700796.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traditional scanf implementations ignore integer overflows because
C language standard allows here undefined behavior (§7.21.6.2 #10).

So, sane and safe behavior wouldn't harm anything.

This patch carefully checks integer overflows and stops matching if result
does not fit into appropriate type before assigning it into argument.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 lib/vsprintf.c |   86 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 30 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 276a0bc3b019..ada0501f1525 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3026,12 +3026,13 @@ EXPORT_SYMBOL_GPL(bprintf);
  * - "%[...]" requires field width
  * - %s without field width limited with SHRT_MAX
  * - "%*..." simply skips non white-space characters without conversion
+ * - integer overflows are handled as matching failure
  */
 int vsscanf(const char *buf, const char *fmt, va_list args)
 {
 	const char *str = buf;
-	char *next;
-	char digit;
+	const char *next;
+	unsigned int rv;
 	int num = 0;
 	u8 qualifier;
 	unsigned int base;
@@ -3230,29 +3231,31 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		 */
 		str = skip_spaces(str);
 
-		digit = *str;
-		if (is_sign && digit == '-')
-			digit = *(str + 1);
+		next = str;
 
-		if (!digit
-		    || (base == 16 && !isxdigit(digit))
-		    || (base == 10 && !isdigit(digit))
-		    || (base == 8 && (!isdigit(digit) || digit > '7'))
-		    || (base == 0 && !isdigit(digit)))
-			break;
+		/* skip leading sign */
+		if (is_sign && (*str == '+' || *str == '-'))
+			next++;
 
-		if (is_sign)
-			val.s = qualifier != 'L' ?
-				simple_strtol(str, &next, base) :
-				simple_strtoll(str, &next, base);
-		else
-			val.u = qualifier != 'L' ?
-				simple_strtoul(str, &next, base) :
-				simple_strtoull(str, &next, base);
+		/* 64-bit integer conversion, similar to _kstrtoull() */
+		next = _parse_integer_fixup_radix(next, &base);
+		rv = _parse_integer(next, base, &val.u);
+		if (rv == 0)
+			break;
+		if (rv & KSTRTOX_OVERFLOW)
+			goto overflow;
+		next += rv;
+
+		if (is_sign) {
+			if (*str == '-') {
+				val.s = -val.u;
+				if (val.s > 0)
+					goto overflow;
+			} else if (val.s < 0)
+				goto overflow;
+		}
 
-		if (field_width > 0 && next - str > field_width) {
-			if (base == 0)
-				_parse_integer_fixup_radix(str, &base);
+		if (field_width > 0) {
 			while (next - str > field_width) {
 				if (is_sign)
 					val.s = div_s64(val.s, base);
@@ -3264,22 +3267,37 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
-			if (is_sign)
+			if (is_sign) {
+				if ((signed char)val.s != val.s)
+					goto overflow;
 				*va_arg(args, signed char *) = val.s;
-			else
+			} else {
+				if ((unsigned char)val.u != val.u)
+					goto overflow;
 				*va_arg(args, unsigned char *) = val.u;
+			}
 			break;
 		case 'h':
-			if (is_sign)
+			if (is_sign) {
+				if ((short)val.s != val.s)
+					goto overflow;
 				*va_arg(args, short *) = val.s;
-			else
+			} else {
+				if ((unsigned short)val.u != val.u)
+					goto overflow;
 				*va_arg(args, unsigned short *) = val.u;
+			}
 			break;
 		case 'l':
-			if (is_sign)
+			if (is_sign) {
+				if ((long)val.s != val.s)
+					goto overflow;
 				*va_arg(args, long *) = val.s;
-			else
+			} else {
+				if ((unsigned long)val.u != val.u)
+					goto overflow;
 				*va_arg(args, unsigned long *) = val.u;
+			}
 			break;
 		case 'L':
 			if (is_sign)
@@ -3288,13 +3306,20 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 				*va_arg(args, unsigned long long *) = val.u;
 			break;
 		case 'z':
+			if ((size_t)val.u != val.u)
+				goto overflow;
 			*va_arg(args, size_t *) = val.u;
 			break;
 		default:
-			if (is_sign)
+			if (is_sign) {
+				if ((int)val.s != val.s)
+					goto overflow;
 				*va_arg(args, int *) = val.s;
-			else
+			} else {
+				if ((unsigned int)val.u != val.u)
+					goto overflow;
 				*va_arg(args, unsigned int *) = val.u;
+			}
 			break;
 		}
 		num++;
@@ -3304,6 +3329,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		str = next;
 	}
 
+overflow:
 	return num;
 }
 EXPORT_SYMBOL(vsscanf);

