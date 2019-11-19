Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75796C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BA0208D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfKSQ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:58:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfKSQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oE-0007Uj-RQ; Tue, 19 Nov 2019 17:56:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21D851C19D8;
        Tue, 19 Nov 2019 17:56:50 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: No need to process the synthesized MMAP
 events twice
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-mofoxvcx2dryppcw3o689jdd@git.kernel.org>
References: <tip-mofoxvcx2dryppcw3o689jdd@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157418261005.12247.14540142455238150040.tip-bot2@tip-bot2>
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

Commit-ID:     6e0a9b3dfaaf93476b34825e53c4ec065267081e
Gitweb:        https://git.kernel.org/tip/6e0a9b3dfaaf93476b34825e53c4ec065267081e
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 14 Nov 2019 12:15:34 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 11:21:32 -03:00

perf record: No need to process the synthesized MMAP events twice

At the end of a 'perf record' session, by default, we'll process all
samples and populate the threads, maps, etc so as to find out which of
the DSOs got samples, to reduce the size of the build-id table we'll
add to the perf.data headers.

But we don't need to process the PERF_RECORD_MMAP events synthesized
for the kernel modules, as we have those already via
perf_session__create_kernel_maps(), so add mmap/mmap2 handlers that
first look at event->header.misc to see if the event is for a user map,
bailing out if not.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mofoxvcx2dryppcw3o689jdd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b95c000..7ab3110 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2148,6 +2148,31 @@ static const char * const __record_usage[] = {
 };
 const char * const *record_usage = __record_usage;
 
+static int build_id__process_mmap(struct perf_tool *tool, union perf_event *event,
+				  struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+	return perf_event__process_mmap(tool, event, sample, machine);
+}
+
+static int build_id__process_mmap2(struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+
+	return perf_event__process_mmap2(tool, event, sample, machine);
+}
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -2177,8 +2202,8 @@ static struct record record = {
 		.exit		= perf_event__process_exit,
 		.comm		= perf_event__process_comm,
 		.namespaces	= perf_event__process_namespaces,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
+		.mmap		= build_id__process_mmap,
+		.mmap2		= build_id__process_mmap2,
 		.ordered_events	= true,
 	},
 };
