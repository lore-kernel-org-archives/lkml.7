Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FCAC4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA183208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmO1p7aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfIVCiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:38:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41811 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfIVCip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:38:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so6931486pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0Czsg+8wgnms04WFOYdV3qwQyiaTdxFxEDLwG9pCto=;
        b=MmO1p7aMvE8XySSKiccfQtyN4wEr+ryzh8033uUcAQsT9t1XYnQ2iRqhNOi9ttkj5M
         /yCYvgCMR7dYvbLIfahld0u1qJFzfA6AGRK6h1o/+JWe3MkSM3H0/T2MOssm3gRpVEnD
         CRfOht8NSJenM/HZdTjWgTsG6DToXvUkiv8J9T5+0euxaVD0GpxjuUyHVW1v/GcXedAP
         TfMkddOBZxSz7LJb8n6R+5oWWteOdU6Ll75kALxO5zmWYj/tJ1M81YMxwqWuJYFmm/kg
         wAsznZaju4FYkvpdRKrmYAbGZCk9HWLx57ZnycrDSNAKkmoPcv0TZdYba8l1U1s5SF86
         3oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0Czsg+8wgnms04WFOYdV3qwQyiaTdxFxEDLwG9pCto=;
        b=YlHeLgEHkRibWi6fKdc+/UT889nImaRMUb1kir0XG1RZFx3DEU7JIpWtJO/rnT7mEV
         X2wEtXXm7Y4cXrC/3FIuRZtA/E1+AfhU5NpAj+ucqUfpg2YtVay76IvAh/aUcbc+Ms2h
         /ozOkdGSvx1gAYASOmx8Sw73obU46n15mAYbJ0bDcnB8uAWx6jbt+cQFgIaNyQSyPu/o
         zDOTNlEoE6w1cfi4nQReJj7RZ5spTJ/T8LmvxiDIAweDO1/VFhStwKaO2GC5p/5PiCqd
         tGWCi37diYN0Ppp/4KVkHcLohGwhVU8rBRU/CodAxXjEIgGLxbtRsV99a8C8QAz3fDMW
         QM0Q==
X-Gm-Message-State: APjAAAU/ygiRLygdVzaVDMOE3OBAWcMoQkOs5mYKBlKqNmt54S9dDFaT
        VAlefu76+q8IeFUKkd9Svgwu4/w5vjo=
X-Google-Smtp-Source: APXvYqy31313vQ5mGg+XsjFW4pzvAZm1hwvktQW0LxsoAe/5Y6CdDjJ046gRNGu/pVzHjyhazpTg5A==
X-Received: by 2002:a62:ea02:: with SMTP id t2mr21678021pfh.39.1569119924657;
        Sat, 21 Sep 2019 19:38:44 -0700 (PDT)
Received: from localhost.localdomain ([207.148.65.56])
        by smtp.gmail.com with ESMTPSA id p20sm5597047pgj.47.2019.09.21.19.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 19:38:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 2/2] perf: add support for logging debug messages to file
Date:   Sun, 22 Sep 2019 10:38:23 +0800
Message-Id: <20190922023823.12543-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922023823.12543-1-changbin.du@gmail.com>
References: <20190922023823.12543-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in TUI mode, it is impossible to show all the debug messages to
console. This make it hard to debug perf issues using debug messages.
This patch adds support for logging debug messages to file to resolve
this problem.

The usage is:
perf -debug verbose=2,file=~/perf.log COMMAND

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf.txt | 14 ++++++++------
 tools/perf/util/debug.c           | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index c05a94b2488e..b2084a93210d 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -16,14 +16,16 @@ OPTIONS
 	Setup debug variable (see list below) in value
 	range (0, 10). Use like:
 	  --debug verbose   # sets verbose = 1
-	  --debug verbose=2 # sets verbose = 2
+	  --debug verbose=2,file=~/perf.log
+	                    # sets verbose = 2 and save log to file
 
 	List of debug variables allowed to set:
-	  verbose=level		- general debug messages
-	  ordered-events=level	- ordered events object debug messages
-	  data-convert=level	- data convert command debug messages
-	  stderr		- write debug output (option -v) to stderr
-				  in browser mode
+	  verbose=level         - general debug messages
+	  ordered-events=level  - ordered events object debug messages
+	  data-convert=level    - data convert command debug messages
+	  stderr                - write debug output (option -v) to stderr
+	                          in browser mode
+	  file=path             - write debug output to log file
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index ae6eb6d1c695..f62d87ab79d5 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -6,6 +6,7 @@
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <errno.h>
 #include <sys/wait.h>
 #include <api/debug.h>
 #include <linux/kernel.h>
@@ -28,6 +29,7 @@ int verbose;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
 static bool redirect_to_stderr;
+static FILE *log_file;
 int debug_data_convert;
 
 int veprintf(int level, int var, const char *fmt, va_list args)
@@ -39,6 +41,9 @@ int veprintf(int level, int var, const char *fmt, va_list args)
 			ui_helpline__vshow(fmt, args);
 		else
 			ret = vfprintf(stderr, fmt, args);
+
+		if (log_file)
+			vfprintf(log_file, fmt, args);
 	}
 
 	return ret;
@@ -220,7 +225,22 @@ int perf_debug_option(const char *str)
 			debug_data_convert = str2loglevel(vstr);
 		else if (!strcmp(opt, "stderr"))
 			redirect_to_stderr = true;
-		else {
+		else if (!strcmp(opt, "file")) {
+			if (!vstr)
+				vstr = (char *)"perf.log";
+
+			if (log_file)
+				fclose(log_file);
+
+			log_file = fopen(vstr, "a");
+			if (!log_file) {
+				pr_err("Can not create log file: %s\n",
+				       strerror(errno));
+				free(dstr);
+				return -1;
+			}
+			fprintf(log_file, "\n===========perf log===========\n");
+		} else {
 			fprintf(stderr, "unkown debug option '%s'\n", opt);
 			free(dstr);
 			return -1;
-- 
2.20.1

