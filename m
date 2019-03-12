Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C746EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC21214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfCLFc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:32:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:35673 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbfCLFc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:32:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 22:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,469,1544515200"; 
   d="scan'208";a="306419705"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 22:32:56 -0700
Received: from [10.252.11.175] (abudanko-mobl.ccr.corp.intel.com [10.252.11.175])
        by linux.intel.com (Postfix) with ESMTP id 7DF3558046F;
        Mon, 11 Mar 2019 22:32:53 -0700 (PDT)
Subject: [PATCH v7 09/12] perf record: implement -z,--compression_level=n
 option
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1e360280-fdd3-0555-0daf-d711d4d0941f@linux.intel.com>
Date:   Tue, 12 Mar 2019 08:32:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implemented -z,--compression_level=n option that enables compression
of mmaped kernel data buffers content in runtime during perf record
mode collection.

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
 tools/perf/Documentation/perf-record.txt | 5 +++++
 tools/perf/builtin-record.c              | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d1e6c1fd7387..632502b1f335 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -472,6 +472,11 @@ Also at some cases executing less trace write syscalls with bigger data size can
 shorter than executing more trace write syscalls with smaller data size thus lowering
 runtime profiling overhead.
 
+-z::
+--compression-level=n::
+Produce compressed trace using specified level n (no compression: 0 - default,
+fastest compression: 1, smallest trace: 22)
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 47e0abe22192..9f1bba6d4331 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -346,7 +346,7 @@ static void record__aio_mmap_read_sync(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_mmap *maps = evlist->mmap;
 
-	if (!rec->opts.nr_cblocks)
+	if (!record__aio_enabled(rec))
 		return;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
@@ -2166,6 +2166,10 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
+#ifdef HAVE_ZSTD_SUPPORT
+	OPT_UINTEGER('z', "compression-level", &record.opts.comp_level,
+		     "Produce compressed trace using specified level (default: 0, fastest: 1, smallest: 22)"),
+#endif
 	OPT_END()
 };
 
-- 
2.20.1

