Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE2CC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F582186A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DAp0EWbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfHOJQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:16:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbfHOJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:16:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9GMYr2270342
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:16:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9GMYr2270342
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860583;
        bh=qgQwcS9vqN6A1JMDyfTrlZSBFQeKPquDL/x8bhkf67s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DAp0EWbGpB/Koi3PHlsDFJRtbPI22EluaRHClvqENR93qzBBldXchQi1tZWgtVvWT
         RmPSQTHju5eJ37s4FG5QGCDHUnOkkajq6miB9hnBxr7MWhTzWfVlN86WNZB8ZtNO5K
         JdOnmoORxGT7IoHVtJxpYQWv4oWVxHpTdakJ67xssoIQGTNFapbS/tRwPrNb6BEqkc
         hxo4vWG5z8Lc+US7m3X8hF/2MjhvSZjsKxG6gKWRQOfngVR7pWRUONPdPOipEk55HM
         yb7WlsiaERb5FagGvpCDJkiK9wakrZpTCeMTI7LSvNA9BOzzU/M78nwdGMeob+eniH
         Nqgzj5SojhROw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9GLYb2270335;
        Thu, 15 Aug 2019 02:16:21 -0700
Date:   Thu, 15 Aug 2019 02:16:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-57fc032ad643ffd018d66bd4c1bd3a91de4841e8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
        vincent.weaver@maine.edu, tglx@linutronix.de, peterz@infradead.org,
        alexander.shishkin@linux.intel.com
Reply-To: namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, vincent.weaver@maine.edu,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20190726211415.GE24867@kernel.org>
References: <20190726211415.GE24867@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Avoid infinite loop when seeing
 invalid header.size
Git-Commit-ID: 57fc032ad643ffd018d66bd4c1bd3a91de4841e8
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

Commit-ID:  57fc032ad643ffd018d66bd4c1bd3a91de4841e8
Gitweb:     https://git.kernel.org/tip/57fc032ad643ffd018d66bd4c1bd3a91de4841e8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Jul 2019 10:58:41 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf session: Avoid infinite loop when seeing invalid header.size

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
 
@@ -2072,6 +2078,9 @@ remap:
 
 more:
 	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
 	if (!event) {
 		if (mmaps[map_idx]) {
 			munmap(mmaps[map_idx], mmap_size);
