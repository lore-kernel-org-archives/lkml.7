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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FBBC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3468224673
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unAIKatQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbfLEVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43605 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbfLEVwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:19 -0500
Received: by mail-io1-f66.google.com with SMTP id s2so5224034iog.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaXRbIcfrfy+6sOtLvNoOiV/KR6L6wO+a8T26somqJk=;
        b=unAIKatQPjwBArX0E/TE5RpLs9pmJyVTw4L0vbydqRAjOJkwV6QGGF7yZwtGrD19rR
         2jTSxrpM/XrNU7ADAUCMm0znq3mgaSRvb+nS9Sm/XXBs2PKWzEd2cSnUZCL5Vu3GNz/U
         nfZv0FnUDy73za6qVST7mAX1xYUyEnGY9H0nYe776uo2aRYh/2sxjd3mMHsj1A7UT0EK
         weuok8jWyrBeanPzyJjs2uxuLfUUGdMqyGXDy7o2gUkeZhKclILuCrx/yidb5xiljM6M
         ZhYQzUhIJ1ovUmtgglPUnuviFVEqv99M4RoziHpMlEZNNhtp4aCnGv+X1tkCbzdyUveU
         owfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaXRbIcfrfy+6sOtLvNoOiV/KR6L6wO+a8T26somqJk=;
        b=YI5dPe98G+zjmjMMTY6Etr+uZMTu0LXzhafTihFqfuzWwUEpioBxJg3sS58bcsHR+Y
         guykHJZ6VgYjBDWjJHeZrCRzKMCqSgFsPbnBh2XD1j1bUPFkkYVX1j0hTDJW2nwIuC/u
         zyVA6EivtiBTSvS3rTLBkT6ahRcV3T1ykuOWHD5hN+ozuK48lpe/sbGov10eeTXW/9Zr
         YXrQYWd4R6dWQNhHi3jWxOLAGYoz9PFyyRe+51PdueWBxy9ttfo4Wk0ZkQWKW0ikX26o
         fnhPT9+MLjR0SVnQ5goxQdTAtP7Fkgsu12hDMyGhgmd23auRB+5mhWN5sgLphtfBHOZ7
         4BGg==
X-Gm-Message-State: APjAAAWMu5wixOWZjiMo1oTmj4c2+RSJ88JajCEfmQpF7NCp3H3BBY4g
        VzBrF4iY6vkU9Gs5/oSc2+4=
X-Google-Smtp-Source: APXvYqxXt5TiZxCOwghX+47z1s9SBHcobFUtVuRMnefSDaoq+zVFRjVn9UU9txV31GA3OVrdgzTo3A==
X-Received: by 2002:a6b:731a:: with SMTP id e26mr7953547ioh.254.1575582738277;
        Thu, 05 Dec 2019 13:52:18 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:17 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 09/18] dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
Date:   Thu,  5 Dec 2019 14:51:40 -0700
Message-Id: <20191205215151.421926-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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
 lib/dynamic_debug.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9fa6d4eeae5c..839f89b24474 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -414,6 +414,26 @@ static int ddebug_parse_query(char *words[], int nwords,
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
@@ -424,7 +444,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			       unsigned int *maskp)
 {
 	unsigned flags = 0;
-	int op = '=', i;
+	int op;
 
 	switch (*str) {
 	case '+':
@@ -438,19 +458,8 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
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
2.23.0

