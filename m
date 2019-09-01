Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C795C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3523711
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340652;
	bh=I+og5Fn2jlxt5UAvdLFh4/aV6JdewF+SdElhT24+X4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FlI4ITNNg0E84GcQVuL42L6i459L5qy6XN51NERq4+tLEqSThuvl24Ep7s/DYNHzg
	 KbrLUtcL7Y6zVNrNYxC69Qv4Nov+KMXdY251y4mhUI7ry1bG9RHyZElkdfS99yy88f
	 2DrUupkx6VzVHtRPjitOWY7mfJ5oTxApX7rdRfzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfIAMYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbfIAMYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CA321897;
        Sun,  1 Sep 2019 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340648;
        bh=I+og5Fn2jlxt5UAvdLFh4/aV6JdewF+SdElhT24+X4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyeIzmo9xUGA4Kx2q2s3pA92QVcZ449iEsXyaQGaoJH+Y0cFI1uW5U2bAAbbqfBgA
         zKt1d8KXjqDDKs7aZ/xjSFiStsWLUhdHZL5k0n0W6/5tq88oph6gsHMg5EFQJLkb+6
         ekDPRsZdcbFGNuR+pPj5Rt2rO9L0YiaxXI4bNpD8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/47] perf header: Move CPUINFO_PROC to the only file where it is used
Date:   Sun,  1 Sep 2019 09:22:49 -0300
Message-Id: <20190901122326.5793-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce perf-sys.h and eventually nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ars2j5m3if3gypsvkbbijucq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-sys.h    | 44 ----------------------------------------
 tools/perf/util/header.c | 18 ++++++++++++++++
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 3eb7a39169f6..6ffb0fbd6237 100644
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
index dd2bb0861ab1..d252124f926d 100644
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
-- 
2.21.0

