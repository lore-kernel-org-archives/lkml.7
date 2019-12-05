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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EA1C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69032466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvZDJ1iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfLEVwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:16 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35332 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLEVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:13 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so4417737ild.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkLmBXFUJUiujXB1umDLKcn6FYwNM55ntuOqjeXmxO4=;
        b=uvZDJ1iP/hTiQQei6qNd5edPtpj8+WFZeK7DwvLijsBtII26bvvcKVxIwg3MJ2njgx
         zKwrqjYNmf+CEoDqHeQQ+2c3IOVVIrl8yPWxe5XZqPXMY3DcwlWQy+P3+EA+0LHXRzEn
         72APYh4KqslHKfUag34IIq6j/LQX3hhTX3k4Gqpc0UzCQOsgBGrT5lhcuZSUQJGb3pEe
         9xvjgiDH8iNoRHqtAV9bCQxr0xI2i8PyZPDTevOaVjg5crXU6RmawhZMYoZrKSdJo9Sz
         hJaNRLv54wKrEkv6CKdKtbbZEh+gY71/tgk1kLsdOaRFzQclcgA41AL1WNYqZ4IGiDIe
         iQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkLmBXFUJUiujXB1umDLKcn6FYwNM55ntuOqjeXmxO4=;
        b=C1PtKWjm9CQ2ngSniCs/TZZP6wOEpf6k3QzV39otUobGlaOZZrIOcm9wB4/9fGIKeK
         AV3XDoxYuOP4Tp2XUCBkKzdMN/bBlGcSwIIsrZnuRkkBWR8mf1s1BzYTNNw4uD4RAfY5
         DlraOah5g9DrK6KI72WZ6JgyyXEVPB+I37n6aTb5wqJQJKVji+TVdHORyuFjSL5G9qBT
         Xb+rQh7UlImuWrEzbZA3OzZO7J6Ykpy094KH0x5egW4la+y8v9izG+G7zQOFQMdE0ezE
         DhK9j72eX4nyhZtgpb1wZmP/MuRP7fKUC13K6rhsIdc/fgHpWC56uaFzwHs08yNyYo9i
         ouUg==
X-Gm-Message-State: APjAAAXW7wSzEqRrpm/W0JpOKJu7SoxZFV2D5UJqiG+K7dqDV8D/aGVU
        Pu7pf86htLNXe3ZTOCl/6bU=
X-Google-Smtp-Source: APXvYqwO5tg7/sePvTEP6dRzFzvMCj3SPNLSAgdlMd6H7TKKL+oFQSQY9GWGR5FciYZBa2UB6WKznQ==
X-Received: by 2002:a92:5b1a:: with SMTP id p26mr11463935ilb.9.1575582732990;
        Thu, 05 Dec 2019 13:52:12 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:12 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 06/18] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Thu,  5 Dec 2019 14:51:37 -0700
Message-Id: <20191205215151.421926-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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

