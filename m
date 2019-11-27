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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8E020835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG41P4Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfK0Ruv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:50:51 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:32841 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0Ruv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:50:51 -0500
Received: by mail-il1-f195.google.com with SMTP id y16so14244194iln.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9sFvSVCjMbmru2cAfKAhYSNr5hnv5CQxVIAALqigoU=;
        b=AG41P4IetILl2isGM0nVwEHyR47EGnaI+o4rXm2n9WHyg1Xk4u7GtAH/HqhbwtPrK9
         V523BCo6BUTfjYxCE71NpUSksfMwomIbZHfAvs7pnEJDx4WRYUyn2G9YcJbGexIBHHS3
         hjp6c53S3V0JiW+nUgNqUrWODi/eYGKyFvN0BEV/I7pG64ezVfN/YY1JjFofLjcKKUzM
         lU8Nz3YNyj258vD3wCRpyE+iHUpWzV+AvmL7d177J8R0Qoj0IYs87dRSxbn0YZqOAYCi
         QWuPQgp0h3386FlKLPc5+Fjz0SiiWi2rahEnVsuwO8ZvYIqLWYDFahKSLDSmLif/h/cm
         8R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9sFvSVCjMbmru2cAfKAhYSNr5hnv5CQxVIAALqigoU=;
        b=m/QKsx2TK9TxqSAAT/VWzChUpHwfY175b6IFOZD1VQ9xTaDKnWzirvB6faUz2zFs+2
         vCt/GqgxRUJR+em2VqGpUo2NZldyebaac+bZwsSIEKv6KFprkQRT83KtcOu1iXjpVcYG
         VjiD+JF5E+9BYy2r58+Ypw9WO3RguNiMTyfnIHV6ZjGzsgO7R88OwtKNePNXYjwS+8dw
         8S1vZE3Z2JrwCq0fcFL5i0XFdHAyoPMUUoVQ5+/PtPyvNt5IYuVaUmunU3o6M1a+6kxs
         UvX9aSUJYU4fczuFA1PUHD4L3sIKAgBd86uKCB0ntQB5J+YGPby+ty/cowqTmzGgY4Qb
         qOMQ==
X-Gm-Message-State: APjAAAUhvjtXJnCwP8Tx7syER/TfHbbIv6pfaUa86mZmFo7JyiysM0BR
        WCRWX/gAWFle+vm9kDBrYOw=
X-Google-Smtp-Source: APXvYqz89TUAUSTdgQYwZM9NgjEIAKC2JBRbyYg/JxZDbNsIMZP88Ijo0FmKR0Qg6WM2nnkYYH+euw==
X-Received: by 2002:a05:6e02:d92:: with SMTP id i18mr44152161ilj.20.1574877050575;
        Wed, 27 Nov 2019 09:50:50 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id s23sm4633162ild.48.2019.11.27.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:50:49 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 03/16] dyndbg: raise verbosity needed to enable ddebug_proc_* logging
Date:   Wed, 27 Nov 2019 10:50:44 -0700
Message-Id: <20191127175044.1351285-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The verbose/debug logging done by `cat $DBGFS/dynamic_debug/control`
is voluminous, and clutters logging done during parsing of queries,
which is much more useful when manipulating/enabling callsites.

So increase the required verbosity to 8&9 for per-page and per-line
logging; ie ddebug_proc_(start|stop) and ddebug_proc_(show|next)
respectively.  This leaves 2-7 for any further logging tweaks to the
query parsing process.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6cefceffadcb..c86c97154657 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -105,12 +105,16 @@ static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
 	return buf;
 }
 
-#define vpr_info(fmt, ...)					\
+#define vnpr_info(lvl, fmt, ...)				\
 do {								\
-	if (verbose)						\
+	if (verbose >= lvl)					\
 		pr_info(fmt, ##__VA_ARGS__);			\
 } while (0)
 
+#define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
+#define v8pr_info(fmt, ...)	vnpr_info(8, fmt, ##__VA_ARGS__)
+#define v9pr_info(fmt, ...)	vnpr_info(9, fmt, ##__VA_ARGS__)
+
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -771,7 +775,7 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	struct _ddebug *dp;
 	int n = *pos;
 
-	vpr_info("called m=%p *pos=%lld\n", m, (unsigned long long)*pos);
+	v8pr_info("called m=%p *pos=%lld\n", m, (unsigned long long)*pos);
 
 	mutex_lock(&ddebug_lock);
 
@@ -795,7 +799,7 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp;
 
-	vpr_info("called m=%p p=%p *pos=%lld\n",
+	v9pr_info("called m=%p p=%p *pos=%lld\n",
 		 m, p, (unsigned long long)*pos);
 
 	if (p == SEQ_START_TOKEN)
@@ -818,7 +822,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	struct _ddebug *dp = p;
 	char flagsbuf[10];
 
-	vpr_info("called m=%p p=%p\n", m, p);
+	v9pr_info("called m=%p p=%p\n", m, p);
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
@@ -842,7 +846,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
  */
 static void ddebug_proc_stop(struct seq_file *m, void *p)
 {
-	vpr_info("called m=%p p=%p\n", m, p);
+	v8pr_info("called m=%p p=%p\n", m, p);
 	mutex_unlock(&ddebug_lock);
 }
 
-- 
2.23.0

