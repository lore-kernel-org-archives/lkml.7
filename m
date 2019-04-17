Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF2620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfDQLy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732019AbfDQLyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9916B024;
        Wed, 17 Apr 2019 11:54:22 +0000 (UTC)
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
Subject: [PATCH v7 07/10] vsprintf: Consolidate handling of unknown pointer specifiers
Date:   Wed, 17 Apr 2019 13:53:47 +0200
Message-Id: <20190417115350.20479-8-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few printk formats that make sense only with two or more
specifiers. Also some specifiers make sense only when a kernel feature
is enabled.

The handling of unknown specifiers is inconsistent and not helpful.
Using WARN() looks like an overkill for this type of error. pr_warn()
is not good either. It would by handled via printk_safe buffer and
it might be hard to match it with the problematic string.

A reasonable compromise seems to be writing the unknown format specifier
into the original string with a question mark, for example (%pC?).
It should be self-explaining enough. Note that it is in brackets
to follow the (null) style.

Note that it introduces a warning about that test_hashed() function
is unused. It is going to be used again by a later patch.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/test_printf.c |  3 +--
 lib/vsprintf.c    | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 659b6cc0d483..250ee864b8b8 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -462,8 +462,7 @@ struct_rtc_time(void)
 		.tm_year = 118,
 	};
 
-	test_hashed("%pt", &tm);
-
+	test("(%ptR?)", "%pt", &tm);
 	test("2018-11-26T05:35:43", "%ptR", &tm);
 	test("0118-10-26T05:35:43", "%ptRr", &tm);
 	test("05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9817d171f608..f471a658422f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1435,6 +1435,8 @@ static noinline_for_stack
 char *ip_addr_string(char *buf, char *end, const void *ptr,
 		     struct printf_spec spec, const char *fmt)
 {
+	char *err_fmt_msg;
+
 	switch (fmt[1]) {
 	case '6':
 		return ip6_addr_string(buf, end, ptr, spec, fmt);
@@ -1457,7 +1459,8 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 		}}
 	}
 
-	return ptr_to_id(buf, end, ptr, spec);
+	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
+	return string_nocheck(buf, end, err_fmt_msg, spec);
 }
 
 static noinline_for_stack
@@ -1585,7 +1588,7 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 		size = sizeof(netdev_features_t);
 		break;
 	default:
-		return ptr_to_id(buf, end, addr, spec);
+		return string_nocheck(buf, end, "(%pN?)", spec);
 	}
 
 	return special_hex_number(buf, end, num, size);
@@ -1689,7 +1692,7 @@ char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 	case 'R':
 		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
 	default:
-		return ptr_to_id(buf, end, ptr, spec);
+		return string_nocheck(buf, end, "(%ptR?)", spec);
 	}
 }
 
@@ -1697,7 +1700,10 @@ static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
+	if (!IS_ENABLED(CONFIG_HAVE_CLK))
+		return string_nocheck(buf, end, "(%pC?)", spec);
+
+	if (!clk)
 		return string(buf, end, NULL, spec);
 
 	switch (fmt[1]) {
@@ -1706,7 +1712,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 #ifdef CONFIG_COMMON_CLK
 		return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return ptr_to_id(buf, end, clk, spec);
+		return string_nocheck(buf, end, "(%pC?)", spec);
 #endif
 	}
 }
@@ -1739,7 +1745,8 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 }
 
 static noinline_for_stack
-char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
+char *flags_string(char *buf, char *end, void *flags_ptr,
+		   struct printf_spec spec, const char *fmt)
 {
 	unsigned long flags;
 	const struct trace_print_flags *names;
@@ -1760,8 +1767,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
 		names = gfpflag_names;
 		break;
 	default:
-		WARN_ONCE(1, "Unsupported flags modifier: %c\n", fmt[1]);
-		return buf;
+		return string_nocheck(buf, end, "(%pG?)", spec);
 	}
 
 	return format_flags(buf, end, flags, names);
@@ -1817,7 +1823,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return string_nocheck(buf, end, "(!OF)", spec);
+		return string_nocheck(buf, end, "(%pOF?)", spec);
 
 	if ((unsigned long)dn < PAGE_SIZE)
 		return string_nocheck(buf, end, "(null)", spec);
@@ -1896,7 +1902,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	}
 
-	return ptr_to_id(buf, end, ptr, spec);
+	return string_nocheck(buf, end, "(%pO?)", spec);
 }
 
 /*
@@ -2091,7 +2097,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 #endif
 
 	case 'G':
-		return flags_string(buf, end, ptr, fmt);
+		return flags_string(buf, end, ptr, spec, fmt);
 	case 'O':
 		return kobject_string(buf, end, ptr, spec, fmt);
 	case 'x':
-- 
2.16.4

