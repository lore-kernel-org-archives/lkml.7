Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D188C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AC920672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434735;
	bh=AzRx6yQ8L/yxI1WjpT88wjq6DeTgstySYVUBxPUddk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BTEqKri1+IhBOF7G+K6+mwlaBFqSl56lwmDD2RAoR06TLwlFHJQ0CqaTStdo/pfs5
	 x5IKKzTywyfjdjBpDxdltA3YismtONeJO9sh3eyf3erD+YJ0BhVMjZpNzPoottcEZ9
	 9iYIlh7ZY9+2sR3WWwXkv4Toh+tkpIV9ZRSeFovQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfKVO6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfKVO5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26756207FC;
        Fri, 22 Nov 2019 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434673;
        bh=AzRx6yQ8L/yxI1WjpT88wjq6DeTgstySYVUBxPUddk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vm+kjKuw2zvqQQqxzFadxYg2Q4JAvzxqrRdOLM2zmEQbX58Hws61cQ16pX7XNIRpt
         mb51l0+3lgBRLctX/gvB3bSsPFgSa27ryUk4awzqD5ydd8KWMLimKuEIto2awOxAzh
         WcYWOVuBlxpa3dGAvx9dGw/CJqFJ23Ucsw8cEIVY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/26] perf auxtrace: Add support for AUX area sample recording
Date:   Fri, 22 Nov 2019 11:56:57 -0300
Message-Id: <20191122145711.3171-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
 tools/perf/util/auxtrace.c | 107 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  17 ++++++
 tools/perf/util/pmu.h      |   1 +
 tools/perf/util/record.h   |   2 +
 4 files changed, 127 insertions(+)

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
index 3f4aa5427d76..ab48de13c353 100644
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
@@ -648,6 +653,18 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 	return -EINVAL;
 }
 
+static inline
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
2.21.0

