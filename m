Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D70C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B8A21A49
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfJOFbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:31:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfJOFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQm-0008SG-W9; Tue, 15 Oct 2019 07:31:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 78AC71C0105;
        Tue, 15 Oct 2019 07:31:36 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:36 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Centralize map refcnt setting
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-23-jolsa@kernel.org>
References: <20191007125344.14268-23-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749642.12254.5807565002595821879.tip-bot2@tip-bot2>
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

Commit-ID:     285aaeac8c5d537b56b70169e21ac29ae5caa8e1
Gitweb:        https://git.kernel.org/tip/285aaeac8c5d537b56b70169e21ac29ae5caa8e1
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:30 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:52:41 -03:00

libperf: Centralize map refcnt setting

Currently when a new map is mmapped we set its refcnt to 2 in the
perf_evlist_mmap_ops::mmap callback.

Every mmap gets its refcnt set to 2 when it's first mmaped:

  - 1 for the current user, which will be taken out by a call to
    perf_evlist__munmap_filtered(), where we find out there's
    no more data comming from kernel to this mmap.

  - 1 for the drain code where in perf_mmap__consume() the mmap
    is released if it is empty.

Move this common setup into libperf's generic code before the mmap
callback is called.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-23-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c | 30 +++++++++++++++---------------
 tools/perf/util/mmap.c  | 15 ---------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index b697226..f9a802d 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -362,21 +362,6 @@ static int
 perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 			  int output, int cpu)
 {
-	/*
-	 * The last one will be done at perf_mmap__consume(), so that we
-	 * make sure we don't prevent tools from consuming every last event in
-	 * the ring buffer.
-	 *
-	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
-	 * anymore, but the last events for it are still in the ring buffer,
-	 * waiting to be consumed.
-	 *
-	 * Tools can chose to ignore this at their own discretion, but the
-	 * evlist layer can't just drop it when filtering events in
-	 * perf_evlist__filter_pollfd().
-	 */
-	refcount_set(&map->refcnt, 2);
-
 	return perf_mmap__mmap(map, mp, output, cpu);
 }
 
@@ -418,6 +403,21 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (*output == -1) {
 			*output = fd;
 
+			/*
+			 * The last one will be done at perf_mmap__consume(), so that we
+			 * make sure we don't prevent tools from consuming every last event in
+			 * the ring buffer.
+			 *
+			 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
+			 * anymore, but the last events for it are still in the ring buffer,
+			 * waiting to be consumed.
+			 *
+			 * Tools can chose to ignore this at their own discretion, but the
+			 * evlist layer can't just drop it when filtering events in
+			 * perf_evlist__filter_pollfd().
+			 */
+			refcount_set(&map->refcnt, 2);
+
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2a8bf0a..063d1b9 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -243,21 +243,6 @@ static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params 
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
-	/*
-	 * The last one will be done at perf_mmap__consume(), so that we
-	 * make sure we don't prevent tools from consuming every last event in
-	 * the ring buffer.
-	 *
-	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
-	 * anymore, but the last events for it are still in the ring buffer,
-	 * waiting to be consumed.
-	 *
-	 * Tools can chose to ignore this at their own discretion, but the
-	 * evlist layer can't just drop it when filtering events in
-	 * perf_evlist__filter_pollfd().
-	 */
-	refcount_set(&map->core.refcnt, 2);
-
 	if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
 			  errno);
