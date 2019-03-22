Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0816C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C69721925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCVWEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:04:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47011 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfCVWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:04:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM3DpJ745692
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:03:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM3Dp6745688;
        Fri, 22 Mar 2019 15:03:13 -0700
Date:   Fri, 22 Mar 2019 15:03:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ec65def1045e4c7817b7f741a86dadae82877a93@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, ak@linux.intel.com,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        adrian.hunter@intel.com, alexey.budankov@linux.intel.com,
        acme@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, acme@redhat.com,
          alexey.budankov@linux.intel.com, eranian@google.com,
          alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
          namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
          jolsa@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <20190308134745.5057-2-jolsa@kernel.org>
References: <20190308134745.5057-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Support having perf.data stored as a
 directory
Git-Commit-ID: ec65def1045e4c7817b7f741a86dadae82877a93
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

Commit-ID:  ec65def1045e4c7817b7f741a86dadae82877a93
Gitweb:     https://git.kernel.org/tip/ec65def1045e4c7817b7f741a86dadae82877a93
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 8 Mar 2019 14:47:35 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf data: Support having perf.data stored as a directory

The caller needs to set 'struct perf_data::is_dir flag and the path will
be treated as a directory.

The 'struct perf_data::file' is initialized and open as 'path/header'
file.

Add a check to the direcory interface functions to check the is_dir flag.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-2-jolsa@kernel.org
[ Be consistent on how to signal failure, i.e. use -1 and let users check errno ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/data.h    |  6 ++++++
 tools/perf/util/session.c |  4 ++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index e098e189f93e..18fa8d4614eb 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 	struct perf_data_file *files = NULL;
 	int i, ret = -1;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	files = zalloc(nr * sizeof(*files));
 	if (!files)
 		return -ENOMEM;
@@ -69,6 +72,9 @@ int perf_data__open_dir(struct perf_data *data)
 	DIR *dir;
 	int nr = 0;
 
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
 	dir = opendir(data->path);
 	if (!dir)
 		return -EINVAL;
@@ -173,6 +179,16 @@ static int check_backup(struct perf_data *data)
 	return 0;
 }
 
+static bool is_dir(struct perf_data *data)
+{
+	struct stat st;
+
+	if (stat(data->path, &st))
+		return false;
+
+	return (st.st_mode & S_IFMT) == S_IFDIR;
+}
+
 static int open_file_read(struct perf_data *data)
 {
 	struct stat st;
@@ -254,6 +270,30 @@ static int open_file_dup(struct perf_data *data)
 	return open_file(data);
 }
 
+static int open_dir(struct perf_data *data)
+{
+	int ret;
+
+	/*
+	 * So far we open only the header, so we can read the data version and
+	 * layout.
+	 */
+	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
+		return -1;
+
+	if (perf_data__is_write(data) &&
+	    mkdir(data->path, S_IRWXU) < 0)
+		return -1;
+
+	ret = open_file(data);
+
+	/* Cleanup whatever we managed to create so far. */
+	if (ret && perf_data__is_write(data))
+		rm_rf_perf_data(data->path);
+
+	return ret;
+}
+
 int perf_data__open(struct perf_data *data)
 {
 	if (check_pipe(data))
@@ -265,11 +305,18 @@ int perf_data__open(struct perf_data *data)
 	if (check_backup(data))
 		return -1;
 
-	return open_file_dup(data);
+	if (perf_data__is_read(data))
+		data->is_dir = is_dir(data);
+
+	return perf_data__is_dir(data) ?
+	       open_dir(data) : open_file_dup(data);
 }
 
 void perf_data__close(struct perf_data *data)
 {
+	if (perf_data__is_dir(data))
+		perf_data__close_dir(data);
+
 	zfree(&data->file.path);
 	close(data->file.fd);
 }
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 14b47be2bd69..06aefeda311f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -19,6 +19,7 @@ struct perf_data {
 	const char		*path;
 	struct perf_data_file	 file;
 	bool			 is_pipe;
+	bool			 is_dir;
 	bool			 force;
 	enum perf_data_mode	 mode;
 
@@ -43,6 +44,11 @@ static inline int perf_data__is_pipe(struct perf_data *data)
 	return data->is_pipe;
 }
 
+static inline bool perf_data__is_dir(struct perf_data *data)
+{
+	return data->is_dir;
+}
+
 static inline int perf_data__fd(struct perf_data *data)
 {
 	return data->file.fd;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index db643f3c2b95..de777bdc0ed3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -152,6 +152,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			}
 
 			perf_evlist__init_trace_event_sample_raw(session->evlist);
+
+			/* Open the directory data. */
+			if (data->is_dir && perf_data__open_dir(data))
+				goto out_delete;
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
