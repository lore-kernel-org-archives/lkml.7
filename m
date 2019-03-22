Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463722190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfCVWGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:06:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:06:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM5sjM747532
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:05:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM5r5t747529;
        Fri, 22 Mar 2019 15:05:53 -0700
Date:   Fri, 22 Mar 2019 15:05:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-258031c017c353e899902342a25579fc81a34cc1@git.kernel.org>
Cc:     acme@redhat.com, ak@linux.intel.com, adrian.hunter@intel.com,
        jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        alexey.budankov@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com, eranian@google.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com
Reply-To: namhyung@kernel.org, alexey.budankov@linux.intel.com,
          mingo@kernel.org, acme@redhat.com, ak@linux.intel.com,
          adrian.hunter@intel.com, jolsa@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          eranian@google.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <20190308134745.5057-6-jolsa@kernel.org>
References: <20190308134745.5057-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf header: Add DIR_FORMAT feature to describe
 directory data
Git-Commit-ID: 258031c017c353e899902342a25579fc81a34cc1
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

Commit-ID:  258031c017c353e899902342a25579fc81a34cc1
Gitweb:     https://git.kernel.org/tip/258031c017c353e899902342a25579fc81a34cc1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 8 Mar 2019 14:47:39 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf header: Add DIR_FORMAT feature to describe directory data

The data files layout is described by HEADER_DIR_FORMAT feature.
Currently it holds only version number (1):

     uint64_t version;

The current version holds only version value (1) means that data files:

  - Follow the 'data.*' name format.

  - Contain raw events data in standard perf format as read from kernel
    (and need to be sorted)

Future versions are expected to describe different data files layout
according to special needs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  2 ++
 tools/perf/util/data.c      | 10 ++++++++--
 tools/perf/util/data.h      |  1 +
 tools/perf/util/header.c    | 44 +++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h    |  5 +++++
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e983c8d71a79..a468d882e74f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -837,6 +837,8 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index b71c441cafbb..c6b67efea11a 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -14,6 +14,7 @@
 #include "data.h"
 #include "util.h"
 #include "debug.h"
+#include "header.h"
 
 static void close_dir(struct perf_data_file *files, int nr)
 {
@@ -41,8 +42,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	if (!files)
 		return -ENOMEM;
 
-	data->dir.files = files;
-	data->dir.nr    = nr;
+	data->dir.version = PERF_DIR_VERSION;
+	data->dir.files   = files;
+	data->dir.nr      = nr;
 
 	for (i = 0; i < nr; i++) {
 		struct perf_data_file *file = &files[i];
@@ -75,6 +77,10 @@ int perf_data__open_dir(struct perf_data *data)
 	if (WARN_ON(!data->is_dir))
 		return -EINVAL;
 
+	/* The version is provided by DIR_FORMAT feature. */
+	if (WARN_ON(data->dir.version != PERF_DIR_VERSION))
+		return -1;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index d342469bdfda..6aef8746469f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -24,6 +24,7 @@ struct perf_data {
 	enum perf_data_mode	 mode;
 
 	struct {
+		u64			 version;
 		struct perf_data_file	*files;
 		int			 nr;
 	} dir;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 01b324c275b9..b0683bf4d9f3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -861,6 +861,21 @@ static int write_clockid(struct feat_fd *ff,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
+static int write_dir_format(struct feat_fd *ff,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
+}
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1341,6 +1356,17 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.clockid_res_ns * 1000);
 }
 
+static void print_dir_format(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2373,6 +2399,21 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_dir_format(struct feat_fd *ff,
+			      void *_data __maybe_unused)
+{
+	struct perf_session *session;
+	struct perf_data *data;
+
+	session = container_of(ff->ph, struct perf_session, header);
+	data = session->data;
+
+	if (WARN_ON(!perf_data__is_dir(data)))
+		return -1;
+
+	return do_read_u64(ff, &data->dir.version);
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2432,7 +2473,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
-	FEAT_OPR(CLOCKID,       clockid,        false)
+	FEAT_OPR(CLOCKID,	clockid,	false),
+	FEAT_OPN(DIR_FORMAT,	dir_format,	false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0d553ddca0a3..6a231340238d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -39,6 +39,7 @@ enum {
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
+	HEADER_DIR_FORMAT,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
@@ -48,6 +49,10 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_file_section {
 	u64 offset;
 	u64 size;
