Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F94C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9789121726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121999;
	bh=AnT5X/D2I2Fxx6E7taNVvTD5H6XtqDdzYk62kfskvUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZnNuMwkc0ybbJ/ew1dPPsC0fOKjz+9+Qa1Ia07epqoybqEUh6O9KsK9Y+XQkjBv1c
	 nHgXwJn7OtfurfH0ZrTGMSe42ZNKXyTJMcASNkeLzI9aXJI6NdJZbEDCFNg67BsMiv
	 7f+7kDRkvnbpwlunfl3oJIVUp4cdYxOVRHO9gRIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfEQTj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbfEQTjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:39:54 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC80F216FD;
        Fri, 17 May 2019 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121993;
        bh=AnT5X/D2I2Fxx6E7taNVvTD5H6XtqDdzYk62kfskvUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et/HOTljgMsJBrCFqc61w9kvIDCl1oqpROm1hxJLX7Cg71rZqVY0jAmaCuJuvwR+0
         JT3HgmRgRHgZcDkG7u3IPXv4P1HM87XuHwkOFkU6B3wNAQKhtE+V6SjaCrodYsBzh3
         +QnBni3FZopvKvYRHE/jOnJ2GrM3kAys6uUmDWKs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 48/73] perf session: Define 'bytes_transferred' and 'bytes_compressed' metrics
Date:   Fri, 17 May 2019 16:35:46 -0300
Message-Id: <20190517193611.4974-49-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
@@ -1491,6 +1492,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
+	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
+		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
+		session->header.env.comp_ratio = ratio + 0.5;
+	}
+
 	if (forks) {
 		int exit_status;
 
@@ -1537,9 +1543,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
-- 
2.20.1

