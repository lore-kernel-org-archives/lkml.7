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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF0DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9106F2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyMKubXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfLJC2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:09 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39029 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfLJC2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:05 -0500
Received: by mail-il1-f194.google.com with SMTP id n1so185073ilm.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9sFvSVCjMbmru2cAfKAhYSNr5hnv5CQxVIAALqigoU=;
        b=oyMKubXOMxnZRrsJpScK/e9RuzFm+b7fJXFaTJl2wPs8ucUwy74XgW4BQO6Fi3Fpoe
         f2GbdWiLG5dPOLuOqm8AqQ6a8qD1IffJK0swsOlue3dAk/JycFYOpR/eDlmH6FmaKzmH
         uR2ZWzzIS+IowVKlzZZnn05J259SA6VqG1WvWQhYzMiM+ihiIeNuQv7c0dxyuScq3VU0
         g/BDuMfCbo2Gwv9VPq6v3cSNYDwRk9DUB3UgyV3H3+I25N8kG+2AD1BYIRUWslaAkFtp
         zapBlNdoEZ1IBREsNwEoJZF68fF5o7OKnyDYTR+XMXP5QuVmtyPRLRTrvhk4t6/aCB4y
         e46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9sFvSVCjMbmru2cAfKAhYSNr5hnv5CQxVIAALqigoU=;
        b=dBzB8g4TlJP0D9ymANb0pzrognOEzZXy8MCfh8o62qyGsp8AIiL3eBO34EvVzzm4Sm
         RItWeWgUNK2lt83VwQCLYHtt/4SdY3Jt/EbEbgQVFoWk2dJetlttN6j9PFRqEsYGXq33
         OcIJi9/FxSavA4YmTeXa3CBDuIBK7AxMYiRowCFTAhmXtiVEoWPR5pWIMhmwl/0lSren
         FQP3WuNyBkLssWQM+fI/fa1n+6HAljb0+dXXTPwf2XyEpfEFBV8QRI5ibk6GAgwszCTT
         RX+W2Oya3mIJJ3KpCP8dXyAW+ZUtv7+bS3pC21IOHpPuyQS32v64yNhsFEGj/8iyTK+z
         /eZw==
X-Gm-Message-State: APjAAAVi+VzOfs/zLZyxNNDFa8NTScC1LZiltOYEMIhSDzY5nLjGqgrj
        sM8BbI2nlp0oC/7U60sSaoQ=
X-Google-Smtp-Source: APXvYqycpaJyfAprafs72o+An8kTVWNl6EH5XBwHFW9veXSctXGDy/29JYhVHmq5uxYKtn63OIR3JA==
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr30440509ilq.306.1575944884736;
        Mon, 09 Dec 2019 18:28:04 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:04 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 03/16] dyndbg: raise verbosity needed to enable ddebug_proc_* logging
Date:   Mon,  9 Dec 2019 19:27:29 -0700
Message-Id: <20191210022742.822686-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

