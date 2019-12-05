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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3916E2466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2kfavJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfLEVwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46797 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbfLEVwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:08 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so5181632iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9sFvSVCjMbmru2cAfKAhYSNr5hnv5CQxVIAALqigoU=;
        b=e2kfavJmKjeTI9mi/93RI330gUNTdxtpVHrZoz2PxikNnAQ/BTaLDOm262O1wxrgUn
         JgzRQN5vA3mQnObbPSQIVIfMWtBDDuVAVxFmtqnR9BmE5OYzM5n2qBmnhGeooFvxlL/N
         1CWEvpKcF7ThBZMg04viYh9hhpaMcqWyU0Bs4JCET/QxNa5MKVGsreMjpSaJR9w4c1pG
         NaoynqEBlpDQMc88x+geS2MJNT4TtCTAhbo+ibeiFZUgJtTOPDOoCpVYlYAnhDRLR7u0
         tG8WCl1wdqoywkjeZ9WMXBmA+7lIlbDlg9mbVeCxpLIyJyJifFaNogZIxTpJ79f/rS00
         nLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9sFvSVCjMbmru2cAfKAhYSNr5hnv5CQxVIAALqigoU=;
        b=LDdcpTAOnApbV7TJNLOdsoEyoFVcu0Io6mKXJ6YUScnHyv5pPShTlYzuCivC6aI9gw
         v1cUa5IdtyZybO7B16vRfSXhU76TqGduuPFnSBt739PUNXniAUij42iTFgBptHLSdJyh
         AI1S89ebSvlDj7F0ekN5240+lpid6d6NVkwdIwxgi+8rbjBOdk9r7AhZ7dIkNA1e3Qtm
         mvAOl+f5uQv9t1ABFOy8cZRejFB4zfv/0Lrxan+SBkJAu5J99VddctYEl4t6fMPcJAUb
         0iaY5HLX0gGYDgZXx3zFfDbPVwH3W0EU/hH+UpRY9cdxWsKvifvrSVKlahRgbrkuaDF8
         LDOA==
X-Gm-Message-State: APjAAAUa+3wkQSAruGXEE42aXRCeYN4SV4ZOPnTAOQ7kVxoeJXMPLAWT
        SLRDIVIwd2ilyTFb7c67RY817MxKjPs=
X-Google-Smtp-Source: APXvYqxrdoguIPC6OhaGziYThymXqDsVd72Rkgg4s6l6aZA7b/PD0lR3lnwgOKK+Y5LybR63viAJaA==
X-Received: by 2002:a02:6944:: with SMTP id e65mr10143051jac.11.1575582728146;
        Thu, 05 Dec 2019 13:52:08 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:07 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 03/18] dyndbg: raise verbosity needed to enable ddebug_proc_* logging
Date:   Thu,  5 Dec 2019 14:51:34 -0700
Message-Id: <20191205215151.421926-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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

