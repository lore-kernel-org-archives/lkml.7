Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3349DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAA6218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCPOLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:11:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:9778 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfCPOLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:11:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Mar 2019 07:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,486,1544515200"; 
   d="scan'208";a="152968193"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2019 07:11:46 -0700
Received: from [10.252.10.233] (abudanko-mobl.ccr.corp.intel.com [10.252.10.233])
        by linux.intel.com (Postfix) with ESMTP id DEB1158028E;
        Sat, 16 Mar 2019 07:11:43 -0700 (PDT)
Subject: [PATCH v9 03/12] perf session: define bytes_transferred and
 bytes_compressed metrics
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
Organization: Intel Corp.
Message-ID: <467278b1-81aa-f247-6e45-63437c474fda@linux.intel.com>
Date:   Sat, 16 Mar 2019 17:11:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Define bytes_transferred and bytes_compressed metrics to calculate ratio
in the end of the data collection:

	compression ratio = bytes_transferred / bytes_compressed

bytes_transferred accumulates the amount of bytes that was extracted from
the mmaped kernel buffers for compression. bytes_compressed accumulates
the amount of bytes that was received after applying compression.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 14 +++++++++++++-
 tools/perf/util/env.h       |  1 +
 tools/perf/util/session.h   |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f55302dec440..51b7f23a0c7a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1166,6 +1166,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_session *session;
 	bool disabled = false, draining = false;
 	int fd;
+	float ratio = 0;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1463,6 +1464,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
+	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
+		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
+		session->header.env.comp_ratio = ratio + 0.5;
+	}
+
 	if (forks) {
 		int exit_status;
 
@@ -1509,9 +1515,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
index d01b8355f4ca..fb39e9af128f 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -64,6 +64,7 @@ struct perf_env {
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
 	u64                     clockid_res_ns;
+	u32                     comp_ratio;
 };
 
 extern struct perf_env perf_env;
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

