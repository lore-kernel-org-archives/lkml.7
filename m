Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D894C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B22721927
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfJOFb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:31:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfJOFbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQt-0008So-0A; Tue, 15 Oct 2019 07:31:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ACD461C0105;
        Tue, 15 Oct 2019 07:31:37 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:37 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Introduce perf_evlist__mmap_cb_idx()
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-19-jolsa@kernel.org>
References: <20191007125344.14268-19-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749758.12254.13508063095488271406.tip-bot2@tip-bot2>
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

Commit-ID:     9abd2ab2377613425e1c362694f85b110f5bace2
Gitweb:        https://git.kernel.org/tip/9abd2ab2377613425e1c362694f85b110f5bace2
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:26 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:23:52 -03:00

perf tools: Introduce perf_evlist__mmap_cb_idx()

Add perf_evlist__mmap_cb_idx function to call auxtrace_mmap_params__set_idx()
on each new index during perf_evlist__mmap_ops call.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a9b189a..11716f2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -739,6 +739,17 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 	return 0;
 }
 
+static void
+perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
+			 struct perf_mmap_param *_mp,
+			 int idx, bool per_cpu)
+{
+	struct evlist *evlist = container_of(_evlist, struct evlist, core);
+	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
+
+	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
+}
+
 static int evlist__mmap_per_cpu(struct evlist *evlist,
 				     struct mmap_params *mp)
 {
@@ -935,6 +946,9 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 		.flush		= flush,
 		.comp_level	= comp_level
 	};
+	struct perf_evlist_mmap_ops ops __maybe_unused = {
+		.idx = perf_evlist__mmap_cb_idx,
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = evlist__alloc_mmap(evlist, false);
