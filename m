Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B084C2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCRRlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:41:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:47808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbfCRRlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:41:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 10:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="123687196"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2019 10:41:06 -0700
Received: from [10.251.91.19] (abudanko-mobl.ccr.corp.intel.com [10.251.91.19])
        by linux.intel.com (Postfix) with ESMTP id B05D758052E;
        Mon, 18 Mar 2019 10:41:03 -0700 (PDT)
Subject: [PATCH v10 03/12] perf session: define bytes_transferred and
 bytes_compressed metrics
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1d4bf499-cb03-26dc-6fc6-f14fec7622ce@linux.intel.com>
Date:   Mon, 18 Mar 2019 20:41:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
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

