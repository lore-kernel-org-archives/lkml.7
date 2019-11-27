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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48569C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221D420835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTRpwdA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfK0RvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42715 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0RvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:24 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so25814622ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE8w0wMRoXjYU5yMlPYtNhR9/So/tLdxFIEhs/BR7j4=;
        b=oTRpwdA6eDpJzBCE/InF3AHw3bB7kE7rWw8/Q2bjDrPhXqdNakwK3Y4o8FsMtzZWQY
         0xz+AnWFynLTM0Rh9SnihftZvgnrU4uwtZZNK/e1vGRSE/l4qduwpQ1Idf7yma/GtoDi
         YeeGUAMx7r4oqJ3GPh9uJW5PuwIJwZelftODPmeJYQ7Uly3usFkGBMYP6rOb2I5y6+H7
         Ey6PhCRQNQnNMByyXMiclm6WXiiGRRs27YkqT2wx1jmGwv9U5SEGXV5CliSwqO1noGAc
         Avn85wOTVu4Nf2Ve2iy0JD+puY5r9HHOodi42lKK/1j8lCK8rw9K/FVy2oXC6WqVRrGD
         X3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE8w0wMRoXjYU5yMlPYtNhR9/So/tLdxFIEhs/BR7j4=;
        b=R1vP3pxJjIUQWia8yJBodKOgN+Nhz6lOLOgTm5W+6YxYr8Bpc9b1x3FuaDjMWyQWLe
         btUDzwnCtNwERLBVLuQZ6NF1R38x0XnemTxa01RzxmH8Hwz+Dl8nq3pNJffbohaFkOJg
         neJW2XV03GZtPs7/OBpbv/z/tk9QfV7y6wFEkSXy1vwP+V1zbLY+WSosvOuVevXnP4nT
         Fca+n/QvXvLS1fZTVQWohLQugdxbt3ULyAY6GRee+/BMwrwDmC7QPhWlpGQuW4ALKKcq
         KEz3gX2fkYU50+W25SHQAvDI5feGZORpkDKVcjwLg4KjmjNhjCU7Tx7h80SASrgdRnmQ
         rVKw==
X-Gm-Message-State: APjAAAWBhLygHFJE5KvhD5JaNf4DwLQCjUBLwgSCdeyzOPagdfNaLN+Q
        L6A3rhOfi1FencWsYgP0p5w=
X-Google-Smtp-Source: APXvYqx6cOwFDHDBGNePpn3HLsnyg31rrYusaoy8em3jvdlX9PFaPzMM1yXmvj1KFm+WP7uWP2nkzQ==
X-Received: by 2002:a02:aa0c:: with SMTP id r12mr5758550jam.75.1574877083896;
        Wed, 27 Nov 2019 09:51:23 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id k20sm3945029iol.3.2019.11.27.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:23 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 11/16] dyndbg: add filter parameter to ddebug_parse_flags
Date:   Wed, 27 Nov 2019 10:51:21 -0700
Message-Id: <20191127175121.1351752-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
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

