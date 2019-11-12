Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6364C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB232246A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfKLLUA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:20:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfKLLSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBl-0000mF-Px; Tue, 12 Nov 2019 12:18:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5799B1C04A9;
        Tue, 12 Nov 2019 12:18:18 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:17 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf data: Support single perf.data file directory
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191004083121.12182-5-adrian.hunter@intel.com>
References: <20191004083121.12182-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355749791.29376.9806639587173781912.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     46e201efa15b70ec39df5237116fddebb4f5057c
Gitweb:        https://git.kernel.org/tip/46e201efa15b70ec39df5237116fddebb4f5057c
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 04 Oct 2019 11:31:20 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf data: Support single perf.data file directory

Support directory output that contains a regular perf.data file, named
"data". By default the directory is named perf.data i.e.
	perf.data
	└── data

Most of the infrastructure to support a directory is already there. This
patch makes the changes needed to support the format above.

Presently there is no 'perf record' option to output a directory.

This is preparation for adding support for putting a copy of /proc/kcore in
the directory.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191004083121.12182-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-directory-format.txt | 28 ++++++++-
 tools/perf/builtin-record.c                             |  2 +-
 tools/perf/util/data.c                                  |  9 ++-
 tools/perf/util/data.h                                  |  6 ++-
 4 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt

diff --git a/tools/perf/Documentation/perf.data-directory-format.txt b/tools/perf/Documentation/perf.data-directory-format.txt
new file mode 100644
index 0000000..4bf0890
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
index 2fb83aa..e402459 100644
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
index df173f0..964ea10 100644
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
index 218fe9a..f68815f 100644
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
