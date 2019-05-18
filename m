Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD40CC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC0C2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fWau3doH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfERJUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:20:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbfERJUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:20:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9KMYX1738726
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:20:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9KMYX1738726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171222;
        bh=WWwPk2fil4khkGEaRro3ggH1U+G56hqNPH/FZHlhAhk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fWau3doHw8oDok9Lw8zeIJwgdG7G2WXsbvum9bhGUvz/z+lGWISVrA+76eHpQV/dv
         BI1qh46ovpkJ3jM8Z4ytHb8aRwPgcxUayRuV5wNn+BqHxa42ogTZ/a2CWDjF/P/0pg
         1ghlSmSEY1+hus7hQrMIoSImvz9FqoiR1/HBm4utDZqMDEptWGWfAciNUoutW6oOUx
         MM19PYuq+zjh8Kr5YEemaZkcdDR9XV9vKILT30xMH8ajfWfvCGAeUedfZVeIvYIiI+
         HTNcwZBe1Ff+8p2NRuJLYZj14hj/ksy6OJULfGmeU2h9sNqfbQ9ClY5oWqs0Qadc7v
         jyT1W+K1haLkw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9KLBe1738723;
        Sat, 18 May 2019 02:20:21 -0700
Date:   Sat, 18 May 2019 02:20:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-42e1fd80a5b8bf9188ddb502b788433ece189aae@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com,
        alexey.budankov@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, ak@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          namhyung@kernel.org, mingo@kernel.org, ak@linux.intel.com,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <ebbaf031-8dda-3864-ebc6-7922d43ee515@linux.intel.com>
References: <ebbaf031-8dda-3864-ebc6-7922d43ee515@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Implement COMPRESSED event record and
 its attributes
Git-Commit-ID: 42e1fd80a5b8bf9188ddb502b788433ece189aae
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

Commit-ID:  42e1fd80a5b8bf9188ddb502b788433ece189aae
Gitweb:     https://git.kernel.org/tip/42e1fd80a5b8bf9188ddb502b788433ece189aae
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:41:33 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf record: Implement COMPRESSED event record and its attributes

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
 tools/perf/Documentation/perf.data-file-format.txt | 24 ++++++++++
 tools/perf/builtin-record.c                        |  8 ++++
 tools/perf/perf.h                                  |  1 +
 tools/perf/util/env.h                              | 10 ++++
 tools/perf/util/event.c                            |  1 +
 tools/perf/util/event.h                            |  7 +++
 tools/perf/util/header.c                           | 53 ++++++++++++++++++++++
 tools/perf/util/header.h                           |  1 +
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
@@ -1344,6 +1344,30 @@ out:
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
@@ -2667,6 +2698,27 @@ out:
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
