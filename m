Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6910C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D09D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfB1H7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:59:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfB1H7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:59:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7wtDo2952160
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:58:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7wskd2952157;
        Wed, 27 Feb 2019 23:58:54 -0800
Date:   Wed, 27 Feb 2019 23:58:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-45112e89a8b2b4c9a004147cbfb448b1200cfbf7@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        adrian.hunter@intel.com, eranian@google.com,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        ak@linux.intel.com, hpa@zytor.com, jolsa@kernel.org
Reply-To: alexey.budankov@linux.intel.com, mingo@kernel.org,
          ak@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          adrian.hunter@intel.com, eranian@google.com
In-Reply-To: <20190221094145.9151-2-jolsa@kernel.org>
References: <20190221094145.9151-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Move size to struct perf_data_file
Git-Commit-ID: 45112e89a8b2b4c9a004147cbfb448b1200cfbf7
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

Commit-ID:  45112e89a8b2b4c9a004147cbfb448b1200cfbf7
Gitweb:     https://git.kernel.org/tip/45112e89a8b2b4c9a004147cbfb448b1200cfbf7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 21 Feb 2019 10:41:29 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 22 Feb 2019 16:52:07 -0300

perf data: Move size to struct perf_data_file

We are about to add support for multiple files, so we need each file to
keep its size.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190221094145.9151-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 5 ++---
 tools/perf/util/data.c      | 2 +-
 tools/perf/util/data.h      | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6c3719ac901d..e5e9900c9039 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -660,10 +660,9 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int process_buildids(struct record *rec)
 {
-	struct perf_data *data = &rec->data;
 	struct perf_session *session = rec->session;
 
-	if (data->size == 0)
+	if (perf_data__size(&rec->data) == 0)
 		return 0;
 
 	/*
@@ -851,7 +850,7 @@ record__finish_output(struct record *rec)
 		return;
 
 	rec->session->header.data_size += rec->bytes_written;
-	data->size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
 
 	if (!rec->no_buildid) {
 		process_buildids(rec);
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index d8cfc19ddb10..09eceda17fc2 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -82,7 +82,7 @@ static int open_file_read(struct perf_data *data)
 		goto out_close;
 	}
 
-	data->size = st.st_size;
+	data->file.size = st.st_size;
 	return fd;
 
  out_close:
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 4828f7feea89..85f9c0dbf982 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -12,13 +12,13 @@ enum perf_data_mode {
 struct perf_data_file {
 	const char	*path;
 	int		 fd;
+	unsigned long	 size;
 };
 
 struct perf_data {
 	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 force;
-	unsigned long		 size;
 	enum perf_data_mode	 mode;
 };
 
@@ -44,7 +44,7 @@ static inline int perf_data__fd(struct perf_data *data)
 
 static inline unsigned long perf_data__size(struct perf_data *data)
 {
-	return data->size;
+	return data->file.size;
 }
 
 int perf_data__open(struct perf_data *data);
