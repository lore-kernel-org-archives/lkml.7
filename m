Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7093C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765D42084F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="U0MGgTd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfCJQ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:56:36 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:53993 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfCJQ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:56:34 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id C3FAC2068A;
        Sun, 10 Mar 2019 19:56:31 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id u0nAfJn7g6-uVMGDYX3;
        Sun, 10 Mar 2019 19:56:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552236991; bh=oJUj1DQCQP/23dU5OB0gSuZqfoYkEusAlgNZ1+dSVq0=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=U0MGgTd6LAlz+yXBF12x6xudLDk53SmCUe33566a9Qj326ARZ5pc2c8697C+TVMqo
         qF+OaU5XY9S4iei6JOxR8L4F5KdSKfGFeFiiZcSoO913TWb8hzudlLP8fGwegeAepW
         zRWqNJlxaxM64M1Y7Fo3c/lwMOKnpjLcITeL6ri8=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:35])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id HkKXDBUQrL-uVdi4wU1;
        Sun, 10 Mar 2019 19:56:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 1/6] lib: scanf: document features of scanf format string
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 10 Mar 2019 19:56:31 +0300
Message-ID: <155223699117.4075.8079162387262586958.stgit@buzz>
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

Kernel implementation of vsscanf() has some limitations.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 lib/vsprintf.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 791b6fa36905..276a0bc3b019 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3004,6 +3004,28 @@ EXPORT_SYMBOL_GPL(bprintf);
  * @buf:	input buffer
  * @fmt:	format of buffer
  * @args:	arguments
+ *
+ * Returns number of successfully matched arguments.
+ *
+ * This function implements only basic vsscanf features:
+ *
+ * - conversion specifiers: d, i, o, u, x, X, s, c, [, n
+ * - type modifiers: hh, h, l, L, ll, z
+ *
+ * Not implemented features:
+ *
+ * - floating-point numbers
+ * - memory-allocation "%m..."
+ * - pointer "%p", ptrdiff_t "%t...", intmax_t "%j..."
+ * - discaring of matching input "%*[...]"
+ * - ranges or matching ']' in "%[...]"
+ * - positional assignment "%n$"
+ *
+ * Non-standatd features:
+ *
+ * - "%[...]" requires field width
+ * - %s without field width limited with SHRT_MAX
+ * - "%*..." simply skips non white-space characters without conversion
  */
 int vsscanf(const char *buf, const char *fmt, va_list args)
 {
@@ -3291,6 +3313,12 @@ EXPORT_SYMBOL(vsscanf);
  * @buf:	input buffer
  * @fmt:	formatting of buffer
  * @...:	resulting arguments
+ *
+ * Returns number of successfully matched arguments.
+ *
+ * See format description in comment for vsscanf() above.
+ *
+ * For single integer conversion it is better to use kstrto*().
  */
 int sscanf(const char *buf, const char *fmt, ...)
 {

