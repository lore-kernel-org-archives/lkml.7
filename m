Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C04C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3FB2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8QhW+SE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLJC2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:15 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46484 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfLJC2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:11 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so14671761ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czlw2v1n44KvBNP8Ri+2G2naF0l2P1nitiHJyK13A/U=;
        b=o8QhW+SEg/jdK5XN5U4u5sEftKv1IiVT7BLpprM61ysKGNjvdEYxl6XBqgRwOhL71z
         B6fPFaZ+hhavmO6HANcNoRNIG0siztrx9Eee+jgNEC0HoDMsjyUJKTy3zTXA0KqQ88sH
         HIw81xabtLRcMxxdof//JE882ftCpb6sGiCYclQzBBS/iU0nQC5CQbIdixLKd3joNgTw
         YMs1CObgEU4ojh4uvgxiIZmT3MMPTRmB7dcd26IYOIwDghI4jfQNiK4IEKepszvxg0lH
         qD9Xx1Y6QUH4r7D5Im93w4NduylyAqEyEBbeZUcR1+c5Gq6snSqc7NrHhszsZNbohJam
         uvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czlw2v1n44KvBNP8Ri+2G2naF0l2P1nitiHJyK13A/U=;
        b=DsT90D+LUhYLHC2yQsHFf0T6mFnBMbnPQcQCQgKVE/blpM0gVCZT+KI5K6QvQfbQJ2
         WnWvholkK4SpzDExCGVQHpmGE+0SbBPfPb3zrdTgaDKEsdK3z/NrRg4LUGffwkW5hr9x
         f+NC74PZz6OpCQp7tjy355JLOvMiYBy6IO8frQOlnBj9TDJynWkGf0DHjv1jKT+wZICM
         JAXXoLOSvigbcseqcM1N5kG2KIVxI8UCgh3KJ5N0t7cMbBzD+6peIU8fNyjyFZcs9lZ6
         /0+kzMG9X76AS5OvExW/bqapZ6vhIA09esmQEeF0CGZDRsW5BNpz+JI4zrcIiSyvRje8
         /y6w==
X-Gm-Message-State: APjAAAV35+aZ3Imvt6VmJZFmxTABNsrP8/yWrsggitAXfvzvYBvn4qFv
        8Vq6Pi8Q9zEkdZ0caQH9puE=
X-Google-Smtp-Source: APXvYqwz7MJt4Z+kz8L6nnenQiq4A/+cYz7GlV/gJ/IsLmW9B6LxttmvumML8CYMaAxQ4e8mzG2i8Q==
X-Received: by 2002:a92:1e0c:: with SMTP id e12mr13616006ile.115.1575944891083;
        Mon, 09 Dec 2019 18:28:11 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:10 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 07/16] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Mon,  9 Dec 2019 19:27:33 -0700
Message-Id: <20191210022742.822686-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

