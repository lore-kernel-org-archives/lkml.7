Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F061321A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928424;
	bh=PXIholq/CCyjyrIDXTT3uoEBRYe2YtbU/Dd4vPEq5QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVNsv4DVlTkQBHurFOePzCZXf38TzVYZvMMgazjaUsbazZnG1DsHUoamuImZs24yY
	 r+w6Q3rSLac6hqumZO0aLabm0Wnw2L9w729R0jG7b+EEoP/GISsFAnUCkC/+y3tvHC
	 FQujYAeAFBYENTjr5RXiAhJs57KVg9qIDQmILw3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfJALNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731944AbfJALNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:41 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4958321920;
        Tue,  1 Oct 2019 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928420;
        bh=PXIholq/CCyjyrIDXTT3uoEBRYe2YtbU/Dd4vPEq5QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZKI7an5VYZ+ZPGbyHgo7LepTkkvPmruQz4Jd66nIwNdCoQWVODyddwsCALm8h5bM
         7pJJeTGae0mYRixGw7hUqDrGLrs6rEoYpVQKXylTZQRNoPBs/iZrZf5cZRSwEoi1/y
         e/v2tCZafeE6daRo6MGXNgtITaDtvrmT6B1BzMTE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/24] perf tools: Propagate get_cpuid() error
Date:   Tue,  1 Oct 2019 08:12:09 -0300
Message-Id: <20191001111216.7208-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For consistency, propagate the exact cause for get_cpuid() to have
failed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9ig269f7ktnhh99g4l15vpu2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/header.c | 3 ++-
 tools/perf/arch/s390/util/header.c    | 9 +++++----
 tools/perf/arch/x86/util/header.c     | 3 ++-
 tools/perf/builtin-kvm.c              | 7 ++++---
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index b6b7bc7e31a1..3b4cdfc5efd6 100644
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
index 8b0b018d896a..7933f6871c81 100644
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
@@ -133,14 +134,14 @@ int get_cpuid(char *buffer, size_t sz)
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
index 662ecf84a421..aa6deb463bf3 100644
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
index 2227e2f42c09..58a9e0989491 100644
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
-- 
2.21.0

