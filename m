Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9743AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F45F207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCIF5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:57:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:63276 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfCIF4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:56:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 21:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,458,1544515200"; 
   d="scan'208";a="132845010"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2019 21:56:41 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9304F301CE6; Fri,  8 Mar 2019 21:56:41 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 05/15] perf tools report: Parse time quantum
Date:   Fri,  8 Mar 2019 21:56:18 -0800
Message-Id: <20190309055628.21617-6-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190309055628.21617-1-andi@firstfloor.org>
References: <20190309055628.21617-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Many workloads change over time. perf report currently aggregates
the whole time range reported in perf.data.

This patch adds an option for a time quantum to quantisize the
perf.data over time.

This just adds the option, will be used in follow on patches
for a time sort key.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Move time_quantum to symbol_conf. check for zero time quantum
v3:
Document s unit
v4:
Use _NSEC defines
---
 tools/perf/Documentation/perf-report.txt |  4 +++
 tools/perf/builtin-report.c              | 42 ++++++++++++++++++++++++
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
index 09180e559ad6..46bd80363c90 100644
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
index eb873ea1c405..913d24340d6b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -29,6 +29,7 @@
 #include <elf.h>
 #include <limits.h>
 #include <symbol/kallsyms.h>
+#include <linux/time64.h>
 #include <sys/utsname.h>
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
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
-- 
2.20.1

