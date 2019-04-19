Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84422C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418A1204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698571;
	bh=RVlJHtQMgvYGyiPP9k6pNTsj2MUZISj+QsEgDPR4yI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fHhl0jePUzZU69AFYs2Zglj7EurUghz5wFgXUBNqmJvC/EUpfOz0AvD2I4ugDRJgw
	 7zq1ugLlV6UUrQ6giROljWwtebMpWHOH3Zm9f2Sn46SW8SSVAUFAAiY2qMF3Z2Jhsf
	 YFzV7s8LDCKhWrDkzfevhq7uOjLJrbY/M2H+jz94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfDSS3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbfDSS3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:18 -0400
Received: from quaco.ghostprotocols.net (unknown [177.102.80.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2B421A49;
        Fri, 19 Apr 2019 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677065;
        bh=RVlJHtQMgvYGyiPP9k6pNTsj2MUZISj+QsEgDPR4yI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xNeOnFaB04oIISzuiNl3gbwBsdTn0ZU+iBg6VoGf7FEYx4eF/rzydH+7OlGNDpYPT
         DyJLWrTOPDZimD5yNfBkrpFWZ7OGFHtqMY1TlsZ7tQO7Xq8EknukdT+VojamiHaBWd
         LujU5ZSXLmtJiJsSdYX5FdEoZ5Zt8mXAfjdK7pGo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/7] perf evlist: Fix side band thread draining
Date:   Fri, 19 Apr 2019 09:30:27 -0300
Message-Id: <20190419123029.11328-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Current perf_evlist__poll_thread() code could finish without draining
the data. Adding the logic that makes sure we won't finish before the
drain.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
Link: http://lkml.kernel.org/r/20190416160127.30203-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6689378ee577..51ead577533f 100644
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
2.20.1

