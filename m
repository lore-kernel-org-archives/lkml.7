Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A25C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E959320870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKWIPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKWIPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZO-0002a6-Iy; Sat, 23 Nov 2019 09:15:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C97361C1AD4;
        Sat, 23 Nov 2019 09:15:01 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:01 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Add support for AUX area sample recording
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-6-adrian.hunter@intel.com>
References: <20191115124225.5247-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690175.21853.6088707204491010593.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f0bb7ee8530a07d3c23bd2e06984796e66cfbcf1
Gitweb:        https://git.kernel.org/tip/f0bb7ee8530a07d3c23bd2e06984796e66cfbcf1
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:15 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf auxtrace: Add support for AUX area sample recording

Add support for parsing and validating AUX area sample options. At
present, the only option is the sample size, but it is also necessary to
ensure that events are in a group with an AUX area event as the leader.

Committer note:

Add missing 'static inline' in front of auxtrace_parse_sample_options()
for when we don't HAVE_AUXTRACE_SUPPORT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 107 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/auxtrace.h |  17 ++++++-
 tools/perf/util/pmu.h      |   1 +-
 tools/perf/util/record.h   |   2 +-
 4 files changed, 127 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 263d1d9..51fbe01 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -69,6 +69,13 @@ static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
 	return pmu;
 }
 
+static bool perf_evsel__is_aux_event(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+
+	return pmu && pmu->auxtrace;
+}
+
 static bool auxtrace__dont_decode(struct perf_session *session)
 {
 	return !session->itrace_synth_opts ||
@@ -609,6 +616,106 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	return -EINVAL;
 }
 
+/*
+ * Event record size is 16-bit which results in a maximum size of about 64KiB.
+ * Allow about 4KiB for the rest of the sample record, to give a maximum
+ * AUX area sample size of 60KiB.
+ */
+#define MAX_AUX_SAMPLE_SIZE (60 * 1024)
+
+/* Arbitrary default size if no other default provided */
+#define DEFAULT_AUX_SAMPLE_SIZE (4 * 1024)
+
+static int auxtrace_validate_aux_sample_size(struct evlist *evlist,
+					     struct record_opts *opts)
+{
+	struct evsel *evsel;
+	bool has_aux_leader = false;
+	u32 sz;
+
+	evlist__for_each_entry(evlist, evsel) {
+		sz = evsel->core.attr.aux_sample_size;
+		if (perf_evsel__is_group_leader(evsel)) {
+			has_aux_leader = perf_evsel__is_aux_event(evsel);
+			if (sz) {
+				if (has_aux_leader)
+					pr_err("Cannot add AUX area sampling to an AUX area event\n");
+				else
+					pr_err("Cannot add AUX area sampling to a group leader\n");
+				return -EINVAL;
+			}
+		}
+		if (sz > MAX_AUX_SAMPLE_SIZE) {
+			pr_err("AUX area sample size %u too big, max. %d\n",
+			       sz, MAX_AUX_SAMPLE_SIZE);
+			return -EINVAL;
+		}
+		if (sz) {
+			if (!has_aux_leader) {
+				pr_err("Cannot add AUX area sampling because group leader is not an AUX area event\n");
+				return -EINVAL;
+			}
+			perf_evsel__set_sample_bit(evsel, AUX);
+			opts->auxtrace_sample_mode = true;
+		} else {
+			perf_evsel__reset_sample_bit(evsel, AUX);
+		}
+	}
+
+	if (!opts->auxtrace_sample_mode) {
+		pr_err("AUX area sampling requires an AUX area event group leader plus other events to which to add samples\n");
+		return -EINVAL;
+	}
+
+	if (!perf_can_aux_sample()) {
+		pr_err("AUX area sampling is not supported by kernel\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int auxtrace_parse_sample_options(struct auxtrace_record *itr,
+				  struct evlist *evlist,
+				  struct record_opts *opts, const char *str)
+{
+	bool has_aux_leader = false;
+	struct evsel *evsel;
+	char *endptr;
+	unsigned long sz;
+
+	if (!str)
+		return 0;
+
+	if (!itr) {
+		pr_err("No AUX area event to sample\n");
+		return -EINVAL;
+	}
+
+	sz = strtoul(str, &endptr, 0);
+	if (*endptr || sz > UINT_MAX) {
+		pr_err("Bad AUX area sampling option: '%s'\n", str);
+		return -EINVAL;
+	}
+
+	if (!sz)
+		sz = itr->default_aux_sample_size;
+
+	if (!sz)
+		sz = DEFAULT_AUX_SAMPLE_SIZE;
+
+	/* Set aux_sample_size based on --aux-sample option */
+	evlist__for_each_entry(evlist, evsel) {
+		if (perf_evsel__is_group_leader(evsel)) {
+			has_aux_leader = perf_evsel__is_aux_event(evsel);
+		} else if (has_aux_leader) {
+			evsel->core.attr.aux_sample_size = sz;
+		}
+	}
+
+	return auxtrace_validate_aux_sample_size(evlist, opts);
+}
+
 struct auxtrace_record *__weak
 auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
 {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 3f4aa54..ab48de1 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -313,6 +313,7 @@ struct auxtrace_mmap_params {
  * @reference: provide a 64-bit reference number for auxtrace_event
  * @read_finish: called after reading from an auxtrace mmap
  * @alignment: alignment (if any) for AUX area data
+ * @default_aux_sample_size: default sample size for --aux sample option
  */
 struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
@@ -336,6 +337,7 @@ struct auxtrace_record {
 	u64 (*reference)(struct auxtrace_record *itr);
 	int (*read_finish)(struct auxtrace_record *itr, int idx);
 	unsigned int alignment;
+	unsigned int default_aux_sample_size;
 };
 
 /**
@@ -498,6 +500,9 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 				    struct record_opts *opts,
 				    const char *str);
+int auxtrace_parse_sample_options(struct auxtrace_record *itr,
+				  struct evlist *evlist,
+				  struct record_opts *opts, const char *str);
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts);
@@ -649,6 +654,18 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 }
 
 static inline
+int auxtrace_parse_sample_options(struct auxtrace_record *itr __maybe_unused,
+				  struct evlist *evlist __maybe_unused,
+				  struct record_opts *opts __maybe_unused,
+				  const char *str)
+{
+	if (!str)
+		return 0;
+	pr_err("AUX area tracing not supported\n");
+	return -EINVAL;
+}
+
+static inline
 int auxtrace__process_event(struct perf_session *session __maybe_unused,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample __maybe_unused,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 3e8cd31..2eb7a70 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -26,6 +26,7 @@ struct perf_pmu {
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
+	bool auxtrace;
 	int max_precise;
 	struct perf_event_attr *default_config;
 	struct perf_cpu_map *cpus;
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 948bbcf..5421fd2 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -32,6 +32,7 @@ struct record_opts {
 	bool	      full_auxtrace;
 	bool	      auxtrace_snapshot_mode;
 	bool	      auxtrace_snapshot_on_exit;
+	bool	      auxtrace_sample_mode;
 	bool	      record_namespaces;
 	bool	      record_switch_events;
 	bool	      all_kernel;
@@ -56,6 +57,7 @@ struct record_opts {
 	u64	      user_interval;
 	size_t	      auxtrace_snapshot_size;
 	const char    *auxtrace_snapshot_opts;
+	const char    *auxtrace_sample_opts;
 	bool	      sample_transaction;
 	unsigned      initial_delay;
 	bool	      use_clockid;
