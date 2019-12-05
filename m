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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69224C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189092466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6gwEXQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfLEVw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:29 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38292 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbfLEVwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:20 -0500
Received: by mail-il1-f195.google.com with SMTP id u17so4414876ilq.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECGG/XNVXiLaDg6OhX+pEjRtCpyeoVbqK1ISASeYZrc=;
        b=b6gwEXQrHIf7BHdjWCsnNu1N0TJ583HXk5tZUmKGOGHX06pVvi4cx9hk0A+pnwo5pc
         GNdZ2mSOfp7bX2aalSMtvHB7VLX6JjZgheAmNK9VS1GRAm+Rb1JMdr6WspHSAGV5Tiww
         Or4Y0GVOHVFnus4/nGgfWC6fqReZzVMRNrM4maf3cLL8rpeqCkPL1KTudkLtpUGOOtmG
         FNqTjqyTZN/xjhkDYm5jYyrG2M4hDmdwHWagTmqlEfZQLnkq11WC2HE1m4BgcC1gWFan
         izBJehY8aTgbmrGSIjqydNSfiKqztCoDd8v72Tl8DF4s/sI7XQCrBna4eFwjcyVRGHP5
         eVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECGG/XNVXiLaDg6OhX+pEjRtCpyeoVbqK1ISASeYZrc=;
        b=RDCU6BfkJVweMcc3dEZaAyL8jrbZojbbG02R7DRWsJBHvAPfjPafXOEuO8UIU0AXlU
         l0drC2oZhBb5a7vsYL2qeugSGa4AK1vmGhYTl66p9uBgt7/SnDR2f1Txrxvnvk7v5RM+
         79Fnx5h6f1mVBzcrdfkcH2NHAil5SqCP06T9FywHGSwaU1bRObvMIjB9YWWfu1Ig2d40
         Drshl0TO0F6P31DdJ5aLuBV/9BJN/jBm8HkWwOZf3ansP0kGuKbDqtwiEBAbRVt+O8q9
         JFf2lEgwivEkd5MgdtbJKjdZ/QOMKf1yQa27qFOru1vSila8uK7Cd6CR805hlvM95zof
         3S3Q==
X-Gm-Message-State: APjAAAXPYFCCYIefxRRchh4LGj4JBLiQVJ8dOzbJt557lRymx0tkAcEL
        R0wwrZvu97my7AnSIfQp3J0=
X-Google-Smtp-Source: APXvYqxCUug3AZKxeiE6c5qQwhyNzkgwITHxPiL6wu13W3NnnYZQSA7seOr2PEkb7B7XTbv1pzRqXg==
X-Received: by 2002:a92:aa4d:: with SMTP id j74mr11284418ili.271.1575582739787;
        Thu, 05 Dec 2019 13:52:19 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:19 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 10/18] dyndbg: combine flags & mask into a struct, use that
Date:   Thu,  5 Dec 2019 14:51:41 -0700
Message-Id: <20191205215151.421926-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

combine flags & mask into a struct, and replace those 2 parameters in
3 functions: ddebug_change, ddebug_parse_flags, ddebug_read_flags,
altering the derefs in them accordingly.

This simplifies the 3 function sigs, preparing for more changes.
We dont yet need mask from ddebug_read_flags, but will soon.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 839f89b24474..0d1b3dbdec1d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -64,6 +64,11 @@ struct ddebug_iter {
 
 struct flagsbuf { char buf[12]; };	/* big enough to hold all the flags */
 
+struct flagsettings {
+	unsigned int flags;
+	unsigned int mask;
+};
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -142,7 +147,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			unsigned int pflags, unsigned int mask)
+			 struct flagsettings *mods)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -191,14 +196,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | pflags;
+			newflags = (dp->flags & mods->mask) | mods->flags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(pflags & _DPRINTK_FLAGS_PRINT))
+				if (!(mods->flags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (pflags & _DPRINTK_FLAGS_PRINT)
+			} else if (mods->flags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
@@ -414,14 +419,14 @@ static int ddebug_parse_query(char *words[], int nwords,
 	return 0;
 }
 
-static int ddebug_read_flags(const char *str, unsigned int *flags)
+static int ddebug_read_flags(const char *str, struct flagsettings *f)
 {
 	int i;
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
-				*flags |= opt_array[i].flag;
+				f->flags |= opt_array[i].flag;
 				break;
 			}
 		}
@@ -430,7 +435,7 @@ static int ddebug_read_flags(const char *str, unsigned int *flags)
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", *flags);
+	vpr_info("flags=0x%x mask=0x%x\n", f->flags, f->mask);
 	return 0;
 }
 
@@ -440,10 +445,8 @@ static int ddebug_read_flags(const char *str, unsigned int *flags)
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
-			       unsigned int *maskp)
+static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 {
-	unsigned flags = 0;
 	int op;
 
 	switch (*str) {
@@ -458,31 +461,30 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	}
 	vpr_info("op='%c'\n", op);
 
-	if (ddebug_read_flags(str, &flags))
+	if (ddebug_read_flags(str, mods))
 		return -EINVAL;
 
-	/* calculate final *flagsp, *maskp according to mask and op */
+	/* calculate final flags, mask based upon op */
 	switch (op) {
 	case '=':
-		*maskp = 0;
-		*flagsp = flags;
+		mods->mask = 0;
 		break;
 	case '+':
-		*maskp = ~0U;
-		*flagsp = flags;
+		mods->mask = ~0U;
 		break;
 	case '-':
-		*maskp = ~flags;
-		*flagsp = 0;
+		mods->mask = ~mods->flags;
+		mods->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", *flagsp, *maskp);
+	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
+
 	return 0;
 }
 
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
-	unsigned int flags = 0, mask = 0;
+	struct flagsettings mods = {};
 	struct ddebug_query query;
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -494,7 +496,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -503,7 +505,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, flags, mask);
+	nfound = ddebug_change(&query, &mods);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.23.0

