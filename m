Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC82AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9717D20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BsSoNl5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDIV0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37147 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfDIVZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:25:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id l20so135769edv.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJWlbI3M5V4dXQvM7hUr/BPrpI85lJLXDxFuQhj2gkU=;
        b=BsSoNl5ULzVRnFLa9wln5BiY8nLup+uGZAEGwNmPeJ1nIsQ+PjyEVm9+/NSOt26nKN
         MamiBRtdfu8gsXVfsBMI9IOL0RzkYKh3wgy7e2aWQtBql6zuYW8P/fi9IuAhdiu8JV9a
         Q8snCq7wAfKk9YJSjUY4GkLR69fDfiqnFXOb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJWlbI3M5V4dXQvM7hUr/BPrpI85lJLXDxFuQhj2gkU=;
        b=DM48rNzmXud8ane0pSoiyQNyfQ2aAtAlUuT9nvjcVHtSjQCWt/hwbe7tFEvPB5Uu7J
         f3BvcxmqmbVaPnevp4LupbUX3fhU9/8DAJooSWmvjx8qfedx9PrWdDaUSn6J2ipweRiC
         6Hun7ytX0xnqKYCbK+0JcrovmcganAbQ6/ETpL3agRE5QGmi5oUnblFtOihmbVdfnFuY
         pIC0TUnHswmkGnjWLq0PAVCqEDhpq03SayqAppWyjTHXhSNj6obxUPbnTvT76AyTX3iE
         twwAEE3vHsZ5fLCZppbubJk0qqXN4aXyXaCf0CINdPBZTa+aRxJJVnBobMyZvZWBy5NP
         CNDw==
X-Gm-Message-State: APjAAAWueWt5mjgTeJaSo0zfxWhJf67rpr3GvX7BHCrddAH4n+3CB9BY
        j2D8cSCTZA0ZbT2jEmkAw48I4g==
X-Google-Smtp-Source: APXvYqyfL2QLKatN1Zso4TGsRkRh6NwZrNkl/2VjaxKm1Ospjn3RKCclNHyyFw8uO7yyOlCzL4mSNw==
X-Received: by 2002:aa7:dc4a:: with SMTP id g10mr24670956edu.103.1554845154945;
        Tue, 09 Apr 2019 14:25:54 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:54 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 04/10] dynamic_debug: introduce accessors for string members of struct _ddebug
Date:   Tue,  9 Apr 2019 23:25:11 +0200
Message-Id: <20190409212517.7321-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
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
index 7bdf98c37e91..497b1c8ccc2a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,6 +37,23 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
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
 
@@ -158,21 +175,21 @@ static int ddebug_change(const struct ddebug_query *query,
 
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
@@ -197,8 +214,8 @@ static int ddebug_change(const struct ddebug_query *query,
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
@@ -533,10 +550,10 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
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
@@ -790,10 +807,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
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
@@ -987,20 +1004,20 @@ static int __init dynamic_debug_init(void)
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

