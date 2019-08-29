Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B23C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3072341B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089613;
	bh=OTvQ2FxwJL4hx3T2GOw3OBIbtwM396Z3zLvEGLq1fvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sX67ZxGkvvgMKStW1DWjnfIu4II3ehmx5eXj6szGsrZTlEY+4wvszX44wfi0bv2xa
	 pqZxH+fJPxyt+iHTxQOTgh6TQjm0X4AAnVNEm7uFu9yS22CFwZtfNMd3z1OC07EAMq
	 ypvPkQnX4dWwqWVdF9e3WIT363YDOMbBj/GtHaXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfH2OkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbfH2OkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7A622CED;
        Thu, 29 Aug 2019 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089607;
        bh=OTvQ2FxwJL4hx3T2GOw3OBIbtwM396Z3zLvEGLq1fvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gF2Z7gID4M21OaIlDVhuSDKY+3i/cOuwxRKpiAgFRX/xyotnTlgRG1tVjWzh/ic3
         +s0U1iDZxRyYS08UkDphKbcLFxr4lGPAe8l4iz/Sj3hGdKZvm42nePobreE+bKpM++
         O5xpHWZb8QlXnKPvgXZR4i7675TLP2zVVxqlqJNY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/37] perf evlist: Remove needless util.h from evlist.h
Date:   Thu, 29 Aug 2019 11:38:48 -0300
Message-Id: <20190829143917.29745-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There is no need for that util/util.h include there and, remove it,
pruning the include tree, fix the fallout by adding necessary headers to
places that were getting needed includes indirectly from evlist.h ->
util.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-s9f7uve8wvykr5itcm7m7d8q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-bts.c | 1 +
 tools/perf/arch/x86/util/intel-pt.c  | 1 +
 tools/perf/builtin-report.c          | 1 +
 tools/perf/builtin-script.c          | 1 +
 tools/perf/builtin-top.c             | 1 +
 tools/perf/builtin-trace.c           | 1 +
 tools/perf/tests/sdt.c               | 1 +
 tools/perf/util/auxtrace.c           | 1 +
 tools/perf/util/evlist.c             | 1 +
 tools/perf/util/evlist.h             | 1 -
 tools/perf/util/evsel.c              | 1 +
 tools/perf/util/header.c             | 1 +
 tools/perf/util/session.c            | 1 +
 13 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 16d26ea701ad..e4bb5df9b731 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -22,6 +22,7 @@
 #include "../../util/tsc.h"
 #include "../../util/auxtrace.h"
 #include "../../util/intel-bts.h"
+#include "../../util/util.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 746981c82a16..04b424ad4d99 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -26,6 +26,7 @@
 #include "../../util/record.h"
 #include "../../util/target.h"
 #include "../../util/tsc.h"
+#include "../../util/util.h"
 #include "../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 318b0b95c14c..0338916af4bf 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -44,6 +44,7 @@
 #include "util/auxtrace.h"
 #include "util/units.h"
 #include "util/branch.h"
+#include "util/util.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 51e7e6d0eee6..e005be0d359f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -52,6 +52,7 @@
 #include <subcmd/pager.h>
 #include <perf/evlist.h>
 #include "util/record.h"
+#include "util/util.h"
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 29e910fb2d9a..42ba733c9045 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -34,6 +34,7 @@
 #include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/top.h"
+#include "util/util.h"
 #include <linux/rbtree.h>
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 58a75dd3a571..6d9805a8791b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -41,6 +41,7 @@
 #include "util/intlist.h"
 #include "util/thread_map.h"
 #include "util/stat.h"
+#include "util/util.h"
 #include "trace/beauty/beauty.h"
 #include "trace-event.h"
 #include "util/parse-events.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 8bfaa630389c..dbc35a8912ed 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -9,6 +9,7 @@
 #include "debug.h"
 #include "probe-file.h"
 #include "build-id.h"
+#include "util.h"
 
 /* To test SDT event, we need libelf support to scan elf binary */
 #if defined(HAVE_SDT_EVENT) && defined(HAVE_LIBELF_SUPPORT)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 12e9b7acbb2c..112c24aa2cf2 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -50,6 +50,7 @@
 #include "intel-bts.h"
 #include "arm-spe.h"
 #include "s390-cpumsf.h"
+#include "util.h"
 
 #include <linux/ctype.h>
 #include "symbol/kallsyms.h"
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47bc54111f57..5ad92fa72e78 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -16,6 +16,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "units.h"
+#include "util.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <signal.h>
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e31ddcc058f2..16796de7af3f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -13,7 +13,6 @@
 #include "event.h"
 #include "evsel.h"
 #include "mmap.h"
-#include "util.h"
 #include <signal.h>
 #include <unistd.h>
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d4540bfe4574..dbc04e1053a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -40,6 +40,7 @@
 #include "stat.h"
 #include "string2.h"
 #include "memswap.h"
+#include "util.h"
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1f2965a07bef..8e67faf4fe88 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -42,6 +42,7 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
+#include "util.h"
 #include "cputopo.h"
 #include "bpf-event.h"
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5786e9c807c5..a275f2e15b94 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
+#include "util.h"
 #include "arch/common.h"
 
 #ifdef HAVE_ZSTD_SUPPORT
-- 
2.21.0

