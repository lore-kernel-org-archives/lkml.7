Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F99C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00289206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pp9EPYPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfJHMgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:36:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34928 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:36:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so2964627wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5V4/YTrCDA2Y4CjapiR7kwxoAP4iI0pi4NlrpV9i7/0=;
        b=pp9EPYPCdjMCuyJsvWvvT6MesZUAFpzob9Gpw4+F3i4leWX87MqaB1V3TwNfO6jHYn
         /HQ9HeLAo2Nvm0iy/1vEUWtDN7zePVCxBoOXDy9q7mYtNv/5EhMkYuro+GYZhA46EHat
         bg6yGpRbClI5LIQocIG5Opfm4T65xHsDSnZgMkXDHAX0ecYoqbqbrePiW99vpvaBaHLK
         0rN7RFcx5CwkrZU+F76fZggf4UgKUIuC7RSBcWxe+Gpfw9jQSsrzgqvlgra69dUs5+1X
         9ER8NQkGzgHA19qsmcE6Tk/4mxsQ8V3PVpRJkvAHhb/wmQQzDhO/04jG2WFdXI1+5KLw
         aWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5V4/YTrCDA2Y4CjapiR7kwxoAP4iI0pi4NlrpV9i7/0=;
        b=NOJmtGIuWvVrQc2VhpowxC3+De5QhkQ3s53GSEJAezo0NEanFN6FnovgeLv3V0VVyn
         QQlEAcfuzn5GekjrVrhL5f3ZRvTDbYIdzSIflgQzFugHi6qz4UdZbh6QLeNAclbqZ4Th
         4xvzChNeayUvInmeCeXc+rWJrGgAPOcFomvjjYUBfpkmjDfCJnR33c6fkotHtaubNjaB
         V0S1/Uap4fXi84tHmzoNzCBu8RQIOp3fuELw8JqlbhGUKw13i++EqfxGv7nCRcqhFCQ3
         ckWy3jmnKjX3WJ3/EiTYxl2XhkB3G9/vMxcXpR9S0TlZTKZT3pQYE7koapiaTxq/M1pF
         V63w==
X-Gm-Message-State: APjAAAUZgXNSibPzMNxJHKk5Y4ySfdK+jIyPpKOlRGXPZMelSPMAl9eI
        VuLlfRWUoOXLuInfKVAnPwoTCTRUXNQ=
X-Google-Smtp-Source: APXvYqyQcR6eiTaaSpLGRIh+UVzp3KrHoklpyAO8vRKcatrOySFwKS6iSttskXWxORRcBGRIuSl4Zg==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr3655361wma.44.1570538179357;
        Tue, 08 Oct 2019 05:36:19 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id d4sm23100575wrq.22.2019.10.08.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:36:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 2/2] perf: add support for logging debug messages to file
Date:   Tue,  8 Oct 2019 20:35:54 +0800
Message-Id: <20191008123554.6796-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008123554.6796-1-changbin.du@gmail.com>
References: <20191008123554.6796-1-changbin.du@gmail.com>
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
v4: fix another segfault.
v3: fix a segfault issue.
---
 tools/perf/Documentation/perf.txt | 15 ++++++-----
 tools/perf/util/debug.c           | 44 ++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 10 deletions(-)

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
index df82ad9cd16d..5cc2479d63ea 100644
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
@@ -34,8 +35,10 @@ int veprintf(int level, int var, const char *fmt, va_list args)
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
@@ -197,6 +200,24 @@ static int str2loglevel(const char *vstr)
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
@@ -218,8 +239,23 @@ int perf_debug_option(const char *str)
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

