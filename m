Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD17CA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F17820862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0l8sOkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfJ2HsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:48:01 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46695 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfJ2HsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:48:01 -0400
Received: by mail-pf1-f201.google.com with SMTP id d3so10336538pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 00:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uQ+VfXHw941Qt2IfQmDs/KJlks9L5fWtJCzf+hKT0sI=;
        b=G0l8sOkPbXyLHwlpxt/7VvImboSKd37p3QVbKBMlD1gHAGMSiesF8bmcktjirjGAHB
         7EL0LB2ino9xrhh37iHiK6YRNl+ApaXD++c0mLkl9U2fE7aU6QrAOFjg89+5W2O7ENaJ
         8QnGtmULflOr+n1uLqYWZK/+mUZSxnQ0xuu1KBsWWi4vBXEUcSbBhDV133rCfyz1UEaf
         fO8nhpfvzpsXuJQiPsLiGNbE363p+nk34BvafLMM2QkZbbsb4xUw8Um4cDsbuW8JvmzO
         26hRmWxR+U9oD+hHqbIHm/tuo3rq0+aGXiNBzMZ33MVwIVWa0PjBVgq2cKsUrGXJ9TrX
         wMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uQ+VfXHw941Qt2IfQmDs/KJlks9L5fWtJCzf+hKT0sI=;
        b=ltVYOPhZMUj1iHNtz139aAFlu28T134iu2gfThrXKrwnr3RFMejdOWbHhtazug82Ad
         fsdn0ranHxWzcKq6p9SqFiiqD/8DEz8evsyGjaGWtI4we/ij/x/Hdhv+zmUKy0V0nstB
         piTWjQLmPDuO1e9W6HxJJ86fJnJ2ybtsOGXatf5GfA73bLV4OhWgO11tsGseluvdFRsH
         y44VsU3QRqbSNCmygC8bqDgzs5IsrIzAKOmfvbpj3a8IcixrYtdTHxmGMqe9R9TCAuMF
         zM+pf1ES4pBIr8moTg7QUHDq72YV5GdujBXcWCFhjJkTEp4Ng3KU+SbAbQXTgPYce+R4
         iMJg==
X-Gm-Message-State: APjAAAWgysnlW7FAJbOBxB3W9B9gk2x1MyR+bPNzcVq1P2fuS6VjyxUr
        mU0ukaub+KCEiPSN2XRhYV9tKr3RkHHCsg==
X-Google-Smtp-Source: APXvYqxQy7hRtHS5Lcr98ntXyTn9K7vgNSIKEqbmJMojZpOokoGl8xhDQrtuKPHmetvnD2QCrD5hw/qS2cW1wQ==
X-Received: by 2002:a63:1812:: with SMTP id y18mr10982593pgl.302.1572335280130;
 Tue, 29 Oct 2019 00:48:00 -0700 (PDT)
Date:   Tue, 29 Oct 2019 15:47:53 +0800
Message-Id: <20191029074753.173665-1-robinhsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH 2/2] fsck.f2fs: Enable user-space cache
From:   Robin Hsu <robinhsu@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com, robinhsu@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added command line options -c <num_cache_entry> and -m <max_hash_collision>
to activate cache for fsck.  It may significantly speed up fsck.

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 fsck/main.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 8c62a14..8edb177 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -10,6 +10,9 @@
  *   Liu Shuoran <liushuoran@huawei.com>
  *   Jaegeuk Kim <jaegeuk@kernel.org>
  *  : add sload.f2fs
+ * Copyright (c) 2019 Google Inc.
+ *   Robin Hsu <robinhsu@google.com>
+ *  : add cache layer
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -20,6 +23,7 @@
 #include <ctype.h>
 #include <time.h>
 #include <getopt.h>
+#include <stdbool.h>
 #include "quotaio.h"
 
 struct f2fs_fsck gfsck;
@@ -54,7 +58,12 @@ void fsck_usage()
 	MSG(0, "\nUsage: fsck.f2fs [options] device\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
-	MSG(0, "  -C encoding[:flag1,flag2] Set options for enabling casefolding\n");
+	MSG(0, "  -c <num-cache-entry>  set number of cache entries"
+			" (default 0)\n");
+	MSG(0, "  -m <max-hash-collision>  set max cache hash collision"
+			" (default 16)\n");
+	MSG(0, "  -C encoding[:flag1,flag2] Set options for enabling"
+			" casefolding\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -f check/fix entire partition\n");
 	MSG(0, "  -g add default options\n");
@@ -66,6 +75,7 @@ void fsck_usage()
 	MSG(0, "  -y fix all the time\n");
 	MSG(0, "  -V print the version number and exit\n");
 	MSG(0, "  --dry-run do not really fix corruptions\n");
+	MSG(0, "  --debug-cache to debug cache when -c is used\n");
 	exit(1);
 }
 
@@ -187,15 +197,18 @@ void f2fs_parse_options(int argc, char *argv[])
 	}
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = ":aC:d:fg:O:p:q:StyV";
+		const char *option_string = ":aC:c:m:d:fg:O:p:q:StyV";
 		int opt = 0, val;
 		char *token;
 		struct option long_opt[] = {
 			{"dry-run", no_argument, 0, 1},
+			{"debug-cache", no_argument, 0, 2},
 			{0, 0, 0, 0}
 		};
 
 		c.func = FSCK;
+		c.cache_config.max_hash_collision = 16;
+		c.cache_config.dbg_en = false;
 		while ((option = getopt_long(argc, argv, option_string,
 						long_opt, &opt)) != EOF) {
 			switch (option) {
@@ -203,10 +216,20 @@ void f2fs_parse_options(int argc, char *argv[])
 				c.dry_run = 1;
 				MSG(0, "Info: Dry run\n");
 				break;
+			case 2:
+				c.cache_config.dbg_en = true;
+				break;
 			case 'a':
 				c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption.\n");
 				break;
+			case 'c':
+				c.cache_config.num_cache_entry = atoi(optarg);
+				break;
+			case 'm':
+				c.cache_config.max_hash_collision =
+						atoi(optarg);
+				break;
 			case 'g':
 				if (!strcmp(optarg, "android"))
 					c.defset = CONF_ANDROID;
-- 
2.24.0.rc0.303.g954a862665-goog

