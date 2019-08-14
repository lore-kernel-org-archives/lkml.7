Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEEEC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482102173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808124;
	bh=KW6gTRnZj9jpNELCDHkaD5uUry5F6Ts7t6FIAvH3aIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNmJlXgu0cHvYlDlUl/c5dBqLvxjPNlJ3peDwDuSiO2gBiQQgdjzH3u0o4WptDGSM
	 hze35WUfz2KlC2aNHBD4zvXVD8eZyKvEA9wvIcCLilTCaepJvzKFM1I7i9svCp7LOP
	 oottDPUqbLChw783jBrFRLFX/lHHk2Q9j2WtK5Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHNSmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNSmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:42:02 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9762064A;
        Wed, 14 Aug 2019 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808122;
        bh=KW6gTRnZj9jpNELCDHkaD5uUry5F6Ts7t6FIAvH3aIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAPBDjoptFqFkJO61VqBRCQS5hGVVYY4iQzDsykiBNrH7ocJjEuDeowf9iygGvthT
         oZ0H4z35Q+GSniijrzsPVpURIdHAiAxV9wqfcuEo6IQSoa4csIwZCwk1azUFMWDNoD
         MfsIo3HuwDtQ0m+Dc5UvLsW45ZDNxdO1YG+F6pGs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/28] perf session: Avoid infinite loop when seeing invalid header.size
Date:   Wed, 14 Aug 2019 15:40:24 -0300
Message-Id: <20190814184051.3125-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Vince reported that when fuzzing the userland perf tool with a bogus
perf.data file he got into a infinite loop in 'perf report'.

Changing the return of fetch_mmaped_event() to ERR_PTR(-EINVAL) for that
case gets us out of that infinite loop.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726211415.GE24867@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 11e6093c941b..b9fe71d11bf6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <traceevent/event-parse.h>
@@ -1955,7 +1956,9 @@ fetch_mmaped_event(struct perf_session *session,
 		/* We're not fetching the event so swap back again */
 		if (session->header.needs_swap)
 			perf_event_header__bswap(&event->header);
-		return NULL;
+		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
+			 __func__, head, event->header.size, mmap_size);
+		return ERR_PTR(-EINVAL);
 	}
 
 	return event;
@@ -1973,6 +1976,9 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	while (decomp->head < decomp->size && !session_done()) {
 		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
 
+		if (IS_ERR(event))
+			return PTR_ERR(event);
+
 		if (!event)
 			break;
 
@@ -2072,6 +2078,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 more:
 	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
 	if (!event) {
 		if (mmaps[map_idx]) {
 			munmap(mmaps[map_idx], mmap_size);
-- 
2.21.0

