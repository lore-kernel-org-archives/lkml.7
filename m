Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A2EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6C320833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Mjb0oXI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfFQWVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:21:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44507 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfFQWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so18390363edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=117Icy7B/1xeFyWHl4lkihw6HeMCgd3HauhM0ZhcRsE=;
        b=Mjb0oXI2dWnjqbNJnIGlywLOfLaKthgHtMTcgWzcAaYc830Wgp159wPWSkrLgphjgD
         wh6gHAEW6amhNAUFv3Y+HjhExUl3gzyTqUqnbLkQhnPuz2APq8pr8Fz7sFS9BTod/a7j
         Nh/3406rsN62zCL1WCUyFaj2aywXM6q2zwZSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=117Icy7B/1xeFyWHl4lkihw6HeMCgd3HauhM0ZhcRsE=;
        b=d+s5QRSbEhPlnyZ/BnorIw3LBtJxZqWuDvKu44Sf0M++3bOppSoy5lCHal9YhmAyaN
         erBpyl0rOrPb0I1yP9/2+Dpd/YPuY421SDZCJZVgR9GM0klSohhQUK2yy9bHlGzSpHYF
         5c/Phhf8DW/QmW7HlwQWo3JTzlF4LUjw4AQb0RqTzexvaAkzfNgWwH8AiSaGINZKqRyp
         LTpAE0l5zooWWvICgHKswqQJF4oDkT7VUVDfT9nibyYw+rOw0lRdQHIV0TcEh6Ik9eRb
         fBZOSxykikQNVbEXLGjpURc+Opf2ih7IfKv1ozHJKlw/UneD8QtxAP9G8gMsPjSEB3OF
         dEcA==
X-Gm-Message-State: APjAAAWtHRZjy/l84UTT2gM9C4cQIr0uQwpNX4058dQgcjoZbm6Eaijr
        +LiXCboHI4h5kccTmZSw+Dw8RQ==
X-Google-Smtp-Source: APXvYqy6V0awRjDH5fj69pS3YenOwm0VtqUACzgq1mn2/dn7WtzY0FzhcuyJ29Gk4iurlmxZf6GYig==
X-Received: by 2002:a05:6402:712:: with SMTP id w18mr33340133edx.201.1560810048577;
        Mon, 17 Jun 2019 15:20:48 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 5/8] dynamic_debug: drop use of bitfields in struct _ddebug
Date:   Tue, 18 Jun 2019 00:20:31 +0200
Message-Id: <20190617222034.10799-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly initializing a struct containing bitfields in assembly is
hard. Instead, merge lineno and flags to a single unsigned int, which we
mask manually. This should not cause any worse code than what gcc would
need to generate for accessing the bitfields anyway.

Actually, on 64 bit, there is a four byte hole after these fields, so we
could just give flags and lineno each their own u32. But I don't think
that's worth the ifdeffery.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 12 ++++------
 lib/dynamic_debug.c           | 44 +++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 6c809440f319..7d6d0153096e 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -20,7 +20,6 @@ struct _ddebug {
 	const char *function;
 	const char *filename;
 	const char *format;
-	unsigned int lineno:18;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -37,7 +36,7 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	unsigned int flags:8;
+	unsigned int flags_lineno; /* flags in lower 8 bits, lineno in upper 24 */
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
@@ -46,7 +45,7 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-
+#define _DPRINTK_FLAGS_LINENO_INIT (((unsigned)__LINE__ << 8) | _DPRINTK_FLAGS_DEFAULT)
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 int ddebug_add_module(struct _ddebug *tab, unsigned int n,
@@ -85,8 +84,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
-		.lineno = __LINE__,				\
-		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		.flags_lineno = _DPRINTK_FLAGS_LINENO_INIT,	\
 		_DPRINTK_KEY_INIT				\
 	}
 
@@ -111,10 +109,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	likely(descriptor.flags_lineno & _DPRINTK_FLAGS_PRINT)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	unlikely(descriptor.flags_lineno & _DPRINTK_FLAGS_PRINT)
 #endif
 
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3599c4c0361a..3a1a80041cd6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -55,6 +55,18 @@ static inline const char *dd_format(const struct _ddebug *dd)
 {
 	return dd->format;
 }
+static inline unsigned dd_lineno(const struct _ddebug *dd)
+{
+	return dd->flags_lineno >> 8;
+}
+static inline unsigned dd_flags(const struct _ddebug *dd)
+{
+	return dd->flags_lineno & 0xff;
+}
+static inline void dd_set_flags(struct _ddebug *dd, unsigned newflags)
+{
+	dd->flags_lineno = (dd_lineno(dd) << 8) | newflags;
+}
 
 extern struct _ddebug __start___verbose[];
 extern struct _ddebug __stop___verbose[];
@@ -113,7 +125,7 @@ static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
 
 	BUG_ON(maxlen < 6);
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (dp->flags & opt_array[i].flag)
+		if (dd_flags(dp) & opt_array[i].flag)
 			*p++ = opt_array[i].opt_char;
 	if (p == buf)
 		*p++ = '_';
@@ -159,7 +171,7 @@ static int ddebug_change(const struct ddebug_query *query,
 {
 	int i;
 	struct ddebug_table *dt;
-	unsigned int newflags;
+	unsigned int newflags, oldflags;
 	unsigned int nfound = 0;
 	char flagbuf[10];
 
@@ -196,27 +208,28 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			/* match against the line number range */
 			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
+			    dd_lineno(dp) < query->first_lineno)
 				continue;
 			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			    dd_lineno(dp) > query->last_lineno)
 				continue;
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | flags;
-			if (newflags == dp->flags)
+			oldflags = dd_flags(dp);
+			newflags = (oldflags & mask) | flags;
+			if (newflags == oldflags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
+			if (oldflags & _DPRINTK_FLAGS_PRINT) {
 				if (!(flags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
 			} else if (flags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
-			dp->flags = newflags;
+			dd_set_flags(dp, newflags);
 			vpr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dd_filename(dp)), dp->lineno,
+				 trim_prefix(dd_filename(dp)), dd_lineno(dp),
 				 dt->mod_name, dd_function(dp),
 				 ddebug_describe_flags(dp, flagbuf,
 						       sizeof(flagbuf)));
@@ -539,10 +552,11 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
+	unsigned flags = dd_flags(desc);
 
 	*buf = '\0';
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -550,15 +564,15 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				dd_modname(desc));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				dd_function(desc));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
-				desc->lineno);
+				dd_lineno(desc));
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
@@ -844,7 +858,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dd_filename(dp)), dp->lineno,
+		   trim_prefix(dd_filename(dp)), dd_lineno(dp),
 		   iter->table->mod_name, dd_function(dp),
 		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
 	seq_escape(m, dd_format(dp), "\t\r\n\"");
-- 
2.20.1

