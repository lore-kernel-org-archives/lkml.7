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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08FAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760732077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWzaVJnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfLJC2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:24 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35888 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfLJC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:18 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so14748421iln.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CE8w0wMRoXjYU5yMlPYtNhR9/So/tLdxFIEhs/BR7j4=;
        b=jWzaVJnk6E+Cqe8obtDTJHU5TTm9DGsV9u+VMKO1rRqCtMj2iuYn0QB2eP+Kj/Kogo
         NhdOEbyrc7js/jp0C67ADtzdFMSo1ZEMx6vkg9gzHi2KRe6D5iYY/GOLYX8kKBidXRwj
         sDpqrJZlcljfsTiwiCjHedE3ZG+6KJP/F9M8SHUGtq1s7zQXcSfUqKM480M0wnG81uUO
         FE6zpmF1fag9aOGvAOlFeCuzywg0VLirNwd+WsSbYazGQczL5svc/n+AidedKLK2GnuP
         pTPW+u4KBh5WyBGtrea/WHpnPfRJ2ZX9aevCsvYTi5HIs8mb69qaiHeM8fCm6G9lxvLr
         LghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CE8w0wMRoXjYU5yMlPYtNhR9/So/tLdxFIEhs/BR7j4=;
        b=IqErRmFGxmS6twDfdaUv2MsIdQoztDnAy5tRK5uJW6cy3mIi81rE7peBUIsIDwCegl
         /uzb0SZdUNUQVTc/K8IchLMksg+swyxzrLeLrnDQ3mlGxxuwDb9OvZxfdQSPmlF/phvn
         tUYlRPd/tvnKG1Cakbkgew4mGKpDwW6upqJykYzfdw2zR/w4/ek7Wbd7T3ixl8mtVmQ+
         hH+8BM00XOlXW8J3Oyyx3ZyCYSbFH95++8seXWkXJ5l7hdRD5RJYMQCSH/dsRoCxNqYY
         H5nFAYWQmu23Fp3z+nbjzIAatEB1Qqfab0PbohO1n+wkmlFmdkvAF0mB1dieBPGPLPeR
         QkOA==
X-Gm-Message-State: APjAAAUr4whxLbB2w+3OMUhgIgQQcS8tGmait7AVAHxtB/DcO5R+sc+q
        /aqTBaUUQfQlDQn4FibH5ZU=
X-Google-Smtp-Source: APXvYqzUSjE/HuGrJ5G1rlFqLgqTU6mWskt1Ydu56D5vawUo60zsHxiXHhQAzBo282bZfm+Ph+jiuQ==
X-Received: by 2002:a92:cf52:: with SMTP id c18mr274116ilr.44.1575944897825;
        Mon, 09 Dec 2019 18:28:17 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:17 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 11/16] dyndbg: add filter parameter to ddebug_parse_flags
Date:   Mon,  9 Dec 2019 19:27:37 -0700
Message-Id: <20191210022742.822686-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new *filter param to 2 functions, allowing ddebug_parse_flags()
to communicate filter settings to ddebug_change(),

Also, ddebug_change doesn't alter any of its arguments, including its 2
new ones; mods, filter.  Say so by adding const modifier to them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0d1b3dbdec1d..8c62c76badcf 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -147,7 +147,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			 struct flagsettings *mods)
+			 const struct flagsettings *mods,
+			 const struct flagsettings *filter)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -445,7 +446,10 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
+
+static int ddebug_parse_flags(const char *str,
+			      struct flagsettings *mods,
+			      struct flagsettings *filter)
 {
 	int op;
 
@@ -477,7 +481,9 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 		mods->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
+
+	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
+		 mods->flags, mods->mask, filter->flags, filter->mask);
 
 	return 0;
 }
@@ -485,6 +491,7 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
+	struct flagsettings filter = {};
 	struct ddebug_query query;
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -496,7 +503,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &mods)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods, &filter)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -505,7 +512,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &mods);
+	nfound = ddebug_change(&query, &mods, &filter);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.23.0

