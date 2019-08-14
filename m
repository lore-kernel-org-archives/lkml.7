Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBFAC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47306216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808157;
	bh=G6SLBKtPcCn6+bkxylFHP/9pWE6GUa4gPQkLSzMaufA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tFA5hd2XLlh7Jm5W+ZuYiyEmBsCMs7Tc6ReNNqlEnkeNSLLEmLy5QzmHizGtM1IDR
	 yEsNKtchp/4tDT1FfPIMicUEqeXWKLOeo1+IShYXjsuEB5KXTaYriEnpoovsdi9Pqc
	 t9PSJjD1VVR+OgDZAWQ0IqEct8o/yAZkkOZsMZFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfHNSmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfHNSmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:42:35 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 773C82064A;
        Wed, 14 Aug 2019 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808154;
        bh=G6SLBKtPcCn6+bkxylFHP/9pWE6GUa4gPQkLSzMaufA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GI7ukkff1pGJgda2LRSvexRGgF5oLTcl2VC/OPI/mQRzcll8lhGamWHjjnFXerOt9
         adPXajetLtp+3EJVT8ZrSrV42CPE2lmr1P3AMwAcO7mXy7LeJuxkzIkkDcTwWnyBDv
         4+pfteQ0zPSf1FV9vhaT6fM9+X0kpyw8NGakx7Lo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Luke Mujica <lukemujica@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/28] perf tools: Fix paths in include statements
Date:   Wed, 14 Aug 2019 15:40:28 -0300
Message-Id: <20190814184051.3125-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Mujica <lukemujica@google.com>

These paths point to the wrong location but still work because they get
picked up by a -I flag that happens to direct to the correct file. Fix
paths to lead to the actual file location without help from include
flags.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190719202253.220261-1-lukemujica@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 4 ++--
 tools/perf/arch/x86/util/tsc.c      | 6 +++---
 tools/perf/ui/helpline.c            | 4 ++--
 tools/perf/ui/util.c                | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 54a3f2373c35..81b531a707bf 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include "../../util/kvm-stat.h"
-#include "../../util/evsel.h"
+#include "../../../util/kvm-stat.h"
+#include "../../../util/evsel.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 950539f9a4f7..b1eb963b4a6e 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -5,10 +5,10 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../perf.h"
+#include "../../../perf.h"
 #include <linux/types.h>
-#include "../../util/debug.h"
-#include "../../util/tsc.h"
+#include "../../../util/debug.h"
+#include "../../../util/tsc.h"
 
 int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 			     struct perf_tsc_conversion *tc)
diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
index b3c421429ed4..54bcd08df87e 100644
--- a/tools/perf/ui/helpline.c
+++ b/tools/perf/ui/helpline.c
@@ -3,10 +3,10 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "../debug.h"
+#include "../util/debug.h"
 #include "helpline.h"
 #include "ui.h"
-#include "../util.h"
+#include "../util/util.h"
 
 char ui_helpline__current[512];
 
diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
index 63bf06e80ab9..9ed76e88a3e4 100644
--- a/tools/perf/ui/util.c
+++ b/tools/perf/ui/util.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util.h"
-#include "../debug.h"
+#include "../util/debug.h"
 
 
 /*
-- 
2.21.0

