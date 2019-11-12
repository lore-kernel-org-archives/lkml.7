Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ED9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0073E22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfKLLWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:22:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33561 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfKLLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBO-0000Mq-89; Tue, 12 Nov 2019 12:18:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 146A21C04C9;
        Tue, 12 Nov 2019 12:17:59 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:58 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf inject: Make --strip keep evsels
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191105100057.21465-1-adrian.hunter@intel.com>
References: <20191105100057.21465-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355747868.29376.8267731943513542020.tip-bot2@tip-bot2>
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

Commit-ID:     ef5502a1d9bd042dcf457378a6ac96701e498b1b
Gitweb:        https://git.kernel.org/tip/ef5502a1d9bd042dcf457378a6ac96701e498b1b
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 05 Nov 2019 12:00:57 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:49:40 -03:00

perf inject: Make --strip keep evsels

create_gcov (refer to the autofdo example in tools/perf/Documentation/intel-pt.txt)
now needs the evsels to read the perf.data file. So don't strip them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191105100057.21465-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 54 +------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3..1e5d283 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -578,58 +578,6 @@ static void strip_init(struct perf_inject *inject)
 		evsel->handler = drop_sample;
 }
 
-static bool has_tracking(struct evsel *evsel)
-{
-	return evsel->core.attr.mmap || evsel->core.attr.mmap2 || evsel->core.attr.comm ||
-	       evsel->core.attr.task;
-}
-
-#define COMPAT_MASK (PERF_SAMPLE_ID | PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
-		     PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
-
-/*
- * In order that the perf.data file is parsable, tracking events like MMAP need
- * their selected event to exist, except if there is only 1 selected event left
- * and it has a compatible sample type.
- */
-static bool ok_to_remove(struct evlist *evlist,
-			 struct evsel *evsel_to_remove)
-{
-	struct evsel *evsel;
-	int cnt = 0;
-	bool ok = false;
-
-	if (!has_tracking(evsel_to_remove))
-		return true;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->handler != drop_sample) {
-			cnt += 1;
-			if ((evsel->core.attr.sample_type & COMPAT_MASK) ==
-			    (evsel_to_remove->core.attr.sample_type & COMPAT_MASK))
-				ok = true;
-		}
-	}
-
-	return ok && cnt == 1;
-}
-
-static void strip_fini(struct perf_inject *inject)
-{
-	struct evlist *evlist = inject->session->evlist;
-	struct evsel *evsel, *tmp;
-
-	/* Remove non-synthesized evsels if possible */
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel->handler == drop_sample &&
-		    ok_to_remove(evlist, evsel)) {
-			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			evlist__remove(evlist, evsel);
-			evsel__delete(evsel);
-		}
-	}
-}
-
 static int __cmd_inject(struct perf_inject *inject)
 {
 	int ret = -EINVAL;
@@ -729,8 +677,6 @@ static int __cmd_inject(struct perf_inject *inject)
 				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
-			if (inject->strip)
-				strip_fini(inject);
 		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
