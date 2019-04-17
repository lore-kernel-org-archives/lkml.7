Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D0C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E03217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbfDQLya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:43908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729578AbfDQLy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9845FB035;
        Wed, 17 Apr 2019 11:54:26 +0000 (UTC)
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
Subject: [PATCH v7 10/10] vsprintf: Limit the length of inlined error messages
Date:   Wed, 17 Apr 2019 13:53:50 +0200
Message-Id: <20190417115350.20479-11-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inlined error messages must be used carefully because
they need to fit into the given buffer.

Handle them using a custom wrapper that makes people aware
of the problem. Also define a reasonable hard limit to
avoid a completely insane usage.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 4e5666035b74..1f367f3a7e2b 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -612,6 +612,21 @@ static char *string_nocheck(char *buf, char *end, const char *s,
 	return widen_string(buf, len, end, spec);
 }
 
+/* Be careful: error messages must fit into the given buffer. */
+static char *error_string(char *buf, char *end, const char *s,
+			  struct printf_spec spec)
+{
+	/*
+	 * Hard limit to avoid a completely insane messages. It actually
+	 * works pretty well because most error messages are in
+	 * the many pointer format modifiers.
+	 */
+	if (spec.precision == -1)
+		spec.precision = 2 * sizeof(void *);
+
+	return string_nocheck(buf, end, s, spec);
+}
+
 /*
  * This is not a fool-proof test. 99% of the time that this will fault is
  * due to a bad pointer, not one that crosses into bad memory. Just test
@@ -638,7 +653,7 @@ static int check_pointer(char **buf, char *end, const void *ptr,
 
 	err_msg = check_pointer_msg(ptr);
 	if (err_msg) {
-		*buf = string_nocheck(*buf, end, err_msg, spec);
+		*buf = error_string(*buf, end, err_msg, spec);
 		return -EFAULT;
 	}
 
@@ -741,7 +756,7 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
 		spec.field_width = 2 * sizeof(ptr);
 		/* string length must be less than default_width */
-		return string_nocheck(buf, end, str, spec);
+		return error_string(buf, end, str, spec);
 	}
 
 #ifdef CONFIG_64BIT
@@ -777,7 +792,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		if (in_irq() || in_serving_softirq() || in_nmi()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
-			return string_nocheck(buf, end, "pK-error", spec);
+			return error_string(buf, end, "pK-error", spec);
 		}
 
 		/*
@@ -1511,12 +1526,12 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 		case AF_INET6:
 			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
 		default:
-			return string_nocheck(buf, end, "(einval)", spec);
+			return error_string(buf, end, "(einval)", spec);
 		}}
 	}
 
 	err_fmt_msg = fmt[0] == 'i' ? "(%pi?)" : "(%pI?)";
-	return string_nocheck(buf, end, err_fmt_msg, spec);
+	return error_string(buf, end, err_fmt_msg, spec);
 }
 
 static noinline_for_stack
@@ -1653,7 +1668,7 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 		size = sizeof(netdev_features_t);
 		break;
 	default:
-		return string_nocheck(buf, end, "(%pN?)", spec);
+		return error_string(buf, end, "(%pN?)", spec);
 	}
 
 	return special_hex_number(buf, end, num, size);
@@ -1765,7 +1780,7 @@ char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 	case 'R':
 		return rtc_str(buf, end, (const struct rtc_time *)ptr, spec, fmt);
 	default:
-		return string_nocheck(buf, end, "(%ptR?)", spec);
+		return error_string(buf, end, "(%ptR?)", spec);
 	}
 }
 
@@ -1774,7 +1789,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
 {
 	if (!IS_ENABLED(CONFIG_HAVE_CLK))
-		return string_nocheck(buf, end, "(%pC?)", spec);
+		return error_string(buf, end, "(%pC?)", spec);
 
 	if (check_pointer(&buf, end, clk, spec))
 		return buf;
@@ -1785,7 +1800,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 #ifdef CONFIG_COMMON_CLK
 		return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return string_nocheck(buf, end, "(%pC?)", spec);
+		return error_string(buf, end, "(%pC?)", spec);
 #endif
 	}
 }
@@ -1843,7 +1858,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 		names = gfpflag_names;
 		break;
 	default:
-		return string_nocheck(buf, end, "(%pG?)", spec);
+		return error_string(buf, end, "(%pG?)", spec);
 	}
 
 	return format_flags(buf, end, flags, names);
@@ -1899,7 +1914,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	str_spec.field_width = -1;
 
 	if (!IS_ENABLED(CONFIG_OF))
-		return string_nocheck(buf, end, "(%pOF?)", spec);
+		return error_string(buf, end, "(%pOF?)", spec);
 
 	if (check_pointer(&buf, end, dn, spec))
 		return buf;
@@ -1978,7 +1993,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
 		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	}
 
-	return string_nocheck(buf, end, "(%pO?)", spec);
+	return error_string(buf, end, "(%pO?)", spec);
 }
 
 /*
-- 
2.16.4

