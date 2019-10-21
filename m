Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFC8CA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB720656
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfJVADq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:03:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfJVADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:03:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxT-0004G9-5V; Tue, 22 Oct 2019 01:19:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D596F1C0489;
        Tue, 22 Oct 2019 01:19:18 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:18 -0000
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf test: Avoid infinite loop for task exit case
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011091942.29841-2-leo.yan@linaro.org>
References: <20191011091942.29841-2-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <157169995839.29376.12083653777021293473.tip-bot2@tip-bot2>
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

Commit-ID:     791ce9c48c79210d2ffcdbe69421e7783b32921f
Gitweb:        https://git.kernel.org/tip/791ce9c48c79210d2ffcdbe69421e7783b32921f
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Fri, 11 Oct 2019 17:19:42 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 08:36:22 -03:00

perf test: Avoid infinite loop for task exit case

When executing the task exit testing case, perf gets stuck in an endless
loop this case and doesn't return back on Arm64 Juno board.

After digging into this issue, since Juno board has Arm's big.LITTLE
CPUs, thus the PMUs are not compatible between the big CPUs and little
CPUs.  This leads to a PMU event that cannot be enabled properly when
the traced task is migrated from one variant's CPU to another variant.
Finally, the test case runs into infinite loop for cannot read out any
event data after return from polling.

Eventually, we need to work out formal solution to allow PMU events can
be freely migrated from one CPU variant to another, but this is a
difficult task and a different topic.  This patch tries to fix the Perf
test case to avoid infinite loop, when the testing detects 1000 times
retrying for reading empty events, it will directly bail out and return
failure.  This allows the Perf tool can continue its other test cases.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191011091942.29841-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/task-exit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 19fa7cb..adaff90 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -54,6 +54,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
 	struct mmap *md;
+	int retry_count = 0;
 
 	signal(SIGCHLD, sig_handler);
 
@@ -133,6 +134,13 @@ retry:
 out_init:
 	if (!exited || !nr_exit) {
 		evlist__poll(evlist, -1);
+
+		if (retry_count++ > 1000) {
+			pr_debug("Failed after retrying 1000 times\n");
+			err = -1;
+			goto out_free_maps;
+		}
+
 		goto retry;
 	}
 
