Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8768A22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfKLLSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfKLLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBh-0000iE-T2; Tue, 12 Nov 2019 12:18:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D5DAA1C04E4;
        Tue, 12 Nov 2019 12:18:15 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:15 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Avoid close(-1)
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191020175202.32456-3-andi@firstfloor.org>
References: <20191020175202.32456-3-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157355749550.29376.6682935779950651002.tip-bot2@tip-bot2>
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

Commit-ID:     2ccfb8bc2143ca347609d1d4434176d73a78d805
Gitweb:        https://git.kernel.org/tip/2ccfb8bc2143ca347609d1d4434176d73a78d805
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Sun, 20 Oct 2019 10:51:55 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf evsel: Avoid close(-1)

In some weak fallback cases close can be called a lot with -1. Check for
this case and avoid calling close then.

This is mainly to shut up valgrind which complains about this case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191020175202.32456-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c  | 3 ++-
 tools/perf/util/evsel.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index a8cb582..5a89857 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -120,7 +120,8 @@ void perf_evsel__close_fd(struct perf_evsel *evsel)
 
 	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d831038..d445184 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1815,7 +1815,8 @@ out_close:
 	old_errno = errno;
 	do {
 		while (--thread >= 0) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 		thread = nthreads;
