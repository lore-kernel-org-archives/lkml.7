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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74245C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A34420836
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvIKplhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfKYPPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:15:13 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:33277 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfKYPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:15:12 -0500
Received: by mail-pl1-f175.google.com with SMTP id ay6so6657589plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFkziehGXfKYKYKKEFT1Sr/1TaUB77DAPp453TTXVzY=;
        b=qvIKplhg+uGx9+wy6rRC0P9vyrwAIXM4ryqSTyz6Z2DOAAEsTD8nRUFiQAvHmOEgDE
         YWVHkwePR53KB3ZJvVXOw6MFLalQdD4BZFf4uMsYnaG4fLl9/0Rd1zj4m5FtBWoMTNsg
         PdRtxA0IgCZTc/e3Zpe/LoUt028Zj5cHg+mRV8/nMOebLJqU17m9n6DyN7/k2vMWXJdP
         zjlqbTs+kLR+ISNws1NHYaoTPVn5GLJ1irL6xvc0/4R8F+nRumU3u63e9RndFvkOQK6q
         hNvXE1t75teMZAIyL4hRf3vYFdn20HYO7yql9U/TRdVKT2zbogTUmBjzgSPEWgJpWmfG
         PSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFkziehGXfKYKYKKEFT1Sr/1TaUB77DAPp453TTXVzY=;
        b=iIrz2bAj8q/vEJBPCrU8S8uz4UAd5TG1y7nHa3FNE5YuZdijFqT6ZFQ8xZWpRId0Tn
         D/rk2dbY2USkW9BsOXkFTRBuN8k8f4MBsTAca3rkKzTMVrH0k3VNnaHow0fjDiIqKIEt
         Tj0BM51Gs9MpmBl+ZarP5Z8VRlvupOJoFhtse6AhKkAfdrXdBS5ofLISR7qaWagcvGnO
         zLqh2hMA1N+I1UgnuLvSiJF/ZwtPnmn8E564bs6VOQrXm/F/0vgp5a9234GbywnxLBgY
         llsQ2WF289R8WwDni+bKwJiCP0E+FmxXnqcvAmGVwRB/3Ew0lqBleNQztHVML278f8qC
         mw3w==
X-Gm-Message-State: APjAAAWVydWY8Jc4/zsW/46QXKO7R7DJ8ScLQrWni6xwT+/NxvJvUIiV
        Aueg2LUP/g5QpEOcydrlTjLEOJl0ra8=
X-Google-Smtp-Source: APXvYqw7qGixIqAmEA0D390YLmeL6QHGXDTslmgd2XIkt8JPe+o5Dpy/eVh6bQaxpw09MJWOqt9SKQ==
X-Received: by 2002:a17:902:760d:: with SMTP id k13mr701989pll.59.1574694911702;
        Mon, 25 Nov 2019 07:15:11 -0800 (PST)
Received: from localhost.localdomain ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id v17sm9334631pfc.41.2019.11.25.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:15:11 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 1/2] perf: support multiple debug options separated by ','
Date:   Mon, 25 Nov 2019 23:14:45 +0800
Message-Id: <20191125151446.10948-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125151446.10948-1-changbin.du@gmail.com>
References: <20191125151446.10948-1-changbin.du@gmail.com>
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
 tools/perf/Documentation/perf.txt | 13 +++--
 tools/perf/util/debug.c           | 89 ++++++++++++++++---------------
 2 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 3f37ded13f8c..fd8d790f68a7 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -19,13 +19,12 @@ OPTIONS
 	  --debug verbose=2 # sets verbose = 2
 
 	List of debug variables allowed to set:
-	  verbose          - general debug messages
-	  ordered-events   - ordered events object debug messages
-	  data-convert     - data convert command debug messages
-	  stderr           - write debug output (option -v) to stderr
-	                     in browser mode
-	  perf-event-open  - Print perf_event_open() arguments and
-			     return value
+	  verbose=level		- general debug messages
+	  ordered-events=level	- ordered events object debug messages
+	  data-convert=level	- data convert command debug messages
+	  stderr		- write debug output (option -v) to stderr
+	  perf-event-open	- Print perf_event_open() arguments and
+	                          return value in browser mode
 
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

