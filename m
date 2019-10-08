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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A548EC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB502173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUxDgv0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfJHMgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:36:17 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45424 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:36:16 -0400
Received: by mail-wr1-f44.google.com with SMTP id r5so19147716wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFqp3FYVQxAZCJNtTZgC4FqFytGhefEpuCZKb+wIGoY=;
        b=sUxDgv0fonfTNWSRVYdoJBz0z7NMCLzdcP8YzTiDfl6stkx7z8sSj1nqMFRWDzYpRh
         aGByT8asNjJQOQW9Zz3kPsh63EEglYrJdSnroy+bcT00tKmeMkIOrvsVWwbohdS9EiNu
         wuUvEUAmjOcU10m5WZDHBD/q7+gIgdgSyEDLQJP7aA5O53ahB9dqDukZ1EZlHWy0IDGH
         d4vrJW8NU+EBH3wr955uwkoXsoyzH4WIDhrBx4voNgQYnGWX40aI+tiRRtyYyCD8oibp
         +tdirE/buODd/YGDscDUKHVBBJXsR61uDWHMiwEengM2ThDjVJn/vFdEktM9D0map52a
         9NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFqp3FYVQxAZCJNtTZgC4FqFytGhefEpuCZKb+wIGoY=;
        b=A/Gd2Uwmf4i7Byr07FK67tfbW7k3difCwkM8BOZ9imJ4NBEVjoWbJzEJS7u6P70Cy3
         qZLjzzqTM+TIp6FAvbemK5iISTSPtUhyG3MIpONWzjj3X7YglAoiPPPIq3rD7Wb0CyQK
         qy4zFMJnlwQTh8UuMjCPdC2/GEsKPcDUOMsDTnYyb6hwNEUf9UHkoULlqfF5Zob3OVou
         OgKQJokPwpfhFFLpK5FseW1AwyMThJNwVozVz66UU7CTvp7qgoux4ixluZgz4jRNLibi
         Dd2Le+EdmA1icctxRIbFofDy8WQHb+MthsbCnUqz5fLedrc63HESzwTj/XLt8hpaec7W
         yMqg==
X-Gm-Message-State: APjAAAX+McLwFo5t8hFKrAbcGdVMtWUBrvZAAc0GMtVo+e8qvYsRrTpf
        x6tcLxskXnsLlzjJRkQ83fg=
X-Google-Smtp-Source: APXvYqwNsEnwt2ngk7exDcvii7U5+iybpFuEkqvMSKGX+VFJiLKlQN+cuhJpoPfX72fV0yywfb8Jug==
X-Received: by 2002:adf:f684:: with SMTP id v4mr24224588wrp.155.1570538173956;
        Tue, 08 Oct 2019 05:36:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id d4sm23100575wrq.22.2019.10.08.05.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:36:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 1/2] perf: support multiple debug options separated by ','
Date:   Tue,  8 Oct 2019 20:35:53 +0800
Message-Id: <20191008123554.6796-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008123554.6796-1-changbin.du@gmail.com>
References: <20191008123554.6796-1-changbin.du@gmail.com>
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

