Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC292067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx86JK5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfJ2UAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45043 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:43 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so16166210iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4F20sJBf3dcrMHwMIoY7/VkZoHW79iYj8hDdOdKZBY=;
        b=Hx86JK5+J26ak3/oL8WFVHHKXDAO/bQ3NzrZBoLHWnRE/dkLVhzLAYmyqfPYKvZfQm
         ze5Lb1AgBDChdAoB5/JplUkNOoIiro3NuS/M2nk38cyWyYFlg8FGto3goRj4hfSXEBtP
         19t5ixeY9o1RP1Zw8l5eGMF5rT6r1OSnC8pt76by1zZeb3o9ENJM0XrpJmImCkQEKNeJ
         2rpbJJ9nlnGB1aAIpJTDsub6w7My42N+XH4594S3BnNaW3EStGZuTBxyp4ORmu1wuxZr
         PZBdEDU39T0zcsuthvs1d3Lab0xPcYSoK91EeoHENSwFglutyOZzXgd8NvAVrLIh0ZLP
         dclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4F20sJBf3dcrMHwMIoY7/VkZoHW79iYj8hDdOdKZBY=;
        b=cBJyt0g0dxA5rXTFrxE6uZeVGosBELsMEq8bEJmfp2ssYa2Ldc1t1Gq//S85N18GvD
         DjvH8AwJzzxkcZ0KHKlL4w4Jgc7c7rJtegofho4329FyOOI2mOoSzSpyA54/s+ikHQ3K
         p1crRwa2vghvt5YqgNVLZGM4MboNSO7Z0IiExp7ZMcz0tmxOvEULkhF3GLAdUT/XnBm+
         9ZE109yCFdxfn0LVoNmZcqPedQeu4FD8lxh8yKkInPo5z3MfrnO/XYWZpLkFMaeptlg0
         UqxhDox7UTHKjGXuX2X+60FKHUVpHtqtlB6PEhH1bb1RY4tnx0aebbOUc3t1F+nWrmZl
         hecw==
X-Gm-Message-State: APjAAAU15/oNH50f87yvaF97u6GeArmPkfocz71lnKUP7Hld0DIKjcjI
        se9MVfRHjOCjqsCXNYp6oaw=
X-Google-Smtp-Source: APXvYqywRDPxBWZLnFHdfvjhIMH24usC33ZF3sV7soVY2nvuovYW5Dki3i7nVxPbIRHyKJXdPNC6Cg==
X-Received: by 2002:a05:6638:928:: with SMTP id 8mr24074576jak.124.1572379242482;
        Tue, 29 Oct 2019 13:00:42 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id z69sm1427786ilc.30.2019.10.29.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/16] dyndbg: fix a BUG_ON in ddebug_change
Date:   Tue, 29 Oct 2019 14:00:39 -0600
Message-Id: <20191029200039.9939-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

banish a BUG_ON(stringbuf-too-short) by sticking a fixed-size one
inside a struct, and passing &it around instead of the string & size.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4ce0c53cdcfd..3ac77c49d623 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -60,6 +60,8 @@ struct ddebug_iter {
 	unsigned int idx;
 };
 
+struct flagsbuf { char buf[10]; };
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -75,21 +77,19 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 };
 
 /* format a string into buf[] which describes the _ddebug's flags */
-static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
-				    size_t maxlen)
+static char *ddebug_describe_flags(struct _ddebug *dp, struct flagsbuf *flags)
 {
-	char *p = buf;
+	char *p = flags->buf;
 	int i;
 
-	BUG_ON(maxlen < 6);
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
 		if (dp->flags & opt_array[i].flag)
 			*p++ = opt_array[i].opt_char;
-	if (p == buf)
+	if (p == flags->buf)
 		*p++ = '_';
 	*p = '\0';
 
-	return buf;
+	return flags->buf;
 }
 
 #define vnpr_info(lvl, fmt, ...)				\
@@ -135,7 +135,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	char flagbuf[10];
+	struct flagsbuf flagbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -190,8 +190,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			vpr_info("changed %s:%d [%s]%s =%s\n",
 				 dp->filename, dp->lineno,
 				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp, flagbuf,
-						       sizeof(flagbuf)));
+				 ddebug_describe_flags(dp, &flagbuf));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -804,7 +803,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	char flagsbuf[10];
+	struct flagsbuf flagbuf;
 
 	v9pr_info("called m=%p p=%p\n", m, p);
 
@@ -817,7 +816,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   dp->filename, dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
+		   ddebug_describe_flags(dp, &flagbuf));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
-- 
2.21.0

