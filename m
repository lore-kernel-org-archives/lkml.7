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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB576C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0F2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCwGhIyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfKZOhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:37:45 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40063 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKZOho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:37:44 -0500
Received: by mail-pl1-f175.google.com with SMTP id f9so8240733plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8zO+xt1MSvBZtFxxGtMQBJ7xxQizcxZbY7RVgBCCT0=;
        b=HCwGhIyGgBP1/QtIliAniIL0nZ58syWHMO3Aa5nYobrWefRh911rjzUx2TZuIN2gmL
         cgrhd0vfsvM/kMazVdXw03H+XMLqaHRawXUB51d8k1hT92Z1uKZ+2dzzQxU9vOmiXl03
         m0r+Y223ptW6SOYi08MP1jjtJXZ6xzWJJXqhN3h46PIkJL5dQj2fS1fyBzIs2XmwKJ5j
         hZNj1sgzJdo30yhpwzSXicJTCmRitT5XuQkc3Lsz4i9ZEgW4kgGeKngqyb5uzRqIg/m+
         b3IsIAigurR4RsfPgpV32UgCL21rpHfs7DBaECJZpi8T7cNmhnIHj/17NCnHNik3FHOM
         Be3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8zO+xt1MSvBZtFxxGtMQBJ7xxQizcxZbY7RVgBCCT0=;
        b=c9bk36SY3d8rBocfe622yEquBoCxW3SKaQw49FhKlJ5q/qR5etyBXHbwhbzB+e5jcO
         DAUUCBGW3v80tzqUuX/E1lSc8amz5JWjhgvj0TmHm27OxKKE3fJegd/q8zTNX8Argwll
         inWsOZVQ8KBu6rZf0Z15DlK8MQ+IxX4u+uuaOxW62VP0lyQ49QY/9xYhRALe9LpnpYWt
         7X0sA4qpHhrFuxoTICWjVm+aT54m9QMeEWWYD8KV89rLUgVU6oHlHakWNggjOGldikEG
         +pKnNJ7Jn6P9HNGyD9EveGtJzmlQxk1sY9ylIQ/TTxVQchJd6ZkF4xB3t+39xrl+DO0Y
         sdOg==
X-Gm-Message-State: APjAAAXcvkTVfgid0D18KZytXlqa9b+eyR1eFhoxTgdzOU5MULiYHUdK
        GGX84H+q7oHB0vI0itbgd1rggzfmDqE=
X-Google-Smtp-Source: APXvYqzymg9RcWDEWYCjhYfCHIzhu9Y9axotGrdypFLlPkMYADIts0gMozlCgom8ov98tVRmr9r1WA==
X-Received: by 2002:a17:902:b693:: with SMTP id c19mr34789066pls.89.1574779062974;
        Tue, 26 Nov 2019 06:37:42 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id b13sm13139368pgj.28.2019.11.26.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:37:42 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 1/2] perf: support multiple debug options separated by ','
Date:   Tue, 26 Nov 2019 22:37:19 +0800
Message-Id: <20191126143720.10333-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126143720.10333-1-changbin.du@gmail.com>
References: <20191126143720.10333-1-changbin.du@gmail.com>
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
 tools/perf/Documentation/perf.txt | 18 +++----
 tools/perf/util/debug.c           | 89 ++++++++++++++++---------------
 2 files changed, 56 insertions(+), 51 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 3f37ded13f8c..dcf9d98065f2 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -13,19 +13,19 @@ SYNOPSIS
 OPTIONS
 -------
 --debug::
-	Setup debug variable (see list below) in value
-	range (0, 10). Use like:
+	Setup debug variable (see list below). The range of 'level' value
+	is (0, 10). Use like:
 	  --debug verbose   # sets verbose = 1
 	  --debug verbose=2 # sets verbose = 2
 
 	List of debug variables allowed to set:
-	  verbose          - general debug messages
-	  ordered-events   - ordered events object debug messages
-	  data-convert     - data convert command debug messages
-	  stderr           - write debug output (option -v) to stderr
-	                     in browser mode
-	  perf-event-open  - Print perf_event_open() arguments and
-			     return value
+	  verbose[=level]	- general debug messages
+	  ordered-events[=level]- ordered events object debug messages
+	  data-convert[=level]	- data convert command debug messages
+	  stderr		- write debug output (option -v) to stderr
+	                          in browser mode
+	  perf-event-open	- Print perf_event_open() arguments and
+	                          return value
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index adb656745ecc..929da46ece92 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -27,7 +27,7 @@ int verbose;
 int debug_peo_args;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
-static int redirect_to_stderr;
+static bool redirect_to_stderr;
 int debug_data_convert;
 
 int veprintf(int level, int var, const char *fmt, va_list args)
@@ -173,42 +173,18 @@ void trace_event(union perf_event *event)
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
-	{ .name = "perf-event-open",	.ptr = &debug_peo_args },
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
@@ -219,20 +195,49 @@ int perf_debug_option(const char *str)
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
+		else if (!strcmp(opt, "perf-event-open"))
+			debug_peo_args = true;
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

