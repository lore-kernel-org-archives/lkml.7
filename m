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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A513CCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D7D21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs8xLLUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404359AbfJRA2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:22 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53624 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfJRA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:21 -0400
Received: by mail-wm1-f48.google.com with SMTP id i16so4313255wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFqp3FYVQxAZCJNtTZgC4FqFytGhefEpuCZKb+wIGoY=;
        b=Xs8xLLUC7vqKNGY3+NqKGZDTkuaCdzTGjg1rSrHY9aQ2ge/67zvJIEdIUAAfxvOZMo
         HDYDAdgvjp1ta19eLb77gqYnWJD0rKHZbgq0SAtXssHm+Ry/6D1420QGepvq6i5QLdtN
         XNt72cNZ2Fe5O4lqyyNKSEvQPr/CPUGEbK6xFCNb8rIZp5BOjHo2rwTRLjzdiF70vgBA
         mhaSouFC817+anHIGg+xw4zf8HYe1AMVO9gJTgo0DSiT37TcaZ0i64aUczQLJ+d9UhAD
         rcpEwGQXsTPy1YE1DVB58SrmNPtUz5x3ISiwXiQ1BGsLyRyqfYs2DhvL5dXYg5W5no2Z
         7AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFqp3FYVQxAZCJNtTZgC4FqFytGhefEpuCZKb+wIGoY=;
        b=Ca7vcr8ZaQ3P3Ach28INuHWz2D7UYYAiFfKAJ1GeIWTzfNvnw2qlnWic7FOE1LsIHv
         FBCPgvyd1V70rl6ftmyiGYAzwdetXQiKhjQkZqTBAZ4sD+L3BxCTU3OJzZYRZURyJKAK
         NwIupGzV8q/+SDmg3gECfRpWJV9D372O4YtshkaJB6ziY2DwwCUI6JGb5/VCscHk1Tig
         T7/A4jgDnQv6G/5X1RQ3W4A4S4EkVHRa/Z79/GRetO95qoyguKJLwfypK7pKNi8IeeWy
         yeGRMwcHUpkXwGGKM9leFfjpnH1F9mvQg1Yh7DQ3iY0u1Y1tcF4XHoZrinWofoxJcrFn
         YzOQ==
X-Gm-Message-State: APjAAAW0yeg4eogQ34BIgYcb34kJQPfQwbTdlFYjGAOXLwfyoDAtwuwz
        S5Enh0muE1bbIx/i0Nqtfd4=
X-Google-Smtp-Source: APXvYqwVUQ7MbfyT+Qo4MSv4jIP4v0B3bX5Gx/5S09VyFAHxKxLjJ8LonWWSuPZB44FDAjCT7ykIRg==
X-Received: by 2002:a1c:1d53:: with SMTP id d80mr278143wmd.14.1571358498562;
        Thu, 17 Oct 2019 17:28:18 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id p10sm4437649wrx.2.2019.10.17.17.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:28:17 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 1/2] perf: support multiple debug options separated by ','
Date:   Fri, 18 Oct 2019 08:27:56 +0800
Message-Id: <20191018002757.4112-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018002757.4112-1-changbin.du@gmail.com>
References: <20191018002757.4112-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for multiple debug options separated by ',' and
non-int values.
	--debug verbose=2,stderr

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf.txt | 10 ++--
 tools/perf/util/debug.c           | 86 ++++++++++++++++---------------
 2 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 401f0ed67439..c05a94b2488e 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -19,11 +19,11 @@ OPTIONS
 	  --debug verbose=2 # sets verbose = 2
 
 	List of debug variables allowed to set:
-	  verbose          - general debug messages
-	  ordered-events   - ordered events object debug messages
-	  data-convert     - data convert command debug messages
-	  stderr           - write debug output (option -v) to stderr
-	                     in browser mode
+	  verbose=level		- general debug messages
+	  ordered-events=level	- ordered events object debug messages
+	  data-convert=level	- data convert command debug messages
+	  stderr		- write debug output (option -v) to stderr
+				  in browser mode
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index e55114f0336f..df82ad9cd16d 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -26,7 +26,7 @@
 int verbose;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
-static int redirect_to_stderr;
+static bool redirect_to_stderr;
 int debug_data_convert;
 
 int veprintf(int level, int var, const char *fmt, va_list args)
@@ -172,41 +172,18 @@ void trace_event(union perf_event *event)
 		     trace_event_printer, event);
 }
 
-static struct debug_variable {
-	const char *name;
-	int *ptr;
-} debug_variables[] = {
-	{ .name = "verbose",		.ptr = &verbose },
-	{ .name = "ordered-events",	.ptr = &debug_ordered_events},
-	{ .name = "stderr",		.ptr = &redirect_to_stderr},
-	{ .name = "data-convert",	.ptr = &debug_data_convert },
-	{ .name = NULL, }
-};
-
-int perf_debug_option(const char *str)
+static int str2loglevel(const char *vstr)
 {
-	struct debug_variable *var = &debug_variables[0];
-	char *vstr, *s = strdup(str);
 	int v = 1;
-
-	vstr = strchr(s, '=');
-	if (vstr)
-		*vstr++ = 0;
-
-	while (var->name) {
-		if (!strcmp(s, var->name))
-			break;
-		var++;
-	}
-
-	if (!var->name) {
-		pr_err("Unknown debug variable name '%s'\n", s);
-		free(s);
-		return -1;
-	}
+	char *endptr;
 
 	if (vstr) {
-		v = atoi(vstr);
+		v = strtol(vstr, &endptr,0);
+		if (vstr == endptr) {
+			fprintf(stderr, "warning: '%s' is not a digit\n", vstr);
+			return -1;
+		}
+
 		/*
 		 * Allow only values in range (0, 10),
 		 * otherwise set 0.
@@ -217,20 +194,47 @@ int perf_debug_option(const char *str)
 	if (quiet)
 		v = -1;
 
-	*var->ptr = v;
-	free(s);
+	return v;
+}
+
+int perf_debug_option(const char *str)
+{
+	char *sep, *vstr;
+	char *dstr = strdup(str);
+	char *opt = dstr;
+
+	do {
+		if ((sep = strchr(opt, ',')) != NULL)
+			*sep = '\0';
+
+		vstr = strchr(opt, '=');
+		if (vstr)
+			*vstr++ = 0;
+
+		if (!strcmp(opt, "verbose"))
+			verbose = str2loglevel(vstr);
+		else if (!strcmp(opt, "ordered-events"))
+			debug_ordered_events = str2loglevel(vstr);
+		else if (!strcmp(opt, "data-convert"))
+			debug_data_convert = str2loglevel(vstr);
+		else if (!strcmp(opt, "stderr"))
+			redirect_to_stderr = true;
+		else {
+			fprintf(stderr, "unkown debug option '%s'\n", opt);
+			free(dstr);
+			return -1;
+		}
+
+		opt = sep + 1;
+	} while (sep && sep[1]);
+
+	free(dstr);
 	return 0;
 }
 
 int perf_quiet_option(void)
 {
-	struct debug_variable *var = &debug_variables[0];
-
-	/* disable all debug messages */
-	while (var->name) {
-		*var->ptr = -1;
-		var++;
-	}
+	verbose = debug_ordered_events = debug_data_convert = -1;
 
 	return 0;
 }
-- 
2.20.1

