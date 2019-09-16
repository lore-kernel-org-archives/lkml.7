Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69ADC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22AC20890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfIPI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:58:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:49388 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfIPI6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:58:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 01:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="211088538"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2019 01:58:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] perf tools: Support single perf.data file directory
Date:   Mon, 16 Sep 2019 11:56:45 +0300
Message-Id: <20190916085646.6199-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916085646.6199-1-adrian.hunter@intel.com>
References: <20190916085646.6199-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support directory output that contains a regular perf.data file. This is
preparation for adding support for putting a copy of /proc/kcore in that
directory.

Distinguish the multiple file case from the regular (single) perf.data file
case by adding data->is_multi_file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c |  2 +-
 tools/perf/util/data.c      | 37 +++++++++++++++++++++++++++----------
 tools/perf/util/data.h      |  6 ++++++
 tools/perf/util/header.h    |  1 +
 tools/perf/util/session.c   |  2 +-
 tools/perf/util/util.c      |  1 +
 6 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1447004eee8a..4c356a046dd3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -534,7 +534,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
+	if (!perf_data__is_pipe(data) && !perf_data__is_multi_file(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 88fba2ba549f..2fd3114d1167 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -37,7 +37,7 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	struct perf_data_file *files = NULL;
 	int i, ret = -1;
 
-	if (WARN_ON(!data->is_dir))
+	if (WARN_ON(!data->is_multi_file))
 		return -EINVAL;
 
 	files = zalloc(nr * sizeof(*files));
@@ -76,7 +76,7 @@ int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
-	if (WARN_ON(!data->is_dir))
+	if (WARN_ON(!data->is_multi_file))
 		return -EINVAL;
 
 	/* The version is provided by DIR_FORMAT feature. */
@@ -217,6 +217,16 @@ static bool is_dir(struct perf_data *data)
 	return (st.st_mode & S_IFMT) == S_IFDIR;
 }
 
+static bool is_multi_file(struct perf_data *data)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	snprintf(path, sizeof(path), "%s/header", data->path);
+
+	return !stat(path, &st);
+}
+
 static int open_file_read(struct perf_data *data)
 {
 	struct stat st;
@@ -302,12 +312,17 @@ static int open_dir(struct perf_data *data)
 {
 	int ret;
 
-	/*
-	 * So far we open only the header, so we can read the data version and
-	 * layout.
-	 */
-	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
-		return -1;
+	if (perf_data__is_multi_file(data)) {
+		/*
+		 * So far we open only the header, so we can read the data version and
+		 * layout.
+		 */
+		if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+			return -1;
+	} else {
+		if (asprintf(&data->file.path, "%s/perf.data", data->path) < 0)
+			return -1;
+	}
 
 	if (perf_data__is_write(data) &&
 	    mkdir(data->path, S_IRWXU) < 0)
@@ -333,8 +348,10 @@ int perf_data__open(struct perf_data *data)
 	if (check_backup(data))
 		return -1;
 
-	if (perf_data__is_read(data))
+	if (perf_data__is_read(data)) {
 		data->is_dir = is_dir(data);
+		data->is_multi_file = is_multi_file(data);
+	}
 
 	return perf_data__is_dir(data) ?
 	       open_dir(data) : open_file_dup(data);
@@ -406,7 +423,7 @@ unsigned long perf_data__size(struct perf_data *data)
 	u64 size = data->file.size;
 	int i;
 
-	if (!data->is_dir)
+	if (!data->is_multi_file)
 		return size;
 
 	for (i = 0; i < data->dir.nr; i++) {
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 259868a39019..0c5994d969c7 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -20,6 +20,7 @@ struct perf_data {
 	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 is_dir;
+	bool			 is_multi_file;
 	bool			 force;
 	enum perf_data_mode	 mode;
 
@@ -50,6 +51,11 @@ static inline bool perf_data__is_dir(struct perf_data *data)
 	return data->is_dir;
 }
 
+static inline bool perf_data__is_multi_file(struct perf_data *data)
+{
+	return data->is_multi_file;
+}
+
 static inline int perf_data__fd(struct perf_data *data)
 {
 	return data->file.fd;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 999dac41871e..73ad217958b8 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -53,6 +53,7 @@ enum perf_header_version {
 };
 
 enum perf_dir_version {
+	PERF_DIR_SINGLE_FILE	= 0,
 	PERF_DIR_VERSION	= 1,
 };
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2b583e6adb49..6dd04bd092d1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -222,7 +222,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
 
 			/* Open the directory data. */
-			if (data->is_dir && perf_data__open_dir(data))
+			if (data->is_multi_file && perf_data__open_dir(data))
 				goto out_delete;
 		}
 	} else  {
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 32322a20a68b..5ca7490afdd1 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -189,6 +189,7 @@ int rm_rf_perf_data(const char *path)
 	const char *pat[] = {
 		"header",
 		"data.*",
+		"perf.data",
 		NULL,
 	};
 
-- 
2.17.1

