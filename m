Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C699CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F06C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUquq++S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfJ2UA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:59 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41216 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:58 -0400
Received: by mail-il1-f195.google.com with SMTP id z10so6126ilo.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5wyzzOlOhv9OQYwHY5Y47upGbberqCt9PFifiOihdU=;
        b=JUquq++S8Cp+MMx/h0aNziRNpklzh3S0xcRlQHBptC0BLb4Owy60d3nfijGy1wIOji
         gHuCkkyWd9ymq4MH1AN6SkBCumAdcO5zzpZvj2ELbwNmTmYcwAP0WDDWQeq8W1Gf2uRl
         os+KhpqDqSpJafjUgUzy8uCa6436Fq1BuJ+LnCY++nihhU4j2IAAzcXdnbuUAtHg04tf
         6SyWOrRQLm5azOCZaFukbF8p2HoBcbHmI8zemCxmZfVh/p9BWDYldR9OmlNKRPH5kqhA
         N3RTuxx7CNAWYsNM70tj+3wjZLv9jA6netL8tNDMwyWphE9bTDiKvyIGYoZWKSWzBEZ/
         /Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5wyzzOlOhv9OQYwHY5Y47upGbberqCt9PFifiOihdU=;
        b=ciP4G9i18bM63DrT2iF+xJMdiCFAMoDFIyqCbfRTw4D+CTfZ86YpqymeRHubszypaS
         mNGV4XSFu5Hxk7WQM4aZCv7ZdCAOSFEncGjyPqX4ORtTS7uqgkZc0YrxMKg2Xj+D97OY
         OtlZpOYijwNPBeJkhh6KovCU50mWLM8sBzuwvF9nQ9vmxwr6LZZ+1hLAI3jmGdHRxnVS
         25NYhPuOf05iGSSSeyZIbuVEKlmpwOJGwuVHm4Yagu5yI419FKuwqo5JZeJFIFtq4Np0
         cxL1tz43E1iOPDmUyQCx0Gnl3Ta3wCttzBCkS4FBfaCLDUklZIeZnMqv1RDgPBjU/Nnp
         OA2A==
X-Gm-Message-State: APjAAAX92azm8kIphJwsz7e6BP4QNOuu6FKhB0crOmVgkyMZtIi0o5h2
        mvSy+BEFWuIPkgjNcJ/u8KqSFF2GKHs=
X-Google-Smtp-Source: APXvYqznPvSHAEjbKgSi/f18DYoP7cI6I+Le8NRjWP/Wtzjt8kbnALuL1JYpOEC5FlfojQVzJ3B7xQ==
X-Received: by 2002:a92:8498:: with SMTP id y24mr28062448ilk.89.1572379258082;
        Tue, 29 Oct 2019 13:00:58 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id p13sm383001ilg.10.2019.10.29.13.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 10/16] dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
Date:   Tue, 29 Oct 2019 14:00:54 -0600
Message-Id: <20191029200054.10091-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ddebug_parse_flags accepts [+-=][pflmt_]+ as flag-spec
strings.  If we allow [pflmt_]*[+-=][pflmt_]+ instead, the (new) 1st
flagset can be used as a filter to select callsites, before applying
changes in the 2nd flagset.  1st step is to split out the flags-reader
so we can use it again.

The point of this is to allow user to compose an arbitrary set of
changes, by marking callsites with [fmlt] flags, and then to
activate that composed set in a single query.

 #> echo '=_' > control			# clear all flags
 #> echo 'module usb* +fmlt' > control	# build the marked set, repeat
 #> echo 'fmlt+p' > control		# activate

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1b65821162e5..91c658c35902 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -293,11 +293,11 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 		/* range <first>-<last> */
 		if (parse_lineno(last, &query->last_lineno) < 0)
 			return -EINVAL;
-		
+
 		/* special case for last lineno not specified */
 		if (query->last_lineno == 0)
 			query->last_lineno = UINT_MAX;
-		
+
 		if (query->last_lineno < query->first_lineno) {
 			pr_err("last-line:%d < 1st-line:%d\n",
 			       query->last_lineno,
@@ -311,7 +311,7 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 		 query->last_lineno);
 	return 0;
 }
-	
+
 static int check_set(const char **dest, char *src, char *name)
 {
 	int rc = 0;
@@ -399,6 +399,26 @@ static int ddebug_parse_query(char *words[], int nwords,
 	return 0;
 }
 
+static int ddebug_read_flags(const char *str, unsigned int *flags)
+{
+	int i;
+
+	for (; *str ; ++str) {
+		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
+			if (*str == opt_array[i].opt_char) {
+				*flags |= opt_array[i].flag;
+				break;
+			}
+		}
+		if (i < 0) {
+			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			return -EINVAL;
+		}
+	}
+	vpr_info("flags=0x%x\n", *flags);
+	return 0;
+}
+
 /*
  * Parse `str' as a flags specification, format [-+=][p]+.
  * Sets up *maskp and *flagsp to be used when changing the
@@ -409,7 +429,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			       unsigned int *maskp)
 {
 	unsigned flags = 0;
-	int op = '=', i;
+	int op;
 
 	switch (*str) {
 	case '+':
@@ -423,19 +443,8 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	}
 	vpr_info("op='%c'\n", op);
 
-	for (; *str ; ++str) {
-		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
-			if (*str == opt_array[i].opt_char) {
-				flags |= opt_array[i].flag;
-				break;
-			}
-		}
-		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
-			return -EINVAL;
-		}
-	}
-	vpr_info("flags=0x%x\n", flags);
+	if (ddebug_read_flags(str, &flags))
+		return -EINVAL;
 
 	/* calculate final *flagsp, *maskp according to mask and op */
 	switch (op) {
-- 
2.21.0

