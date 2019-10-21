Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47122166E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfJVAFJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387534AbfJVAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgx6-0003yk-AN; Tue, 22 Oct 2019 01:19:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE7061C0086;
        Tue, 22 Oct 2019 01:18:58 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:58 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Honour --max-events in processing
 syscalls:sys_enter_*
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-0ob1dky1a9ijlfrfhxyl40wr@git.kernel.org>
References: <tip-0ob1dky1a9ijlfrfhxyl40wr@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169993806.29376.8362318761084030080.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     db25bf98a3861225bc0b2138cf665097141c72ee
Gitweb:        https://git.kernel.org/tip/db25bf98a3861225bc0b2138cf665097141c72ee
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 18 Oct 2019 11:48:57 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 18 Oct 2019 12:19:02 -03:00

perf trace: Honour --max-events in processing syscalls:sys_enter_*

We were doing this only at the sys_exit syscall tracepoint, as for
strace-like we count the pair of sys_enter and sys_exit as one event,
but when asking specifically for a the syscalls:sys_enter_NAME
tracepoint we need to count each of those as an event.

I.e. things like:

  # perf trace --max-events=4 -e syscalls:sys_enter_lseek
     0.000 pool/2242 syscalls:sys_enter_lseek(fd: 14<anon_inode:[timerfd]>, offset: 0, whence: CUR)
     0.034 pool/2242 syscalls:sys_enter_lseek(fd: 15<anon_inode:[timerfd]>, offset: 0, whence: CUR)
     0.051 pool/2242 syscalls:sys_enter_lseek(fd: 16<anon_inode:[timerfd]>, offset: 0, whence: CUR)
  2307.900 sshd/30800 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libsystemd.so.0.25.0>, offset: 9032, whence: SET)
  #

Were going on forever, since we only had sys_enter events.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0ob1dky1a9ijlfrfhxyl40wr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0294b17..1aaf7b2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2727,12 +2727,6 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 			} else {
 				trace__fprintf_tp_fields(trace, evsel, sample, thread, NULL, 0);
 			}
-			++trace->nr_events_printed;
-
-			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
-				evsel__disable(evsel);
-				evsel__close(evsel);
-			}
 		}
 	}
 
@@ -2743,6 +2737,13 @@ newline:
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+
+	++trace->nr_events_printed;
+
+	if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
+		evsel__disable(evsel);
+		evsel__close(evsel);
+	}
 out:
 	thread__put(thread);
 	return 0;
