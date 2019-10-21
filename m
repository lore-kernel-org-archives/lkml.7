Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB831CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F362084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfJUUE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:04:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:57214 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730253AbfJUUEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:04:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="201467383"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2019 13:04:23 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 06/13] perf header: Support CPU PMU capabilities
Date:   Mon, 21 Oct 2019 13:03:07 -0700
Message-Id: <20191021200314.1613-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021200314.1613-1-kan.liang@linux.intel.com>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To stitch LBR call stack, the max LBR information is required. So the
CPU PMU capabilities information has to be stored in perf header.

Add a new feature HEADER_CPU_PMU_CAPS for CPU PMU capabilities.
Retrieve all CPU PMU capabilities, not just max LBR information.

Add variable max_branches to facilitate future usage.

The CPU PMU capabilities information is only useful for LBR call stack
mode. Clear the feature for perf stat and other perf record mode.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../Documentation/perf.data-file-format.txt   |  16 +++
 tools/perf/builtin-record.c                   |   3 +
 tools/perf/builtin-stat.c                     |   1 +
 tools/perf/util/env.h                         |   3 +
 tools/perf/util/header.c                      | 110 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 6 files changed, 134 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index b0152e1095c5..b6472e463284 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -373,6 +373,22 @@ struct {
 Indicates that trace contains records of PERF_RECORD_COMPRESSED type
 that have perf_events records in compressed form.
 
+	HEADER_CPU_PMU_CAPS = 28,
+
+	A list of cpu PMU capabilities. The format of data is as below.
+
+struct {
+	u32 nr_cpu_pmu_caps;
+	{
+		char	name[];
+		char	value[];
+	} [nr_cpu_pmu_caps]
+};
+
+
+Example:
+ cpu pmu capabilities: branches=32, max_precise=3, pmu_name=icelake
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 23332861de6e..fbbeb1e625ef 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1057,6 +1057,9 @@ static void record__init_features(struct record *rec)
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
+	if (!callchain_param.enabled || (callchain_param.record_mode != CALLCHAIN_LBR))
+		perf_header__clear_feat(&session->header, HEADER_CPU_PMU_CAPS);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 468fc49420ce..26bb9794e95a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1418,6 +1418,7 @@ static void init_features(struct perf_session *session)
 	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
 	perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
+	perf_header__clear_feat(&session->header, HEADER_CPU_PMU_CAPS);
 }
 
 static int __cmd_record(int argc, const char **argv)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index a3059dc1abe5..dae64e20b280 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -48,6 +48,7 @@ struct perf_env {
 	char			*cpuid;
 	unsigned long long	total_mem;
 	unsigned int		msr_pmu_type;
+	unsigned int		max_branches;
 
 	int			nr_cmdline;
 	int			nr_sibling_cores;
@@ -57,12 +58,14 @@ struct perf_env {
 	int			nr_memory_nodes;
 	int			nr_pmu_mappings;
 	int			nr_groups;
+	int			nr_cpu_pmu_caps;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
 	char			*sibling_dies;
 	char			*sibling_threads;
 	char			*pmu_mappings;
+	char			*cpu_pmu_caps;
 	struct cpu_topology_map	*cpu;
 	struct cpu_cache_level	*caches;
 	int			 caches_cnt;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 6c51404fbeef..16274ffd875e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1402,6 +1402,39 @@ static int write_compressed(struct feat_fd *ff __maybe_unused,
 	return do_write(ff, &(ff->ph->env.comp_mmap_len), sizeof(ff->ph->env.comp_mmap_len));
 }
 
+static int write_cpu_pmu_caps(struct feat_fd *ff,
+			      struct evlist *evlist __maybe_unused)
+{
+	struct perf_pmu_caps *caps = NULL;
+	struct perf_pmu *cpu_pmu;
+	int nr_caps;
+	int ret;
+
+	cpu_pmu = perf_pmu__find("cpu");
+	if (!cpu_pmu)
+		return -ENOENT;
+
+	nr_caps = perf_pmu__caps_parse(cpu_pmu);
+	if (nr_caps < 0)
+		return nr_caps;
+
+	ret = do_write(ff, &nr_caps, sizeof(nr_caps));
+	if (ret < 0)
+		return ret;
+
+	while ((caps = perf_pmu__scan_caps(cpu_pmu, caps))) {
+		ret = do_write_string(ff, caps->name);
+		if (ret < 0)
+			return ret;
+
+		ret = do_write_string(ff, caps->value);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1817,6 +1850,28 @@ static void print_compressed(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
 }
 
+static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
+{
+	const char *delimiter = "# cpu pmu capabilities: ";
+	char *str;
+	u32 nr_caps;
+
+	nr_caps = ff->ph->env.nr_cpu_pmu_caps;
+	if (!nr_caps) {
+		fprintf(fp, "# cpu pmu capabilities: not available\n");
+		return;
+	}
+
+	str = ff->ph->env.cpu_pmu_caps;
+	while (nr_caps--) {
+		fprintf(fp, "%s%s", delimiter, str);
+		delimiter = ", ";
+		str += strlen(str) + 1;
+	}
+
+	fprintf(fp, "\n");
+}
+
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
 	const char *delimiter = "# pmu mappings: ";
@@ -2854,6 +2909,60 @@ static int process_compressed(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_cpu_pmu_caps(struct feat_fd *ff,
+				void *data __maybe_unused)
+{
+	char *name, *value;
+	struct strbuf sb;
+	u32 nr_caps;
+
+	if (do_read_u32(ff, &nr_caps))
+		return -1;
+
+	if (!nr_caps) {
+		pr_debug("cpu pmu capabilities not available\n");
+		return 0;
+	}
+
+	ff->ph->env.nr_cpu_pmu_caps = nr_caps;
+
+	if (strbuf_init(&sb, 128) < 0)
+		return -1;
+
+	while (nr_caps--) {
+		name = do_read_string(ff);
+		if (!name)
+			goto error;
+
+		value = do_read_string(ff);
+		if (!value)
+			goto free_name;
+
+		if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
+			goto free_value;
+
+		/* include a NULL character at the end */
+		if (strbuf_add(&sb, "", 1) < 0)
+			goto free_value;
+
+		if (!strcmp(name, "branches"))
+			ff->ph->env.max_branches = atoi(value);
+
+		free(value);
+		free(name);
+	}
+	ff->ph->env.cpu_pmu_caps = strbuf_detach(&sb, NULL);
+	return 0;
+
+free_value:
+	free(value);
+free_name:
+	free(name);
+error:
+	strbuf_release(&sb);
+	return -1;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -2911,6 +3020,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
 	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
 	FEAT_OPR(COMPRESSED,	compressed,	false),
+	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ca53a929e9fd..ae8a7108f52b 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -43,6 +43,7 @@ enum {
 	HEADER_BPF_PROG_INFO,
 	HEADER_BPF_BTF,
 	HEADER_COMPRESSED,
+	HEADER_CPU_PMU_CAPS,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.17.1

