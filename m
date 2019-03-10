Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886DBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896B206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QIeflJ6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCJQ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:56:40 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:36151 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbfCJQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:56:39 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 7674F20EC4;
        Sun, 10 Mar 2019 19:56:35 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1vleoypaQU-uZWqDTcp;
        Sun, 10 Mar 2019 19:56:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552236995; bh=Wp7QbwIfVsFVzbM6vqSdTmim3pFJbpPo/MioA+3gnEs=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=QIeflJ6xMPXeAW83hVg8TcfvSbqq91fG+02UYadOKVp6lNypSArs4UR5p1HcGwD0p
         WFLcZUbIAg8Ga4vYvU67n7Mc3YHNxqy8ywvMsvaWD5uwQbpCMKOJArCDszlVbNgNL2
         E2Eu2AwE/8trR6Ce4fbfvX1HzsgldpznueQi54QM=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:35])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QUzTA6bGIA-uYD4WA3R;
        Sun, 10 Mar 2019 19:56:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 3/6] lib: scanf: add vsscanf feature for matching end of
 text
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 10 Mar 2019 19:56:34 +0300
Message-ID: <155223699475.4075.10085989782784489732.stgit@buzz>
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

Traditional sscanf ignores trailing unmatched characters,
because it derives from design of streaming fscanf().

Without extra care this leads to confusing parsing results:
"%d" successfully parses "0x1" as 0 and "1M" as 1.

Silent ignore of trailing input also could hide bugs and
unexpectedly break backward compatibility at any change.

This patch adds end of text matching into sscanf format by
ASCII End-Of-Transfer character '\004' (EOT aka ^D).

EOT stops matching and if input text haven't ended and adds
flag SCANF_MORE to the result value. Result stays positive.

EOT allows to rephrase common end of text checks like:

int end;
if (sscanf(buf, fmt "%n", ..., &end) == NR && !buf[end])

char dummy;
if (sscanf(buf, fmt "%c", ..., &dummy) == NR - 1)

purely in format string without extra code or arguments:

if (sscanf(buf, fmt KERN_EOT, ...) == NR)

This checks that text ends strictly after previous matched character.
For skipping trailing white spaces simply add space before EOT.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/kernel.h |    6 ++++++
 lib/vsprintf.c         |   11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 34a5036debd3..32726b25eaa5 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -476,6 +476,12 @@ char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 extern __printf(2, 0)
 const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
 
+#define KERN_EOT	"\004"	/* ASCII End Of Transfer */
+#define KERN_EOT_ASCII	'\004'
+
+/* sscanf adds this to the result if EOT does not match end of text */
+#define SCANF_MORE	(1 << 30)
+
 extern __scanf(2, 3)
 int sscanf(const char *, const char *, ...);
 extern __scanf(2, 0)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index ada0501f1525..66debf42387a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3005,7 +3005,8 @@ EXPORT_SYMBOL_GPL(bprintf);
  * @fmt:	format of buffer
  * @args:	arguments
  *
- * Returns number of successfully matched arguments.
+ * Returns number of successfully matched arguments,
+ * plus SCANF_MORE bit flag if EOT does not matched end of text.
  *
  * This function implements only basic vsscanf features:
  *
@@ -3027,6 +3028,8 @@ EXPORT_SYMBOL_GPL(bprintf);
  * - %s without field width limited with SHRT_MAX
  * - "%*..." simply skips non white-space characters without conversion
  * - integer overflows are handled as matching failure
+ * - KERN_EOT ("\004") matches end of string otherwise stops parsing and
+ *   returns count matched arguments plus SCANF_MORE bit flag,
  */
 int vsscanf(const char *buf, const char *fmt, va_list args)
 {
@@ -3055,6 +3058,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 
 		/* anything that is not a conversion must match exactly */
 		if (*fmt != '%' && *fmt) {
+			/* EOT in format string: text must end here */
+			if (*fmt == KERN_EOT_ASCII) {
+				if (*str)
+					num |= SCANF_MORE;
+				break;
+			}
 			if (*fmt++ != *str++)
 				break;
 			continue;

