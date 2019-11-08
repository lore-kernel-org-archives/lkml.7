Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F7C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA462087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbNUAC8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfKHSPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:15:46 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45148 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfKHSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:15:46 -0500
Received: by mail-pf1-f202.google.com with SMTP id a14so5588820pfr.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WYNgukJg3TMdsYIiVMekOZqim/EMcDZIsIJ6xrJU8Lk=;
        b=jbNUAC8++Dd9yCAjCl30jxFB14mro/T8/8c6Pwq0crbEl0zju8dgbssZvam/NSwsrZ
         zur15JSXQlAw5bu4+UEPgNljlTHGv/NX6MPpGWK7PjrBd+/popeg0EVZ5zjmDbmLm0VG
         07AysfBnJMMa+hu+Dt3ikVRW/SDCiIwzIpuoVbOOI7/9nqPZ1QI7BqMUgDI5qCckNQHG
         kQQm2L1dtjMQ3SLrO4N8DFHyTZ78o1j289minqJjb1IiJocrTx+Q+2fWsbM2ldieaFN5
         3AyIfhx3TAnKB1f+8OZIr1Vlti6o3NhypPCQ25X5DFSm9SCoIPF8g0DIVGZBZ1MVnyW5
         G6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WYNgukJg3TMdsYIiVMekOZqim/EMcDZIsIJ6xrJU8Lk=;
        b=bz58wdFY7dv6FnEGyJXa1Scw6eVJIyp4MLbgniRK6vW590ftc6qXAq4pwSnSBWqWqy
         Bgww6TScluUEm1lPpzd3WbVRUJAcYsOWZxcR+TDAmt785iEDgXhkjuT+xbntycBVwudd
         I0CbCN6Iish7ldkdPqc6/zlTOLB7WipQVZSew9Oj6I0UNmrYG1IjbaOj43GOoGqRa/1L
         vNs+qo36bWZF4EWF6A6sU7c2LNyTxxbIkDS80Q4QstcUt9MMJn5xrqlYi6oS8CzPgK5n
         xlFEvhYtJUoeZYeZnbWwxwBpId1qL/KHqnn+Fcxnp3wxYwb5ws8sz+35KX68j7V+NlZO
         7Ckw==
X-Gm-Message-State: APjAAAVwKjpUVh6P20uL1j344l6/oiYbd7XLxom6tmEhNBRwpYGsgHew
        sNiWSy/vy+PpVfiNTqvB3cRqp2VfDv4L
X-Google-Smtp-Source: APXvYqw46Dn4IrFhkUndvuMOOve2KCLyPW5PU43vzXbhiBccQbmPuNg75QYUTXS1dOoq/d4jEcna2pQ5udrZ
X-Received: by 2002:a63:5d12:: with SMTP id r18mr13672833pgb.149.1573236943620;
 Fri, 08 Nov 2019 10:15:43 -0800 (PST)
Date:   Fri,  8 Nov 2019 10:15:33 -0800
In-Reply-To: <20191107222315.GA7261@kernel.org>
Message-Id: <20191108181533.222053-1-irogers@google.com>
Mime-Version: 1.0
References: <20191107222315.GA7261@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] perf tools: report initial event parsing error
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record the first event parsing error and report. Implementing feedback
from Jiri Olsa:
https://lkml.org/lkml/2019/10/28/680

An example error is:

$ tools/perf/perf stat -e c/c/
WARNING: multiple event parsing errors
event syntax error: 'c/c/'
                       \___ unknown term

valid terms: event,filter_rem,filter_opc0,edge,filter_isoc,filter_tid,filter_loc,filter_nc,inv,umask,filter_opc1,tid_en,thresh,filter_all_op,filter_not_nm,filter_state,filter_nm,config,config1,config2,name,period,percore

Initial error:
event syntax error: 'c/c/'
                    \___ Cannot find PMU `c'. Missing kernel support?
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c |  9 ++-
 tools/perf/builtin-stat.c               |  2 +
 tools/perf/builtin-trace.c              | 16 ++++--
 tools/perf/tests/parse-events.c         |  3 +-
 tools/perf/util/metricgroup.c           |  2 +-
 tools/perf/util/parse-events.c          | 76 ++++++++++++++++++-------
 tools/perf/util/parse-events.h          |  4 ++
 7 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 9cc1c4a9dec4..30f5310373ca 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -113,10 +113,15 @@ static int is_tracepoint_available(const char *str, struct evlist *evlist)
 	struct parse_events_error err;
 	int ret;
 
-	err.str = NULL;
+	bzero(&err, sizeof(err));
 	ret = parse_events(evlist, str, &err);
-	if (err.str)
+	if (err.str) {
 		pr_err("%s : %s\n", str, err.str);
+		free(&err->str);
+		free(&err->help);
+		free(&err->first_str);
+		free(&err->first_help);
+	}
 	return ret;
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5964e808d73d..0a15253b438c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1307,6 +1307,7 @@ static int add_default_attributes(void)
 	if (stat_config.null_run)
 		return 0;
 
+	bzero(&errinfo, sizeof(errinfo));
 	if (transaction_run) {
 		/* Handle -T as -M transaction. Once platform specific metrics
 		 * support has been added to the json files, all archictures
@@ -1364,6 +1365,7 @@ static int add_default_attributes(void)
 			return -1;
 		}
 		if (err) {
+			parse_events_print_error(&errinfo, smi_cost_attrs);
 			fprintf(stderr, "Cannot set up SMI cost events\n");
 			return -1;
 		}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 43c05eae1768..46a72ecac427 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3016,11 +3016,18 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 {
 	bool found = false;
 	struct evsel *evsel, *tmp;
-	struct parse_events_error err = { .idx = 0, };
-	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
+	struct parse_events_error err;
+	int ret;
 
-	if (ret)
+	bzero(&err, sizeof(err));
+	ret = parse_events(evlist, "probe:vfs_getname*", &err);
+	if (ret) {
+		free(err.str);
+		free(err.help);
+		free(err.first_str);
+		free(err.first_help);
 		return false;
+	}
 
 	evlist__for_each_entry_safe(evlist, evsel, tmp) {
 		if (!strstarts(perf_evsel__name(evsel), "probe:vfs_getname"))
@@ -4832,8 +4839,9 @@ int cmd_trace(int argc, const char **argv)
 	 * wrong in more detail.
 	 */
 	if (trace.perfconfig_events != NULL) {
-		struct parse_events_error parse_err = { .idx = 0, };
+		struct parse_events_error parse_err;
 
+		bzero(&parse_err, sizeof(parse_err));
 		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err);
 		if (err) {
 			parse_events_print_error(&parse_err, trace.perfconfig_events);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 25e0ed2eedfc..091c3aeccc27 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1768,10 +1768,11 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
-	struct parse_events_error err = { .idx = 0, };
+	struct parse_events_error err;
 	struct evlist *evlist;
 	int ret;
 
+	bzero(&err, sizeof(err));
 	if (e->valid && !e->valid()) {
 		pr_debug("... SKIP");
 		return 0;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a7c0424dbda3..6a4d350d5cdb 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -523,7 +523,7 @@ int metricgroup__parse_groups(const struct option *opt,
 	if (ret)
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
-	memset(&parse_error, 0, sizeof(struct parse_events_error));
+	bzero(&parse_error, sizeof(parse_error));
 	ret = parse_events(perf_evlist, extra_events.buf, &parse_error);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6d18ff9bce49..a369bbc289b2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -189,12 +189,29 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
 		free(help);
 		return;
 	}
-	WARN_ONCE(err->str, "WARNING: multiple event parsing errors\n");
-	err->idx = idx;
-	free(err->str);
-	err->str = str;
-	free(err->help);
-	err->help = help;
+	switch (err->num_errors) {
+	case 0:
+		err->idx = idx;
+		err->str = str;
+		err->help = help;
+		break;
+	case 1:
+		err->first_idx = err->idx;
+		err->idx = idx;
+		err->first_str = err->str;
+		err->str = str;
+		err->first_help = err->help;
+		err->help = help;
+		break;
+	default:
+		WARN_ONCE(1, "WARNING: multiple event parsing errors\n");
+		free(err->str);
+		err->str = str;
+		free(err->help);
+		err->help = help;
+		break;
+	}
+	err->num_errors++;
 }
 
 struct tracepoint_path *tracepoint_id_to_path(u64 config)
@@ -2007,15 +2024,14 @@ static int get_term_width(void)
 	return ws.ws_col > MAX_WIDTH ? MAX_WIDTH : ws.ws_col;
 }
 
-void parse_events_print_error(struct parse_events_error *err,
-			      const char *event)
+static void __parse_events_print_error(int err_idx, const char *err_str,
+				const char *err_help, const char *event)
 {
 	const char *str = "invalid or unsupported event: ";
 	char _buf[MAX_WIDTH];
 	char *buf = (char *) event;
 	int idx = 0;
-
-	if (err->str) {
+	if (err_str) {
 		/* -2 for extra '' in the final fprintf */
 		int width       = get_term_width() - 2;
 		int len_event   = strlen(event);
@@ -2038,8 +2054,8 @@ void parse_events_print_error(struct parse_events_error *err,
 		buf = _buf;
 
 		/* We're cutting from the beginning. */
-		if (err->idx > max_err_idx)
-			cut = err->idx - max_err_idx;
+		if (err_idx > max_err_idx)
+			cut = err_idx - max_err_idx;
 
 		strncpy(buf, event + cut, max_len);
 
@@ -2052,16 +2068,33 @@ void parse_events_print_error(struct parse_events_error *err,
 			buf[max_len] = 0;
 		}
 
-		idx = len_str + err->idx - cut;
+		idx = len_str + err_idx - cut;
 	}
 
 	fprintf(stderr, "%s'%s'\n", str, buf);
 	if (idx) {
-		fprintf(stderr, "%*s\\___ %s\n", idx + 1, "", err->str);
-		if (err->help)
-			fprintf(stderr, "\n%s\n", err->help);
-		zfree(&err->str);
-		zfree(&err->help);
+		fprintf(stderr, "%*s\\___ %s\n", idx + 1, "", err_str);
+		if (err_help)
+			fprintf(stderr, "\n%s\n", err_help);
+	}
+}
+
+void parse_events_print_error(struct parse_events_error *err,
+			      const char *event)
+{
+	if (!err->num_errors)
+		return;
+
+	__parse_events_print_error(err->idx, err->str, err->help, event);
+	zfree(&err->str);
+	zfree(&err->help);
+
+	if (err->num_errors > 1) {
+		fputs("\nInitial error:\n", stderr);
+		__parse_events_print_error(err->first_idx, err->first_str,
+					err->first_help, event);
+		zfree(&err->first_str);
+		zfree(&err->first_help);
 	}
 }
 
@@ -2071,8 +2104,11 @@ int parse_events_option(const struct option *opt, const char *str,
 			int unset __maybe_unused)
 {
 	struct evlist *evlist = *(struct evlist **)opt->value;
-	struct parse_events_error err = { .idx = 0, };
-	int ret = parse_events(evlist, str, &err);
+	struct parse_events_error err;
+	int ret;
+
+	bzero(&err, sizeof(err));
+	ret = parse_events(evlist, str, &err);
 
 	if (ret) {
 		parse_events_print_error(&err, str);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5ee8ac93840c..ff367f248fe8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -110,9 +110,13 @@ struct parse_events_term {
 };
 
 struct parse_events_error {
+	int   num_errors;       /* number of errors encountered */
 	int   idx;	/* index in the parsed string */
 	char *str;      /* string to display at the index */
 	char *help;	/* optional help string */
+	int   first_idx;/* as above, but for the first encountered error */
+	char *first_str;
+	char *first_help;
 };
 
 struct parse_events_state {
-- 
2.24.0.432.g9d3f5f5b63-goog

