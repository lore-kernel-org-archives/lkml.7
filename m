Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4DDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2DA21835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9EJ3E9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfLEVwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:19 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46358 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbfLEVwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:15 -0500
Received: by mail-il1-f195.google.com with SMTP id t17so4346304ilm.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czlw2v1n44KvBNP8Ri+2G2naF0l2P1nitiHJyK13A/U=;
        b=u9EJ3E9o639t3kAnoadfidXpqM8i75hfWT/AjwGATRRAXqt+vgdXk3o6NMYjSSYRIO
         xdwWxq03v4+d3jx34V3lISTR0LB0c2glrCVbECdHrw9m8GF352a38IelDwX7LGhaHqsj
         VNRwnDtMXjcdjn5G4f5Rms2R0e5BWp1xeoWgpUH+PKInJfVoIkgfYm7exfaCK+tCuw6b
         8JM3h7CVakZaAQR/REWv0ug+A8PV/FN73Hh0DYGMXtkLD8RMvu/0ZfkiHIxfzNz1atIV
         DrByREG8pAGzwYSNsLUQvMOTWdIIf4lDdWjWoxkY+tl7+4vZIwWhw7EqmGsHtoD6F4oI
         4JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czlw2v1n44KvBNP8Ri+2G2naF0l2P1nitiHJyK13A/U=;
        b=sQr8a6BhfsJpm0bCsLAdV8hrFAZ37MjLM2iUtuGGo4ZqsrXiBzidTdIw7xWDls20/Q
         RBv1dwb5+NilzTVUPHcd7exc4U3kfU1mM1HJif++NlAv8GlFmozMRrynykDIeFWKYOtX
         DQtDeTKY0iTGl6uk3j20RMPXPUWgi31FXCxD9fu+abMCDndT9G4b5g02G0Ndx69qURio
         OKtxwFRi0oFmwKYxO4SHn0xCAxofMp+NvkiUHt+6EFFRw2g47FX3rnKsl/0a26nKJz8W
         h1TDBC+pivag8hw6lgvF1c54NLF2fpGWqKhliX4koNjiYH3Nxva0XxklAUUW/uAhq2mx
         fhxQ==
X-Gm-Message-State: APjAAAVKx3b1sRWE+rjtGbLNhkGCrsYW05C7LuEOYh3ba5p62ub7uA/W
        HXWa7WHUKYGVYaYfGKzU05vPUylUlgc=
X-Google-Smtp-Source: APXvYqya6eFerJqElswc8s9VKDzi90BI3XEF+7SqiXw2fzyMVerqm1YuZsVmIbv5DqAIZk97Y/NsbQ==
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr11686219ilg.137.1575582734406;
        Thu, 05 Dec 2019 13:52:14 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:13 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/18] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Thu,  5 Dec 2019 14:51:38 -0700
Message-Id: <20191205215151.421926-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the code-block reusable to later handle "file foo.c:101-200" etc.
This should be a 90%+ code-move, with minimal adaptations; reindent,
and maybe fixes for compile, behavior.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 49cb24948e12..f0cf90e672b8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -292,6 +292,39 @@ static inline int parse_lineno(const char *str, unsigned int *val)
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
@@ -350,34 +383,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 							    UNESCAPE_SPECIAL);
 			rc = check_set(&query->format, words[i+1], "format");
 		} else if (!strcmp(words[i], "line")) {
-			char *first = words[i+1];
-			char *last = strchr(first, '-');
-			if (query->first_lineno || query->last_lineno) {
-				pr_err("match-spec: line used 2x\n");
-				return -EINVAL;
-			}
-			if (last)
-				*last++ = '\0';
-			if (parse_lineno(first, &query->first_lineno) < 0)
+			if (parse_linerange(query, words[i+1]))
 				return -EINVAL;
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
2.23.0

