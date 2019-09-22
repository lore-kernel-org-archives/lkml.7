Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A765C4740A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F44217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 02:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY9lbdia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfIVCil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 22:38:41 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:41926 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfIVCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 22:38:40 -0400
Received: by mail-pl1-f171.google.com with SMTP id t10so4931143plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 19:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8q6MNCABMDlM/R1LIFa8oysDHH50DToOChOmjLLVbU=;
        b=iY9lbdiaKjI60gd9i5XxcIo6DblArB55ty+VPbKRX/kyc9Gy3Gw50rzuxdw27vlObx
         wpR7GADzfAeh3ONtf/Pi2BBPnYqM5Dra3cVQ89qBgVb95cIOBq8Y3SvmjW45RDKImbAp
         v9bXenkDNzLliTetGiP/9JHcIo4Z+31qy3G9e6lsvTWfle8/qSP8cjiRGISFY23ZhpNp
         6O5pfg1SKFEv3tVqJTiLDeSrGBA15JauDm3HNRMfVzdGxMVWC7U7pNwSKJ78E59OAwpa
         22EeuBxgp6OwXzyl60jD84Za8lWZUZbwXdiFgFOt1QYSGggNyOO8gytEfIVqMjRosmad
         ZDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8q6MNCABMDlM/R1LIFa8oysDHH50DToOChOmjLLVbU=;
        b=uWPYkJO1ecfm/VTTP4IwLeKpQ9vFpV4gTFiVqbKX+P8M6RrSCIrnCWHPUlhDgMIsia
         lusfw+GMxXLTox2voV+BIf6vN6hs9zQ/dYsrvOooRYBEK1OPkHmI7U8OzwtB46Kzto+G
         gA1UXQ3y9lYLA5nGQJ3f7SdkrauVfSEjvfr/Pg8m8quFx/1P3/t+sg9a5CGQfSQD4VQu
         Krr8wmv9XARB5D60nDm6J1l4O3DZUj60dwD16WxB3YMx3FJZo5roy1kUzYKM6yZ9uK7R
         aZdEfx3VL/8RzMLdwgNFjeooCgkoZu0oXc0Khz56VKxriAJkg+NlBMmuQiJyethES80J
         xFkA==
X-Gm-Message-State: APjAAAW/R0u9k60yskjnuHSTC9QpqslVi8zZz2vNImr0ePZPiTS54DTm
        oTJNB2zAR7GeaUXXVPVX38geYmy+gzg=
X-Google-Smtp-Source: APXvYqyOEvNRiD0iZKONmxhfNJYaMFYLbAWE2hUQu3uv5FWEpnE1eqLrtc9jkYyS267LnXJ056L2jQ==
X-Received: by 2002:a17:902:aa93:: with SMTP id d19mr321916plr.301.1569119919582;
        Sat, 21 Sep 2019 19:38:39 -0700 (PDT)
Received: from localhost.localdomain ([207.148.65.56])
        by smtp.gmail.com with ESMTPSA id p20sm5597047pgj.47.2019.09.21.19.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 19:38:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 1/2] perf: support multiple debug options separated by ','
Date:   Sun, 22 Sep 2019 10:38:22 +0800
Message-Id: <20190922023823.12543-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922023823.12543-1-changbin.du@gmail.com>
References: <20190922023823.12543-1-changbin.du@gmail.com>
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
index a1b59bd35519..ae6eb6d1c695 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -27,7 +27,7 @@
 int verbose;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
-static int redirect_to_stderr;
+static bool redirect_to_stderr;
 int debug_data_convert;
 
 int veprintf(int level, int var, const char *fmt, va_list args)
@@ -173,41 +173,18 @@ void trace_event(union perf_event *event)
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
@@ -218,20 +195,47 @@ int perf_debug_option(const char *str)
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

