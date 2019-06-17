Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6F920833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Y92dmsqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfFQWVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:21:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34167 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfFQWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so18483354edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vRpZZ4IfQKGytYHR1q3gyvtG2oFgpC+iBYxFZ9TdPI4=;
        b=Y92dmsqb2535eP39fja8Utwp0VjKIJ0UA79NymZgTkcN/lARsGyVCh60FZTZdZi8h7
         Ct2XkOxATdDYCl2HC8jD7r9DBhcQ30mKLNPOetHYQYK393Pq2LQXECnt/JUVXIpKi55i
         5FZwxX9EPUyqGfmN2+CwBdgS0BFeZJGVVvknc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vRpZZ4IfQKGytYHR1q3gyvtG2oFgpC+iBYxFZ9TdPI4=;
        b=HjPEYJuXoDpok6wDK327xNAjIOxmHm16W+KTSLsrGCPyMm3pCJoqoLXgB8XQ9riBV2
         qf1gr2kAT87qOs+KQjmeI98D/OpCoAtVZBcS9uoMw66/e28rQydER/ZZ6c+6wfSgl7M7
         JEH7+gYyqmjYhUayBFEshWvaAkGkUBRrnG+SuhoaMBiYokDTqXXsONlTP6Nsu0yFcayi
         pV2fQaVZo4HraW1B5yGMjNQbk6atA3TP96ALLeXpERsxAHtC7rcXEJPqKy8RvbD6WW7Q
         lowChejMAQx+c98JLctL7gVlJbOtjARSi+U2wI8RviURfZk/HKbEMVqqifP6J5x7NTRj
         hfew==
X-Gm-Message-State: APjAAAUOrnyZQjI60nRDejopnxY+sxsaHM5R4glm6EI3n6F7Q4K1TEAV
        ek/Ry+AqjACRV0aHKmSv4YJj2A==
X-Google-Smtp-Source: APXvYqxB/HM4ILYgTyys6tHTEuR80fT28nBcYxtuuvetjHW+pjg0SeWF0rJbAVf0pEZpNGa1F7agCg==
X-Received: by 2002:a17:906:e204:: with SMTP id gf4mr55594798ejb.302.1560810047454;
        Mon, 17 Jun 2019 15:20:47 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 4/8] dynamic_debug: introduce accessors for string members of struct _ddebug
Date:   Tue, 18 Jun 2019 00:20:30 +0200
Message-Id: <20190617222034.10799-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we introduce compact versions of these pointers (a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS), all access to these members must
go via appropriate accessors. This just mass-converts dynamic_debug.c to
use the new accessors.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/dynamic_debug.c | 51 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8a16c2d498e9..3599c4c0361a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -39,6 +39,23 @@
 
 #include <rdma/ib_verbs.h>
 
+static inline const char *dd_modname(const struct _ddebug *dd)
+{
+	return dd->modname;
+}
+static inline const char *dd_function(const struct _ddebug *dd)
+{
+	return dd->function;
+}
+static inline const char *dd_filename(const struct _ddebug *dd)
+{
+	return dd->filename;
+}
+static inline const char *dd_format(const struct _ddebug *dd)
+{
+	return dd->format;
+}
+
 extern struct _ddebug __start___verbose[];
 extern struct _ddebug __stop___verbose[];
 
@@ -160,21 +177,21 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			/* match against the source filename */
 			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
+			    !match_wildcard(query->filename, dd_filename(dp)) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
+					   kbasename(dd_filename(dp))) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					   trim_prefix(dd_filename(dp))))
 				continue;
 
 			/* match against the function */
 			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
+			    !match_wildcard(query->function, dd_function(dp)))
 				continue;
 
 			/* match against the format */
 			if (query->format &&
-			    !strstr(dp->format, query->format))
+			    !strstr(dd_format(dp), query->format))
 				continue;
 
 			/* match against the line number range */
@@ -199,8 +216,8 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			vpr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
+				 trim_prefix(dd_filename(dp)), dp->lineno,
+				 dt->mod_name, dd_function(dp),
 				 ddebug_describe_flags(dp, flagbuf,
 						       sizeof(flagbuf)));
 		}
@@ -535,10 +552,10 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	pos_after_tid = pos;
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
+				dd_modname(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
+				dd_function(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
@@ -827,10 +844,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(dd_filename(dp)), dp->lineno,
+		   iter->table->mod_name, dd_function(dp),
 		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
-	seq_escape(m, dp->format, "\t\r\n\"");
+	seq_escape(m, dd_format(dp), "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
 	return 0;
@@ -1024,20 +1041,20 @@ static int __init dynamic_debug_init(void)
 		return 1;
 	}
 	iter = __start___verbose;
-	modname = iter->modname;
+	modname = dd_modname(iter);
 	iter_start = iter;
 	for (; iter < __stop___verbose; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
+		verbose_bytes += strlen(dd_modname(iter)) + strlen(dd_function(iter))
+			+ strlen(dd_filename(iter)) + strlen(dd_format(iter));
 
-		if (strcmp(modname, iter->modname)) {
+		if (strcmp(modname, dd_modname(iter))) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
-			modname = iter->modname;
+			modname = dd_modname(iter);
 			iter_start = iter;
 		}
 		n++;
-- 
2.20.1

