Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4887ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40902084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfJGOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44241 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJGOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK8-0005vQ-Kt; Mon, 07 Oct 2019 16:49:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 407D01C0895;
        Mon,  7 Oct 2019 16:49:15 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:15 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Propagate get_cpuid() error
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-9ig269f7ktnhh99g4l15vpu2@git.kernel.org>
References: <tip-9ig269f7ktnhh99g4l15vpu2@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975520.9978.15325095538088547649.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f67001a4a08eb124197ed4376941e1da9cf94b42
Gitweb:        https://git.kernel.org/tip/f67001a4a08eb124197ed4376941e1da9cf94b42
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Sep 2019 10:55:34 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:54 -03:00

perf tools: Propagate get_cpuid() error

For consistency, propagate the exact cause for get_cpuid() to have
failed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9ig269f7ktnhh99g4l15vpu2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/header.c |  3 ++-
 tools/perf/arch/s390/util/header.c    |  9 +++++----
 tools/perf/arch/x86/util/header.c     |  3 ++-
 tools/perf/builtin-kvm.c              |  7 ++++---
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index b6b7bc7..3b4cdfc 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/types.h>
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -30,7 +31,7 @@ get_cpuid(char *buffer, size_t sz)
 		buffer[nb-1] = '\0';
 		return 0;
 	}
-	return -1;
+	return ENOBUFS;
 }
 
 char *
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 8b0b018..7933f68 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -8,6 +8,7 @@
  */
 
 #include <sys/types.h>
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
@@ -54,7 +55,7 @@ int get_cpuid(char *buffer, size_t sz)
 
 	sysinfo = fopen(SYSINFO, "r");
 	if (sysinfo == NULL)
-		return -1;
+		return errno;
 
 	while ((read = getline(&line, &line_sz, sysinfo)) != -1) {
 		if (!strncmp(line, SYSINFO_MANU, strlen(SYSINFO_MANU))) {
@@ -89,7 +90,7 @@ int get_cpuid(char *buffer, size_t sz)
 
 	/* Missing manufacturer, type or model information should not happen */
 	if (!manufacturer[0] || !type[0] || !model[0])
-		return -1;
+		return EINVAL;
 
 	/*
 	 * Scan /proc/service_levels and return the CPU-MF counter facility
@@ -133,14 +134,14 @@ skip_sysinfo:
 	else
 		nbytes = snprintf(buffer, sz, "%s,%s,%s", manufacturer, type,
 				  model);
-	return (nbytes >= sz) ? -1 : 0;
+	return (nbytes >= sz) ? ENOBUFS : 0;
 }
 
 char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *buf = malloc(128);
 
-	if (buf && get_cpuid(buf, 128) < 0)
+	if (buf && get_cpuid(buf, 128))
 		zfree(&buf);
 	return buf;
 }
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 662ecf8..aa6deb4 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/types.h>
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -58,7 +59,7 @@ __get_cpuid(char *buffer, size_t sz, const char *fmt)
 		buffer[nb-1] = '\0';
 		return 0;
 	}
-	return -1;
+	return ENOBUFS;
 }
 
 int
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 2227e2f..58a9e09 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -705,14 +705,15 @@ static int process_sample_event(struct perf_tool *tool,
 
 static int cpu_isa_config(struct perf_kvm_stat *kvm)
 {
-	char buf[64], *cpuid;
+	char buf[128], *cpuid;
 	int err;
 
 	if (kvm->live) {
 		err = get_cpuid(buf, sizeof(buf));
 		if (err != 0) {
-			pr_err("Failed to look up CPU type\n");
-			return err;
+			pr_err("Failed to look up CPU type: %s\n",
+			       str_error_r(err, buf, sizeof(buf)));
+			return -err;
 		}
 		cpuid = buf;
 	} else
