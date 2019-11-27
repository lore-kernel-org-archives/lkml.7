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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0292A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN3U/3Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfK0RvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:07 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37710 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0RvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:05 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so15203627ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVqM3XyMgumqJ3SCUSrKi+gH3fLBN/ajp7m/rX9qNj4=;
        b=nN3U/3EcuU16psD8wY25vqnduQZh2jv6Yu+vYujZXF1lWxDlnWhaCxMsMIryFWP69N
         nWQDglF4GS59DSP9fBmpZBA22fTbu1grsTShquz4RSATnmJ4kw2607W15VRbEbaJiuvL
         xiIQS3BgvCXvWoh7LYPSTG7Khj32X2POwzt+zh4fhBInmLFksXDORTeQV972qLXW+9te
         AkzicMyrwmXg3cw9bN4z0qImGtsGovGp7gzwx91m5NCnn9GgoLrVDTHsg95vPhJS5B/X
         d1v+LelJGh6V9PLskS5KutLdpNyo7vK4yN4ApYakgiBEdD316mVgZNdEuRjoTNHjkMVD
         xW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CVqM3XyMgumqJ3SCUSrKi+gH3fLBN/ajp7m/rX9qNj4=;
        b=QrSlm26hvh8mq8a4rkvvqGRG8JBJLzuCRAfqL78gnkmh+b1rialwFwCSrOm5tuuwUF
         oPa0OSfRi3Qfaf1VzjRX6XqMpMXY0NSUTDoR9x4AG4NFtZidWs3RRJUUyGptiI/IuTrO
         AuQT887Uhfm7lSDQjPx+AcnT+L/ue0nyJaK5wRomQykyTcIhNZxBc1snNd6iYAwEnWJw
         xmna6RMBUYsx1j4YpwY8XaGx8NXEl8U95hEDbUG/hKlZKkriOQl4IFvQCUzRQTRRIlh6
         UQ0OpOkgusbgNfhK/5xLDOHvmOng1Hqkp42E9+6u44dxSlNX1x31AjW3pAXnDTqMe0DY
         K13w==
X-Gm-Message-State: APjAAAWUsV1SKGfugqflcQOCS1m2aZPuCQAKyAlkPBoCYN2pBMXQY7Yw
        3aq8vJdj+x/9nL+kjEm+NJ4=
X-Google-Smtp-Source: APXvYqyw7NnTp9hfhjzDKn29WQ7o3uXpQtbpO2HhpnlknHSZR+HkdO3/hrlZsAWFqIhTtuURdmLr1A==
X-Received: by 2002:a6b:c982:: with SMTP id z124mr38750043iof.291.1574877065076;
        Wed, 27 Nov 2019 09:51:05 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id k11sm4574351ilc.5.2019.11.27.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:04 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/16] dyndbg: refactor parse_linerange out of ddebug_parse_query
Date:   Wed, 27 Nov 2019 10:51:01 -0700
Message-Id: <20191127175102.1351520-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
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
index 0e4783e11755..496c3da48e2b 100644
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

