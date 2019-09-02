Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7459C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CC7215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfIBIQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfIBIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVj-00080R-Bk; Mon, 02 Sep 2019 10:16:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E7EF61C0DE7;
        Mon,  2 Sep 2019 10:16:26 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:26 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf header: Move CPUINFO_PROC to the only file
 where it is used
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-ars2j5m3if3gypsvkbbijucq@git.kernel.org>
References: <tip-ars2j5m3if3gypsvkbbijucq@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741218675.17293.4112902995246071094.tip-bot2@tip-bot2>
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

Commit-ID:     a77494026309711a5f1e4b078e353cd46c2dad9f
Gitweb:        https://git.kernel.org/tip/a77494026309711a5f1e4b078e353cd46c2dad9f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 14:40:28 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf header: Move CPUINFO_PROC to the only file where it is used

To reduce perf-sys.h and eventually nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ars2j5m3if3gypsvkbbijucq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-sys.h    | 44 +---------------------------------------
 tools/perf/util/header.c | 18 ++++++++++++++++-
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 3eb7a39..6ffb0fb 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -10,50 +10,6 @@
 #include <linux/perf_event.h>
 #include <asm/barrier.h>
 
-#ifdef __powerpc__
-#define CPUINFO_PROC	{"cpu"}
-#endif
-
-#ifdef __s390__
-#define CPUINFO_PROC	{"vendor_id"}
-#endif
-
-#ifdef __sh__
-#define CPUINFO_PROC	{"cpu type"}
-#endif
-
-#ifdef __hppa__
-#define CPUINFO_PROC	{"cpu"}
-#endif
-
-#ifdef __sparc__
-#define CPUINFO_PROC	{"cpu"}
-#endif
-
-#ifdef __alpha__
-#define CPUINFO_PROC	{"cpu model"}
-#endif
-
-#ifdef __arm__
-#define CPUINFO_PROC	{"model name", "Processor"}
-#endif
-
-#ifdef __mips__
-#define CPUINFO_PROC	{"cpu model"}
-#endif
-
-#ifdef __arc__
-#define CPUINFO_PROC	{"Processor"}
-#endif
-
-#ifdef __xtensa__
-#define CPUINFO_PROC	{"core ID"}
-#endif
-
-#ifndef CPUINFO_PROC
-#define CPUINFO_PROC	{ "model name", }
-#endif
-
 static inline int
 sys_perf_event_open(struct perf_event_attr *attr,
 		      pid_t pid, int cpu, int group_fd,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dd2bb08..d252124 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -436,7 +436,25 @@ static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 static int write_cpudesc(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
+#if defined(__powerpc__) || defined(__hppa__) || defined(__sparc__)
+#define CPUINFO_PROC	{ "cpu", }
+#elif defined(__s390__)
+#define CPUINFO_PROC	{ "vendor_id", }
+#elif defined(__sh__)
+#define CPUINFO_PROC	{ "cpu type", }
+#elif defined(__alpha__) || defined(__mips__)
+#define CPUINFO_PROC	{ "cpu model", }
+#elif defined(__arm__)
+#define CPUINFO_PROC	{ "model name", "Processor", }
+#elif defined(__arc__)
+#define CPUINFO_PROC	{ "Processor", }
+#elif defined(__xtensa__)
+#define CPUINFO_PROC	{ "core ID", }
+#else
+#define CPUINFO_PROC	{ "model name", }
+#endif
 	const char *cpuinfo_procs[] = CPUINFO_PROC;
+#undef CPUINFO_PROC
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(cpuinfo_procs); i++) {
