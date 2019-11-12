Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA41CC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7D02246F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKLLSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfKLLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBi-0000jR-Ge; Tue, 12 Nov 2019 12:18:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 46FD71C04CB;
        Tue, 12 Nov 2019 12:18:16 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:15 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Always preserve errno while cleaning up
 perf_event_open failures
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191020175202.32456-2-andi@firstfloor.org>
References: <20191020175202.32456-2-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157355749593.29376.11413893527155626939.tip-bot2@tip-bot2>
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

Commit-ID:     796c01a4bfb4b35ec6d1bd1cd5d520515d078b51
Gitweb:        https://git.kernel.org/tip/796c01a4bfb4b35ec6d1bd1cd5d520515d078b51
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Sun, 20 Oct 2019 10:51:54 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf evsel: Always preserve errno while cleaning up perf_event_open failures

In some cases when perf_event_open fails, it may do some closes to clean
up. In special cases these closes can fail too, which overwrites the
errno of the perf_event_open, which is then incorrectly reported.

Save/restore errno around closes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191020175202.32456-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda..d831038 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1574,7 +1574,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
-	int pid = -1, err;
+	int pid = -1, err, old_errno;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
 	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
@@ -1727,8 +1727,8 @@ try_fallback:
 	 */
 	if (err == -EMFILE && set_rlimit < INCREASED_MAX) {
 		struct rlimit l;
-		int old_errno = errno;
 
+		old_errno = errno;
 		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
 			if (set_rlimit == NO_CHANGE)
 				l.rlim_cur = l.rlim_max;
@@ -1812,6 +1812,7 @@ out_close:
 	if (err)
 		threads->err_thread = thread;
 
+	old_errno = errno;
 	do {
 		while (--thread >= 0) {
 			close(FD(evsel, cpu, thread));
@@ -1819,6 +1820,7 @@ out_close:
 		}
 		thread = nthreads;
 	} while (--cpu >= 0);
+	errno = old_errno;
 	return err;
 }
 
