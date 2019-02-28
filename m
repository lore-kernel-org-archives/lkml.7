Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA54C2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfB1IDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:03:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfB1IDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:03:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S83Php2953124
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:03:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S83P542953120;
        Thu, 28 Feb 2019 00:03:25 -0800
Date:   Thu, 28 Feb 2019 00:03:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-145520631130bd64820b591775733256473eac62@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, eranian@google.com,
        adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com,
        alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org
Reply-To: alexander.shishkin@linux.intel.com, ak@linux.intel.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
          eranian@google.com, adrian.hunter@intel.com,
          peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
          alexey.budankov@linux.intel.com
In-Reply-To: <20190224190656.30163-9-jolsa@kernel.org>
References: <20190224190656.30163-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Add perf_data__(create_dir|close_dir)
 functions
Git-Commit-ID: 145520631130bd64820b591775733256473eac62
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

Commit-ID:  145520631130bd64820b591775733256473eac62
Gitweb:     https://git.kernel.org/tip/145520631130bd64820b591775733256473eac62
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 24 Feb 2019 20:06:44 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 10:42:05 -0300

perf data: Add perf_data__(create_dir|close_dir) functions

Add perf_data__create_dir() to create nr files inside 'struct perf_data'
path directory:

  int perf_data__create_dir(struct perf_data *data, int nr);

and function to close that data:

  void perf_data__close_dir(struct perf_data *data);

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h |  8 ++++++++
 2 files changed, 55 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index d008c3973012..005b3909d1dc 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -7,11 +7,58 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <string.h>
+#include <asm/bug.h>
 
 #include "data.h"
 #include "util.h"
 #include "debug.h"
 
+static void close_dir(struct perf_data_file *files, int nr)
+{
+	while (--nr >= 1) {
+		close(files[nr].fd);
+		free(files[nr].path);
+	}
+	free(files);
+}
+
+void perf_data__close_dir(struct perf_data *data)
+{
+	close_dir(data->dir.files, data->dir.nr);
+}
+
+int perf_data__create_dir(struct perf_data *data, int nr)
+{
+	struct perf_data_file *files = NULL;
+	int i, ret = -1;
+
+	files = zalloc(nr * sizeof(*files));
+	if (!files)
+		return -ENOMEM;
+
+	data->dir.files = files;
+	data->dir.nr    = nr;
+
+	for (i = 0; i < nr; i++) {
+		struct perf_data_file *file = &files[i];
+
+		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
+			goto out_err;
+
+		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
+		if (ret < 0)
+			goto out_err;
+
+		file->fd = ret;
+	}
+
+	return 0;
+
+out_err:
+	close_dir(files, i);
+	return ret;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 2bce28117ccf..2d0d015a7d4d 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -21,6 +21,11 @@ struct perf_data {
 	bool			 is_pipe;
 	bool			 force;
 	enum perf_data_mode	 mode;
+
+	struct {
+		struct perf_data_file	*files;
+		int			 nr;
+	} dir;
 };
 
 static inline bool perf_data__is_read(struct perf_data *data)
@@ -64,4 +69,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
 			   size_t pos, bool at_exit);
+
+int perf_data__create_dir(struct perf_data *data, int nr);
+void perf_data__close_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
