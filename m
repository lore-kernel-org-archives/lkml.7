Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F665C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC8521741
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430524;
	bh=GXH1QL8bpM4qk9zDWjDHVye66FOdFh1GtTwzoQ/eQfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRWE1G8/nDavKcxlSKvUpvmlNe0BB2Lpv7Oyb7B7gSiauOlRlhKTaVi6Tr/M0g85/
	 s/Dp3TKqSs9kjWul2UPa5L1xq9SmtE7TG4ItZLJMBBWwRfcUd6Yi5jRY3WzvWLT5Lf
	 NouA5S337iCoYrqKYcwcIESlSA3zhTmAVXWbI8mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfDPQCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:02:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfDPQCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:02:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8476D307E047;
        Tue, 16 Apr 2019 16:02:00 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E9945D71B;
        Tue, 16 Apr 2019 16:01:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 08/12] perf tools: Fix side band thread draining
Date:   Tue, 16 Apr 2019 18:01:23 +0200
Message-Id: <20190416160127.30203-9-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 16 Apr 2019 16:02:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current perf_evlist__poll_thread code could finish
without draining the data. Adding the logic that
makes sure we won't finish before the drain.

Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
Link: http://lkml.kernel.org/n/tip-41i888xyim9n5ceyr44jb468@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f2bbae38278d..4b6783ff5813 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1868,12 +1868,12 @@ static void *perf_evlist__poll_thread(void *arg)
 {
 	struct perf_evlist *evlist = arg;
 	bool draining = false;
-	int i;
+	int i, done = 0;
+
+	while (!done) {
+		bool got_data = false;
 
-	while (draining || !(evlist->thread.done)) {
-		if (draining)
-			draining = false;
-		else if (evlist->thread.done)
+		if (evlist->thread.done)
 			draining = true;
 
 		if (!draining)
@@ -1894,9 +1894,13 @@ static void *perf_evlist__poll_thread(void *arg)
 					pr_warning("cannot locate proper evsel for the side band event\n");
 
 				perf_mmap__consume(map);
+				got_data = true;
 			}
 			perf_mmap__read_done(map);
 		}
+
+		if (draining && !got_data)
+			break;
 	}
 	return NULL;
 }
-- 
2.17.2

