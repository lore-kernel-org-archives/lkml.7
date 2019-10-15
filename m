Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB75217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfJOFdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:33:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42262 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbfJOFcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRR-0000Y7-Fk; Tue, 15 Oct 2019 07:32:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1B77F1C04A9;
        Tue, 15 Oct 2019 07:31:53 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf env: Add routine to read the env->cpuid from
 the running machine
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-h2wb3sx7u7znx6lqfezrh7ca@git.kernel.org>
References: <tip-h2wb3sx7u7znx6lqfezrh7ca@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111751299.12254.13329361993141140643.tip-bot2@tip-bot2>
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

Commit-ID:     f1cedfb82858c8a7ec21e45d0ce7b6e2ce9edea0
Gitweb:        https://git.kernel.org/tip/f1cedfb82858c8a7ec21e45d0ce7b6e2ce9edea0
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Sep 2019 11:50:15 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf env: Add routine to read the env->cpuid from the running machine

In 'perf top' we use that cpuid when initializing the per arch
annotation init routines (e.g. x86__annotate_init()) and in that case
(live mode, 'perf top') we need to obtain it from the running machine,
not from a perf.data file header.

Provide a means to do that. Will be used by 'perf top' in a followup
patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h2wb3sx7u7znx6lqfezrh7ca@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 16 ++++++++++++++++
 tools/perf/util/env.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 3baca06..2a91a10 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -2,6 +2,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "env.h"
+#include "util/header.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 #include "bpf-event.h"
@@ -256,6 +257,21 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	return 0;
 }
 
+int perf_env__read_cpuid(struct perf_env *env)
+{
+	char cpuid[128];
+	int err = get_cpuid(cpuid, sizeof(cpuid));
+
+	if (err)
+		return err;
+
+	free(env->cpuid);
+	env->cpuid = strdup(cpuid);
+	if (env->cpuid == NULL)
+		return ENOMEM;
+	return 0;
+}
+
 static int perf_env__read_arch(struct perf_env *env)
 {
 	struct utsname uts;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index db40906..a3059dc 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -104,6 +104,7 @@ void perf_env__exit(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
+int perf_env__read_cpuid(struct perf_env *env);
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
