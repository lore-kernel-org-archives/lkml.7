Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E220732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKOJFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:05:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:60095 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOJFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:05:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 01:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; 
   d="scan'208";a="379874420"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2019 01:05:17 -0800
Received: from [10.125.252.175] (abudanko-mobl.ccr.corp.intel.com [10.125.252.175])
        by linux.intel.com (Postfix) with ESMTP id DD84F5802B1;
        Fri, 15 Nov 2019 01:05:15 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v1] perf session: fix decompression of PERF_RECORD_COMPRESSED
 records
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <237222f1-9765-dce1-601c-60530a7fc844@linux.intel.com>
Date:   Fri, 15 Nov 2019 12:05:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid termination of trace loading in case the last record in 
the decompressed buffer partly resides in the following 
mmaped PERF_RECORD_COMPRESSED record. In this case NULL value
returned by fetch_mmaped_event() means to proceed to the next 
mmaped record then decompress it and load compressed events. 

The issue can be reproduced like this:

  $ perf record -z -- some_long_running_workload
  $ perf report --stdio -vv
  decomp (B): 44519 to 163000
  decomp (B): 48119 to 174800
  decomp (B): 65527 to 131072
  fetch_mmaped_event: head=0x1ffe0 event->header_size=0x28, mmap_size=0x20000: fuzzed perf.data?
  Error:
  failed to process sample
  ...

Testing:
71: Zstd perf.data compression/decompression              : Ok

Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Link: https://marc.info/?l=linux-kernel&m=156580812427554&w=2
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/session.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ecb91bc..3f6f812ec4ed 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1957,9 +1957,31 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	return err;
 }
 
+static union perf_event *
+prefetch_event(char *buf, u64 head, size_t mmap_size,
+	       bool needs_swap, union perf_event *ret);
+
 static union perf_event *
 fetch_mmaped_event(struct perf_session *session,
 		   u64 head, size_t mmap_size, char *buf)
+{
+	return prefetch_event(buf, head, mmap_size,
+			      session->header.needs_swap,
+			      ERR_PTR(-EINVAL));
+}
+
+static union perf_event *
+fetch_decomp_event(struct perf_session *session,
+		   u64 head, size_t mmap_size, char *buf)
+{
+	return prefetch_event(buf, head, mmap_size,
+			      session->header.needs_swap,
+			      NULL);
+}
+
+static union perf_event *
+prefetch_event(char *buf, u64 head, size_t mmap_size,
+	       bool needs_swap, union perf_event *ret)
 {
 	union perf_event *event;
 
@@ -1971,20 +1993,20 @@ fetch_mmaped_event(struct perf_session *session,
 		return NULL;
 
 	event = (union perf_event *)(buf + head);
+	if (needs_swap)
+		perf_event_header__bswap(&event->header);
 
-	if (session->header.needs_swap)
+	if (head + event->header.size <= mmap_size)
+		return event;
+
+	/* We're not fetching the event so swap back again */
+	if (needs_swap)
 		perf_event_header__bswap(&event->header);
 
-	if (head + event->header.size > mmap_size) {
-		/* We're not fetching the event so swap back again */
-		if (session->header.needs_swap)
-			perf_event_header__bswap(&event->header);
-		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
-			 __func__, head, event->header.size, mmap_size);
-		return ERR_PTR(-EINVAL);
-	}
+	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx\n",
+		__func__, head, event->header.size, mmap_size);
 
-	return event;
+	return ret;
 }
 
 static int __perf_session__process_decomp_events(struct perf_session *session)
@@ -1997,10 +2019,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		return 0;
 
 	while (decomp->head < decomp->size && !session_done()) {
-		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
-
-		if (IS_ERR(event))
-			return PTR_ERR(event);
+		union perf_event *event = fetch_decomp_event(session, decomp->head, decomp->size, decomp->data);
 
 		if (!event)
 			break;

