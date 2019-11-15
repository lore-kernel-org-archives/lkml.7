Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8833C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E335207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKOMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfKOMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749668"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:29 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] perf auxtrace: Add support for AUX area sample recording
Date:   Fri, 15 Nov 2019 14:42:15 +0200
Message-Id: <20191115124225.5247-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing and validating AUX area sample options. At present,
the only option is the sample size, but it is also necessary to ensure that
events are in a group with an AUX area event as the leader.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 107 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  16 ++++++
 tools/perf/util/pmu.h      |   1 +
 tools/perf/util/record.h   |   2 +
 4 files changed, 126 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 263d1d9d8987..51fbe01f8a11 100644
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
index 3f4aa5427d76..12b02eb4e01c 100644
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
@@ -648,6 +653,17 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 	return -EINVAL;
 }
 
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
 static inline
 int auxtrace__process_event(struct perf_session *session __maybe_unused,
 			    union perf_event *event __maybe_unused,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 3e8cd31a89cc..2eb7a7001307 100644
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
index 948bbcf9aef3..5421fd2ad383 100644
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
-- 
2.17.1

