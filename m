Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D0920835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfDQLyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbfDQLyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24540AFFB;
        Wed, 17 Apr 2019 11:54:17 +0000 (UTC)
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
Subject: [PATCH v7 04/10] vsprintf: Factor out %p[iI] handler as ip_addr_string()
Date:   Wed, 17 Apr 2019 13:53:44 +0200
Message-Id: <20190417115350.20479-5-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the non-trivial code from the long pointer() function. We are going
to improve error handling that will make it even more complicated.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c9c9a1179870..8ca29bc0d786 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1431,6 +1431,35 @@ char *ip4_addr_string_sa(char *buf, char *end, const struct sockaddr_in *sa,
 	return string_nocheck(buf, end, ip4_addr, spec);
 }
 
+static noinline_for_stack
+char *ip_addr_string(char *buf, char *end, const void *ptr,
+		     struct printf_spec spec, const char *fmt)
+{
+	switch (fmt[1]) {
+	case '6':
+		return ip6_addr_string(buf, end, ptr, spec, fmt);
+	case '4':
+		return ip4_addr_string(buf, end, ptr, spec, fmt);
+	case 'S': {
+		const union {
+			struct sockaddr		raw;
+			struct sockaddr_in	v4;
+			struct sockaddr_in6	v6;
+		} *sa = ptr;
+
+		switch (sa->raw.sa_family) {
+		case AF_INET:
+			return ip4_addr_string_sa(buf, end, &sa->v4, spec, fmt);
+		case AF_INET6:
+			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
+		default:
+			return string_nocheck(buf, end, "(invalid address)", spec);
+		}}
+	}
+
+	return ptr_to_id(buf, end, ptr, spec);
+}
+
 static noinline_for_stack
 char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		     const char *fmt)
@@ -2011,28 +2040,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 					 * 4:	001.002.003.004
 					 * 6:   000102...0f
 					 */
-		switch (fmt[1]) {
-		case '6':
-			return ip6_addr_string(buf, end, ptr, spec, fmt);
-		case '4':
-			return ip4_addr_string(buf, end, ptr, spec, fmt);
-		case 'S': {
-			const union {
-				struct sockaddr		raw;
-				struct sockaddr_in	v4;
-				struct sockaddr_in6	v6;
-			} *sa = ptr;
-
-			switch (sa->raw.sa_family) {
-			case AF_INET:
-				return ip4_addr_string_sa(buf, end, &sa->v4, spec, fmt);
-			case AF_INET6:
-				return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
-			default:
-				return string_nocheck(buf, end, "(invalid address)", spec);
-			}}
-		}
-		break;
+		return ip_addr_string(buf, end, ptr, spec, fmt);
 	case 'E':
 		return escaped_string(buf, end, ptr, spec, fmt);
 	case 'U':
-- 
2.16.4

