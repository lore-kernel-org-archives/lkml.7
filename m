Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8C2C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 10:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE83F2053B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 10:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7J6BIuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfIOK1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 06:27:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37722 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfIOK1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 06:27:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so9888471pgg.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 03:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DlVioqK5uRpVVeZFyNBzYhv8CboJoJINHakxoF0V8I=;
        b=W7J6BIuqiJqwOVGySU2/2sLo7n4L6vpQ8koOf7tgML2ci44KuW7+Z+QeF4EtGlNWor
         nap+mTsX2lJxE8BN/MkQw+Sa00gHBTpMFqTV5eMQz382sLbN7m6H6TTXn6N9n1vCxOU/
         GgVksaLYVvAwgbMcd712Y47yGFFkSXV+mMYKGeo2LWgxdca92htSSarGwomadLnRnveR
         bD4BquVLrcThJ5BjkiUAVZ1Q/w802R4JsiiuPyIFw1xw6Ba8Y8ySR7eGkvbLC4q8glCZ
         PHNiumU7GQtEXMWU1XFU8MAUuNJMi3BnBOd0cyx6HrrRB8g0wVxofpxUZMgoH2cBG889
         /AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DlVioqK5uRpVVeZFyNBzYhv8CboJoJINHakxoF0V8I=;
        b=rDRDANOKYuz6lPJBZKWIid6ODsCQOmVSD0Qd+R+VqWdZ3tQtk+YdCD29D/jdDgRiFZ
         nCy/Qb4cglAXW0jTSoOBb/jHyU/WQ5Gf9E6xPE8/QxgxKBmzcuKdiPe7t38wVOyzXCec
         QU7Anm3E/3QsVFTX8Ts25LqohGHboCRt0iFIpYYTesiUfhbI6nMXePVQ0LaST5neslLi
         laGoY+lcykO0zpx6zjdITok+S8aL1FK5KwHHwFQkU97Aj/M48Hi5CQvXWBPhqIUPlQxH
         RIWDvnGP02j2nacuWUaZAiL1ztqZAHdOyLND4faL4iVhhTyYkR37g/HiHTP5olqHtT7m
         OTmA==
X-Gm-Message-State: APjAAAUbe8Ppeyh/doUAT6TEfdVAgV3L2wlCjWX2s08gg/R5l5yRrPqm
        XUakKNVxB6lfGwteqVQCOfQ=
X-Google-Smtp-Source: APXvYqxYfX35UFjEHcttlbtfS4aoDMY+DF6sXK/pLY6jigba0QdQ93GLnkdogmU8eiUcO5/mHjVHdw==
X-Received: by 2002:a63:6d0:: with SMTP id 199mr20262117pgg.299.1568543273794;
        Sun, 15 Sep 2019 03:27:53 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id d190sm10875510pgc.25.2019.09.15.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 03:27:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] perf: add support for logging debug messages to file
Date:   Sun, 15 Sep 2019 18:27:40 +0800
Message-Id: <20190915102740.24209-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
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
perf -debug verbose=2 --debug file=1 COMMAND

And the path of log file is '~/perf.log'.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf.txt |  4 +++-
 tools/perf/util/debug.c           | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 401f0ed67439..45db7b22d1a5 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -16,7 +16,8 @@ OPTIONS
 	Setup debug variable (see list below) in value
 	range (0, 10). Use like:
 	  --debug verbose   # sets verbose = 1
-	  --debug verbose=2 # sets verbose = 2
+	  --debug verbose=2 --debug file=1
+	                    # sets verbose = 2 and save log to file
 
 	List of debug variables allowed to set:
 	  verbose          - general debug messages
@@ -24,6 +25,7 @@ OPTIONS
 	  data-convert     - data convert command debug messages
 	  stderr           - write debug output (option -v) to stderr
 	                     in browser mode
+	  file             - write debug output to log file ~/perf.log
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 3780fe42453b..f0b4346a0efa 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -8,6 +8,7 @@
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <errno.h>
 #include <sys/wait.h>
 #include <api/debug.h>
 #include <linux/time64.h>
@@ -28,6 +29,8 @@ int verbose;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
 static int redirect_to_stderr;
+static int log_to_file;
+static FILE *log_file;
 int debug_data_convert;
 
 int veprintf(int level, int var, const char *fmt, va_list args)
@@ -39,6 +42,9 @@ int veprintf(int level, int var, const char *fmt, va_list args)
 			ui_helpline__vshow(fmt, args);
 		else
 			ret = vfprintf(stderr, fmt, args);
+
+		if (log_file)
+			vfprintf(log_file, fmt, args);
 	}
 
 	return ret;
@@ -180,6 +186,7 @@ static struct debug_variable {
 	{ .name = "verbose",		.ptr = &verbose },
 	{ .name = "ordered-events",	.ptr = &debug_ordered_events},
 	{ .name = "stderr",		.ptr = &redirect_to_stderr},
+	{ .name = "file",		.ptr = &log_to_file},
 	{ .name = "data-convert",	.ptr = &debug_data_convert },
 	{ .name = NULL, }
 };
@@ -219,6 +226,19 @@ int perf_debug_option(const char *str)
 		v = -1;
 
 	*var->ptr = v;
+
+	if (log_to_file) {
+		char log_path[PATH_MAX];
+
+		strcat(strcpy(log_path, getenv("HOME")), "/perf.log");
+		log_file = fopen(log_path, "a");
+		if (!log_file) {
+			pr_err("Can not create log file: %s\n", strerror(errno));
+			free(s);
+			return -1;
+		}
+	}
+
 	free(s);
 	return 0;
 }
-- 
2.20.1

