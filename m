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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E218C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7485C20835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C52hOvyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfK0RvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:18 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44453 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0RvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:17 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so12336375iln.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/jFsJaL2N7XwaNf3zNXPD+Pmrt5eD/pk/nm1WN7o9k=;
        b=C52hOvybEBwv4fwmmW6CYHRLi3kS072OzD9uf17vHxrfEDKBNmFcZlLQtAlC7eRBv8
         bH4u6JXuJ2pNtkrYzU3w/nLBVSJxy5P1YeG3m/HG63VGianibshK389RmNsZl3u2C7BB
         ayYfHKNmaeQMFSlT/oxkc3xalpoGEKPp0+zQt2lint3J9kr/eKtXiVihqkP7UJXeHkeP
         fq5RWVZtiieVcNjZbXULxix7ZFHj3YpzTQ4Y83ab4xnU9JzSUgTGto4/AtdZs1paBEDx
         ItX+pcTfae1+73iWNx8b5K+GeUYxzkLpHVc9xipo+oPTQ9IMf9sxVn+SH8+x2i8rWcGA
         5KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/jFsJaL2N7XwaNf3zNXPD+Pmrt5eD/pk/nm1WN7o9k=;
        b=UPhfqCtQQ6pTMQgpn/zZCG7D3BeV5WjpIbnh7zGgiVcwoJhQOGr6v4hmaAbvW7i/BE
         7Uv2WrRPpC4tOZEanBc4TdNss9Ikw2Qen/PvgX+n5gK3io70y17hf53I1PbgrdGT13lH
         3bpV95xa7fKhffowfEyifr52eHCztyO9RQa3nzB62/rbjUkH8DjRJk3VSLklJ/ClBjcH
         CpjaT7INIlU4ygFkGJV3dxAHLF0t/775wvBF85oLpFvabvvR+wqGOaVRuCVntgZ+rN3A
         LiHOst0oorUoBIlQBqGxAdvTZjvjYP9WZGPTeWO35PIAkqRt0IyF8nz/F/Cg/SmvJOEW
         U7Rw==
X-Gm-Message-State: APjAAAUfyC+OHeZOh7/+cLX0vLzJifeBI616o75Ps6Pt4x/KER8oCV2N
        r1SjKp0hvOiZGzbTEyw/R9U=
X-Google-Smtp-Source: APXvYqx5nI+JhTOdQcr1WTBDFePcnxsE/+vWKrHbI0YF98bdRnLP7DO78MgQ6LWkHDQAU5HbifFYRw==
X-Received: by 2002:a92:5a84:: with SMTP id b4mr8600564ilg.92.1574877076684;
        Wed, 27 Nov 2019 09:51:16 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id k18sm3850170ios.31.2019.11.27.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:15 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 09/16] dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
Date:   Wed, 27 Nov 2019 10:51:13 -0700
Message-Id: <20191127175113.1351640-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ddebug_parse_flags accepts [+-=][pflmt_]+ as flag-spec
strings.  If we allow [pflmt_]*[+-=][pflmt_]+ instead, the (new) 1st
flagset can be used as a filter to select callsites, before applying
changes in the 2nd flagset.  1st step is to split out the flags-reader
so we can use it again.

The point of this is to allow user to compose an arbitrary set of
changes, by marking callsites with [fmlt] flags, and then to
activate that composed set in a single query.

 #> echo '=_' > control			# clear all flags
 #> echo 'module usb* +fmlt' > control	# build the marked set, repeat
 #> echo 'fmlt+p' > control		# activate

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9a6768e9334a..b745cc23326f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -414,6 +414,26 @@ static int ddebug_parse_query(char *words[], int nwords,
 	return 0;
 }
 
+static int ddebug_read_flags(const char *str, unsigned int *flags)
+{
+	int i;
+
+	for (; *str ; ++str) {
+		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
+			if (*str == opt_array[i].opt_char) {
+				*flags |= opt_array[i].flag;
+				break;
+			}
+		}
+		if (i < 0) {
+			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			return -EINVAL;
+		}
+	}
+	vpr_info("flags=0x%x\n", *flags);
+	return 0;
+}
+
 /*
  * Parse `str' as a flags specification, format [-+=][p]+.
  * Sets up *maskp and *flagsp to be used when changing the
@@ -424,7 +444,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			       unsigned int *maskp)
 {
 	unsigned flags = 0;
-	int op = '=', i;
+	int op;
 
 	switch (*str) {
 	case '+':
@@ -438,19 +458,8 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	}
 	vpr_info("op='%c'\n", op);
 
-	for (; *str ; ++str) {
-		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
-			if (*str == opt_array[i].opt_char) {
-				flags |= opt_array[i].flag;
-				break;
-			}
-		}
-		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
-			return -EINVAL;
-		}
-	}
-	vpr_info("flags=0x%x\n", flags);
+	if (ddebug_read_flags(str, &flags))
+		return -EINVAL;
 
 	/* calculate final *flagsp, *maskp according to mask and op */
 	switch (op) {
-- 
2.23.0

