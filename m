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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A3CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A3F2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFBHhaPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfJ2UAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36879 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:27 -0400
Received: by mail-io1-f68.google.com with SMTP id 1so16202131iou.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkXv5VjGx7+Jwkb67zh9nR2cI1MbuFERQ2WCuB8TmWI=;
        b=kFBHhaPtVDnorWQHpbTy1n2bm14d1CnQtM7P5dkZtt43Rw9p7i5R98hdiH6ajExSed
         nZ55/qs+A8YHDTddBwywRgwzB9I6Dn1+hAVhJmYPNh46sjmjZcV0ue1RenZc4mDLnrzc
         h34V0V9exD8ryrKzarwhJ5kpHgGmCwHra1l1mLlnu6/PJddlwmZgZ477QNODfTdDqkBp
         9KKEy92zD4PJihd+9juiwL2pBoKUHcd9mM47tf0PllwmC1L92r83WXhYSjnmQ3NLr7Ov
         HeJhTyyWTcHkKu8pRzwXwc1IlXSt3e6R/0c/avFTGrfA5TztmJiI2oZyE2gXn8gLBzex
         rIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkXv5VjGx7+Jwkb67zh9nR2cI1MbuFERQ2WCuB8TmWI=;
        b=hQsKxE5YaNItX8jbBRFzIDegjzRvq3lbqUVbG0Pbc5LjXUQctTkd0dNdDXEJdx8NDu
         vhUpodlHSs8MxEdarV7kC58yN5SnEiaOUK5SlEzvcDI6KTJCl3KuAGC532swJAAVHcvu
         SSrgNbsRarzaCWqdsP5F7Eqkwrkc+pw71lByrsa9AISMZm75MRn47AX7xEH94fHC36Y6
         6TE79Qe+Rq675EmbctA2RyYm+nfLoq0iPNpdgg2sSxKG2mN2s5dPhZEXierij1vlP6AH
         ebDE4EMuJwkToXv6DVEfV/VnR8MMDwPU8jH91RnNgzwBIugx7Mim4X6XmA++DhwTx5A3
         8RFQ==
X-Gm-Message-State: APjAAAUFsraFlrXLuGrHKrlTC/E5qoHPwYoda9UO97Z89bbyp/e50NdV
        a8dNR1vXszn0SSYEKsFD0ZM=
X-Google-Smtp-Source: APXvYqzNRzWMGpotsojyLAd6S62CLCdC0hzn29ul01Y6oArn+V/86Fg2txCxSZnaOU+2ENemIxp2hA==
X-Received: by 2002:a5d:9359:: with SMTP id i25mr5553420ioo.184.1572379226221;
        Tue, 29 Oct 2019 13:00:26 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f66sm2150724ill.19.2019.10.29.13.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 03/16] dyndbg: raise verbosity needed to enable ddebug_proc_* logging
Date:   Tue, 29 Oct 2019 14:00:22 -0600
Message-Id: <20191029200022.9741-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
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
index 8fb140a55ad3..f82ec49e5916 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -94,12 +94,16 @@ static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
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
@@ -758,7 +762,7 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	struct _ddebug *dp;
 	int n = *pos;
 
-	vpr_info("called m=%p *pos=%lld\n", m, (unsigned long long)*pos);
+	v8pr_info("called m=%p *pos=%lld\n", m, (unsigned long long)*pos);
 
 	mutex_lock(&ddebug_lock);
 
@@ -782,7 +786,7 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp;
 
-	vpr_info("called m=%p p=%p *pos=%lld\n",
+	v9pr_info("called m=%p p=%p *pos=%lld\n",
 		 m, p, (unsigned long long)*pos);
 
 	if (p == SEQ_START_TOKEN)
@@ -805,7 +809,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	struct _ddebug *dp = p;
 	char flagsbuf[10];
 
-	vpr_info("called m=%p p=%p\n", m, p);
+	v9pr_info("called m=%p p=%p\n", m, p);
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
@@ -829,7 +833,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
  */
 static void ddebug_proc_stop(struct seq_file *m, void *p)
 {
-	vpr_info("called m=%p p=%p\n", m, p);
+	v8pr_info("called m=%p p=%p\n", m, p);
 	mutex_unlock(&ddebug_lock);
 }
 
-- 
2.21.0

