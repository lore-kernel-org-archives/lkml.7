Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611C620727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZtkWe0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfKZOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:37:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46318 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKZOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:37:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so731390pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zrnv0oDKKER09MnS4EvMICed1va+rXp+dO15OJjiL2A=;
        b=UZtkWe0VZ6TrDNroTbqABVRZEifpQd++CjqUJ6wyHGtUy2udOHPyLTC3QXB0B1YPqY
         vDU76/jBXovNgUR+ybt6ktqov7IpSrT8q9X5VmY/M84wWf+X2b36GhFXMdVc3eKpHSc3
         0WaJUWW1Q59UtzZGUx5EHCZaCvgy9lhW/SGdifAzaxpyjuc4DaZdA8z6yCpO3F+FsfZ7
         T/NbuxPEwOeUpY1zoFvYp+t/KTaKRdU4rGAeWJq2PsIYxlJRxLEGWkCGqP0bvOVLz1cb
         Ge6e7s0+jW55l1DNuGqsoee75w2M4tL58b8KV46lIQ22B6ZPdaQqTNRTu58qBaU9wtfR
         HO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zrnv0oDKKER09MnS4EvMICed1va+rXp+dO15OJjiL2A=;
        b=fD679l86ZZtwfw9pMHWrwTrrqGtW2P3vs+19TNFYhFp7YsGW7N65X7vDfk3c6vTcq5
         v6O4Y5RawO03y4o26X9nOGlrebwBW3BismjL5WxjfXhTPwZW2OqywO5PkPHPd50nNqne
         e70ipF3RqaJ/n8+wc/3J/A5zj7vJLOmSZ56Xbyg/nIA6BhzvFlwPfi28QNDUv3FE9yNm
         9MXdwb3Qcr8Bq0KDa/cdSnOcK/C6mz+djCf27km/dysixJjF4RMRMGbYCVGP1UkWqzJE
         R91LD2XorJXxkNXMeq1/zZXKVPHQe76V7GCju3q45WIyJa5IlQSM2kelqZMM1bUpnBUR
         bqlg==
X-Gm-Message-State: APjAAAW94P226mkXxKL7F2LzRwR1EfSImMuSsDhBlgRWvgivFITLxxP2
        Bsd95mMMEDgjTpHR5mCSdBM=
X-Google-Smtp-Source: APXvYqyyXhu4M2GGeNGDPhcuzZFk+1k5w+X6jUnlLYwEqczYCcb3C4maS4a3WUNvCcgAZ8nkf5fbrA==
X-Received: by 2002:a63:a34b:: with SMTP id v11mr17752819pgn.229.1574779068640;
        Tue, 26 Nov 2019 06:37:48 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id b13sm13139368pgj.28.2019.11.26.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:37:48 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 2/2] perf: add support for logging debug messages to file
Date:   Tue, 26 Nov 2019 22:37:20 +0800
Message-Id: <20191126143720.10333-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126143720.10333-1-changbin.du@gmail.com>
References: <20191126143720.10333-1-changbin.du@gmail.com>
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
v5: doc default log path.
v4: fix another segfault.
v3: fix a segfault issue.
---
 tools/perf/Documentation/perf.txt |  6 ++++-
 tools/perf/util/debug.c           | 44 ++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index dcf9d98065f2..52c6ba825552 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -16,7 +16,8 @@ OPTIONS
 	Setup debug variable (see list below). The range of 'level' value
 	is (0, 10). Use like:
 	  --debug verbose   # sets verbose = 1
-	  --debug verbose=2 # sets verbose = 2
+	  --debug verbose=2,file=~/perf.log
+	                    # sets verbose = 2 and save log to file
 
 	List of debug variables allowed to set:
 	  verbose[=level]	- general debug messages
@@ -26,6 +27,9 @@ OPTIONS
 	                          in browser mode
 	  perf-event-open	- Print perf_event_open() arguments and
 	                          return value
+	  file[=path]           - write debug output to log file, default
+	                          'perf.log' (stderr and file options are
+	                          exclusive)
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 929da46ece92..21bc889976bc 100644
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
@@ -27,7 +28,7 @@ int verbose;
 int debug_peo_args;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
-static bool redirect_to_stderr;
+static FILE *log_file;
 int debug_data_convert;
 
 int veprintf(int level, int var, const char *fmt, va_list args)
@@ -35,8 +36,10 @@ int veprintf(int level, int var, const char *fmt, va_list args)
 	int ret = 0;
 
 	if (var >= level) {
-		if (use_browser >= 1 && !redirect_to_stderr)
+		if (use_browser >= 1 && !log_file)
 			ui_helpline__vshow(fmt, args);
+		else if (log_file)
+			ret = vfprintf(log_file, fmt, args);
 		else
 			ret = vfprintf(stderr, fmt, args);
 	}
@@ -198,6 +201,24 @@ static int str2loglevel(const char *vstr)
 	return v;
 }
 
+static void flush_log(void)
+{
+	if (log_file)
+		fflush(log_file);
+}
+
+static void set_log_output(FILE *f)
+{
+	if (f == log_file)
+		return;
+
+	if (log_file && log_file != stderr)
+		fclose(log_file);
+
+	log_file = f;
+	atexit(flush_log);
+}
+
 int perf_debug_option(const char *str)
 {
 	char *sep, *vstr;
@@ -219,10 +240,25 @@ int perf_debug_option(const char *str)
 		else if (!strcmp(opt, "data-convert"))
 			debug_data_convert = str2loglevel(vstr);
 		else if (!strcmp(opt, "stderr"))
-			redirect_to_stderr = true;
+			set_log_output(stderr);
 		else if (!strcmp(opt, "perf-event-open"))
 			debug_peo_args = true;
-		else {
+		else if (!strcmp(opt, "file")) {
+			FILE *f;
+
+			if (!vstr)
+				vstr = (char *)"perf.log";
+
+			f = fopen(vstr, "a");
+			if (!f) {
+				pr_err("Can not create log file: %s\n",
+				       strerror(errno));
+				free(dstr);
+				return -1;
+			}
+			fprintf(f, "\n===========perf log===========\n");
+			set_log_output(f);
+		} else {
 			fprintf(stderr, "unkown debug option '%s'\n", opt);
 			free(dstr);
 			return -1;
-- 
2.20.1

