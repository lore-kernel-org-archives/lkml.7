Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7205C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF5722DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000696;
	bh=sOV+UdPwkRKBMiPneqRSkbaGk3mb9QaECxrtJ3X+gEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gtL1s7SmGaaBopMnGQO4tDg08D7LzB5SYZX0Ppn3KF8VjjfBg4pwxmAkQkHCKnNlf
	 uMBihj1ExztzjUXEhJLLt3I6PBWT+Za4T/TZIaQiR3I7l+kG3gT/0dQW2D0pZVy0yF
	 KmtaaPtY9Pw3dZkMiDCIsHxvN9r1/cLoDS860hNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfH1N6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfH1N6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:58:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 018AB2BE94;
        Wed, 28 Aug 2019 13:58:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1311001B13;
        Wed, 28 Aug 2019 13:58:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 22/23] libperf: Rename the PERF_RECORD_ structs to have a "perf" prefix
Date:   Wed, 28 Aug 2019 15:57:16 +0200
Message-Id: <20190828135717.7245-23-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 28 Aug 2019 13:58:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even more, to have a "perf_record_" prefix, so that they match the
PERF_RECORD_ enum they map to.

Link: http://lkml.kernel.org/n/tip-rrypskxisy9mpmu96jtgpp0p@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/cs-etm.c    |   4 +-
 tools/perf/arch/arm64/util/arm-spe.c |   2 +-
 tools/perf/arch/s390/util/auxtrace.c |   2 +-
 tools/perf/arch/x86/util/intel-bts.c |   2 +-
 tools/perf/arch/x86/util/intel-pt.c  |   2 +-
 tools/perf/arch/x86/util/tsc.c       |   2 +-
 tools/perf/builtin-record.c          |   4 +-
 tools/perf/builtin-script.c          |   2 +-
 tools/perf/builtin-stat.c            |   2 +-
 tools/perf/lib/include/perf/event.h  | 136 +++++++++++++--------------
 tools/perf/tests/cpumap.c            |  12 +--
 tools/perf/tests/event_update.c      |  16 ++--
 tools/perf/tests/stat.c              |   8 +-
 tools/perf/tests/thread-map.c        |   2 +-
 tools/perf/util/arm-spe.c            |   4 +-
 tools/perf/util/auxtrace.c           |  16 ++--
 tools/perf/util/auxtrace.h           |   8 +-
 tools/perf/util/build-id.c           |   2 +-
 tools/perf/util/cpumap.c             |   6 +-
 tools/perf/util/cpumap.h             |   4 +-
 tools/perf/util/cs-etm.c             |   2 +-
 tools/perf/util/event.c              |  34 +++----
 tools/perf/util/event.h              |   4 +-
 tools/perf/util/header.c             |  54 +++++------
 tools/perf/util/intel-bts.c          |   4 +-
 tools/perf/util/intel-pt.c           |   8 +-
 tools/perf/util/python.c             |   4 +-
 tools/perf/util/s390-cpumsf.c        |   4 +-
 tools/perf/util/session.c            |  20 ++--
 tools/perf/util/session.h            |   2 +-
 tools/perf/util/stat.c               |   6 +-
 tools/perf/util/thread_map.c         |   4 +-
 tools/perf/util/thread_map.h         |   4 +-
 33 files changed, 193 insertions(+), 193 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index a185dab2d903..a5a4632e1a78 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -564,7 +564,7 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
 
 static void cs_etm_get_metadata(int cpu, u32 *offset,
 				struct auxtrace_record *itr,
-				struct auxtrace_info_event *info)
+				struct perf_record_auxtrace_info *info)
 {
 	u32 increment;
 	u64 magic;
@@ -629,7 +629,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 
 static int cs_etm_info_fill(struct auxtrace_record *itr,
 			    struct perf_session *session,
-			    struct auxtrace_info_event *info,
+			    struct perf_record_auxtrace_info *info,
 			    size_t priv_size)
 {
 	int i;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index cdd5c0c84183..984da1f8151c 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -40,7 +40,7 @@ arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 
 static int arm_spe_info_fill(struct auxtrace_record *itr,
 			     struct perf_session *session,
-			     struct auxtrace_info_event *auxtrace_info,
+			     struct perf_record_auxtrace_info *auxtrace_info,
 			     size_t priv_size)
 {
 	struct arm_spe_recording *sper =
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index f32d7a72d039..b0fb70e38960 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -29,7 +29,7 @@ static size_t cpumsf_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 static int
 cpumsf_info_fill(struct auxtrace_record *itr __maybe_unused,
 		 struct perf_session *session __maybe_unused,
-		 struct auxtrace_info_event *auxtrace_info __maybe_unused,
+		 struct perf_record_auxtrace_info *auxtrace_info __maybe_unused,
 		 size_t priv_size __maybe_unused)
 {
 	auxtrace_info->type = PERF_AUXTRACE_S390_CPUMSF;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 1f2cf612bc9c..664377182ba8 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -58,7 +58,7 @@ intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 
 static int intel_bts_info_fill(struct auxtrace_record *itr,
 			       struct perf_session *session,
-			       struct auxtrace_info_event *auxtrace_info,
+			       struct perf_record_auxtrace_info *auxtrace_info,
 			       size_t priv_size)
 {
 	struct intel_bts_recording *btsr =
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index d7125e331dda..ecf3068e980b 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -313,7 +313,7 @@ static void intel_pt_tsc_ctc_ratio(u32 *n, u32 *d)
 
 static int intel_pt_info_fill(struct auxtrace_record *itr,
 			      struct perf_session *session,
-			      struct auxtrace_info_event *auxtrace_info,
+			      struct perf_record_auxtrace_info *auxtrace_info,
 			      size_t priv_size)
 {
 	struct intel_pt_recording *ptr =
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index b1eb963b4a6e..81720e27f8a3 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -57,7 +57,7 @@ int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc,
 		.time_conv = {
 			.header = {
 				.type = PERF_RECORD_TIME_CONV,
-				.size = sizeof(struct time_conv_event),
+				.size = sizeof(struct perf_record_time_conv),
 			},
 		},
 	};
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 359bb8f33e57..3c00be8cac71 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -898,7 +898,7 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
 
 static size_t process_comp_header(void *record, size_t increment)
 {
-	struct compressed_event *event = record;
+	struct perf_record_compressed *event = record;
 	size_t size = sizeof(*event);
 
 	if (increment) {
@@ -916,7 +916,7 @@ static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_
 			    void *src, size_t src_size)
 {
 	size_t compressed;
-	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct compressed_event) - 1;
+	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
 
 	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
 						     max_record_size, process_comp_header);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 51e7e6d0eee6..948bd4e82248 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3243,7 +3243,7 @@ static void script__setup_sample_type(struct perf_script *script)
 static int process_stat_round_event(struct perf_session *session,
 				    union perf_event *event)
 {
-	struct stat_round_event *round = &event->stat_round;
+	struct perf_record_stat_round *round = &event->stat_round;
 	struct evsel *counter;
 
 	evlist__for_each_entry(session->evlist, counter) {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6ab13f466827..a7e8c26635db 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1462,7 +1462,7 @@ static int __cmd_record(int argc, const char **argv)
 static int process_stat_round_event(struct perf_session *session,
 				    union perf_event *event)
 {
-	struct stat_round_event *stat_round = &event->stat_round;
+	struct perf_record_stat_round *stat_round = &event->stat_round;
 	struct evsel *counter;
 	struct timespec tsh, *ts = NULL;
 	const char **argv = session->header.env.cmdline_argv;
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index a5b08ef118a7..1655c744ec2b 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -110,13 +110,13 @@ struct perf_record_sample {
 	__u64			 array[];
 };
 
-struct context_switch_event {
+struct perf_record_switch {
 	struct perf_event_header header;
 	__u32			 next_prev_pid;
 	__u32			 next_prev_tid;
 };
 
-struct attr_event {
+struct perf_record_header_attr {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
 	__u64			 id[];
@@ -132,20 +132,20 @@ struct cpu_map_entries {
 	__u16			 cpu[];
 };
 
-struct cpu_map_mask {
+struct perf_record_record_cpu_map {
 	__u16			 nr;
 	__u16			 long_size;
 	unsigned long		 mask[];
 };
 
-struct cpu_map_data {
+struct perf_record_cpu_map_data {
 	__u16			 type;
 	char			 data[];
 };
 
-struct cpu_map_event {
-	struct perf_event_header header;
-	struct cpu_map_data	 data;
+struct perf_record_cpu_map {
+	struct perf_event_header	 header;
+	struct perf_record_cpu_map_data	 data;
 };
 
 enum {
@@ -155,15 +155,15 @@ enum {
 	PERF_EVENT_UPDATE__CPUS  = 3,
 };
 
-struct event_update_event_cpus {
-	struct cpu_map_data	 cpus;
+struct perf_record_event_update_cpus {
+	struct perf_record_cpu_map_data	 cpus;
 };
 
-struct event_update_event_scale {
+struct perf_record_event_update_scale {
 	double			 scale;
 };
 
-struct event_update_event {
+struct perf_record_event_update {
 	struct perf_event_header header;
 	__u64			 type;
 	__u64			 id;
@@ -177,17 +177,17 @@ struct perf_trace_event_type {
 	char			 name[MAX_EVENT_NAME];
 };
 
-struct event_type_event {
+struct perf_record_header_event_type {
 	struct perf_event_header	 header;
 	struct perf_trace_event_type	 event_type;
 };
 
-struct tracing_data_event {
+struct perf_record_header_tracing_data {
 	struct perf_event_header header;
 	__u32			 size;
 };
 
-struct build_id_event {
+struct perf_record_header_build_id {
 	struct perf_event_header header;
 	pid_t			 pid;
 	__u8			 build_id[24];
@@ -201,20 +201,20 @@ struct id_index_entry {
 	__u64			 tid;
 };
 
-struct id_index_event {
+struct perf_record_id_index {
 	struct perf_event_header header;
 	__u64			 nr;
 	struct id_index_entry	 entries[0];
 };
 
-struct auxtrace_info_event {
+struct perf_record_auxtrace_info {
 	struct perf_event_header header;
 	__u32			 type;
 	__u32			 reserved__; /* For alignment */
 	__u64			 priv[];
 };
 
-struct auxtrace_event {
+struct perf_record_auxtrace {
 	struct perf_event_header header;
 	__u64			 size;
 	__u64			 offset;
@@ -227,7 +227,7 @@ struct auxtrace_event {
 
 #define MAX_AUXTRACE_ERROR_MSG 64
 
-struct auxtrace_error_event {
+struct perf_record_auxtrace_error {
 	struct perf_event_header header;
 	__u32			 type;
 	__u32			 code;
@@ -240,28 +240,28 @@ struct auxtrace_error_event {
 	char			 msg[MAX_AUXTRACE_ERROR_MSG];
 };
 
-struct aux_event {
+struct perf_record_aux {
 	struct perf_event_header header;
 	__u64			 aux_offset;
 	__u64			 aux_size;
 	__u64			 flags;
 };
 
-struct itrace_start_event {
+struct perf_record_itrace_start {
 	struct perf_event_header header;
 	__u32			 pid;
 	__u32			 tid;
 };
 
-struct thread_map_event_entry {
+struct perf_record_thread_map_entry {
 	__u64			 pid;
 	char			 comm[16];
 };
 
-struct thread_map_event {
-	struct perf_event_header	 header;
-	__u64				 nr;
-	struct thread_map_event_entry	 entries[];
+struct perf_record_thread_map {
+	struct perf_event_header		 header;
+	__u64					 nr;
+	struct perf_record_thread_map_entry	 entries[];
 };
 
 enum {
@@ -271,18 +271,18 @@ enum {
 	PERF_STAT_CONFIG_TERM__MAX		= 3,
 };
 
-struct stat_config_event_entry {
+struct perf_record_stat_config_entry {
 	__u64			 tag;
 	__u64			 val;
 };
 
-struct stat_config_event {
-	struct perf_event_header	 header;
-	__u64				 nr;
-	struct stat_config_event_entry	 data[];
+struct perf_record_stat_config {
+	struct perf_event_header		 header;
+	__u64					 nr;
+	struct perf_record_stat_config_entry	 data[];
 };
 
-struct stat_event {
+struct perf_record_stat {
 	struct perf_event_header header;
 
 	__u64			 id;
@@ -299,64 +299,64 @@ struct stat_event {
 	};
 };
 
-struct stat_round_event {
+struct perf_record_stat_round {
 	struct perf_event_header header;
 	__u64			 type;
 	__u64			 time;
 };
 
-struct time_conv_event {
+struct perf_record_time_conv {
 	struct perf_event_header header;
 	__u64			 time_shift;
 	__u64			 time_mult;
 	__u64			 time_zero;
 };
 
-struct feature_event {
+struct perf_record_header_feature {
 	struct perf_event_header header;
 	__u64			 feat_id;
 	char			 data[];
 };
 
-struct compressed_event {
+struct perf_record_compressed {
 	struct perf_event_header header;
 	char			 data[];
 };
 
 union perf_event {
-	struct perf_event_header	header;
-	struct perf_record_mmap		mmap;
-	struct perf_record_mmap2	mmap2;
-	struct perf_record_comm		comm;
-	struct perf_record_namespaces	namespaces;
-	struct perf_record_fork		fork;
-	struct perf_record_lost		lost;
-	struct perf_record_lost_samples	lost_samples;
-	struct perf_record_read		read;
-	struct perf_record_throttle	throttle;
-	struct perf_record_sample	sample;
-	struct perf_record_bpf_event	bpf;
-	struct perf_record_ksymbol	ksymbol;
-	struct attr_event		attr;
-	struct event_update_event	event_update;
-	struct event_type_event		event_type;
-	struct tracing_data_event	tracing_data;
-	struct build_id_event		build_id;
-	struct id_index_event		id_index;
-	struct auxtrace_info_event	auxtrace_info;
-	struct auxtrace_event		auxtrace;
-	struct auxtrace_error_event	auxtrace_error;
-	struct aux_event		aux;
-	struct itrace_start_event	itrace_start;
-	struct context_switch_event	context_switch;
-	struct thread_map_event		thread_map;
-	struct cpu_map_event		cpu_map;
-	struct stat_config_event	stat_config;
-	struct stat_event		stat;
-	struct stat_round_event		stat_round;
-	struct time_conv_event		time_conv;
-	struct feature_event		feat;
-	struct compressed_event		pack;
+	struct perf_event_header		header;
+	struct perf_record_mmap			mmap;
+	struct perf_record_mmap2		mmap2;
+	struct perf_record_comm			comm;
+	struct perf_record_namespaces		namespaces;
+	struct perf_record_fork			fork;
+	struct perf_record_lost			lost;
+	struct perf_record_lost_samples		lost_samples;
+	struct perf_record_read			read;
+	struct perf_record_throttle		throttle;
+	struct perf_record_sample		sample;
+	struct perf_record_bpf_event		bpf;
+	struct perf_record_ksymbol		ksymbol;
+	struct perf_record_header_attr		attr;
+	struct perf_record_event_update		event_update;
+	struct perf_record_header_event_type	event_type;
+	struct perf_record_header_tracing_data	tracing_data;
+	struct perf_record_header_build_id	build_id;
+	struct perf_record_id_index		id_index;
+	struct perf_record_auxtrace_info	auxtrace_info;
+	struct perf_record_auxtrace		auxtrace;
+	struct perf_record_auxtrace_error	auxtrace_error;
+	struct perf_record_aux			aux;
+	struct perf_record_itrace_start		itrace_start;
+	struct perf_record_switch		context_switch;
+	struct perf_record_thread_map		thread_map;
+	struct perf_record_cpu_map		cpu_map;
+	struct perf_record_stat_config		stat_config;
+	struct perf_record_stat			stat;
+	struct perf_record_stat_round		stat_round;
+	struct perf_record_time_conv		time_conv;
+	struct perf_record_header_feature	feat;
+	struct perf_record_compressed		pack;
 };
 
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index b71fe09a8087..39493de50117 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -15,9 +15,9 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 			 struct perf_sample *sample __maybe_unused,
 			 struct machine *machine __maybe_unused)
 {
-	struct cpu_map_event *map_event = &event->cpu_map;
-	struct cpu_map_mask *mask;
-	struct cpu_map_data *data;
+	struct perf_record_cpu_map *map_event = &event->cpu_map;
+	struct perf_record_record_cpu_map *mask;
+	struct perf_record_cpu_map_data *data;
 	struct perf_cpu_map *map;
 	int i;
 
@@ -25,7 +25,7 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 
 	TEST_ASSERT_VAL("wrong type", data->type == PERF_CPU_MAP__MASK);
 
-	mask = (struct cpu_map_mask *)data->data;
+	mask = (struct perf_record_record_cpu_map *)data->data;
 
 	TEST_ASSERT_VAL("wrong nr",   mask->nr == 1);
 
@@ -49,9 +49,9 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 			 struct perf_sample *sample __maybe_unused,
 			 struct machine *machine __maybe_unused)
 {
-	struct cpu_map_event *map_event = &event->cpu_map;
+	struct perf_record_cpu_map *map_event = &event->cpu_map;
 	struct cpu_map_entries *cpus;
-	struct cpu_map_data *data;
+	struct perf_record_cpu_map_data *data;
 	struct perf_cpu_map *map;
 
 	data = &map_event->data;
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index c37ff49c07c7..fc04c0f7145b 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -12,7 +12,7 @@ static int process_event_unit(struct perf_tool *tool __maybe_unused,
 			      struct perf_sample *sample __maybe_unused,
 			      struct machine *machine __maybe_unused)
 {
-	struct event_update_event *ev = (struct event_update_event *) event;
+	struct perf_record_event_update *ev = (struct perf_record_event_update *) event;
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong id", ev->type == PERF_EVENT_UPDATE__UNIT);
@@ -25,10 +25,10 @@ static int process_event_scale(struct perf_tool *tool __maybe_unused,
 			       struct perf_sample *sample __maybe_unused,
 			       struct machine *machine __maybe_unused)
 {
-	struct event_update_event *ev = (struct event_update_event *) event;
-	struct event_update_event_scale *ev_data;
+	struct perf_record_event_update *ev = (struct perf_record_event_update *) event;
+	struct perf_record_event_update_scale *ev_data;
 
-	ev_data = (struct event_update_event_scale *) ev->data;
+	ev_data = (struct perf_record_event_update_scale *) ev->data;
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong id", ev->type == PERF_EVENT_UPDATE__SCALE);
@@ -47,7 +47,7 @@ static int process_event_name(struct perf_tool *tool,
 			      struct machine *machine __maybe_unused)
 {
 	struct event_name *tmp = container_of(tool, struct event_name, tool);
-	struct event_update_event *ev = (struct event_update_event*) event;
+	struct perf_record_event_update *ev = (struct perf_record_event_update *) event;
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong id", ev->type == PERF_EVENT_UPDATE__NAME);
@@ -60,11 +60,11 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 			      struct perf_sample *sample __maybe_unused,
 			      struct machine *machine __maybe_unused)
 {
-	struct event_update_event *ev = (struct event_update_event*) event;
-	struct event_update_event_cpus *ev_data;
+	struct perf_record_event_update *ev = (struct perf_record_event_update *) event;
+	struct perf_record_event_update_cpus *ev_data;
 	struct perf_cpu_map *map;
 
-	ev_data = (struct event_update_event_cpus*) ev->data;
+	ev_data = (struct perf_record_event_update_cpus *) ev->data;
 
 	map = cpu_map__new_data(&ev_data->cpus);
 
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index 94250024684a..cc10b4116c9f 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -6,7 +6,7 @@
 #include "counts.h"
 #include "debug.h"
 
-static bool has_term(struct stat_config_event *config,
+static bool has_term(struct perf_record_stat_config *config,
 		     u64 tag, u64 val)
 {
 	unsigned i;
@@ -25,7 +25,7 @@ static int process_stat_config_event(struct perf_tool *tool __maybe_unused,
 				     struct perf_sample *sample __maybe_unused,
 				     struct machine *machine __maybe_unused)
 {
-	struct stat_config_event *config = &event->stat_config;
+	struct perf_record_stat_config *config = &event->stat_config;
 	struct perf_stat_config stat_config;
 
 #define HAS(term, val) \
@@ -65,7 +65,7 @@ static int process_stat_event(struct perf_tool *tool __maybe_unused,
 			      struct perf_sample *sample __maybe_unused,
 			      struct machine *machine __maybe_unused)
 {
-	struct stat_event *st = &event->stat;
+	struct perf_record_stat *st = &event->stat;
 
 	TEST_ASSERT_VAL("wrong cpu",    st->cpu    == 1);
 	TEST_ASSERT_VAL("wrong thread", st->thread == 2);
@@ -95,7 +95,7 @@ static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
 				    struct perf_sample *sample __maybe_unused,
 				    struct machine *machine __maybe_unused)
 {
-	struct stat_round_event *stat_round = &event->stat_round;
+	struct perf_record_stat_round *stat_round = &event->stat_round;
 
 	TEST_ASSERT_VAL("wrong time", stat_round->time == 0xdeadbeef);
 	TEST_ASSERT_VAL("wrong type", stat_round->type == PERF_STAT_ROUND_TYPE__INTERVAL);
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index d803eafedc60..c19ec8849e77 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -56,7 +56,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
 			 struct perf_sample *sample __maybe_unused,
 			 struct machine *machine __maybe_unused)
 {
-	struct thread_map_event *map = &event->thread_map;
+	struct perf_record_thread_map *map = &event->thread_map;
 	struct perf_thread_map *threads;
 
 	TEST_ASSERT_VAL("wrong nr",   map->nr == 1);
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index cd26315bc9aa..d7c3fbb3694f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -192,12 +192,12 @@ static void arm_spe_print_info(__u64 *arr)
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
-	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = sizeof(u64) * ARM_SPE_PMU_TYPE;
 	struct arm_spe *spe;
 	int err;
 
-	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
+	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
 					min_sz)
 		return -EINVAL;
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index cddf04c45a20..c1bf86911e71 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -385,7 +385,7 @@ static int auxtrace_queues__add_indexed_event(struct auxtrace_queues *queues,
 		return err;
 
 	if (event->header.type == PERF_RECORD_AUXTRACE) {
-		if (event->header.size < sizeof(struct auxtrace_event) ||
+		if (event->header.size < sizeof(struct perf_record_auxtrace) ||
 		    event->header.size != sz) {
 			err = -EINVAL;
 			goto out;
@@ -518,7 +518,7 @@ static int auxtrace_not_supported(void)
 
 int auxtrace_record__info_fill(struct auxtrace_record *itr,
 			       struct perf_session *session,
-			       struct auxtrace_info_event *auxtrace_info,
+			       struct perf_record_auxtrace_info *auxtrace_info,
 			       size_t priv_size)
 {
 	if (itr)
@@ -858,13 +858,13 @@ void auxtrace_buffer__free(struct auxtrace_buffer *buffer)
 	free(buffer);
 }
 
-void auxtrace_synth_error(struct auxtrace_error_event *auxtrace_error, int type,
+void auxtrace_synth_error(struct perf_record_auxtrace_error *auxtrace_error, int type,
 			  int code, int cpu, pid_t pid, pid_t tid, u64 ip,
 			  const char *msg, u64 timestamp)
 {
 	size_t size;
 
-	memset(auxtrace_error, 0, sizeof(struct auxtrace_error_event));
+	memset(auxtrace_error, 0, sizeof(struct perf_record_auxtrace_error));
 
 	auxtrace_error->header.type = PERF_RECORD_AUXTRACE_ERROR;
 	auxtrace_error->type = type;
@@ -893,12 +893,12 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 
 	pr_debug2("Synthesizing auxtrace information\n");
 	priv_size = auxtrace_record__info_priv_size(itr, session->evlist);
-	ev = zalloc(sizeof(struct auxtrace_info_event) + priv_size);
+	ev = zalloc(sizeof(struct perf_record_auxtrace_info) + priv_size);
 	if (!ev)
 		return -ENOMEM;
 
 	ev->auxtrace_info.header.type = PERF_RECORD_AUXTRACE_INFO;
-	ev->auxtrace_info.header.size = sizeof(struct auxtrace_info_event) +
+	ev->auxtrace_info.header.size = sizeof(struct perf_record_auxtrace_info) +
 					priv_size;
 	err = auxtrace_record__info_fill(itr, session, &ev->auxtrace_info,
 					 priv_size);
@@ -1168,7 +1168,7 @@ static const char *auxtrace_error_name(int type)
 
 size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 {
-	struct auxtrace_error_event *e = &event->auxtrace_error;
+	struct perf_record_auxtrace_error *e = &event->auxtrace_error;
 	unsigned long long nsecs = e->time;
 	const char *msg = e->msg;
 	int ret;
@@ -1196,7 +1196,7 @@ size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 void perf_session__auxtrace_error_inc(struct perf_session *session,
 				      union perf_event *event)
 {
-	struct auxtrace_error_event *e = &event->auxtrace_error;
+	struct perf_record_auxtrace_error *e = &event->auxtrace_error;
 
 	if (e->type < PERF_AUXTRACE_ERROR_MAX)
 		session->evlist->stats.nr_auxtrace_errors[e->type] += 1;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8e637ac3918e..b213e6431d88 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -28,7 +28,7 @@ struct perf_tool;
 struct perf_mmap;
 struct option;
 struct record_opts;
-struct auxtrace_info_event;
+struct perf_record_auxtrace_info;
 struct events_stats;
 
 /* Auxtrace records must have the same alignment as perf event records */
@@ -318,7 +318,7 @@ struct auxtrace_record {
 				 struct evlist *evlist);
 	int (*info_fill)(struct auxtrace_record *itr,
 			 struct perf_session *session,
-			 struct auxtrace_info_event *auxtrace_info,
+			 struct perf_record_auxtrace_info *auxtrace_info,
 			 size_t priv_size);
 	void (*free)(struct auxtrace_record *itr);
 	int (*snapshot_start)(struct auxtrace_record *itr);
@@ -498,7 +498,7 @@ size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
 				       struct evlist *evlist);
 int auxtrace_record__info_fill(struct auxtrace_record *itr,
 			       struct perf_session *session,
-			       struct auxtrace_info_event *auxtrace_info,
+			       struct perf_record_auxtrace_info *auxtrace_info,
 			       size_t priv_size);
 void auxtrace_record__free(struct auxtrace_record *itr);
 int auxtrace_record__snapshot_start(struct auxtrace_record *itr);
@@ -515,7 +515,7 @@ int auxtrace_index__process(int fd, u64 size, struct perf_session *session,
 			    bool needs_swap);
 void auxtrace_index__free(struct list_head *head);
 
-void auxtrace_synth_error(struct auxtrace_error_event *auxtrace_error, int type,
+void auxtrace_synth_error(struct perf_record_auxtrace_error *auxtrace_error, int type,
 			  int code, int cpu, pid_t pid, pid_t tid, u64 ip,
 			  const char *msg, u64 timestamp);
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index b98754863de9..4c96a33b09ff 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -295,7 +295,7 @@ static int write_buildid(const char *name, size_t name_len, u8 *build_id,
 			 pid_t pid, u16 misc, struct feat_fd *fd)
 {
 	int err;
-	struct build_id_event b;
+	struct perf_record_header_build_id b;
 	size_t len;
 
 	len = name_len + 1;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index f5c21184e1fc..b9301e7e9c76 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -43,7 +43,7 @@ static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 	return map;
 }
 
-static struct perf_cpu_map *cpu_map__from_mask(struct cpu_map_mask *mask)
+static struct perf_cpu_map *cpu_map__from_mask(struct perf_record_record_cpu_map *mask)
 {
 	struct perf_cpu_map *map;
 	int nr, nbits = mask->nr * mask->long_size * BITS_PER_BYTE;
@@ -61,12 +61,12 @@ static struct perf_cpu_map *cpu_map__from_mask(struct cpu_map_mask *mask)
 
 }
 
-struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data)
+struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data)
 {
 	if (data->type == PERF_CPU_MAP__CPUS)
 		return cpu_map__from_entries((struct cpu_map_entries *)data->data);
 	else
-		return cpu_map__from_mask((struct cpu_map_mask *)data->data);
+		return cpu_map__from_mask((struct perf_record_record_cpu_map *)data->data);
 }
 
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c2519e7ea958..2553bef1279d 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,10 +7,10 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
-struct cpu_map_data;
+struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
+struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b3a5daaf1a8f..c84da56f5f7d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2393,7 +2393,7 @@ static void cs_etm__print_auxtrace_info(u64 *val, int num)
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
-	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
 	struct int_node *inode;
 	unsigned int pmu_type;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2369333d61d8..742fba062746 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -991,7 +991,7 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 	event->thread_map.nr = threads->nr;
 
 	for (i = 0; i < threads->nr; i++) {
-		struct thread_map_event_entry *entry = &event->thread_map.entries[i];
+		struct perf_record_thread_map_entry *entry = &event->thread_map.entries[i];
 		char *comm = perf_thread_map__comm(threads, i);
 
 		if (!comm)
@@ -1018,7 +1018,7 @@ static void synthesize_cpus(struct cpu_map_entries *cpus,
 		cpus->cpu[i] = map->map[i];
 }
 
-static void synthesize_mask(struct cpu_map_mask *mask,
+static void synthesize_mask(struct perf_record_record_cpu_map *mask,
 			    struct perf_cpu_map *map, int max)
 {
 	int i;
@@ -1049,7 +1049,7 @@ static size_t mask_size(struct perf_cpu_map *map, int *max)
 			*max = bit;
 	}
 
-	return sizeof(struct cpu_map_mask) + BITS_TO_LONGS(*max) * sizeof(long);
+	return sizeof(struct perf_record_record_cpu_map) + BITS_TO_LONGS(*max) * sizeof(long);
 }
 
 void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max)
@@ -1060,15 +1060,15 @@ void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int
 	/*
 	 * Both array and mask data have variable size based
 	 * on the number of cpus and their actual values.
-	 * The size of the 'struct cpu_map_data' is:
+	 * The size of the 'struct perf_record_cpu_map_data' is:
 	 *
 	 *   array = size of 'struct cpu_map_entries' +
 	 *           number of cpus * sizeof(u64)
 	 *
-	 *   mask  = size of 'struct cpu_map_mask' +
+	 *   mask  = size of 'struct perf_record_record_cpu_map' +
 	 *           maximum cpu bit converted to size of longs
 	 *
-	 * and finaly + the size of 'struct cpu_map_data'.
+	 * and finaly + the size of 'struct perf_record_cpu_map_data'.
 	 */
 	size_cpus = cpus_size(map);
 	size_mask = mask_size(map, max);
@@ -1081,12 +1081,12 @@ void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int
 		*type  = PERF_CPU_MAP__MASK;
 	}
 
-	*size += sizeof(struct cpu_map_data);
+	*size += sizeof(struct perf_record_cpu_map_data);
 	*size = PERF_ALIGN(*size, sizeof(u64));
 	return zalloc(*size);
 }
 
-void cpu_map_data__synthesize(struct cpu_map_data *data, struct perf_cpu_map *map,
+void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf_cpu_map *map,
 			      u16 type, int max)
 {
 	data->type = type;
@@ -1096,16 +1096,16 @@ void cpu_map_data__synthesize(struct cpu_map_data *data, struct perf_cpu_map *ma
 		synthesize_cpus((struct cpu_map_entries *) data->data, map);
 		break;
 	case PERF_CPU_MAP__MASK:
-		synthesize_mask((struct cpu_map_mask *) data->data, map, max);
+		synthesize_mask((struct perf_record_record_cpu_map *) data->data, map, max);
 	default:
 		break;
 	};
 }
 
-static struct cpu_map_event* cpu_map_event__new(struct perf_cpu_map *map)
+static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
 {
-	size_t size = sizeof(struct cpu_map_event);
-	struct cpu_map_event *event;
+	size_t size = sizeof(struct perf_record_cpu_map);
+	struct perf_record_cpu_map *event;
 	int max;
 	u16 type;
 
@@ -1126,7 +1126,7 @@ int perf_event__synthesize_cpu_map(struct perf_tool *tool,
 				   perf_event__handler_t process,
 				   struct machine *machine)
 {
-	struct cpu_map_event *event;
+	struct perf_record_cpu_map *event;
 	int err;
 
 	event = cpu_map_event__new(map);
@@ -1144,7 +1144,7 @@ int perf_event__synthesize_stat_config(struct perf_tool *tool,
 				       perf_event__handler_t process,
 				       struct machine *machine)
 {
-	struct stat_config_event *event;
+	struct perf_record_stat_config *event;
 	int size, i = 0, err;
 
 	size  = sizeof(*event);
@@ -1183,7 +1183,7 @@ int perf_event__synthesize_stat(struct perf_tool *tool,
 				perf_event__handler_t process,
 				struct machine *machine)
 {
-	struct stat_event event;
+	struct perf_record_stat event;
 
 	event.header.type = PERF_RECORD_STAT;
 	event.header.size = sizeof(event);
@@ -1204,7 +1204,7 @@ int perf_event__synthesize_stat_round(struct perf_tool *tool,
 				      perf_event__handler_t process,
 				      struct machine *machine)
 {
-	struct stat_round_event event;
+	struct perf_record_stat_round event;
 
 	event.header.type = PERF_RECORD_STAT_ROUND;
 	event.header.size = sizeof(event);
@@ -1217,7 +1217,7 @@ int perf_event__synthesize_stat_round(struct perf_tool *tool,
 }
 
 void perf_event__read_stat_config(struct perf_stat_config *config,
-				  struct stat_config_event *event)
+				  struct perf_record_stat_config *event)
 {
 	unsigned i;
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index e15eed53ce90..a7341e14eb48 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -374,7 +374,7 @@ int perf_event__synthesize_stat_config(struct perf_tool *tool,
 				       perf_event__handler_t process,
 				       struct machine *machine);
 void perf_event__read_stat_config(struct perf_stat_config *config,
-				  struct stat_config_event *event);
+				  struct perf_record_stat_config *event);
 int perf_event__synthesize_stat(struct perf_tool *tool,
 				u32 cpu, u32 thread, u64 id,
 				struct perf_counts_values *count,
@@ -511,7 +511,7 @@ int kallsyms__get_function_start(const char *kallsyms_filename,
 				 const char *symbol_name, u64 *addr);
 
 void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max);
-void  cpu_map_data__synthesize(struct cpu_map_data *data, struct perf_cpu_map *map,
+void  cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf_cpu_map *map,
 			       u16 type, int max);
 
 void event_attr_init(struct perf_event_attr *attr);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index cc4998fcf4ee..990f23ad46f3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1877,7 +1877,7 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
 	}
 }
 
-static int __event_process_build_id(struct build_id_event *bev,
+static int __event_process_build_id(struct perf_record_header_build_id *bev,
 				    char *filename,
 				    struct perf_session *session)
 {
@@ -1946,7 +1946,7 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
 		u8			   build_id[PERF_ALIGN(BUILD_ID_SIZE, sizeof(u64))];
 		char			   filename[0];
 	} old_bev;
-	struct build_id_event bev;
+	struct perf_record_header_build_id bev;
 	char filename[PATH_MAX];
 	u64 limit = offset + size;
 
@@ -1987,7 +1987,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
 				       int input, u64 offset, u64 size)
 {
 	struct perf_session *session = container_of(header, struct perf_session, header);
-	struct build_id_event bev;
+	struct perf_record_header_build_id bev;
 	char filename[PATH_MAX];
 	u64 limit = offset + size, orig_offset = offset;
 	int err = -1;
@@ -2009,7 +2009,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
 		 *
 		 * "perf: 'perf kvm' tool for monitoring guest performance from host"
 		 *
-		 * Added a field to struct build_id_event that broke the file
+		 * Added a field to struct perf_record_header_build_id that broke the file
 		 * format.
 		 *
 		 * Since the kernel build-id is the first entry, process the
@@ -3677,7 +3677,7 @@ int perf_event__synthesize_features(struct perf_tool *tool,
 {
 	struct perf_header *header = &session->header;
 	struct feat_fd ff;
-	struct feature_event *fe;
+	struct perf_record_header_feature *fe;
 	size_t sz, sz_hdr;
 	int feat, ret;
 
@@ -3740,7 +3740,7 @@ int perf_event__process_feature(struct perf_session *session,
 {
 	struct perf_tool *tool = session->tool;
 	struct feat_fd ff = { .fd = 0 };
-	struct feature_event *fe = (struct feature_event *)event;
+	struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
 	int type = fe->header.type;
 	u64 feat = fe->feat_id;
 
@@ -3777,10 +3777,10 @@ int perf_event__process_feature(struct perf_session *session,
 	return 0;
 }
 
-static struct event_update_event *
+static struct perf_record_event_update *
 event_update_event__new(size_t size, u64 type, u64 id)
 {
-	struct event_update_event *ev;
+	struct perf_record_event_update *ev;
 
 	size += sizeof(*ev);
 	size  = PERF_ALIGN(size, sizeof(u64));
@@ -3800,7 +3800,7 @@ perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 					 struct evsel *evsel,
 					 perf_event__handler_t process)
 {
-	struct event_update_event *ev;
+	struct perf_record_event_update *ev;
 	size_t size = strlen(evsel->unit);
 	int err;
 
@@ -3819,15 +3819,15 @@ perf_event__synthesize_event_update_scale(struct perf_tool *tool,
 					  struct evsel *evsel,
 					  perf_event__handler_t process)
 {
-	struct event_update_event *ev;
-	struct event_update_event_scale *ev_data;
+	struct perf_record_event_update *ev;
+	struct perf_record_event_update_scale *ev_data;
 	int err;
 
 	ev = event_update_event__new(sizeof(*ev_data), PERF_EVENT_UPDATE__SCALE, evsel->id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
-	ev_data = (struct event_update_event_scale *) ev->data;
+	ev_data = (struct perf_record_event_update_scale *) ev->data;
 	ev_data->scale = evsel->scale;
 	err = process(tool, (union perf_event*) ev, NULL, NULL);
 	free(ev);
@@ -3839,7 +3839,7 @@ perf_event__synthesize_event_update_name(struct perf_tool *tool,
 					 struct evsel *evsel,
 					 perf_event__handler_t process)
 {
-	struct event_update_event *ev;
+	struct perf_record_event_update *ev;
 	size_t len = strlen(evsel->name);
 	int err;
 
@@ -3858,8 +3858,8 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 					struct evsel *evsel,
 					perf_event__handler_t process)
 {
-	size_t size = sizeof(struct event_update_event);
-	struct event_update_event *ev;
+	size_t size = sizeof(struct perf_record_event_update);
+	struct perf_record_event_update *ev;
 	int max, err;
 	u16 type;
 
@@ -3875,7 +3875,7 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	ev->type = PERF_EVENT_UPDATE__CPUS;
 	ev->id   = evsel->id[0];
 
-	cpu_map_data__synthesize((struct cpu_map_data *) ev->data,
+	cpu_map_data__synthesize((struct perf_record_cpu_map_data *) ev->data,
 				 evsel->core.own_cpus,
 				 type, max);
 
@@ -3886,9 +3886,9 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 {
-	struct event_update_event *ev = &event->event_update;
-	struct event_update_event_scale *ev_scale;
-	struct event_update_event_cpus *ev_cpus;
+	struct perf_record_event_update *ev = &event->event_update;
+	struct perf_record_event_update_scale *ev_scale;
+	struct perf_record_event_update_cpus *ev_cpus;
 	struct perf_cpu_map *map;
 	size_t ret;
 
@@ -3896,7 +3896,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__SCALE:
-		ev_scale = (struct event_update_event_scale *) ev->data;
+		ev_scale = (struct perf_record_event_update_scale *) ev->data;
 		ret += fprintf(fp, "... scale: %f\n", ev_scale->scale);
 		break;
 	case PERF_EVENT_UPDATE__UNIT:
@@ -3906,7 +3906,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 		ret += fprintf(fp, "... name:  %s\n", ev->data);
 		break;
 	case PERF_EVENT_UPDATE__CPUS:
-		ev_cpus = (struct event_update_event_cpus *) ev->data;
+		ev_cpus = (struct perf_record_event_update_cpus *) ev->data;
 		ret += fprintf(fp, "... ");
 
 		map = cpu_map__new_data(&ev_cpus->cpus);
@@ -4052,9 +4052,9 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 				     union perf_event *event,
 				     struct evlist **pevlist)
 {
-	struct event_update_event *ev = &event->event_update;
-	struct event_update_event_scale *ev_scale;
-	struct event_update_event_cpus *ev_cpus;
+	struct perf_record_event_update *ev = &event->event_update;
+	struct perf_record_event_update_scale *ev_scale;
+	struct perf_record_event_update_cpus *ev_cpus;
 	struct evlist *evlist;
 	struct evsel *evsel;
 	struct perf_cpu_map *map;
@@ -4076,11 +4076,11 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 		evsel->name = strdup(ev->data);
 		break;
 	case PERF_EVENT_UPDATE__SCALE:
-		ev_scale = (struct event_update_event_scale *) ev->data;
+		ev_scale = (struct perf_record_event_update_scale *) ev->data;
 		evsel->scale = ev_scale->scale;
 		break;
 	case PERF_EVENT_UPDATE__CPUS:
-		ev_cpus = (struct event_update_event_cpus *) ev->data;
+		ev_cpus = (struct perf_record_event_update_cpus *) ev->data;
 
 		map = cpu_map__new_data(&ev_cpus->cpus);
 		if (map)
@@ -4152,7 +4152,7 @@ int perf_event__process_tracing_data(struct perf_session *session,
 	char buf[BUFSIZ];
 
 	/* setup for reading amidst mmap */
-	lseek(fd, offset + sizeof(struct tracing_data_event),
+	lseek(fd, offset + sizeof(struct perf_record_header_tracing_data),
 	      SEEK_SET);
 
 	size_read = trace_report(fd, &session->tevent,
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 03c581a0d5d0..99dddb63dac1 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -848,12 +848,12 @@ static void intel_bts_print_info(__u64 *arr, int start, int finish)
 int intel_bts_process_auxtrace_info(union perf_event *event,
 				    struct perf_session *session)
 {
-	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = sizeof(u64) * INTEL_BTS_SNAPSHOT_MODE;
 	struct intel_bts *bts;
 	int err;
 
-	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
+	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
 					min_sz)
 		return -EINVAL;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index c83a9a718c03..825a6a3b03a1 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3063,23 +3063,23 @@ static void intel_pt_print_info_str(const char *name, const char *str)
 	fprintf(stdout, "  %-20s%s\n", name, str ? str : "");
 }
 
-static bool intel_pt_has(struct auxtrace_info_event *auxtrace_info, int pos)
+static bool intel_pt_has(struct perf_record_auxtrace_info *auxtrace_info, int pos)
 {
 	return auxtrace_info->header.size >=
-		sizeof(struct auxtrace_info_event) + (sizeof(u64) * (pos + 1));
+		sizeof(struct perf_record_auxtrace_info) + (sizeof(u64) * (pos + 1));
 }
 
 int intel_pt_process_auxtrace_info(union perf_event *event,
 				   struct perf_session *session)
 {
-	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = sizeof(u64) * INTEL_PT_PER_CPU_MMAPS;
 	struct intel_pt *pt;
 	void *info_end;
 	__u64 *info;
 	int err;
 
-	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
+	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
 					min_sz)
 		return -EINVAL;
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 59974e901232..11479a7ad1c7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -431,8 +431,8 @@ static char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch ev
 static PyMemberDef pyrf_context_switch_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(context_switch_event, next_prev_pid, T_UINT, "next/prev pid"),
-	member_def(context_switch_event, next_prev_tid, T_UINT, "next/prev tid"),
+	member_def(perf_record_switch, next_prev_pid, T_UINT, "next/prev pid"),
+	member_def(perf_record_switch, next_prev_tid, T_UINT, "next/prev tid"),
 	{ .name = NULL, },
 };
 
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index d078ae8353c8..4f6c1465998f 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1109,11 +1109,11 @@ static int s390_cpumsf__config(const char *var, const char *value, void *cb)
 int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 				      struct perf_session *session)
 {
-	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct s390_cpumsf *sf;
 	int err;
 
-	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event))
+	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info))
 		return -EINVAL;
 
 	sf = zalloc(sizeof(struct s390_cpumsf));
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index daa8aed27eae..cb584a87dc6e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -63,8 +63,8 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 		decomp->size = decomp_last_rem;
 	}
 
-	src = (void *)event + sizeof(struct compressed_event);
-	src_size = event->pack.header.size - sizeof(struct compressed_event);
+	src = (void *)event + sizeof(struct perf_record_compressed);
+	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
 
 	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
@@ -835,9 +835,9 @@ static void perf_event__thread_map_swap(union perf_event *event,
 static void perf_event__cpu_map_swap(union perf_event *event,
 				     bool sample_id_all __maybe_unused)
 {
-	struct cpu_map_data *data = &event->cpu_map.data;
+	struct perf_record_cpu_map_data *data = &event->cpu_map.data;
 	struct cpu_map_entries *cpus;
-	struct cpu_map_mask *mask;
+	struct perf_record_record_cpu_map *mask;
 	unsigned i;
 
 	data->type = bswap_64(data->type);
@@ -852,7 +852,7 @@ static void perf_event__cpu_map_swap(union perf_event *event,
 			cpus->cpu[i] = bswap_16(cpus->cpu[i]);
 		break;
 	case PERF_CPU_MAP__MASK:
-		mask = (struct cpu_map_mask *) data->data;
+		mask = (struct perf_record_record_cpu_map *) data->data;
 
 		mask->nr = bswap_16(mask->nr);
 		mask->long_size = bswap_16(mask->long_size);
@@ -2375,10 +2375,10 @@ int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event)
 {
 	struct evlist *evlist = session->evlist;
-	struct id_index_event *ie = &event->id_index;
+	struct perf_record_id_index *ie = &event->id_index;
 	size_t i, nr, max_nr;
 
-	max_nr = (ie->header.size - sizeof(struct id_index_event)) /
+	max_nr = (ie->header.size - sizeof(struct perf_record_id_index)) /
 		 sizeof(struct id_index_entry);
 	nr = ie->nr;
 	if (nr > max_nr)
@@ -2420,14 +2420,14 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 
 	pr_debug2("Synthesizing id index\n");
 
-	max_nr = (UINT16_MAX - sizeof(struct id_index_event)) /
+	max_nr = (UINT16_MAX - sizeof(struct perf_record_id_index)) /
 		 sizeof(struct id_index_entry);
 
 	evlist__for_each_entry(evlist, evsel)
 		nr += evsel->ids;
 
 	n = nr > max_nr ? max_nr : nr;
-	sz = sizeof(struct id_index_event) + n * sizeof(struct id_index_entry);
+	sz = sizeof(struct perf_record_id_index) + n * sizeof(struct id_index_entry);
 	ev = zalloc(sz);
 	if (!ev)
 		return -ENOMEM;
@@ -2467,7 +2467,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 		}
 	}
 
-	sz = sizeof(struct id_index_event) + nr * sizeof(struct id_index_entry);
+	sz = sizeof(struct perf_record_id_index) + nr * sizeof(struct id_index_entry);
 	ev->id_index.header.size = sz;
 	ev->id_index.nr = nr;
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 79e97d17ea04..b7aa076ab6fd 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -28,7 +28,7 @@ struct perf_session {
 	struct itrace_synth_opts *itrace_synth_opts;
 	struct list_head	auxtrace_index;
 	struct trace_event	tevent;
-	struct time_conv_event	time_conv;
+	struct perf_record_time_conv	time_conv;
 	bool			repipe;
 	bool			one_mmap;
 	void			*one_mmap_addr;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4c7957496e7c..018c6d3ee01b 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -382,7 +382,7 @@ int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
 	struct perf_counts_values count;
-	struct stat_event *st = &event->stat;
+	struct perf_record_stat *st = &event->stat;
 	struct evsel *counter;
 
 	count.val = st->val;
@@ -402,7 +402,7 @@ int perf_event__process_stat_event(struct perf_session *session,
 
 size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp)
 {
-	struct stat_event *st = (struct stat_event *) event;
+	struct perf_record_stat *st = (struct perf_record_stat *) event;
 	size_t ret;
 
 	ret  = fprintf(fp, "\n... id %" PRI_lu64 ", cpu %d, thread %d\n",
@@ -415,7 +415,7 @@ size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp)
 {
-	struct stat_round_event *rd = (struct stat_round_event *)event;
+	struct perf_record_stat_round *rd = (struct perf_record_stat_round *)event;
 	size_t ret;
 
 	ret = fprintf(fp, "\n... time %" PRI_lu64 ", type %s\n", rd->time,
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 3e64525bf604..c9bfe4696943 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -369,7 +369,7 @@ void thread_map__read_comms(struct perf_thread_map *threads)
 }
 
 static void thread_map__copy_event(struct perf_thread_map *threads,
-				   struct thread_map_event *event)
+				   struct perf_record_thread_map *event)
 {
 	unsigned i;
 
@@ -383,7 +383,7 @@ static void thread_map__copy_event(struct perf_thread_map *threads,
 	refcount_set(&threads->refcnt, 1);
 }
 
-struct perf_thread_map *thread_map__new_event(struct thread_map_event *event)
+struct perf_thread_map *thread_map__new_event(struct perf_record_thread_map *event)
 {
 	struct perf_thread_map *threads;
 
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index ca165fdf6cb0..3bb860a32b8e 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -8,7 +8,7 @@
 #include <internal/threadmap.h>
 #include <perf/threadmap.h>
 
-struct thread_map_event;
+struct perf_record_thread_map;
 
 struct perf_thread_map *thread_map__new_dummy(void);
 struct perf_thread_map *thread_map__new_by_pid(pid_t pid);
@@ -16,7 +16,7 @@ struct perf_thread_map *thread_map__new_by_tid(pid_t tid);
 struct perf_thread_map *thread_map__new_by_uid(uid_t uid);
 struct perf_thread_map *thread_map__new_all_cpus(void);
 struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid);
-struct perf_thread_map *thread_map__new_event(struct thread_map_event *event);
+struct perf_thread_map *thread_map__new_event(struct perf_record_thread_map *event);
 
 struct perf_thread_map *thread_map__new_str(const char *pid,
 		const char *tid, uid_t uid, bool all_threads);
-- 
2.21.0

