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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593BC2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D07F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuBdSWmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLJC2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40577 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfLJC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:17 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so17111336iop.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECGG/XNVXiLaDg6OhX+pEjRtCpyeoVbqK1ISASeYZrc=;
        b=EuBdSWmuNV2NYuib2Ny6ldhfWC7TORBY9Pj86pxIXE8FHUdK4VcWuclBt4ApKt+j2q
         VN51yPytIl/bxnTZwHoT+JTwkEa10Mm/jbHujyciWAHiSKHuHiCjYjYpUVZrmzwMZ97g
         FnHjskq1LYuJkGx+6aUGEwUetUU/r4CXo0KwxHCjtwpp5bT1uf2mJzQORnSC6MnqCeeg
         BY0X1+R52MtjjmTcXQIpgTHB3exlUMgaEre3FBcnIQCugMptD1g36F4eAyh9E6icJ6v2
         RUvjccE422TXEbvyeuqKHNDFcbvkT7pt/MjKyu1tCj+smkUvz/iJXBYgKZeApgBPXsUM
         4JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECGG/XNVXiLaDg6OhX+pEjRtCpyeoVbqK1ISASeYZrc=;
        b=OjBVhWJ6jcm0EHRk47SAR/cRi4aR4gBWj2syBmB2EPAuLrKFMTyGmvGBg6mhx6vgfZ
         Xm6pZFCgM+bj4k3wxm1Sd9JLiKVSrTc9hn5g1vCV2EDz3nJ8MElzK8uo419S/1ZHlwAK
         t9QRH2SZYfSGyOdi926q6SWgiFyJXPRqR6JTOlv5p+H3Qa0HU/L2NDg5HTtIlzMG/6Fl
         opDkoLr8bBzNv1NCrwB+iBSH5Vl8x7JF1Pi2rh9RdZvu7ztnQpM246H2q7KYsrSNa1sd
         eX+ngQrLmxdA7sfLBnJrELIShzuTl6riqO3Fq7mIGFblM5RCTk4DRLNZeuwvWpbvU2np
         d+Ng==
X-Gm-Message-State: APjAAAUScXo31RR6zZfw6qZs5ujBnG4ViFD34Ro8HxBfAn8jHTOA2EeN
        WdH5w/Sj4Ht9GN958r2+/z/1CPekNSA=
X-Google-Smtp-Source: APXvYqz/Vhbq1nL1kJnnxBqi9RmPc1k+F8aubrcI1+wWOlQNqtn3+K127uBJQxtqZLDBJRqX83zipQ==
X-Received: by 2002:a6b:bd06:: with SMTP id n6mr24003654iof.165.1575944896324;
        Mon, 09 Dec 2019 18:28:16 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:15 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 10/16] dyndbg: combine flags & mask into a struct, use that
Date:   Mon,  9 Dec 2019 19:27:36 -0700
Message-Id: <20191210022742.822686-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

