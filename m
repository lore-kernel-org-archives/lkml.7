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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38190CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5D72067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jum/qRib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfJ2UAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36575 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:46 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so16222415ioc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVfyTtri7OsgAKkzr9aOQARMtmuPqT5/gZLQ61yYxW0=;
        b=Jum/qRibMSfK/0pAGq3H3xR2clcvx0FhHJIRI5IHQtxNimsKjqk+ESA0VZp+PT3vcn
         qUwaaIf9YkgxQt1N3aLw7S18bcUQGjEpXVG8lugKwh0SSr3Q3GezzGDriC2FeXm2wKyI
         PUS7LoYBWop07plidoS1KKL62hh472+JxBrcF21NsqzuRL18nQbsFAk1ElDlAr3zp1Cx
         f6r1Tyehx/HtgD30UqZA5l/hGw1YMAyETMu2LF2ocxqQuM0S8ydn4hnp+ZP+fVHBb7zN
         tkshhtEcKKJjNus9AXictn+cczkFtj2CpU1kY2IaaqHPmHfEB+wn8ONfY3JprehQTdQ5
         Kwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVfyTtri7OsgAKkzr9aOQARMtmuPqT5/gZLQ61yYxW0=;
        b=BUXiRBFbbFZuow4Oxf7hQw07H72ejQdf3kwQTIWWSsvBWXDqtP48WHNDLubeIo9mSt
         ScY8q9NksJs9WNogXJHXz0Q5XudUB0ay8/PCKGifFAcEELdfUUAaa+68sQPyTsVWVgoP
         GnuhgTNqi3cF2A2RsAK/yd4v3xEGgV/uKvM0yx8XJGj+XTnpy+2XLOHNezL1fW/jGMQc
         cYEqf9YwyVRoJs9Il2jrAqjS/cQvhbg4c2fx/iATGV8vVNsw0OwcxfDRItxzSKtvRXNx
         MQH0BrmGcS47bB8niYHNCXlUhad8iOTkkx2n2TqFGzyVwbsDgzbcD+3Ju1v/VXpkJY/c
         3I/A==
X-Gm-Message-State: APjAAAUy0MnaVAYauDToOekyr9BD0UHrJkcbDtGiW9AS9QCPyl6xDJJ3
        u5qvg5wvniaCwYTxGwwwsgI=
X-Google-Smtp-Source: APXvYqwhO89FHtxT/eGHW9GGqf9oDrvhUSTRa2xftks5aoE9O3BBoSgstHxhEIST1vfae+/pEFWrxw==
X-Received: by 2002:a6b:ba44:: with SMTP id k65mr5317027iof.190.1572379245990;
        Tue, 29 Oct 2019 13:00:45 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id v13sm2203622ili.65.2019.10.29.13.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 08/16] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Tue, 29 Oct 2019 14:00:43 -0600
Message-Id: <20191029200043.9988-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the code-block reusable to handle "file foo.c:101-200" etc.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3ac77c49d623..2d0aad5af972 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -277,6 +277,39 @@ static inline int parse_lineno(const char *str, unsigned int *val)
 	return 0;
 }
 
+static int parse_linerange(struct ddebug_query *query, const char *first)
+{
+	char *last = strchr(first, '-');
+
+	if (query->first_lineno || query->last_lineno) {
+		pr_err("match-spec: line used 2x\n");
+		return -EINVAL;
+	}
+	if (last)
+		*last++ = '\0';
+	if (parse_lineno(first, &query->first_lineno) < 0)
+		return -EINVAL;
+	if (last) {
+		/* range <first>-<last> */
+		if (parse_lineno(last, &query->last_lineno) < 0)
+			return -EINVAL;
+		
+		/* special case for last lineno not specified */
+		if (query->last_lineno == 0)
+			query->last_lineno = UINT_MAX;
+		
+		if (query->last_lineno < query->first_lineno) {
+			pr_err("last-line:%d < 1st-line:%d\n",
+			       query->last_lineno,
+			       query->first_lineno);
+			return -EINVAL;
+		}
+	} else {
+		query->last_lineno = query->first_lineno;
+	}
+	return 0;
+}
+	
 static int check_set(const char **dest, char *src, char *name)
 {
 	int rc = 0;
@@ -335,34 +368,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 							    UNESCAPE_SPECIAL);
 			rc = check_set(&query->format, words[i+1], "format");
 		} else if (!strcmp(words[i], "line")) {
-			char *first = words[i+1];
-			char *last = strchr(first, '-');
-			if (query->first_lineno || query->last_lineno) {
-				pr_err("match-spec: line used 2x\n");
+			if (parse_linerange(query, words[i+1]))
 				return -EINVAL;
-			}
-			if (last)
-				*last++ = '\0';
-			if (parse_lineno(first, &query->first_lineno) < 0)
-				return -EINVAL;
-			if (last) {
-				/* range <first>-<last> */
-				if (parse_lineno(last, &query->last_lineno) < 0)
-					return -EINVAL;
-
-				/* special case for last lineno not specified */
-				if (query->last_lineno == 0)
-					query->last_lineno = UINT_MAX;
-
-				if (query->last_lineno < query->first_lineno) {
-					pr_err("last-line:%d < 1st-line:%d\n",
-						query->last_lineno,
-						query->first_lineno);
-					return -EINVAL;
-				}
-			} else {
-				query->last_lineno = query->first_lineno;
-			}
 		} else {
 			pr_err("unknown keyword \"%s\"\n", words[i]);
 			return -EINVAL;
-- 
2.21.0

