Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17A820854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCNLgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:36:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:44694 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfCNLgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:36:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 04:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="282584449"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2019 04:36:22 -0700
Received: from [10.125.252.108] (abudanko-mobl.ccr.corp.intel.com [10.125.252.108])
        by linux.intel.com (Postfix) with ESMTP id 8D4335803FA;
        Thu, 14 Mar 2019 04:36:20 -0700 (PDT)
Subject: [PATCH v8 09/12] perf record: implement -z,--compression_level=n
 option
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4c037bbd-1cc9-90f2-b9cd-0e0839c83b73@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0ce4d030-a37b-4a81-97e1-5e59ca3b0913@linux.intel.com>
Date:   Thu, 14 Mar 2019 14:36:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4c037bbd-1cc9-90f2-b9cd-0e0839c83b73@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implemented -z,--compression_level=n option that enables compression
of mmaped kernel data buffers content in runtime during perf record
mode collection. Default option value is 1 (fastest compression).

Compression overhead has been measured for serial and AIO streaming
when profiling matrix multiplication workload:

    -------------------------------------------------------------
    | SERIAL			  | AIO-1                       |
----------------------------------------------------------------|
|-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
|---------------------------------------------------------------|
| 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
| 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
| 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
| 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
| 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
| 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
-----------------------------------------------------------------

OVH = (Execution time with -z N) / (Execution time with -z 0)

ratio - compression ratio
size  - number of bytes that was compressed

	size ~= trace size x ratio

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/builtin-record.c              | 27 +++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8eb3f5b57202..f5c886fde243 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -471,6 +471,11 @@ Also at some cases executing less trace write syscalls with bigger data size can
 shorter than executing more trace write syscalls with smaller data size thus lowering
 runtime profiling overhead.
 
+-z::
+--compression-level=n::
+Produce compressed trace using specified level n (default: 1 - fastest compression,
+22 - smallest trace)
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d23be2a82cf3..e0da9100e52f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -346,7 +346,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_mmap *maps = evlist->mmap;
 
-	if (!rec->opts.nr_cblocks)
+	if (!record__aio_enabled(rec))
 		return;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
@@ -440,6 +440,26 @@ static int record__mmap_flush_parse(const struct option *opt,
 	return 0;
 }
 
+#ifdef HAVE_ZSTD_SUPPORT
+static unsigned int comp_level_default = 1;
+static int record__parse_comp_level(const struct option *opt,
+				    const char *str,
+				    int unset)
+{
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (unset) {
+		opts->comp_level = 0;
+	} else {
+		if (str)
+			opts->comp_level = strtol(str, NULL, 0);
+		if (!opts->comp_level)
+			opts->comp_level = comp_level_default;
+	}
+
+	return 0;
+}
+#endif
 static unsigned int comp_level_max = 22;
 
 static int record__comp_enabled(struct record *rec)
@@ -2168,6 +2188,11 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
+#ifdef HAVE_ZSTD_SUPPORT
+	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts,
+		     &comp_level_default, "n", "Produce compressed trace using specified level (default: 1 - fastest, 22 - smallest trace)",
+		     record__parse_comp_level),
+#endif
 	OPT_END()
 };
 
-- 
2.20.1

