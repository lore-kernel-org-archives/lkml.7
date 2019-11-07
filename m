Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D37C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF422085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153267;
	bh=m3f5QiSbilNraKanu669l5dVv4q/wfYkXoMKQdko2Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AAfXliurlz04J2PLMg4G0rm0iouGOo82QCoaVrBaDQRn4Quc3NhZ/u8n9Ch0p2SG+
	 mJ/Hg1VzhNVZAkBZTWALj2dNw5/F48JCSpR89mFLJLl/ODMmHlbRZ3Tpp+DkroAZlX
	 JH2SJQ7DhSp9XQGi64mBpSeC60ru/eyZlNmJcyTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfKGTBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKGTBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:01:06 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F9021882;
        Thu,  7 Nov 2019 19:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153265;
        bh=m3f5QiSbilNraKanu669l5dVv4q/wfYkXoMKQdko2Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haImGMQCBqwbDTHU3hT+wZzS11zaGfLBemlTjqKr3n8Q2x/SVoXtSGYrz7ZBSxZ8K
         +zL2jSUyD2hK5ywxXyjLKrFiBin+0hOauFnLI7MnLZhNDog3wCppMmuzFe5DqW6Dzg
         o1IcqKBRIE2nYM7uez6LWdGiRl7/I/+pbUPhSmGI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/63] perf data: Support single perf.data file directory
Date:   Thu,  7 Nov 2019 15:59:13 -0300
Message-Id: <20191107190011.23924-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
index 2fb83aabbef5..e402459752e7 100644
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
2.21.0

