Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B29215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfJDIcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:32:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:57519 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbfJDIcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:32:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="204236458"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2019 01:32:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] perf tools: Support single perf.data file directory
Date:   Fri,  4 Oct 2019 11:31:20 +0300
Message-Id: <20191004083121.12182-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004083121.12182-1-adrian.hunter@intel.com>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support directory output that contains a regular perf.data file, named
"data". By default the directory is named perf.data i.e.
	perf.data
	└── data

Most of the infrastucture to support a directory is already there. This
patch makes the changes needed to support the format above.

Presently there is no 'perf record' option to output a directory.

This is preparation for adding support for putting a copy of /proc/kcore in
the directory.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../perf.data-directory-format.txt            | 28 +++++++++++++++++++
 tools/perf/builtin-record.c                   |  2 +-
 tools/perf/util/data.c                        |  9 +++++-
 tools/perf/util/data.h                        |  6 ++++
 4 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt

diff --git a/tools/perf/Documentation/perf.data-directory-format.txt b/tools/perf/Documentation/perf.data-directory-format.txt
new file mode 100644
index 000000000000..4bf08908178d
--- /dev/null
+++ b/tools/perf/Documentation/perf.data-directory-format.txt
@@ -0,0 +1,28 @@
+perf.data directory format
+
+DISCLAIMER This is not ABI yet and is subject to possible change
+           in following versions of perf. We will remove this
+           disclaimer once the directory format soaks in.
+
+
+This document describes the on-disk perf.data directory format.
+
+The layout is described by HEADER_DIR_FORMAT feature.
+Currently it holds only version number (0):
+
+  HEADER_DIR_FORMAT = 24
+
+  struct {
+     uint64_t version;
+  }
+
+The current only version value 0 means that:
+  - there is a single perf.data file named 'data' within the directory.
+  e.g.
+
+    $ tree -ps perf.data
+    perf.data
+    └── [-rw-------       25912]  data
+
+Future versions are expected to describe different data files
+layout according to special needs.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 23332861de6e..fceac9d42b4e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -537,7 +537,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
+	if (!perf_data__is_pipe(data) && perf_data__is_single_file(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index df173f0bf654..964ea101dba6 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
+	/*
+	 * Directory containing a single regular perf data file which is already
+	 * open, means there is nothing more to do here.
+	 */
+	if (perf_data__is_single_file(data))
+		return 0;
+
 	if (WARN_ON(!data->is_dir))
 		return -EINVAL;
 
@@ -406,7 +413,7 @@ unsigned long perf_data__size(struct perf_data *data)
 	u64 size = data->file.size;
 	int i;
 
-	if (!data->is_dir)
+	if (perf_data__is_single_file(data))
 		return size;
 
 	for (i = 0; i < data->dir.nr; i++) {
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 218fe9a16801..f68815f7e428 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -10,6 +10,7 @@ enum perf_data_mode {
 };
 
 enum perf_dir_version {
+	PERF_DIR_SINGLE_FILE	= 0,
 	PERF_DIR_VERSION	= 1,
 };
 
@@ -54,6 +55,11 @@ static inline bool perf_data__is_dir(struct perf_data *data)
 	return data->is_dir;
 }
 
+static inline bool perf_data__is_single_file(struct perf_data *data)
+{
+	return data->dir.version == PERF_DIR_SINGLE_FILE;
+}
+
 static inline int perf_data__fd(struct perf_data *data)
 {
 	return data->file.fd;
-- 
2.17.1

