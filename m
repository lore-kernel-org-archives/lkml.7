Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E95BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF820721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434659;
	bh=v8w10PJKZU+xbZHqqH9wuVazZ8h333GHcPl7S/cOS5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KYSi3rU0UsQZZ+X+R9BErlRbW3Z5by5Khq9uYUdSZduca/o+91oJPRT+7VgYPJpDV
	 LokAYkkXunFajGPfloc0QJ3cPPh9B9V7EHAWN8z+oLEG1Sqi0TlRj4U19DwRw7FI0G
	 Rhx2zCfvQKYfCDdP7hLmR639F4fisPycTbHJ6hHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKVO5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfKVO5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:36 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E1E2075B;
        Fri, 22 Nov 2019 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434655;
        bh=v8w10PJKZU+xbZHqqH9wuVazZ8h333GHcPl7S/cOS5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8BM61H6eisL9TOYyuUWaJ8UDS658rB1dp60FqyWyHYDj4JMiyo09zfGIeV3FCcHP
         8USoOHNGbaF9ApD870/Z0+dg3O94S1DrCD2ykxhrlQZ/1EUGOxGLVFcg9xjdg25qYo
         8xqA8leuBRdVNFdhEOAm3RbmyUPXMUirhb07z1Vg=
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
Subject: [PATCH 06/26] perf session: Fix decompression of PERF_RECORD_COMPRESSED records
Date:   Fri, 22 Nov 2019 11:56:51 -0300
Message-Id: <20191122145711.3171-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Avoid termination of trace loading in case the last record in the
decompressed buffer partly resides in the following mmaped
PERF_RECORD_COMPRESSED record.

In this case NULL value returned by fetch_mmaped_event() means to
proceed to the next mmaped record then decompress it and load compressed
events.

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

  $ tools/perf/perf report -vv --stdio
  decomp (B): 59593 to 262160
  decomp (B): 4438 to 16512
  decomp (B): 285 to 880
  Looking at the vmlinux_path (8 entries long)
  Using vmlinux for symbols
  decomp (B): 57474 to 261248
  prefetch_event: head=0x3fc78 event->header_size=0x28, mmap_size=0x3fc80: fuzzed or compressed perf.data?
  decomp (B): 25 to 32
  decomp (B): 52 to 120
  ...

Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Link: https://marc.info/?l=linux-kernel&m=156580812427554&w=2
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ecb91bc..8454a650146b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1958,8 +1958,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 }
 
 static union perf_event *
-fetch_mmaped_event(struct perf_session *session,
-		   u64 head, size_t mmap_size, char *buf)
+prefetch_event(char *buf, u64 head, size_t mmap_size,
+	       bool needs_swap, union perf_event *error)
 {
 	union perf_event *event;
 
@@ -1971,20 +1971,32 @@ fetch_mmaped_event(struct perf_session *session,
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
+	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
+		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
 
-	return event;
+	return error;
+}
+
+static union perf_event *
+fetch_mmaped_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
+{
+	return prefetch_event(buf, head, mmap_size, needs_swap, ERR_PTR(-EINVAL));
+}
+
+static union perf_event *
+fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
+{
+	return prefetch_event(buf, head, mmap_size, needs_swap, NULL);
 }
 
 static int __perf_session__process_decomp_events(struct perf_session *session)
@@ -1997,10 +2009,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		return 0;
 
 	while (decomp->head < decomp->size && !session_done()) {
-		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
-
-		if (IS_ERR(event))
-			return PTR_ERR(event);
+		union perf_event *event = fetch_decomp_event(decomp->head, decomp->size, decomp->data,
+							     session->header.needs_swap);
 
 		if (!event)
 			break;
@@ -2100,7 +2110,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	}
 
 more:
-	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
-- 
2.21.0

