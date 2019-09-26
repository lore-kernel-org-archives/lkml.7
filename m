Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5462CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBA621D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458238;
	bh=fCXoo+mWx4vOF7a78aoLtyzKfHxfivsmYpNRVY8Etng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RoGLYwDS9J6MPQB0S0bVb65rllnevkL6YG/7nSywAUd1rUqXy3WGnsj4x6aWF7meY
	 xswN5fVib4inh1ORJZ8lVQcHswlf85wYq1DNk5UnLEGP4Js9G15TPbhodMusJ+MZv1
	 6psBAoexeSt99Z9EYhyOcELDzW9Yj0jfpIg34+eE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390552AbfIZAg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390470AbfIZAgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:25 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13E2217F4;
        Thu, 26 Sep 2019 00:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458183;
        bh=fCXoo+mWx4vOF7a78aoLtyzKfHxfivsmYpNRVY8Etng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zTCz8bBH89NgeV6dSypXxYEXP8BCx/ao8n5di/v3sc95vRye1L9G2rLd9FxjdpqqU
         4fhfv1y1ncR0AKCupTuz8IEGJ8vq/nUDTTtJRPR7LIgcOzxLqwTopVuvf0iMt/BROW
         wpzxJaM5gNmxPYAzFWF089g++ukO8nU2cLuVdDMg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 57/66] perf evsel: Introduce evsel_fprintf.h
Date:   Wed, 25 Sep 2019 21:32:35 -0300
Message-Id: <20190926003244.13962-58-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We already had evsel_fprintf.c, add its counterpart, so that we can
reduce evsel.h a bit more.

We needed a new perf_event_attr_fprintf.c file so as to have a separate
object to link with the python binding in tools/perf/util/python-ext-sources
and not drag symbol_conf, etc into the python binding.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-06bdmt1062d9unzgqmxwlv88@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-evlist.c               |   1 +
 tools/perf/builtin-sched.c                |   1 +
 tools/perf/builtin-script.c               |   1 +
 tools/perf/builtin-trace.c                |   2 +
 tools/perf/util/Build                     |   1 +
 tools/perf/util/evsel.c                   | 153 +---------------------
 tools/perf/util/evsel.h                   |  51 +-------
 tools/perf/util/evsel_fprintf.c           |   1 +
 tools/perf/util/evsel_fprintf.h           |  50 +++++++
 tools/perf/util/header.c                  |   1 +
 tools/perf/util/perf_event_attr_fprintf.c | 148 +++++++++++++++++++++
 tools/perf/util/python-ext-sources        |   1 +
 12 files changed, 218 insertions(+), 193 deletions(-)
 create mode 100644 tools/perf/util/evsel_fprintf.h
 create mode 100644 tools/perf/util/perf_event_attr_fprintf.c

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 60509ce4dd28..440501994931 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -10,6 +10,7 @@
 #include "perf.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evsel_fprintf.h"
 #include "util/parse-events.h"
 #include <subcmd/parse-options.h>
 #include "util/session.h"
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f9706306fea0..5cacc4f84c8d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -6,6 +6,7 @@
 #include "util/cpumap.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evsel_fprintf.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0d43e2e5afff..286fc70d7402 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -17,6 +17,7 @@
 #include "util/trace-event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evsel_fprintf.h"
 #include "util/evswitch.h"
 #include "util/sort.h"
 #include "util/data.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 318225c8d7a7..bb5130d02155 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -28,6 +28,8 @@
 #include "util/dso.h"
 #include "util/env.h"
 #include "util/event.h"
+#include "util/evsel.h"
+#include "util/evsel_fprintf.h"
 #include "util/synthetic-events.h"
 #include "util/evlist.h"
 #include "util/evswitch.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4d1894e38a81..8dcfca1a882f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -11,6 +11,7 @@ perf-y += event.o
 perf-y += evlist.o
 perf-y += evsel.o
 perf-y += evsel_fprintf.o
+perf-y += perf_event_attr_fprintf.o
 perf-y += evswitch.o
 perf-y += find_bit.o
 perf-y += get_current_dir_name.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c284d2adcea..6323b0c60f6c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -30,6 +30,7 @@
 #include "counts.h"
 #include "event.h"
 #include "evsel.h"
+#include "util/evsel_fprintf.h"
 #include "evlist.h"
 #include <perf/cpumap.h>
 #include "thread_map.h"
@@ -1443,152 +1444,6 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	return fd;
 }
 
-struct bit_names {
-	int bit;
-	const char *name;
-};
-
-static void __p_bits(char *buf, size_t size, u64 value, struct bit_names *bits)
-{
-	bool first_bit = true;
-	int i = 0;
-
-	do {
-		if (value & bits[i].bit) {
-			buf += scnprintf(buf, size, "%s%s", first_bit ? "" : "|", bits[i].name);
-			first_bit = false;
-		}
-	} while (bits[++i].name != NULL);
-}
-
-static void __p_sample_type(char *buf, size_t size, u64 value)
-{
-#define bit_name(n) { PERF_SAMPLE_##n, #n }
-	struct bit_names bits[] = {
-		bit_name(IP), bit_name(TID), bit_name(TIME), bit_name(ADDR),
-		bit_name(READ), bit_name(CALLCHAIN), bit_name(ID), bit_name(CPU),
-		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
-		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
-		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
-		bit_name(WEIGHT), bit_name(PHYS_ADDR),
-		{ .name = NULL, }
-	};
-#undef bit_name
-	__p_bits(buf, size, value, bits);
-}
-
-static void __p_branch_sample_type(char *buf, size_t size, u64 value)
-{
-#define bit_name(n) { PERF_SAMPLE_BRANCH_##n, #n }
-	struct bit_names bits[] = {
-		bit_name(USER), bit_name(KERNEL), bit_name(HV), bit_name(ANY),
-		bit_name(ANY_CALL), bit_name(ANY_RETURN), bit_name(IND_CALL),
-		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
-		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
-		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
-		{ .name = NULL, }
-	};
-#undef bit_name
-	__p_bits(buf, size, value, bits);
-}
-
-static void __p_read_format(char *buf, size_t size, u64 value)
-{
-#define bit_name(n) { PERF_FORMAT_##n, #n }
-	struct bit_names bits[] = {
-		bit_name(TOTAL_TIME_ENABLED), bit_name(TOTAL_TIME_RUNNING),
-		bit_name(ID), bit_name(GROUP),
-		{ .name = NULL, }
-	};
-#undef bit_name
-	__p_bits(buf, size, value, bits);
-}
-
-#define BUF_SIZE		1024
-
-#define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
-#define p_unsigned(val)		snprintf(buf, BUF_SIZE, "%"PRIu64, (uint64_t)(val))
-#define p_signed(val)		snprintf(buf, BUF_SIZE, "%"PRId64, (int64_t)(val))
-#define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
-#define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
-#define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
-
-#define PRINT_ATTRn(_n, _f, _p)				\
-do {							\
-	if (attr->_f) {					\
-		_p(attr->_f);				\
-		ret += attr__fprintf(fp, _n, buf, priv);\
-	}						\
-} while (0)
-
-#define PRINT_ATTRf(_f, _p)	PRINT_ATTRn(#_f, _f, _p)
-
-int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
-			     attr__fprintf_f attr__fprintf, void *priv)
-{
-	char buf[BUF_SIZE];
-	int ret = 0;
-
-	PRINT_ATTRf(type, p_unsigned);
-	PRINT_ATTRf(size, p_unsigned);
-	PRINT_ATTRf(config, p_hex);
-	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned);
-	PRINT_ATTRf(sample_type, p_sample_type);
-	PRINT_ATTRf(read_format, p_read_format);
-
-	PRINT_ATTRf(disabled, p_unsigned);
-	PRINT_ATTRf(inherit, p_unsigned);
-	PRINT_ATTRf(pinned, p_unsigned);
-	PRINT_ATTRf(exclusive, p_unsigned);
-	PRINT_ATTRf(exclude_user, p_unsigned);
-	PRINT_ATTRf(exclude_kernel, p_unsigned);
-	PRINT_ATTRf(exclude_hv, p_unsigned);
-	PRINT_ATTRf(exclude_idle, p_unsigned);
-	PRINT_ATTRf(mmap, p_unsigned);
-	PRINT_ATTRf(comm, p_unsigned);
-	PRINT_ATTRf(freq, p_unsigned);
-	PRINT_ATTRf(inherit_stat, p_unsigned);
-	PRINT_ATTRf(enable_on_exec, p_unsigned);
-	PRINT_ATTRf(task, p_unsigned);
-	PRINT_ATTRf(watermark, p_unsigned);
-	PRINT_ATTRf(precise_ip, p_unsigned);
-	PRINT_ATTRf(mmap_data, p_unsigned);
-	PRINT_ATTRf(sample_id_all, p_unsigned);
-	PRINT_ATTRf(exclude_host, p_unsigned);
-	PRINT_ATTRf(exclude_guest, p_unsigned);
-	PRINT_ATTRf(exclude_callchain_kernel, p_unsigned);
-	PRINT_ATTRf(exclude_callchain_user, p_unsigned);
-	PRINT_ATTRf(mmap2, p_unsigned);
-	PRINT_ATTRf(comm_exec, p_unsigned);
-	PRINT_ATTRf(use_clockid, p_unsigned);
-	PRINT_ATTRf(context_switch, p_unsigned);
-	PRINT_ATTRf(write_backward, p_unsigned);
-	PRINT_ATTRf(namespaces, p_unsigned);
-	PRINT_ATTRf(ksymbol, p_unsigned);
-	PRINT_ATTRf(bpf_event, p_unsigned);
-	PRINT_ATTRf(aux_output, p_unsigned);
-
-	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
-	PRINT_ATTRf(bp_type, p_unsigned);
-	PRINT_ATTRn("{ bp_addr, config1 }", bp_addr, p_hex);
-	PRINT_ATTRn("{ bp_len, config2 }", bp_len, p_hex);
-	PRINT_ATTRf(branch_sample_type, p_branch_sample_type);
-	PRINT_ATTRf(sample_regs_user, p_hex);
-	PRINT_ATTRf(sample_stack_user, p_unsigned);
-	PRINT_ATTRf(clockid, p_signed);
-	PRINT_ATTRf(sample_regs_intr, p_hex);
-	PRINT_ATTRf(aux_watermark, p_unsigned);
-	PRINT_ATTRf(sample_max_stack, p_unsigned);
-
-	return ret;
-}
-
-static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
-				void *priv __maybe_unused)
-{
-	return fprintf(fp, "  %-32s %s\n", name, val);
-}
-
 static void perf_evsel__remove_fd(struct evsel *pos,
 				  int nr_cpus, int nr_threads,
 				  int thread_idx)
@@ -1659,6 +1514,12 @@ static bool ignore_missing_thread(struct evsel *evsel,
 	return true;
 }
 
+static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
+				void *priv __maybe_unused)
+{
+	return fprintf(fp, "  %-32s %s\n", name, val);
+}
+
 static void display_attr(struct perf_event_attr *attr)
 {
 	if (verbose >= 2) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4a4c64833893..48183b5f5f83 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -4,7 +4,6 @@
 
 #include <linux/list.h>
 #include <stdbool.h>
-#include <stdio.h>
 #include <sys/types.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
@@ -13,12 +12,6 @@
 #include "symbol_conf.h"
 #include <internal/cpumap.h>
 
-struct addr_location;
-struct evsel;
-union perf_event;
-
-struct cgroup;
-
 /*
  * The 'struct perf_evsel_config_term' is used to pass event
  * specific configuration data to perf_evsel__config routine.
@@ -62,7 +55,11 @@ struct perf_evsel_config_term {
 	bool weak;
 };
 
+struct bpf_object;
+struct cgroup;
+struct perf_counts;
 struct perf_stat_evsel;
+union perf_event;
 
 typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
 
@@ -71,9 +68,6 @@ enum perf_tool_event {
 	PERF_TOOL_DURATION_TIME = 1,
 };
 
-struct bpf_object;
-struct perf_counts;
-
 /** struct evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -404,38 +398,6 @@ static inline bool perf_evsel__is_clock(struct evsel *evsel)
 	       perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
 }
 
-struct perf_attr_details {
-	bool freq;
-	bool verbose;
-	bool event_group;
-	bool force;
-	bool trace_fields;
-};
-
-int perf_evsel__fprintf(struct evsel *evsel,
-			struct perf_attr_details *details, FILE *fp);
-
-#define EVSEL__PRINT_IP			(1<<0)
-#define EVSEL__PRINT_SYM		(1<<1)
-#define EVSEL__PRINT_DSO		(1<<2)
-#define EVSEL__PRINT_SYMOFFSET		(1<<3)
-#define EVSEL__PRINT_ONELINE		(1<<4)
-#define EVSEL__PRINT_SRCLINE		(1<<5)
-#define EVSEL__PRINT_UNKNOWN_AS_ADDR	(1<<6)
-#define EVSEL__PRINT_CALLCHAIN_ARROW	(1<<7)
-#define EVSEL__PRINT_SKIP_IGNORED	(1<<8)
-
-struct callchain_cursor;
-
-int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
-			      unsigned int print_opts, struct callchain_cursor *cursor,
-			      struct strlist *bt_stop_list, FILE *fp);
-
-int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
-			int left_alignment, unsigned int print_opts,
-			struct callchain_cursor *cursor,
-			struct strlist *bt_stop_list, FILE *fp);
-
 bool perf_evsel__fallback(struct evsel *evsel, int err,
 			  char *msg, size_t msgsize);
 int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
@@ -468,11 +430,6 @@ static inline bool evsel__has_callchain(const struct evsel *evsel)
 	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
 }
 
-typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
-
-int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
-			     attr__fprintf_f attr__fprintf, void *priv);
-
 struct perf_env *perf_evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 756b1e852db7..028df7afb0dc 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -4,6 +4,7 @@
 #include <stdbool.h>
 #include <traceevent/event-parse.h>
 #include "evsel.h"
+#include "util/evsel_fprintf.h"
 #include "util/event.h"
 #include "callchain.h"
 #include "map.h"
diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fprintf.h
new file mode 100644
index 000000000000..47e6c8456bb1
--- /dev/null
+++ b/tools/perf/util/evsel_fprintf.h
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __PERF_EVSEL_FPRINTF_H
+#define __PERF_EVSEL_FPRINTF_H 1
+
+#include <stdio.h>
+#include <stdbool.h>
+
+struct evsel;
+
+struct perf_attr_details {
+	bool freq;
+	bool verbose;
+	bool event_group;
+	bool force;
+	bool trace_fields;
+};
+
+int perf_evsel__fprintf(struct evsel *evsel,
+			struct perf_attr_details *details, FILE *fp);
+
+#define EVSEL__PRINT_IP			(1<<0)
+#define EVSEL__PRINT_SYM		(1<<1)
+#define EVSEL__PRINT_DSO		(1<<2)
+#define EVSEL__PRINT_SYMOFFSET		(1<<3)
+#define EVSEL__PRINT_ONELINE		(1<<4)
+#define EVSEL__PRINT_SRCLINE		(1<<5)
+#define EVSEL__PRINT_UNKNOWN_AS_ADDR	(1<<6)
+#define EVSEL__PRINT_CALLCHAIN_ARROW	(1<<7)
+#define EVSEL__PRINT_SKIP_IGNORED	(1<<8)
+
+struct addr_location;
+struct perf_event_attr;
+struct perf_sample;
+struct callchain_cursor;
+struct strlist;
+
+int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
+			      unsigned int print_opts, struct callchain_cursor *cursor,
+			      struct strlist *bt_stop_list, FILE *fp);
+
+int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
+			int left_alignment, unsigned int print_opts,
+			struct callchain_cursor *cursor,
+			struct strlist *bt_stop_list, FILE *fp);
+
+typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
+
+int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
+			     attr__fprintf_f attr__fprintf, void *priv);
+#endif // __PERF_EVSEL_H
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3b24b4974c5f..86d9396cb131 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -25,6 +25,7 @@
 #include "dso.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "util/evsel_fprintf.h"
 #include "header.h"
 #include "memswap.h"
 #include "trace-event.h"
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
new file mode 100644
index 000000000000..d4ad3f04923a
--- /dev/null
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/perf_event.h>
+#include "util/evsel_fprintf.h"
+
+struct bit_names {
+	int bit;
+	const char *name;
+};
+
+static void __p_bits(char *buf, size_t size, u64 value, struct bit_names *bits)
+{
+	bool first_bit = true;
+	int i = 0;
+
+	do {
+		if (value & bits[i].bit) {
+			buf += scnprintf(buf, size, "%s%s", first_bit ? "" : "|", bits[i].name);
+			first_bit = false;
+		}
+	} while (bits[++i].name != NULL);
+}
+
+static void __p_sample_type(char *buf, size_t size, u64 value)
+{
+#define bit_name(n) { PERF_SAMPLE_##n, #n }
+	struct bit_names bits[] = {
+		bit_name(IP), bit_name(TID), bit_name(TIME), bit_name(ADDR),
+		bit_name(READ), bit_name(CALLCHAIN), bit_name(ID), bit_name(CPU),
+		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
+		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
+		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
+		bit_name(WEIGHT), bit_name(PHYS_ADDR),
+		{ .name = NULL, }
+	};
+#undef bit_name
+	__p_bits(buf, size, value, bits);
+}
+
+static void __p_branch_sample_type(char *buf, size_t size, u64 value)
+{
+#define bit_name(n) { PERF_SAMPLE_BRANCH_##n, #n }
+	struct bit_names bits[] = {
+		bit_name(USER), bit_name(KERNEL), bit_name(HV), bit_name(ANY),
+		bit_name(ANY_CALL), bit_name(ANY_RETURN), bit_name(IND_CALL),
+		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
+		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
+		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
+		{ .name = NULL, }
+	};
+#undef bit_name
+	__p_bits(buf, size, value, bits);
+}
+
+static void __p_read_format(char *buf, size_t size, u64 value)
+{
+#define bit_name(n) { PERF_FORMAT_##n, #n }
+	struct bit_names bits[] = {
+		bit_name(TOTAL_TIME_ENABLED), bit_name(TOTAL_TIME_RUNNING),
+		bit_name(ID), bit_name(GROUP),
+		{ .name = NULL, }
+	};
+#undef bit_name
+	__p_bits(buf, size, value, bits);
+}
+
+#define BUF_SIZE		1024
+
+#define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
+#define p_unsigned(val)		snprintf(buf, BUF_SIZE, "%"PRIu64, (uint64_t)(val))
+#define p_signed(val)		snprintf(buf, BUF_SIZE, "%"PRId64, (int64_t)(val))
+#define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
+#define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
+#define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
+
+#define PRINT_ATTRn(_n, _f, _p)				\
+do {							\
+	if (attr->_f) {					\
+		_p(attr->_f);				\
+		ret += attr__fprintf(fp, _n, buf, priv);\
+	}						\
+} while (0)
+
+#define PRINT_ATTRf(_f, _p)	PRINT_ATTRn(#_f, _f, _p)
+
+int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
+			     attr__fprintf_f attr__fprintf, void *priv)
+{
+	char buf[BUF_SIZE];
+	int ret = 0;
+
+	PRINT_ATTRf(type, p_unsigned);
+	PRINT_ATTRf(size, p_unsigned);
+	PRINT_ATTRf(config, p_hex);
+	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned);
+	PRINT_ATTRf(sample_type, p_sample_type);
+	PRINT_ATTRf(read_format, p_read_format);
+
+	PRINT_ATTRf(disabled, p_unsigned);
+	PRINT_ATTRf(inherit, p_unsigned);
+	PRINT_ATTRf(pinned, p_unsigned);
+	PRINT_ATTRf(exclusive, p_unsigned);
+	PRINT_ATTRf(exclude_user, p_unsigned);
+	PRINT_ATTRf(exclude_kernel, p_unsigned);
+	PRINT_ATTRf(exclude_hv, p_unsigned);
+	PRINT_ATTRf(exclude_idle, p_unsigned);
+	PRINT_ATTRf(mmap, p_unsigned);
+	PRINT_ATTRf(comm, p_unsigned);
+	PRINT_ATTRf(freq, p_unsigned);
+	PRINT_ATTRf(inherit_stat, p_unsigned);
+	PRINT_ATTRf(enable_on_exec, p_unsigned);
+	PRINT_ATTRf(task, p_unsigned);
+	PRINT_ATTRf(watermark, p_unsigned);
+	PRINT_ATTRf(precise_ip, p_unsigned);
+	PRINT_ATTRf(mmap_data, p_unsigned);
+	PRINT_ATTRf(sample_id_all, p_unsigned);
+	PRINT_ATTRf(exclude_host, p_unsigned);
+	PRINT_ATTRf(exclude_guest, p_unsigned);
+	PRINT_ATTRf(exclude_callchain_kernel, p_unsigned);
+	PRINT_ATTRf(exclude_callchain_user, p_unsigned);
+	PRINT_ATTRf(mmap2, p_unsigned);
+	PRINT_ATTRf(comm_exec, p_unsigned);
+	PRINT_ATTRf(use_clockid, p_unsigned);
+	PRINT_ATTRf(context_switch, p_unsigned);
+	PRINT_ATTRf(write_backward, p_unsigned);
+	PRINT_ATTRf(namespaces, p_unsigned);
+	PRINT_ATTRf(ksymbol, p_unsigned);
+	PRINT_ATTRf(bpf_event, p_unsigned);
+	PRINT_ATTRf(aux_output, p_unsigned);
+
+	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
+	PRINT_ATTRf(bp_type, p_unsigned);
+	PRINT_ATTRn("{ bp_addr, config1 }", bp_addr, p_hex);
+	PRINT_ATTRn("{ bp_len, config2 }", bp_len, p_hex);
+	PRINT_ATTRf(branch_sample_type, p_branch_sample_type);
+	PRINT_ATTRf(sample_regs_user, p_hex);
+	PRINT_ATTRf(sample_stack_user, p_unsigned);
+	PRINT_ATTRf(clockid, p_signed);
+	PRINT_ATTRf(sample_regs_intr, p_hex);
+	PRINT_ATTRf(aux_watermark, p_unsigned);
+	PRINT_ATTRf(sample_max_stack, p_unsigned);
+
+	return ret;
+}
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index c6dd478956f1..9af183860fbd 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -10,6 +10,7 @@ util/python.c
 util/cap.c
 util/evlist.c
 util/evsel.c
+util/perf_event_attr_fprintf.c
 util/cpumap.c
 util/memswap.c
 util/mmap.c
-- 
2.21.0

