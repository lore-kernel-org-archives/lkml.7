Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34962171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfB1IFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:05:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfB1IFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:05:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S8458H2953267
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:04:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S845EN2953242;
        Thu, 28 Feb 2019 00:04:05 -0800
Date:   Thu, 28 Feb 2019 00:04:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-eb6176709b235b96511c7b4745c30412568395c7@git.kernel.org>
Cc:     eranian@google.com, jolsa@kernel.org,
        alexey.budankov@linux.intel.com, tglx@linutronix.de,
        adrian.hunter@intel.com, acme@redhat.com, ak@linux.intel.com,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: acme@redhat.com, ak@linux.intel.com, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, eranian@google.com,
          jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de
In-Reply-To: <20190224190656.30163-10-jolsa@kernel.org>
References: <20190224190656.30163-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Add perf_data__open_dir_data function
Git-Commit-ID: eb6176709b235b96511c7b4745c30412568395c7
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

Commit-ID:  eb6176709b235b96511c7b4745c30412568395c7
Gitweb:     https://git.kernel.org/tip/eb6176709b235b96511c7b4745c30412568395c7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 24 Feb 2019 20:06:45 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 10:43:07 -0300

perf data: Add perf_data__open_dir_data function

Add perf_data__open_dir_data to open files inside 'struct perf_data'
path directory:

   static int perf_data__open_dir(struct perf_data *data);

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 005b3909d1dc..7bd5ddeb7a41 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -8,6 +8,8 @@
 #include <unistd.h>
 #include <string.h>
 #include <asm/bug.h>
+#include <sys/types.h>
+#include <dirent.h>
 
 #include "data.h"
 #include "util.h"
@@ -59,6 +61,63 @@ out_err:
 	return ret;
 }
 
+int perf_data__open_dir(struct perf_data *data)
+{
+	struct perf_data_file *files = NULL;
+	struct dirent *dent;
+	int ret = -1;
+	DIR *dir;
+	int nr = 0;
+
+	dir = opendir(data->path);
+	if (!dir)
+		return -EINVAL;
+
+	while ((dent = readdir(dir)) != NULL) {
+		struct perf_data_file *file;
+		char path[PATH_MAX];
+		struct stat st;
+
+		snprintf(path, sizeof(path), "%s/%s", data->path, dent->d_name);
+		if (stat(path, &st))
+			continue;
+
+		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data", 4))
+			continue;
+
+		ret = -ENOMEM;
+
+		file = realloc(files, (nr + 1) * sizeof(*files));
+		if (!file)
+			goto out_err;
+
+		files = file;
+		file = &files[nr++];
+
+		file->path = strdup(path);
+		if (!file->path)
+			goto out_err;
+
+		ret = open(file->path, O_RDONLY);
+		if (ret < 0)
+			goto out_err;
+
+		file->fd = ret;
+		file->size = st.st_size;
+	}
+
+	if (!files)
+		return -EINVAL;
+
+	data->dir.files = files;
+	data->dir.nr    = nr;
+	return 0;
+
+out_err:
+	close_dir(files, nr);
+	return ret;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 2d0d015a7d4d..14b47be2bd69 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -71,5 +71,6 @@ int perf_data__switch(struct perf_data *data,
 			   size_t pos, bool at_exit);
 
 int perf_data__create_dir(struct perf_data *data, int nr);
+int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
