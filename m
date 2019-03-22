Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C3421925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfCVWFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:05:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:05:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM5GIJ747478
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:05:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM5Flg747467;
        Fri, 22 Mar 2019 15:05:15 -0700
Date:   Fri, 22 Mar 2019 15:05:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-29583c17b5ce0bc17fdd80da939f8199a03d9668@git.kernel.org>
Cc:     eranian@google.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com, mingo@kernel.org,
        hpa@zytor.com, alexey.budankov@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
          adrian.hunter@intel.com, mingo@kernel.org, eranian@google.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com
In-Reply-To: <20190308134745.5057-5-jolsa@kernel.org>
References: <20190308134745.5057-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Make perf_data__size() work over
 directory
Git-Commit-ID: 29583c17b5ce0bc17fdd80da939f8199a03d9668
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

Commit-ID:  29583c17b5ce0bc17fdd80da939f8199a03d9668
Gitweb:     https://git.kernel.org/tip/29583c17b5ce0bc17fdd80da939f8199a03d9668
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 8 Mar 2019 14:47:38 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf data: Make perf_data__size() work over directory

Make perf_data__size() return proper size for directory data, summing up
all the individual file sizes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 17 +++++++++++++++++
 tools/perf/util/data.h |  6 +-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 5d0f26aef77f..b71c441cafbb 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -393,3 +393,20 @@ out:
 	free(new_filepath);
 	return ret;
 }
+
+unsigned long perf_data__size(struct perf_data *data)
+{
+	u64 size = data->file.size;
+	int i;
+
+	if (!data->is_dir)
+		return size;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+
+		size += file->size;
+	}
+
+	return size;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 0deeb1af9f54..d342469bdfda 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -54,11 +54,6 @@ static inline int perf_data__fd(struct perf_data *data)
 	return data->file.fd;
 }
 
-static inline unsigned long perf_data__size(struct perf_data *data)
-{
-	return data->file.size;
-}
-
 int perf_data__open(struct perf_data *data);
 void perf_data__close(struct perf_data *data);
 ssize_t perf_data__write(struct perf_data *data,
@@ -80,4 +75,5 @@ int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 int perf_data__update_dir(struct perf_data *data);
+unsigned long perf_data__size(struct perf_data *data);
 #endif /* __PERF_DATA_H */
