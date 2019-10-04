Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4599BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCC52133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMLRXqx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfJDCkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:40:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34508 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfJDCkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:40:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so5144835wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rApmcC729gUWr1isxMFLhBUaAyOq+BNm50heuR6WRh4=;
        b=qMLRXqx3opvUpBTmCjHMTd1F11UNrELZH9VsqX6i5gwJoBmw2YIocjPs7o6phUgijN
         Jivv4SvF/k08lPPIj9Pocr00f5/PJTm4Nfy/B7oOTY45JutQFPzjQHwvMe9o2Jb3B/dR
         GaAim1Pru2YJeUVBp1xWjgFZPQ6+pKKNQvgCPcTLDpofFbPvZk3vgwRSmwqgBT6N9T/U
         H9SRYrUXtFjJmFxVpj8qfrDbyR6NvaBIABSYO8YcXd1+Pli08MFwBzYLsYL8VPtM1sRm
         1PXyw2maoIULxLRwI6lEIDNgk+faUIaTOsYn8lBTPzc1Cgm7VZZmJamCTCKB4eE4le4s
         rVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rApmcC729gUWr1isxMFLhBUaAyOq+BNm50heuR6WRh4=;
        b=MZcY5mANo7q20CnRyKYMhxF17nUtpoRBc7xak/y87jtntlJmwK8r0VTOgqgMThODIg
         M5aLnBEVudC+HwhD/qD8HhL05S4p0ml0B0UoJ9cWy/coKdSzsmVjmKE7kfgDkOGYALcq
         Gbs6YKnjVh1Iv00xA+30lBGL5HP2XC8GDjErrjZIjFBf3ppk9JwJNLVuFn5ZkniLvW3Y
         K2EB7lByz0E8h8Mb0xkJ9Bse8PFWveUsTOoukp4gaB0FsHUiHQwQAPbDABFzuT9ebIKo
         So2luor+MPEw8eB+ERtFv7TW5gMTgsBL43b26zz3VzRy99NLF4GBxdPlaUonVvLTq9dc
         cjZA==
X-Gm-Message-State: APjAAAVa+tTsvH0AXvJp/CzbyV2pJ44bhBOpjzT1qVJLSj3LW+SQ2YvQ
        v70Pl0S4VWB2yNeB2bf4EmySxBels34=
X-Google-Smtp-Source: APXvYqwP6nammMtBWUMbUp5rkh5M130zrBhcu45uRGIo1N/tTnOiKjTFJh5eyBJn0ldSHSr2xcGQdQ==
X-Received: by 2002:adf:8b13:: with SMTP id n19mr10021213wra.203.1570156818632;
        Thu, 03 Oct 2019 19:40:18 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id o19sm7447776wmh.27.2019.10.03.19.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 19:40:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 2/2] perf: add support for logging debug messages to file
Date:   Fri,  4 Oct 2019 10:39:54 +0800
Message-Id: <20191004023954.1116-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004023954.1116-1-changbin.du@gmail.com>
References: <20191004023954.1116-1-changbin.du@gmail.com>
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

--
v3: fix a segfault issue.
---
 tools/perf/Documentation/perf.txt | 15 ++++++-----
 tools/perf/util/debug.c           | 44 +++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index c05a94b2488e..a6b19661e5c3 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -16,14 +16,17 @@ OPTIONS
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
+	  file=path             - write debug output to log file (stderr and
+	                          file options are exclusive)
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index df82ad9cd16d..bfb0b886266f 100644
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
@@ -26,7 +27,7 @@
 int verbose;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
-static bool redirect_to_stderr;
+static FILE *log_file;
 int debug_data_convert;
 
 int veprintf(int level, int var, const char *fmt, va_list args)
@@ -34,10 +35,10 @@ int veprintf(int level, int var, const char *fmt, va_list args)
 	int ret = 0;
 
 	if (var >= level) {
-		if (use_browser >= 1 && !redirect_to_stderr)
+		if (use_browser >= 1 && !log_file)
 			ui_helpline__vshow(fmt, args);
 		else
-			ret = vfprintf(stderr, fmt, args);
+			ret = vfprintf(log_file, fmt, args);
 	}
 
 	return ret;
@@ -197,6 +198,24 @@ static int str2loglevel(const char *vstr)
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
@@ -218,8 +237,23 @@ int perf_debug_option(const char *str)
 		else if (!strcmp(opt, "data-convert"))
 			debug_data_convert = str2loglevel(vstr);
 		else if (!strcmp(opt, "stderr"))
-			redirect_to_stderr = true;
-		else {
+			set_log_output(stderr);
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

