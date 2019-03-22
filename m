Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BCAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719542190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfCVWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:01:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfCVWBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:01:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM1HfC745296
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:01:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM1Hhv745293;
        Fri, 22 Mar 2019 15:01:17 -0700
Date:   Fri, 22 Mar 2019 15:01:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-2a1292cbd4e5c81edbf815a410fa2072c341db1e@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
        hpa@zytor.com, mingo@kernel.org
Reply-To: namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
          hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, jolsa@kernel.org
In-Reply-To: <20190305144758.12397-6-andi@firstfloor.org>
References: <20190305144758.12397-6-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Parse time quantum
Git-Commit-ID: 2a1292cbd4e5c81edbf815a410fa2072c341db1e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2a1292cbd4e5c81edbf815a410fa2072c341db1e
Gitweb:     https://git.kernel.org/tip/2a1292cbd4e5c81edbf815a410fa2072c341db1e
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 5 Mar 2019 06:47:48 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf report: Parse time quantum

Many workloads change over time. 'perf report' currently aggregates the
whole time range reported in perf.data.

This patch adds an option for a time quantum to quantisize the perf.data
over time.

This just adds the option, will be used in follow on patches for a time
sort key.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190305144758.12397-6-andi@firstfloor.org
[ Use NSEC_PER_[MU]SEC ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  4 +++
 tools/perf/builtin-report.c              | 42 ++++++++++++++++++++++++++++++++
 tools/perf/util/symbol.c                 |  2 ++
 tools/perf/util/symbol_conf.h            |  1 +
 4 files changed, 49 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 51dbc519dbce..9ec1702bccdd 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -497,6 +497,10 @@ include::itrace.txt[]
 	The period/hits keywords set the base the percentage is computed
 	on - the samples period or the number of samples (hits).
 
+--time-quantum::
+	Configure time quantum for time sort key. Default 100ms.
+	Accepts s, us, ms, ns units.
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 515864ba504a..05c8dd41106c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,9 +47,11 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
+#include "sane_ctype.h"
 #include <signal.h>
 #include <linux/bitmap.h>
 #include <linux/stringify.h>
+#include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -926,6 +928,43 @@ report_parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 	return parse_callchain_report_opt(arg);
 }
 
+static int
+parse_time_quantum(const struct option *opt, const char *arg,
+		   int unset __maybe_unused)
+{
+	unsigned long *time_q = opt->value;
+	char *end;
+
+	*time_q = strtoul(arg, &end, 0);
+	if (end == arg)
+		goto parse_err;
+	if (*time_q == 0) {
+		pr_err("time quantum cannot be 0");
+		return -1;
+	}
+	while (isspace(*end))
+		end++;
+	if (*end == 0)
+		return 0;
+	if (!strcmp(end, "s")) {
+		*time_q *= NSEC_PER_SEC;
+		return 0;
+	}
+	if (!strcmp(end, "ms")) {
+		*time_q *= NSEC_PER_MSEC;
+		return 0;
+	}
+	if (!strcmp(end, "us")) {
+		*time_q *= NSEC_PER_USEC;
+		return 0;
+	}
+	if (!strcmp(end, "ns"))
+		return 0;
+parse_err:
+	pr_err("Cannot parse time quantum `%s'\n", arg);
+	return -1;
+}
+
 int
 report_parse_ignore_callees_opt(const struct option *opt __maybe_unused,
 				const char *arg, int unset __maybe_unused)
@@ -1148,6 +1187,9 @@ int cmd_report(int argc, const char **argv)
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
 	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
+	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns|s)",
+		     "Set time quantum for time sort key (default 100ms)",
+		     parse_time_quantum),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index eb873ea1c405..6b73a0eeb6a1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/time64.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/param.h>
@@ -45,6 +46,7 @@ struct symbol_conf symbol_conf = {
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
+	.time_quantum		= 100 * NSEC_PER_MSEC, /* 100ms */
 	.show_hist_headers	= true,
 	.symfs			= "",
 	.event_group		= true,
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 095a297c8b47..a5684a71b78e 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -56,6 +56,7 @@ struct symbol_conf {
 			*sym_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
+	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
 			*sym_list,
