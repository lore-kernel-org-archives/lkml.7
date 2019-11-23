Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD61EC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30F420720
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKWIPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:15:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36344 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfKWIPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZV-0002bt-Nm; Sat, 23 Nov 2019 09:15:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C873A1C1ACC;
        Sat, 23 Nov 2019 09:15:02 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:02 -0000
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf session: Fix decompression of
 PERF_RECORD_COMPRESSED records
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com>
References: <cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157449690272.21853.2015069761475695078.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bb1835a3b86c73aa534ef6430ad40223728dfbc0
Gitweb:        https://git.kernel.org/tip/bb1835a3b86c73aa534ef6430ad40223728dfbc0
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Mon, 18 Nov 2019 17:21:03 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 19 Nov 2019 19:31:55 -03:00

perf session: Fix decompression of PERF_RECORD_COMPRESSED records

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
 tools/perf/util/session.c | 44 +++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ec..8454a65 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1958,8 +1958,8 @@ out_err:
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
@@ -2100,7 +2110,7 @@ remap:
 	}
 
 more:
-	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
