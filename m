Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D44FC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165932087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EDeHhMgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfERJUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:20:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfERJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:20:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9JfFs1738574
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:19:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9JfFs1738574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171182;
        bh=y2YvIvacy81jkTEkUCEJ+ijWYoaTBwF+kalY8B4t9AE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EDeHhMgQlTtuoMNOH5cifUB0bNIpKD62htmVB3tGKu7vPz2naG5ZQOjYs2YeEY9li
         01+wkEfCXNNDoETPkPqEBrdfSdsRrwzk/nN2BBzz/bFk1WvK8Sz8kXlKarCdKYy6AZ
         wK3f753Mjo06+JSNxpBqCG9RaIZ278v5FVRLXzlZHNsiHs5NYDFCliB8LgPBSJ7Vs3
         rPd16qvi9h9UDeQbe+HsoHYuaOAqnEeD2UOH6JCIOWM65fvkNdfLI8lbCP1lYFdGo2
         8WsxBJHKm2Sn5fvJtVzXLpiBQUOWTOjFclozund6C/Aocfa7mcHxz9Zuc26jNWg5xa
         plxfUV0ZqW5gQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Jfv41738571;
        Sat, 18 May 2019 02:19:41 -0700
Date:   Sat, 18 May 2019 02:19:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-d3c8c08e75c4cbb6a940323092b40fcfd1de5380@git.kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com,
          alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, peterz@infradead.org
In-Reply-To: <1d4bf499-cb03-26dc-6fc6-f14fec7622ce@linux.intel.com>
References: <1d4bf499-cb03-26dc-6fc6-f14fec7622ce@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Define 'bytes_transferred' and
 'bytes_compressed' metrics
Git-Commit-ID: d3c8c08e75c4cbb6a940323092b40fcfd1de5380
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

Commit-ID:  d3c8c08e75c4cbb6a940323092b40fcfd1de5380
Gitweb:     https://git.kernel.org/tip/d3c8c08e75c4cbb6a940323092b40fcfd1de5380
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:41:02 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf session: Define 'bytes_transferred' and 'bytes_compressed' metrics

Define 'bytes_transferred' and 'bytes_compressed' metrics to calculate
ratio in the end of the data collection:

	compression ratio = bytes_transferred / bytes_compressed

The 'bytes_transferred' metric accumulates the amount of bytes that was
extracted from the mmaped kernel buffers for compression, while
'bytes_compressed' accumulates the amount of bytes that was received
after applying compression.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1d4bf499-cb03-26dc-6fc6-f14fec7622ce@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 14 +++++++++++++-
 tools/perf/util/env.h       |  1 +
 tools/perf/util/session.h   |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d2b5a22b7249..386e665a166f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1186,6 +1186,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	struct perf_evlist *sb_evlist = NULL;
 	int fd;
+	float ratio = 0;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1491,6 +1492,11 @@ out_child:
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
+	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
+		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
+		session->header.env.comp_ratio = ratio + 0.5;
+	}
+
 	if (forks) {
 		int exit_status;
 
@@ -1537,9 +1543,15 @@ out_child:
 		else
 			samples[0] = '\0';
 
-		fprintf(stderr,	"[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",
+		fprintf(stderr,	"[ perf record: Captured and wrote %.3f MB %s%s%s",
 			perf_data__size(data) / 1024.0 / 1024.0,
 			data->path, postfix, samples);
+		if (ratio) {
+			fprintf(stderr,	", compressed (original %.3f MB, ratio is %.3f)",
+					rec->session->bytes_transferred / 1024.0 / 1024.0,
+					ratio);
+		}
+		fprintf(stderr, " ]\n");
 	}
 
 out_delete_session:
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4f8e2b485c01..34868ca7efd1 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -62,6 +62,7 @@ struct perf_env {
 	struct cpu_topology_map	*cpu;
 	struct cpu_cache_level	*caches;
 	int			 caches_cnt;
+	u32			comp_ratio;
 	struct numa_node	*numa_nodes;
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index d96eccd7d27f..0e14884f28b2 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -35,6 +35,8 @@ struct perf_session {
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
 	struct perf_tool	*tool;
+	u64			bytes_transferred;
+	u64			bytes_compressed;
 };
 
 struct perf_tool;
