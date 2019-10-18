Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBECDCA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A262221D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQECsyjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbfJRA21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37677 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfJRA20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so4293298wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/AgeDaGZGO42j9ebgYZTy9x0zQEtmqzx5blEqfMmss=;
        b=YQECsyjC+nZoz0FH5ycVzM1x1VsIw6Xjvlh+ckNwEI22KmLb2sCThylJRTklDdmoWL
         +zOixiGEbNb4ZBWygHLJgPtMgni+IIF9PJSR6t/OKDnW7SJpQGYaE1xp6m8nK2yaifx4
         Kio2psPQFS3eYvCRqC0hjTXXTjfUmqYBRWjV/MoTBVFTPVuDvNAVhDU4nu4yCwaf8xxP
         rAZqkeeYJduhFa+sYWRO/47kJ6zHxhXDTRv7QL3RnHuvqDxQqesQ+dFfpme9Zr/JcR5y
         02jCJpw3C0ZD+sIXuvBXffhGIwv/ReUbnxIfyIpao5yG/GJHMCA5AzyzXwLt71GrvWQi
         OFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/AgeDaGZGO42j9ebgYZTy9x0zQEtmqzx5blEqfMmss=;
        b=QSmi8sgqSTU06e/ssPsNpayJX/kc2DgJoeCWjlrg2Sk8whjl3lfAUDrePBrNwGm60m
         8cW8k1ahPPQAouaQ0ABvVJbi6KL90FdaQ5aGAnvVQ3R7vUH/lbTtDWmD3a2i7eu2pVoo
         OCleaBsr+bAfQi4+mi1MPAq1Ih8MfxF8d1IvSuCg9qBIRK96keUxRkM9bBlIRt12A2PM
         MyJa5JG/BmVhAxG3nrbqiT2wJ+tPZz5oDjrM59guZmjcEcTQ9Cnr1DHLjjaWPUpPpy9C
         NMoSsKFgKX/IO8GvsIV7p9z5l7qENlWREAdOYldv6VoX/MXHAWqXNIAcZL94t6TfMxzD
         yAbQ==
X-Gm-Message-State: APjAAAXUR7iZnZnDgxS/Gz42wrJzYEFTTVmwnPjzTxpbmhezjQ5d3B93
        JdP6s9EIVYZeKmv8CCF8JPE=
X-Google-Smtp-Source: APXvYqzoTU83NO/IoYd1Z3a6cY6xZumEXr92tQ3sJy3NJCFRY7sFzgYEbpbPEYEaNmOPWN+BO9B/kQ==
X-Received: by 2002:adf:f24c:: with SMTP id b12mr5647700wrp.82.1571358504903;
        Thu, 17 Oct 2019 17:28:24 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id p10sm4437649wrx.2.2019.10.17.17.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:28:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 2/2] perf: add support for logging debug messages to file
Date:   Fri, 18 Oct 2019 08:27:57 +0800
Message-Id: <20191018002757.4112-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018002757.4112-1-changbin.du@gmail.com>
References: <20191018002757.4112-1-changbin.du@gmail.com>
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
 tools/perf/Documentation/perf.txt | 16 ++++++-----
 tools/perf/util/debug.c           | 44 ++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index c05a94b2488e..48376be3c97a 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -16,14 +16,18 @@ OPTIONS
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
+	  file[=path]           - write debug output to log file, default
+	                          'perf.log' (stderr and file options are
+	                          exclusive)
 
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

