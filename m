Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700882190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfCVWEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:04:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbfCVWEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:04:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM4YIx747360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:04:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM4YnK747355;
        Fri, 22 Mar 2019 15:04:34 -0700
Date:   Fri, 22 Mar 2019 15:04:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e8be135751f26aa5de63e517d375ecf69e9b20c3@git.kernel.org>
Cc:     peterz@infradead.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, hpa@zytor.com, eranian@google.com,
        tglx@linutronix.de, ak@linux.intel.com
Reply-To: jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          eranian@google.com, ak@linux.intel.com, adrian.hunter@intel.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, alexey.budankov@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <20190308134745.5057-4-jolsa@kernel.org>
References: <20190308134745.5057-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Add perf_data__update_dir() function
Git-Commit-ID: e8be135751f26aa5de63e517d375ecf69e9b20c3
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

Commit-ID:  e8be135751f26aa5de63e517d375ecf69e9b20c3
Gitweb:     https://git.kernel.org/tip/e8be135751f26aa5de63e517d375ecf69e9b20c3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 8 Mar 2019 14:47:37 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf data: Add perf_data__update_dir() function

Add perf_data__update_dir() to update the size for every file within the
perf.data directory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 20 ++++++++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 18fa8d4614eb..5d0f26aef77f 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -124,6 +124,26 @@ out_err:
 	return ret;
 }
 
+int perf_data__update_dir(struct perf_data *data)
+{
+	int i;
+
+	if (WARN_ON(!data->is_dir))
+		return -EINVAL;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+		struct stat st;
+
+		if (fstat(file->fd, &st))
+			return -1;
+
+		file->size = st.st_size;
+	}
+
+	return 0;
+}
+
 static bool check_pipe(struct perf_data *data)
 {
 	struct stat st;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 06aefeda311f..0deeb1af9f54 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -79,4 +79,5 @@ int perf_data__switch(struct perf_data *data,
 int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
+int perf_data__update_dir(struct perf_data *data);
 #endif /* __PERF_DATA_H */
