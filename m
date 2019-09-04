Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CCFC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DEC23402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFD/Q00y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbfIDSD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:03:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34043 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733108AbfIDSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:03:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id gn3so1925210plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oFDPWtnZcsIRjip++nuzfzUjSSOG2uoVNeoKW0tuWlk=;
        b=TFD/Q00yhlymHtyNkru4xJubi1H6gp/8m151NUWP31flDleLm0aTqRmOkUMy/b4CnB
         wFVrr+tXekvLfmvq9FrAsyj4Wxjsez3oJ1+BOy8iXdSWRg1zBKpVktmApQEFgV2ukhwP
         /JPe5fh1f/JP4swWAY5X/FARqtx4hc6HE0bxKIwQiDfwqpnNy5o/+yHn5JQFSEkAAdPD
         TcY3S73Qqok9GA8/XYUekqKe/IC8kAhDBeRLZZB/Niutc8sB+dVYRPFXLffs24SzomnN
         ag51kkQ9eEIHhLoirU7RCmnIOEhCl1opI79UyTNNPTS7dWf/k8p+KXFkFm28ykjLdx1F
         X9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oFDPWtnZcsIRjip++nuzfzUjSSOG2uoVNeoKW0tuWlk=;
        b=p52vjzbSHK+WSigqC45zQRsY20r06LZL9JWr/tby7WcpNmsba2N36tS1FOUp+cqNjG
         abVq+B597WWgEgmsOHaPpjCy1jZ797HsIUrthSU8npdAkZ3Yt7ZtncQdVmeyFElazHPw
         fBHrU3CdsQIBSFC3quCm2LltH5QcZL2BOkQBCR7c7P8LTWHCjEQFFb5LPIY4Wkp+gbgl
         zlc4GUAq3khuqL0eQDA8zNxdbxIk3WT0G1uKC717d6oyqXnrc8CvirbbnAVWHcL44RXO
         tht47lfCLVk6Xt05RVfHzzFmJTnfV0bHeMGUFSmrGxMcO9vkc8KUlCiUjlzOlneQc1M+
         lLGw==
X-Gm-Message-State: APjAAAXbV9yx6CwedmCx9kXNv3khNoNq+OUfejA5RUG3yB1nAjt+GoLc
        pLa4KaQmkDDoCxb8UhH/WTuZX10b8Pdm
X-Google-Smtp-Source: APXvYqy5hsfdCLrqd118LcLYJwChyjlmLHywSu6yp3nxvBcM+SLNaVvc4nEFN5xZvHKYYYla2obIbYVrvs/d
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr35328482pgn.182.1567620204023;
 Wed, 04 Sep 2019 11:03:24 -0700 (PDT)
Date:   Wed,  4 Sep 2019 11:03:16 -0700
Message-Id: <20190904180316.139952-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] perf tools: Fix paths in include statements
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These paths point to the wrong location but still work because
they get picked up by a -I flag that happens to direct to the correct
file. Fix paths to lead to the actual file location without help from
include flags.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/perf_regs.c |  4 ++--
 tools/perf/arch/x86/util/auxtrace.c      | 14 ++++++------
 tools/perf/arch/x86/util/header.c        |  4 ++--
 tools/perf/arch/x86/util/intel-bts.c     | 24 ++++++++++----------
 tools/perf/arch/x86/util/intel-pt.c      | 28 ++++++++++++------------
 tools/perf/arch/x86/util/perf_regs.c     |  8 +++----
 tools/perf/arch/x86/util/pmu.c           |  6 ++---
 7 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index e9c436eeffc9..0a5242900248 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -4,8 +4,8 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
 
 #include <linux/kernel.h>
 
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 96f4a2c11893..330d03216b0e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -7,13 +7,13 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include "../../util/header.h"
-#include "../../util/debug.h"
-#include "../../util/pmu.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/evlist.h"
+#include "../../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/pmu.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/evlist.h"
 
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 662ecf84a421..4a864a78241c 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -6,8 +6,8 @@
 #include <string.h>
 #include <regex.h>
 
-#include "../../util/debug.h"
-#include "../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/header.h"
 
 static inline void
 cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d263430c045f..fde7a00a2d74 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -11,18 +11,18 @@
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evsel.h"
-#include "../../util/evlist.h"
-#include "../../util/session.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/record.h"
-#include "../../util/tsc.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-bts.h"
-#include "../../util/util.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evlist.h"
+#include "../../../util/session.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/record.h"
+#include "../../../util/tsc.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/util.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index cb7cf16af79c..71dcb91c7404 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -13,21 +13,21 @@
 #include <linux/zalloc.h>
 #include <cpuid.h>
 
-#include "../../util/session.h"
-#include "../../util/event.h"
-#include "../../util/evlist.h"
-#include "../../util/evsel.h"
-#include "../../util/cpumap.h"
+#include "../../../util/session.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/cpumap.h"
 #include <subcmd/parse-options.h>
-#include "../../util/parse-events.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/auxtrace.h"
-#include "../../util/record.h"
-#include "../../util/target.h"
-#include "../../util/tsc.h"
-#include "../../util/util.h"
-#include "../../util/intel-pt.h"
+#include "../../../util/parse-events.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/record.h"
+#include "../../../util/target.h"
+#include "../../../util/tsc.h"
+#include "../../../util/util.h"
+#include "../../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index c218b83e063b..fca81b39b09f 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -5,10 +5,10 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
-#include "../../perf-sys.h"
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
-#include "../../util/event.h"
+#include "../../../perf-sys.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index e33ef5bc31c5..d48d608517fd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -4,9 +4,9 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/pmu.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/pmu.h"
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
-- 
2.23.0.187.g17f5b7556c-goog

