Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05392082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLqrQm34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfKYPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:15:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46248 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfKYPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:15:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so2167842pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gZCP350pxihV+t/hZss+VK5P0lbaHcKZruQszEdFYQ=;
        b=OLqrQm34kN0aSbyDdV/2T+5q39cL9tObjSAN6OHYahhVG19FWvY+a+mXxPDM6LKJgW
         elBe7S5WaUnhatInytCsGGTwziOkXaDbnqGC7/cB7oChEEMkENWnxKvnCYEdBlO1HULN
         /6Apk1pvrSO5EU8DGo6PXybR3JtxAHXEB0aYzwYre/98+aJjBgS+Ebca6n8hVpX164MG
         o4lLKk7QxXPCE6NbRes7ovSAb7atpExSzLo4hLR3pqyOmLy36s60rLukkAsvtZ3sZVOV
         4T8zDmyvazNup+grs1N5GugMqXx5qObU0zSCN3MBTsJbCDIqqI1lyUWXcEXkjsu9ODJi
         Kw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gZCP350pxihV+t/hZss+VK5P0lbaHcKZruQszEdFYQ=;
        b=Cdw1vSTVGka6C77dfhUBjFQ+NyarhkDV5rbsbnct+vicg9tPGNOdABZ1Pi26Hro6MS
         EtpP4dGPpZgG+JliFXPesZjXu+r3m+iceVDwd7Kvt/c25uxs/mMRCub6rdjou3hp+MSv
         xzJzz7keS6MNhpl1FPWHa64Cosr7b9xM+O2WvjXfnO/ECrj786+HlWTNTM641Q+VXcvv
         Ipuk5b5ZC1rgn7sYmmrmAweIMfv3cF3a8MjxXp1EhTKOafj9WuvBW7XZVWz4gm1h5L14
         DM4uV+z294pKBJ3/WwMPMmi3fh0njY0MXB3Tu/yinfEAJOewkw1r5rOoAPRTu+094+2C
         m3tg==
X-Gm-Message-State: APjAAAUfc27mk/5Dch0cU7t2TFZPYHewtYygRC4t4ripZmCBlbyJ3kUQ
        vtGNksBmZX2yn3iOfWbS4jE=
X-Google-Smtp-Source: APXvYqzZG8GVd4hbc7hw0UGaJmOowScY0gFlz0XPRDHRxTFA84eCOxheGhzTyGKl0LwEFuUeVoXPKA==
X-Received: by 2002:a17:90a:ab98:: with SMTP id n24mr39714816pjq.96.1574694917212;
        Mon, 25 Nov 2019 07:15:17 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id v17sm9334631pfc.41.2019.11.25.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:15:16 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 2/2] perf: add support for logging debug messages to file
Date:   Mon, 25 Nov 2019 23:14:46 +0800
Message-Id: <20191125151446.10948-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125151446.10948-1-changbin.du@gmail.com>
References: <20191125151446.10948-1-changbin.du@gmail.com>
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
 tools/perf/Documentation/perf.txt | 15 +++++++----
 tools/perf/util/debug.c           | 44 ++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index fd8d790f68a7..a47933b53fbe 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -16,15 +16,20 @@ OPTIONS
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
+	  verbose=level         - general debug messages
+	  ordered-events=level  - ordered events object debug messages
+	  data-convert=level    - data convert command debug messages
+	  stderr                - write debug output (option -v) to stderr
+	                          in browser mode
 	  perf-event-open	- Print perf_event_open() arguments and
 	                          return value in browser mode
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

