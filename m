Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5367DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E120835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyGVp04Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfK0RvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:04 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35832 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0RvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:02 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so12325615ild.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBvCUJLGzPXX0Pn9enxN3cNtWBdwerBLUit9nHVW5Gk=;
        b=kyGVp04QChNhrcDytyBm+e8HM7yIeAysxnAW7WR701jqbTnJC+psbtgEmE9dQROAmC
         CWiHA8wGuDXbZwJGABZ5UMBWMwFBDfBRjKQ4yb5HtQRb3Q96a0TozWUm8AfQ0xjZZ9Xh
         YLiyKw5GmU3Xi3QZls6EAQIaSw+5NPYDDkhfgCZ2SCbkTDD+7MyQIv8RH+Kz0FKIXYYs
         umd0bj6hddy79+84ge7xGVGM7E7cb/m6GswBA+pa9lMo9OWibOlwEp5SnSx7j2yitH24
         io5nt1AFCTHsJZf5+xHnU8YJ1lAKZetcs+OAT/ssr+hGYXMhp0SRMTwlg3INj3T+8zmz
         5bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBvCUJLGzPXX0Pn9enxN3cNtWBdwerBLUit9nHVW5Gk=;
        b=TutOMPYNJSTj49hRZb65YtqYkyArcFRwdCBpZ7UVARRzbMdtXAjZXBqQZCgxbW6Ql4
         WzDYYaaLKGr3ZX+XWMXoJcAKUA8wCBa/BBZN4D7XLzX6Ebmod7Ayw2YtbaBwNoeUuJ2x
         TMQwfLtvuU0NW9jKGlNJ4XJOdYdqK7eoVDGkVJJ/OHhv4d2xaoFd/7PMRBmoTv51p683
         zirQSWWNV8t/8TJHmunJ9Ek0gd+6AD/CV9XON5fxYuT5y1WW3E7ANJs9v5NdX143THdF
         b9JJxqzwdBxmJI/W8fapkpQxpCnDZXPFay5CxjmJE+GavSCRY5gZTMIsIkMzDxsNmfLs
         8+WQ==
X-Gm-Message-State: APjAAAWSMaWXfT7v/PK2Hx7TA36222ksL3tCHHbYrIi0hWMPneZl2wue
        b/ZjCpijprr7DlgCB/AYC0U=
X-Google-Smtp-Source: APXvYqysi+xUXxse8kUjtUg4JMB1tULU8dkPD1ZpTyIJAMyHe+XKtKKbdbz6/XsC+dDfYoapvlVYKg==
X-Received: by 2002:a92:5b86:: with SMTP id c6mr44156249ilg.135.1574877061578;
        Wed, 27 Nov 2019 09:51:01 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e15sm669445ioe.18.2019.11.27.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:00 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 06/16] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Wed, 27 Nov 2019 10:50:58 -0700
Message-Id: <20191127175058.1351461-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddebug_describe_flags currently fills a caller provided string buffer,
after testing its size (also passed) in a BUG_ON.

Fix this with a struct containing a known-big-enough string buffer,
and passing it instead.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b5fb0aa0fbc3..0e4783e11755 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -62,6 +62,8 @@ struct ddebug_iter {
 	unsigned int idx;
 };
 
+struct flagsbuf { char buf[12]; };	/* big enough to hold all the flags */
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -88,21 +90,19 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 };
 
 /* format a string into buf[] which describes the _ddebug's flags */
-static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
-				    size_t maxlen)
+static char *ddebug_describe_flags(unsigned int flags, struct flagsbuf *fb)
 {
-	char *p = buf;
+	char *p = fb->buf;
 	int i;
 
-	BUG_ON(maxlen < 6);
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (dp->flags & opt_array[i].flag)
+		if (flags & opt_array[i].flag)
 			*p++ = opt_array[i].opt_char;
-	if (p == buf)
+	if (p == fb->buf)
 		*p++ = '_';
 	*p = '\0';
 
-	return buf;
+	return fb->buf;
 }
 
 #define vnpr_info(lvl, fmt, ...)				\
@@ -148,7 +148,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	char flagbuf[10];
+	struct flagsbuf flags;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -205,8 +205,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			vpr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp, flagbuf,
-						       sizeof(flagbuf)));
+				 ddebug_describe_flags(dp->flags, &flags));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -820,7 +819,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	char flagsbuf[10];
+	struct flagsbuf flags;
 
 	v9pr_info("called m=%p p=%p\n", m, p);
 
@@ -833,7 +832,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
+		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
-- 
2.23.0

