Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B14C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5CD20679
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869916;
	bh=XeXVM1/0bExmXFKPeaSb+mJ859KT/U2LEIZ2cV1dS5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pu2Xl+ykRYyPOej1b7QeiGaK9RUo3u+JiAhr63cD2Q8v+8H0sXIT3FoeHz9crZCEx
	 YRkPD+CFzE2U6oR9NIgy0duZ9E9vLVkfgdlZKKPj39TqqARhZPraLPTfvw9AGUMzGb
	 lxUnzWuwNBvhSuN24gtMk8UBATMgs4cvlyvsdxVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfH0Bif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbfH0BiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6FBD21848;
        Tue, 27 Aug 2019 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869890;
        bh=XeXVM1/0bExmXFKPeaSb+mJ859KT/U2LEIZ2cV1dS5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hiwehf6PhWTEYSLmeKNYQEjiwj8Ix+p/2mn1bp7+j0ud1vj0hkvOcve2qVbgeE07B
         yhbfgGLxhNOH2G3e/g3PLZpsWg8KmrmpZS9VZKPRpWpKuk0dZr0R1s9r52RNeakqW5
         c+5quwM0SrenCpcFwVs5za83f5DFUlqUmuyHiPYU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 29/33] libperf: Rename the PERF_RECORD_ structs to have a "perf" suffix
Date:   Mon, 26 Aug 2019 22:36:30 -0300
Message-Id: <20190827013634.3173-30-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Even more, to have a "perf_record_" prefix, so that they match the
PERF_RECORD_ enum they map to.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qbabmcz2a0pkzt72liyuz3p8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h       | 24 ++++++-------
 tools/perf/tests/parse-no-sample-id-all.c |  4 +--
 tools/perf/util/bpf-event.c               | 12 +++----
 tools/perf/util/event.h                   | 30 ++++++++--------
 tools/perf/util/evsel.c                   |  4 +--
 tools/perf/util/evsel.h                   |  2 +-
 tools/perf/util/intel-bts.c               |  2 +-
 tools/perf/util/namespaces.c              |  2 +-
 tools/perf/util/namespaces.h              |  4 +--
 tools/perf/util/python.c                  | 44 +++++++++++------------
 tools/perf/util/session.c                 |  2 +-
 tools/perf/util/thread.c                  |  4 +--
 tools/perf/util/thread.h                  |  4 +--
 13 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index e768a2dfbe53..36ad3a4a79e6 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -7,7 +7,7 @@
 #include <linux/limits.h>
 #include <linux/bpf.h>
 
-struct mmap_event {
+struct perf_record_mmap {
 	struct perf_event_header header;
 	__u32			 pid, tid;
 	__u64			 start;
@@ -16,7 +16,7 @@ struct mmap_event {
 	char			 filename[PATH_MAX];
 };
 
-struct mmap2_event {
+struct perf_record_mmap2 {
 	struct perf_event_header header;
 	__u32			 pid, tid;
 	__u64			 start;
@@ -31,33 +31,33 @@ struct mmap2_event {
 	char			 filename[PATH_MAX];
 };
 
-struct comm_event {
+struct perf_record_comm {
 	struct perf_event_header header;
 	__u32			 pid, tid;
 	char			 comm[16];
 };
 
-struct namespaces_event {
+struct perf_record_namespaces {
 	struct perf_event_header header;
 	__u32			 pid, tid;
 	__u64			 nr_namespaces;
 	struct perf_ns_link_info link_info[];
 };
 
-struct fork_event {
+struct perf_record_fork {
 	struct perf_event_header header;
 	__u32			 pid, ppid;
 	__u32			 tid, ptid;
 	__u64			 time;
 };
 
-struct lost_event {
+struct perf_record_lost {
 	struct perf_event_header header;
 	__u64			 id;
 	__u64			 lost;
 };
 
-struct lost_samples_event {
+struct perf_record_lost_samples {
 	struct perf_event_header header;
 	__u64			 lost;
 };
@@ -65,7 +65,7 @@ struct lost_samples_event {
 /*
  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
  */
-struct read_event {
+struct perf_record_read {
 	struct perf_event_header header;
 	__u32			 pid, tid;
 	__u64			 value;
@@ -74,7 +74,7 @@ struct read_event {
 	__u64			 id;
 };
 
-struct throttle_event {
+struct perf_record_throttle {
 	struct perf_event_header header;
 	__u64			 time;
 	__u64			 id;
@@ -85,7 +85,7 @@ struct throttle_event {
 #define KSYM_NAME_LEN 256
 #endif
 
-struct ksymbol_event {
+struct perf_record_ksymbol {
 	struct perf_event_header header;
 	__u64			 addr;
 	__u32			 len;
@@ -94,7 +94,7 @@ struct ksymbol_event {
 	char			 name[KSYM_NAME_LEN];
 };
 
-struct bpf_event {
+struct perf_record_bpf_event {
 	struct perf_event_header header;
 	__u16			 type;
 	__u16			 flags;
@@ -104,7 +104,7 @@ struct bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
-struct sample_event {
+struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
 };
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 396e40d68922..8284752a60c8 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -87,10 +87,10 @@ int test__parse_no_sample_id_all(struct test *test __maybe_unused, int subtest _
 		},
 		.id = 2,
 	};
-	struct mmap_event event3 = {
+	struct perf_record_mmap event3 = {
 		.header = {
 			.type = PERF_RECORD_MMAP,
-			.size = sizeof(struct mmap_event),
+			.size = sizeof(struct perf_record_mmap),
 		},
 	};
 	union perf_event *events[] = {
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 5c634bcfea7e..3be8c480fa1f 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -161,8 +161,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       union perf_event *event,
 					       struct record_opts *opts)
 {
-	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
-	struct bpf_event *bpf_event = &event->bpf_event;
+	struct perf_record_ksymbol *ksymbol_event = &event->ksymbol_event;
+	struct perf_record_bpf_event *bpf_event = &event->bpf_event;
 	struct bpf_prog_info_linear *info_linear;
 	struct perf_tool *tool = session->tool;
 	struct bpf_prog_info_node *info_node;
@@ -230,10 +230,10 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
 		int name_len;
 
-		*ksymbol_event = (struct ksymbol_event){
+		*ksymbol_event = (struct perf_record_ksymbol) {
 			.header = {
 				.type = PERF_RECORD_KSYMBOL,
-				.size = offsetof(struct ksymbol_event, name),
+				.size = offsetof(struct perf_record_ksymbol, name),
 			},
 			.addr = prog_addrs[i],
 			.len = prog_lens[i],
@@ -254,10 +254,10 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 
 	if (!opts->no_bpf_event) {
 		/* Synthesize PERF_RECORD_BPF_EVENT */
-		*bpf_event = (struct bpf_event){
+		*bpf_event = (struct perf_record_bpf_event) {
 			.header = {
 				.type = PERF_RECORD_BPF_EVENT,
-				.size = sizeof(struct bpf_event),
+				.size = sizeof(struct perf_record_bpf_event),
 			},
 			.type = PERF_BPF_EVENT_PROG_LOAD,
 			.flags = 0,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index dee0ee57efc2..25f5309a3442 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -305,18 +305,18 @@ static inline void *perf_synth__raw_data(void *p)
  * when possible sends this number in a PERF_RECORD_LOST event. The number of
  * such "chunks" of lost events is stored in .nr_events[PERF_EVENT_LOST] while
  * total_lost tells exactly how many events the kernel in fact lost, i.e. it is
- * the sum of all struct lost_event.lost fields reported.
+ * the sum of all struct perf_record_lost.lost fields reported.
  *
  * The kernel discards mixed up samples and sends the number in a
  * PERF_RECORD_LOST_SAMPLES event. The number of lost-samples events is stored
  * in .nr_events[PERF_RECORD_LOST_SAMPLES] while total_lost_samples tells
  * exactly how many samples the kernel in fact dropped, i.e. it is the sum of
- * all struct lost_samples_event.lost fields reported.
+ * all struct perf_record_lost_samples.lost fields reported.
  *
  * The total_period is needed because by default auto-freq is used, so
  * multipling nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
  * the total number of low level events, it is necessary to to sum all struct
- * sample_event.period and stash the result in total_period.
+ * perf_record_sample.period and stash the result in total_period.
  */
 struct events_stats {
 	u64 total_period;
@@ -550,16 +550,18 @@ struct compressed_event {
 
 union perf_event {
 	struct perf_event_header	header;
-	struct mmap_event		mmap;
-	struct mmap2_event		mmap2;
-	struct comm_event		comm;
-	struct namespaces_event		namespaces;
-	struct fork_event		fork;
-	struct lost_event		lost;
-	struct lost_samples_event	lost_samples;
-	struct read_event		read;
-	struct throttle_event		throttle;
-	struct sample_event		sample;
+	struct perf_record_mmap		mmap;
+	struct perf_record_mmap2	mmap2;
+	struct perf_record_comm		comm;
+	struct perf_record_namespaces	namespaces;
+	struct perf_record_fork		fork;
+	struct perf_record_lost		lost;
+	struct perf_record_lost_samples	lost_samples;
+	struct perf_record_read		read;
+	struct perf_record_throttle	throttle;
+	struct perf_record_sample	sample;
+	struct perf_record_bpf_event	bpf_event;
+	struct perf_record_ksymbol	ksymbol_event;
 	struct attr_event		attr;
 	struct event_update_event	event_update;
 	struct event_type_event		event_type;
@@ -579,8 +581,6 @@ union perf_event {
 	struct stat_round_event		stat_round;
 	struct time_conv_event		time_conv;
 	struct feature_event		feat;
-	struct ksymbol_event		ksymbol_event;
-	struct bpf_event		bpf_event;
 	struct compressed_event		pack;
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 778262f68d5c..b3cfe120d097 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -117,7 +117,7 @@ int __perf_evsel__sample_size(u64 sample_type)
  *
  * This function returns the position of the event id (PERF_SAMPLE_ID or
  * PERF_SAMPLE_IDENTIFIER) in a sample event i.e. in the array of struct
- * sample_event.
+ * perf_record_sample.
  */
 static int __perf_evsel__calc_id_pos(u64 sample_type)
 {
@@ -2420,7 +2420,7 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 				     u64 read_format)
 {
-	size_t sz, result = sizeof(struct sample_event);
+	size_t sz, result = sizeof(struct perf_record_sample);
 
 	if (type & PERF_SAMPLE_IDENTIFIER)
 		result += sizeof(u64);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5a351cae66df..77e07f2486d3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -107,7 +107,7 @@ struct xyarray;
  *         show the name used, not some alias.
  * @id_pos: the position of the event id (PERF_SAMPLE_ID or
  *          PERF_SAMPLE_IDENTIFIER) in a sample event i.e. in the array of
- *          struct sample_event
+ *          struct perf_record_sample
  * @is_pos: the position (counting backwards) of the event id (PERF_SAMPLE_ID or
  *          PERF_SAMPLE_IDENTIFIER) in a non-sample event i.e. if sample_id_all
  *          is used there is an id sample appended to non-sample events
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7eb9e6dc27dd..8dc6408206b9 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -818,7 +818,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 		 * We only use sample types from PERF_SAMPLE_MASK so we can use
 		 * __perf_evsel__sample_size() here.
 		 */
-		bts->branches_event_size = sizeof(struct sample_event) +
+		bts->branches_event_size = sizeof(struct perf_record_sample) +
 				__perf_evsel__sample_size(attr.sample_type);
 	}
 
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 46d3a7754897..99be15dd2b6b 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -19,7 +19,7 @@
 #include <asm/bug.h>
 #include <linux/zalloc.h>
 
-struct namespaces *namespaces__new(struct namespaces_event *event)
+struct namespaces *namespaces__new(struct perf_record_namespaces *event)
 {
 	struct namespaces *namespaces;
 	u64 link_info_size = ((event ? event->nr_namespaces : NR_NAMESPACES) *
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 004430c0de93..40edef56cb52 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -17,7 +17,7 @@
 int setns(int fd, int nstype);
 #endif
 
-struct namespaces_event;
+struct perf_record_namespaces;
 
 struct namespaces {
 	struct list_head list;
@@ -25,7 +25,7 @@ struct namespaces {
 	struct perf_ns_link_info link_info[];
 };
 
-struct namespaces *namespaces__new(struct namespaces_event *event);
+struct namespaces *namespaces__new(struct perf_record_namespaces *event);
 void namespaces__free(struct namespaces *namespaces);
 
 struct nsinfo {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d21e270c7823..59974e901232 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -116,12 +116,12 @@ static PyMemberDef pyrf_mmap_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	member_def(perf_event_header, misc, T_UINT, "event misc"),
-	member_def(mmap_event, pid, T_UINT, "event pid"),
-	member_def(mmap_event, tid, T_UINT, "event tid"),
-	member_def(mmap_event, start, T_ULONGLONG, "start of the map"),
-	member_def(mmap_event, len, T_ULONGLONG, "map length"),
-	member_def(mmap_event, pgoff, T_ULONGLONG, "page offset"),
-	member_def(mmap_event, filename, T_STRING_INPLACE, "backing store"),
+	member_def(perf_record_mmap, pid, T_UINT, "event pid"),
+	member_def(perf_record_mmap, tid, T_UINT, "event tid"),
+	member_def(perf_record_mmap, start, T_ULONGLONG, "start of the map"),
+	member_def(perf_record_mmap, len, T_ULONGLONG, "map length"),
+	member_def(perf_record_mmap, pgoff, T_ULONGLONG, "page offset"),
+	member_def(perf_record_mmap, filename, T_STRING_INPLACE, "backing store"),
 	{ .name = NULL, },
 };
 
@@ -159,11 +159,11 @@ static char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event obje
 static PyMemberDef pyrf_task_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(fork_event, pid, T_UINT, "event pid"),
-	member_def(fork_event, ppid, T_UINT, "event ppid"),
-	member_def(fork_event, tid, T_UINT, "event tid"),
-	member_def(fork_event, ptid, T_UINT, "event ptid"),
-	member_def(fork_event, time, T_ULONGLONG, "timestamp"),
+	member_def(perf_record_fork, pid, T_UINT, "event pid"),
+	member_def(perf_record_fork, ppid, T_UINT, "event ppid"),
+	member_def(perf_record_fork, tid, T_UINT, "event tid"),
+	member_def(perf_record_fork, ptid, T_UINT, "event ptid"),
+	member_def(perf_record_fork, time, T_ULONGLONG, "timestamp"),
 	{ .name = NULL, },
 };
 
@@ -194,9 +194,9 @@ static char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
 static PyMemberDef pyrf_comm_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(comm_event, pid, T_UINT, "event pid"),
-	member_def(comm_event, tid, T_UINT, "event tid"),
-	member_def(comm_event, comm, T_STRING_INPLACE, "process name"),
+	member_def(perf_record_comm, pid, T_UINT, "event pid"),
+	member_def(perf_record_comm, tid, T_UINT, "event tid"),
+	member_def(perf_record_comm, comm, T_STRING_INPLACE, "process name"),
 	{ .name = NULL, },
 };
 
@@ -223,15 +223,15 @@ static char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object."
 static PyMemberDef pyrf_throttle_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(throttle_event, time, T_ULONGLONG, "timestamp"),
-	member_def(throttle_event, id, T_ULONGLONG, "event id"),
-	member_def(throttle_event, stream_id, T_ULONGLONG, "event stream id"),
+	member_def(perf_record_throttle, time, T_ULONGLONG, "timestamp"),
+	member_def(perf_record_throttle, id, T_ULONGLONG, "event id"),
+	member_def(perf_record_throttle, stream_id, T_ULONGLONG, "event stream id"),
 	{ .name = NULL, },
 };
 
 static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
 {
-	struct throttle_event *te = (struct throttle_event *)(&pevent->event.header + 1);
+	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
 
 	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
 				   ", stream_id: %" PRI_lu64 " }",
@@ -253,8 +253,8 @@ static char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
 
 static PyMemberDef pyrf_lost_event__members[] = {
 	sample_members
-	member_def(lost_event, id, T_ULONGLONG, "event id"),
-	member_def(lost_event, lost, T_ULONGLONG, "number of lost events"),
+	member_def(perf_record_lost, id, T_ULONGLONG, "event id"),
+	member_def(perf_record_lost, lost, T_ULONGLONG, "number of lost events"),
 	{ .name = NULL, },
 };
 
@@ -288,8 +288,8 @@ static char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
 
 static PyMemberDef pyrf_read_event__members[] = {
 	sample_members
-	member_def(read_event, pid, T_UINT, "event pid"),
-	member_def(read_event, tid, T_UINT, "event tid"),
+	member_def(perf_record_read, pid, T_UINT, "event pid"),
+	member_def(perf_record_read, tid, T_UINT, "event tid"),
 	{ .name = NULL, },
 };
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index cb1d8dcd0c19..4bfec9db36d6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1254,7 +1254,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
-	struct read_event *read_event = &event->read;
+	struct perf_record_read *read_event = &event->read;
 	u64 read_format;
 
 	if (!dump_trace)
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index bbf7816cba31..dbcb9cfb0f2f 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -169,7 +169,7 @@ struct namespaces *thread__namespaces(struct thread *thread)
 }
 
 static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
-				    struct namespaces_event *event)
+				    struct perf_record_namespaces *event)
 {
 	struct namespaces *new, *curr = __thread__namespaces(thread);
 
@@ -193,7 +193,7 @@ static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 }
 
 int thread__set_namespaces(struct thread *thread, u64 timestamp,
-			   struct namespaces_event *event)
+			   struct perf_record_namespaces *event)
 {
 	int ret;
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index bf06113be4f3..51bdb9a7af7f 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -16,7 +16,7 @@
 
 struct addr_location;
 struct map;
-struct namespaces_event;
+struct perf_record_namespaces;
 struct thread_stack;
 struct unwind_libunwind_ops;
 
@@ -74,7 +74,7 @@ static inline void thread__exited(struct thread *thread)
 
 struct namespaces *thread__namespaces(struct thread *thread);
 int thread__set_namespaces(struct thread *thread, u64 timestamp,
-			   struct namespaces_event *event);
+			   struct perf_record_namespaces *event);
 
 int __thread__set_comm(struct thread *thread, const char *comm, u64 timestamp,
 		       bool exec);
-- 
2.21.0

