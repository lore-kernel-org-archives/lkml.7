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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BF52080D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO+RysS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLJC2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:14 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44877 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJC2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:10 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so14693475iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkLmBXFUJUiujXB1umDLKcn6FYwNM55ntuOqjeXmxO4=;
        b=IO+RysS2qREaZOjem4Y+bzjDm0mibQByZDVSMtz496x9JntanPjqnx9ttRasbVW19c
         PU5T39saycZeSUnn5odFtZ9uTDCGyrMO6xN2PKG3PyAKqRUf7ZWDi0/3F9yS3PYdDjwb
         pcxcdycj7W31EV6TJJVFPhXTbUeqdE1sT82d7Z1K0uk9qskZOVw2ozHU06iG9wIFE5i/
         Jl/GCwG5rztUojB3HMhluBFC5neqdn6wzeDIvhHtvIWGgbX00QDzaR9044phfh3ojLbY
         OT0IjFcSPqYG2morWPPFlb+inoElJuwkYIraBiijy6eseVOfPyBQLveV01jG8B5cggBD
         axUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkLmBXFUJUiujXB1umDLKcn6FYwNM55ntuOqjeXmxO4=;
        b=cULjdIYFUkP+7IMWAurJA38ke8UOlM1Ml1F0wHE0nP5ILFIm3UL46izCHBcWTdBA/+
         UDb/GDHtGmVeQjmfM6f5RSCjDqhJIq60yh+Ua2TT1rbi97IXD1w+zK/7+ceHB/gmpLf5
         jMC3mZkIbph6fSmqcwLc7tl0iOGWqLn+tCu68swVZZavmP0XJu02xxGlwGbCA5DI+ScE
         P2Zg+xaB+ic57c3QNtnZyWNKLFCw12UI0dbxSYNLnZdzBcX05daJ7hPxpXioKl9aH3AI
         R9E7ir3NsnHfL81KGoVZ6QPPzFvu2u6zVqq9DdjWbRW2ND31IwEUFQKmp72XAAM4Jbws
         Oetw==
X-Gm-Message-State: APjAAAXyvuqWCtVRLJp0GTWt+jJFkrUSMGN/LbFSjeNE6UjLwj1ZF6a1
        g15FpMCyATyFcih+pRIwAPJz0Wxy59w=
X-Google-Smtp-Source: APXvYqx9FTao2PSRrVYGFbF26XVfGzr3fOuwZubPvyh+V0zDuUW0sO5QQVo3S73EoSuhvktA6/f8UA==
X-Received: by 2002:a92:8395:: with SMTP id p21mr18302022ilk.285.1575944889652;
        Mon, 09 Dec 2019 18:28:09 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:09 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v4 06/16] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Mon,  9 Dec 2019 19:27:32 -0700
Message-Id: <20191210022742.822686-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddebug_describe_flags currently fills a caller provided string buffer,
after testing its size (also passed) in a BUG_ON.  Fix this with a
struct containing a known-big-enough string buffer, and passing it
instead.

Also simplify ddebug_describe_flags sig, and de-ref the struct in the
caller; this makes function reusable (soon) in contexts where flags
are already unpacked.

-v3 fix compile err introduced in patchset grooming.
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b5fb0aa0fbc3..49cb24948e12 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -62,6 +62,8 @@ struct ddebug_iter {
 	unsigned int idx;
 };
 
+struct flagsbuf { char buf[12]; };	/* big enough to hold all the flags */
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -88,21 +90,19 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 };
 
 /* format a string into buf[] which describes the _ddebug's flags */
-static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
-				    size_t maxlen)
+static char *ddebug_describe_flags(unsigned int flags, struct flagsbuf *fb)
 {
-	char *p = buf;
+	char *p = fb->buf;
 	int i;
 
-	BUG_ON(maxlen < 6);
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (dp->flags & opt_array[i].flag)
+		if (flags & opt_array[i].flag)
 			*p++ = opt_array[i].opt_char;
-	if (p == buf)
+	if (p == fb->buf)
 		*p++ = '_';
 	*p = '\0';
 
-	return buf;
+	return fb->buf;
 }
 
 #define vnpr_info(lvl, fmt, ...)				\
@@ -142,13 +142,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			unsigned int flags, unsigned int mask)
+			unsigned int pflags, unsigned int mask)
 {
 	int i;
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	char flagbuf[10];
+	struct flagsbuf flags;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -191,22 +191,21 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | flags;
+			newflags = (dp->flags & mask) | pflags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(flags & _DPRINTK_FLAGS_PRINT))
+				if (!(pflags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (flags & _DPRINTK_FLAGS_PRINT)
+			} else if (pflags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
 			vpr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp, flagbuf,
-						       sizeof(flagbuf)));
+				 ddebug_describe_flags(dp->flags, &flags));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -820,7 +819,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	char flagsbuf[10];
+	struct flagsbuf flags;
 
 	v9pr_info("called m=%p p=%p\n", m, p);
 
@@ -833,7 +832,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
+		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
-- 
2.23.0

