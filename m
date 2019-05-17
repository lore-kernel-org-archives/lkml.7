Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0839C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C06621744
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122003;
	bh=WRH0PuUjI+4+iX6xr/fcGvcN+Lbgbkq/UKl8/FjZ9v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ud+fw1LWBoz/Ywi/8EPbM/NlD4VK6cjXjhiw9iLqRFlFb3l46UZcjrq4oShDbPMv7
	 LW34tIe0TlMgNBcwkKleuYiGUizShQOeL1EbBbjpuCRTbiokb0PzcRhXgsCO7hSNe6
	 ta79/aqqEL+Ef2PfyR3SGtJTKtFLMr0Ym00J8NjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfEQTkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbfEQTj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:39:58 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 628A52173C;
        Fri, 17 May 2019 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121998;
        bh=WRH0PuUjI+4+iX6xr/fcGvcN+Lbgbkq/UKl8/FjZ9v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUfXQ3jtt8MTGu0OLEeSi/e1KT3fg1i70sr4izkozKpU8piM2AJZqEwpc2pG/TyZp
         i2g6WqPX4DLv9+vaNb3xaceFbX5qnuu0nzUZ1NaAtnS61g34J3xgYmjIyQbPqK14rP
         PoacK74TSBbUnyp+MGTQhm6xEZDieNIlwweN2vSw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/73] perf record: Implement COMPRESSED event record and its attributes
Date:   Fri, 17 May 2019 16:35:47 -0300
Message-Id: <20190517193611.4974-50-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Implemented PERF_RECORD_COMPRESSED event, related data types, header
feature and functions to write, read and print feature attributes from
the trace header section.

comp_mmap_len preserves the size of mmaped kernel buffer that was used
during collection. comp_mmap_len size is used on loading stage as the
size of decomp buffer for decompression of COMPRESSED events content.

Committer notes:

Fixed up conflict with BPF_PROG_INFO and BTF_BTF header features.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/ebbaf031-8dda-3864-ebc6-7922d43ee515@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt   | 24 +++++++++
 tools/perf/builtin-record.c                   |  8 +++
 tools/perf/perf.h                             |  1 +
 tools/perf/util/env.h                         | 10 ++++
 tools/perf/util/event.c                       |  1 +
 tools/perf/util/event.h                       |  7 +++
 tools/perf/util/header.c                      | 53 +++++++++++++++++++
 tools/perf/util/header.h                      |  1 +
 8 files changed, 105 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 593ef49b273c..6967e9b02be5 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -272,6 +272,19 @@ struct {
 
 Two uint64_t for the time of first sample and the time of last sample.
 
+        HEADER_COMPRESSED = 27,
+
+struct {
+	u32	version;
+	u32	type;
+	u32	level;
+	u32	ratio;
+	u32	mmap_len;
+};
+
+Indicates that trace contains records of PERF_RECORD_COMPRESSED type
+that have perf_events records in compressed form.
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
@@ -437,6 +450,17 @@ struct auxtrace_error_event {
 Describes a header feature. These are records used in pipe-mode that
 contain information that otherwise would be in perf.data file's header.
 
+	PERF_RECORD_COMPRESSED 			= 81,
+
+struct compressed_event {
+	struct perf_event_header	header;
+	char				data[];
+};
+
+The header is followed by compressed data frame that can be decompressed
+into array of perf trace records. The size of the entire compressed event
+record including the header is limited by the max value of header.size.
+
 Event types
 
 Define the event attributes with their IDs.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 386e665a166f..45a80b3584ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -372,6 +372,11 @@ static int record__mmap_flush_parse(const struct option *opt,
 	return 0;
 }
 
+static int record__comp_enabled(struct record *rec)
+{
+	return rec->opts.comp_level > 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -888,6 +893,8 @@ static void record__init_features(struct record *rec)
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
 	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!record__comp_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
@@ -1245,6 +1252,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = -1;
 		goto out_child;
 	}
+	session->header.env.comp_mmap_len = session->evlist->mmap_len;
 
 	err = bpf__apply_obj_config();
 	if (err) {
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 369eae61068d..d59dee61b64d 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -86,6 +86,7 @@ struct record_opts {
 	int	     nr_cblocks;
 	int	     affinity;
 	int	     mmap_flush;
+	unsigned int comp_level;
 };
 
 enum perf_affinity {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 34868ca7efd1..271a90b326c4 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -63,6 +63,10 @@ struct perf_env {
 	struct cpu_cache_level	*caches;
 	int			 caches_cnt;
 	u32			comp_ratio;
+	u32			comp_ver;
+	u32			comp_type;
+	u32			comp_level;
+	u32			comp_mmap_len;
 	struct numa_node	*numa_nodes;
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
@@ -81,6 +85,12 @@ struct perf_env {
 	} bpf_progs;
 };
 
+enum perf_compress_type {
+	PERF_COMP_NONE = 0,
+	PERF_COMP_ZSTD,
+	PERF_COMP_MAX
+};
+
 struct bpf_prog_info_node;
 struct btf_node;
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ba7be74fad6e..d1ad6c419724 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -68,6 +68,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_EVENT_UPDATE]		= "EVENT_UPDATE",
 	[PERF_RECORD_TIME_CONV]			= "TIME_CONV",
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
+	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 };
 
 static const char *perf_ns__names[] = {
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4e908ec1ef64..9e999550f247 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -255,6 +255,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_EVENT_UPDATE		= 78,
 	PERF_RECORD_TIME_CONV			= 79,
 	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -627,6 +628,11 @@ struct feature_event {
 	char				data[];
 };
 
+struct compressed_event {
+	struct perf_event_header	header;
+	char				data[];
+};
+
 union perf_event {
 	struct perf_event_header	header;
 	struct mmap_event		mmap;
@@ -660,6 +666,7 @@ union perf_event {
 	struct feature_event		feat;
 	struct ksymbol_event		ksymbol_event;
 	struct bpf_event		bpf_event;
+	struct compressed_event		pack;
 };
 
 void perf_event__print_totals(void);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2d2af2ac2b1e..847ae51a524b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1344,6 +1344,30 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	return ret;
 }
 
+static int write_compressed(struct feat_fd *ff __maybe_unused,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	int ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_ver), sizeof(ff->ph->env.comp_ver));
+	if (ret)
+		return ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_type), sizeof(ff->ph->env.comp_type));
+	if (ret)
+		return ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_level), sizeof(ff->ph->env.comp_level));
+	if (ret)
+		return ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_ratio), sizeof(ff->ph->env.comp_ratio));
+	if (ret)
+		return ret;
+
+	return do_write(ff, &(ff->ph->env.comp_mmap_len), sizeof(ff->ph->env.comp_mmap_len));
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1688,6 +1712,13 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
 	}
 }
 
+static void print_compressed(struct feat_fd *ff, FILE *fp)
+{
+	fprintf(fp, "# compressed : %s, level = %d, ratio = %d\n",
+		ff->ph->env.comp_type == PERF_COMP_ZSTD ? "Zstd" : "Unknown",
+		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
+}
+
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
 	const char *delimiter = "# pmu mappings: ";
@@ -2667,6 +2698,27 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	return err;
 }
 
+static int process_compressed(struct feat_fd *ff,
+			      void *data __maybe_unused)
+{
+	if (do_read_u32(ff, &(ff->ph->env.comp_ver)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_type)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_level)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_ratio)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_mmap_len)))
+		return -1;
+
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2730,6 +2782,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(DIR_FORMAT,	dir_format,	false),
 	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
 	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
+	FEAT_OPR(COMPRESSED,	compressed,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 386da49e1bfa..5b3abe4172e2 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -42,6 +42,7 @@ enum {
 	HEADER_DIR_FORMAT,
 	HEADER_BPF_PROG_INFO,
 	HEADER_BPF_BTF,
+	HEADER_COMPRESSED,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.20.1

